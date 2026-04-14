local TweenService = game:GetService("TweenService")

local function splitPath(path)
	local out = {}
	path = tostring(path or ""):gsub("\\", "/")
	for part in string.gmatch(path, "[^/]+") do
		table.insert(out, part)
	end
	return out
end

local function stripLua(name)
	return (name:gsub("%.lua$", ""))
end

local function resolveRelativeModule(baseScript, relPath)
	local current = baseScript.Parent
	local parts = splitPath(relPath)

	for _, part in ipairs(parts) do
		if part == "." or part == "" then
		elseif part == ".." then
			current = current.Parent
		else
			current = current:WaitForChild(stripLua(part))
		end
	end

	return current
end

local function relRequire(path)
	return require(resolveRelativeModule(script, path))
end

local Parser = relRequire("Parser.lua")
local Utility = relRequire("Utility.lua")

local function cleanupTask(taskObj)
	if typeof(taskObj) == "RBXScriptConnection" then
		if taskObj.Connected then
			taskObj:Disconnect()
		end
	elseif type(taskObj) == "function" then
		taskObj()
	elseif type(taskObj) == "table" then
		if taskObj.Disconnect then
			taskObj:Disconnect()
		elseif taskObj.Destroy then
			taskObj:Destroy()
		end
	end
end

local Maid = {}
Maid.__index = Maid

function Maid.new()
	return setmetatable({
		_tasks = {},
	}, Maid)
end

function Maid:DoCleaning()
	for key, taskObj in pairs(self._tasks) do
		cleanupTask(taskObj)
		self._tasks[key] = nil
	end
end

function Maid:__newindex(key, value)
	local tasks = rawget(self, "_tasks")
	if tasks[key] then
		cleanupTask(tasks[key])
	end
	tasks[key] = value
end

function Maid:__index(key)
	return Maid[key] or rawget(self, "_tasks")[key]
end

local Signal = {}
Signal.__index = Signal

function Signal.new()
	return setmetatable({
		_connections = {},
	}, Signal)
end

function Signal:Connect(fn)
	local conn = {
		Connected = true,
	}
	function conn:Disconnect()
		self.Connected = false
	end
	conn._fn = fn
	table.insert(self._connections, conn)
	return conn
end

function Signal:Fire(...)
	local args = table.pack(...)
	for _, conn in ipairs(self._connections) do
		if conn.Connected and conn._fn then
			conn._fn(table.unpack(args, 1, args.n))
		end
	end
end

function Signal:Wait()
	local bindable = Instance.new("BindableEvent")
	local conn
	conn = self:Connect(function(...)
		conn:Disconnect()
		bindable:Fire(...)
	end)
	local values = table.pack(bindable.Event:Wait())
	bindable:Destroy()
	return table.unpack(values, 1, values.n)
end

function Signal:Destroy()
	for _, conn in ipairs(self._connections) do
		conn:Disconnect()
	end
	table.clear(self._connections)
end

local function merge(t1, t2)
	for k, v in pairs(t2) do
		if type(v) == "table" then
			if type(t1[k]) == "table" then
				merge(t1[k], v)
			else
				t1[k] = v
			end
		else
			t1[k] = v
		end
	end
	return t1
end

local function coerceEasingStyle(value)
	if typeof(value) == "EnumItem" and value.EnumType == Enum.EasingStyle then
		return value
	end
	if type(value) == "string" then
		local name = value:match("([%w_]+)$") or value
		if name == "Constant" then
			name = "Linear"
		end
		return Enum.EasingStyle[name] or Enum.EasingStyle.Linear
	end
	return Enum.EasingStyle.Linear
end

local function coerceEasingDirection(value)
	if typeof(value) == "EnumItem" and value.EnumType == Enum.EasingDirection then
		return value
	end
	if type(value) == "string" then
		local name = value:match("([%w_]+)$") or value
		return Enum.EasingDirection[name] or Enum.EasingDirection.InOut
	end
	return Enum.EasingDirection.InOut
end

local Animator = {}
Animator.__index = Animator
Animator.ClassName = "Animator"

function Animator.isAnimator(value)
	return type(value) == "table" and getmetatable(value) == Animator
end

function Animator.new(Character, AnimationResolvable)
	if typeof(Character) ~= "Instance" then
		error(("invalid argument 1 to 'new' (Instance expected, got %s)"):format(typeof(Character)))
	end

	local self = setmetatable({
		AnimationData = {},
		BoneIgnoreInList = {},
		MotorIgnoreInList = {},
		BoneIgnoreList = {},
		MotorIgnoreList = {},
		handleVanillaAnimator = true,
		Character = Character,
		Looped = false,
		Length = 0,
		Speed = 1,
		IsPlaying = false,
		_stopFadeTime = 0.1,
		_playing = false,
		_stopped = false,
		_isLooping = false,
		_markerSignal = {},
	}, Animator)

	local t = typeof(AnimationResolvable)
	local isInstance = t == "Instance"
	local isAnimation = isInstance and AnimationResolvable.ClassName == "Animation"

	if isAnimation or t == "string" or t == "number" then
		local keyframeSequence = game:GetObjects(
			"rbxassetid://" .. tostring(isAnimation and AnimationResolvable.AnimationId or AnimationResolvable)
		)[1]

		if not keyframeSequence or keyframeSequence.ClassName ~= "KeyframeSequence" then
			error(isAnimation and "invalid argument 2 to 'new' (Content inside AnimationId expected)" or "invalid argument 2 to 'new' (string,number expected)")
		end

		self.AnimationData = Parser:parseAnimationData(keyframeSequence)
	elseif t == "table" then
		self.AnimationData = AnimationResolvable
	elseif isInstance and AnimationResolvable.ClassName == "KeyframeSequence" then
		self.AnimationData = Parser:parseAnimationData(AnimationResolvable)
	else
		error(("invalid argument 2 to 'new' (number,string,table,Instance expected, got %s)"):format(t))
	end

	self.Looped = self.AnimationData.Loop or self.AnimationData.Looped or false
	self.Length = (self.AnimationData.Frames and self.AnimationData.Frames[#self.AnimationData.Frames] and self.AnimationData.Frames[#self.AnimationData.Frames].Time) or 0

	self._maid = Maid.new()
	self.DidLoop = Signal.new()
	self.Stopped = Signal.new()
	self.KeyframeReached = Signal.new()

	self._maid.DidLoop = self.DidLoop
	self._maid.Stopped = self.Stopped
	self._maid.KeyframeReached = self.KeyframeReached

	return self
end

function Animator:IgnoreMotor(inst)
	if typeof(inst) ~= "Instance" or inst.ClassName ~= "Motor6D" then
		error("invalid argument 1 to 'IgnoreMotor' (Motor6D expected)")
	end
	table.insert(self.MotorIgnoreList, inst)
end

function Animator:IgnoreBone(inst)
	if typeof(inst) ~= "Instance" or inst.ClassName ~= "Bone" then
		error("invalid argument 1 to 'IgnoreBone' (Bone expected)")
	end
	table.insert(self.BoneIgnoreList, inst)
end

function Animator:IgnoreMotorIn(inst)
	if typeof(inst) ~= "Instance" then
		error("invalid argument 1 to 'IgnoreMotorIn' (Instance expected)")
	end
	table.insert(self.MotorIgnoreInList, inst)
end

function Animator:IgnoreBoneIn(inst)
	if typeof(inst) ~= "Instance" then
		error("invalid argument 1 to 'IgnoreBoneIn' (Instance expected)")
	end
	table.insert(self.BoneIgnoreInList, inst)
end

function Animator:_playPose(pose, parent, fade)
	if pose.Subpose then
		for _, sp in ipairs(pose.Subpose) do
			self:_playPose(sp, pose, fade)
		end
	end

	if not parent then
		return
	end

	local MotorMap = Utility:getMotorMap(self.Character, {
		IgnoreIn = self.MotorIgnoreInList,
		IgnoreList = self.MotorIgnoreList,
	})

	local BoneMap = Utility:getBoneMap(self.Character, {
		IgnoreIn = self.BoneIgnoreInList,
		IgnoreList = self.BoneIgnoreList,
	})

	local effectiveFade = fade or 0
if effectiveFade < 0.045 then
	effectiveFade = 0
end

local TI
if effectiveFade > 0 then
	TI = TweenInfo.new(
		effectiveFade,
		coerceEasingStyle(pose.EasingStyle),
		coerceEasingDirection(pose.EasingDirection)
	)
end

if effectiveFade > 0 then
	TweenService:Create(obj, TI, Target):Play()
else
	obj.Transform = pose.CFrame
end

	local Target = {
		Transform = pose.CFrame,
	}

	local M = MotorMap[parent.Name]
	local B = BoneMap[parent.Name]
	local C = {}

	if M then
		local MM = M[pose.Name] or {}
		C = merge(C, MM)
	end

	if B then
		local BB = B[pose.Name] or {}
		C = merge(C, BB)
	end

	for _, obj in ipairs(C) do
		if self == nil or self._stopped then
			break
		end

		
	end
end

function Animator:Play(fadeTime, weight, speed)
	fadeTime = fadeTime or 0.1

	if not self.Character or self.Character.Parent == nil or (self._playing and not self._isLooping) then
		return
	end

	self._playing = true
	self._isLooping = false
	self.IsPlaying = true

	local deathConnection
	local noParentConnection

	do
		local Humanoid = self.Character:FindFirstChild("Humanoid")

		if Humanoid then
			deathConnection = Humanoid.Died:Connect(function()
				self:Destroy()
				if deathConnection then
					deathConnection:Disconnect()
				end
			end)
		end

		if self.handleVanillaAnimator then
			local AnimateScript = self.Character:FindFirstChild("Animate")
			if AnimateScript and typeof(AnimateScript) == "Instance" then
				AnimateScript.Disabled = true
			end

			if Humanoid then
				local characterAnimator = Humanoid:FindFirstChild("Animator")
				if characterAnimator and typeof(characterAnimator) == "Instance" then
					local animationTrack = characterAnimator:GetPlayingAnimationTracks()
					for i = 1, #animationTrack do
						animationTrack[i]:Stop()
					end
					characterAnimator:Destroy()
				end
			end
		end

		noParentConnection = self.Character:GetPropertyChangedSignal("Parent"):Connect(function()
			if self ~= nil and self.Character.Parent ~= nil then
				return
			end
			self:Destroy()
			if noParentConnection then
				noParentConnection:Disconnect()
			end
		end)
	end

	local start = os.clock()

	task.spawn(function()
		for i = 1, #(self.AnimationData.Frames or {}) do
			if self._stopped then
				break
			end

			local f = self.AnimationData.Frames[i]
			local t = f.Time / (speed or self.Speed)

			if f.Name ~= "Keyframe" then
				self.KeyframeReached:Fire(f.Name)
			end

			if f.Marker then
				for k, v in next, f.Marker do
					if self._markerSignal[k] then
						for _, v2 in next, v do
							self._markerSignal[k]:Fire(v2)
						end
					end
				end
			end

			if f.Pose then
				for _, p in ipairs(f.Pose) do
					local ft = fadeTime
					if i ~= 1 then
						ft = (t * (speed or self.Speed) - self.AnimationData.Frames[i - 1].Time) / (speed or self.Speed)
					end
					self:_playPose(p, nil, ft)
				end
			end

			if t > os.clock() - start then
				repeat
					task.wait()
				until self._stopped or os.clock() - start >= t
			end
		end

		if deathConnection then
			deathConnection:Disconnect()
			deathConnection = nil
		end

		if noParentConnection then
			noParentConnection:Disconnect()
			noParentConnection = nil
		end

		if self.Looped and not self._stopped then
			self.DidLoop:Fire()
			self._isLooping = true
			return self:Play(fadeTime, weight, speed)
		end

		task.wait()

		if self.Character and self.handleVanillaAnimator then
			local Humanoid = self.Character:FindFirstChild("Humanoid")
			if Humanoid and not Humanoid:FindFirstChildOfClass("Animator") then
				Instance.new("Animator").Parent = Humanoid
			end

			local AnimateScript = self.Character:FindFirstChild("Animate")
			if AnimateScript and AnimateScript.Disabled then
				AnimateScript.Disabled = false
			end
		end

		self._stopped = false
		self._playing = false
		self.IsPlaying = false
		self.Stopped:Fire()
	end)
end

function Animator:GetTimeOfKeyframe(keyframeName)
	for _, f in ipairs(self.AnimationData.Frames or {}) do
		if f.Name == keyframeName then
			return f.Time
		end
	end
	return 0
end

function Animator:GetMarkerReachedSignal(name)
	local signal = self._markerSignal[name]
	if not signal then
		signal = Signal.new()
		self._markerSignal[name] = signal
		self._maid["M_" .. name] = signal
	end
	return signal
end

function Animator:AdjustSpeed(speed)
	self.Speed = speed
end

function Animator:Stop(fadeTime)
	self._stopFadeTime = fadeTime or 0.1
	self._stopped = true
end

function Animator:Destroy()
	if not self._stopped then
		self:Stop(0)
		self.Stopped:Wait()
	end

	if self._maid then
		self._maid:DoCleaning()
	end

	setmetatable(self, nil)
end

return Animator
