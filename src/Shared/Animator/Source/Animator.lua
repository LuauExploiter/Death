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
	if typeof(relPath) == "Instance" then
		return relPath
	end

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

local function customRequire(relPath)
	local target = resolveRelativeModule(script, relPath)
	return require(target)
end

local animatorRequire = customRequire
local HttpRequire = customRequire

local TweenService = game:GetService("TweenService")

local Parser = animatorRequire("Parser.lua")
local Utility = animatorRequire("Utility.lua")
local Signal = animatorRequire("Nevermore/Signal.lua")
local Maid = animatorRequire("Nevermore/Maid.lua")

local tinsert = table.insert
local format = string.format
local spawn = task.spawn
local waitTask = task.wait
local clock = os.clock

local Animator = {}

Animator.__index = Animator
Animator.ClassName = "Animator"

local function coerceEasingStyle(value)
	if typeof(value) == "EnumItem" then
		if value.EnumType == Enum.EasingStyle then
			return value
		end
		local name = tostring(value):match("([%w_]+)$")
		if name == "Constant" then
			name = "Linear"
		end
		return Enum.EasingStyle[name] or Enum.EasingStyle.Linear
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
	if typeof(value) == "EnumItem" then
		if value.EnumType == Enum.EasingDirection then
			return value
		end
		local name = tostring(value):match("([%w_]+)$")
		return Enum.EasingDirection[name] or Enum.EasingDirection.InOut
	end

	if type(value) == "string" then
		local name = value:match("([%w_]+)$") or value
		return Enum.EasingDirection[name] or Enum.EasingDirection.InOut
	end

	return Enum.EasingDirection.InOut
end

local function appendArray(target, source)
	for i = 1, #source do
		target[#target + 1] = source[i]
	end
	return target
end

local function isSpinSensitiveJoint(parentName, poseName)
	local s = (tostring(parentName) .. " " .. tostring(poseName)):lower()
	return s:find("arm") or s:find("hand") or s:find("wrist")
end

function Animator.isAnimator(value)
	return type(value) == "table" and getmetatable(value) == Animator
end

function Animator.new(Character, AnimationResolvable)
	if typeof(Character) ~= "Instance" then
		error(format("invalid argument 1 to 'new' (Instace expected, got %s)", typeof(Character)))
	end

	local self = setmetatable({
		AnimationData = {},
		BoneIgnoreInList = {},
		MotorIgnoreInList = {},
		BoneIgnoreList = {},
		MotorIgnoreList = {},
		handleVanillaAnimator = true,
		Character = nil,
		Looped = false,
		Length = 0,
		Speed = 1,
		IsPlaying = false,
		_stopFadeTime = 0.100000001,
		_playing = false,
		_stopped = false,
		_isLooping = false,
		_markerSignal = {},
		_motorMap = nil,
		_boneMap = nil,
		_mapsDirty = true,
		_activeTweens = {},
	}, Animator)

	local valueType = typeof(AnimationResolvable)

	local isInstance = valueType == "Instance"
	local isAnimation = isInstance and AnimationResolvable.ClassName == "Animation"

	if isAnimation or valueType == "string" or valueType == "number" then
		local keyframeSequence = game:GetObjects(
			"rbxassetid://" .. tostring(IsAnimation and AnimationResolvable.AnimationId or AnimationResolvable)
		)[1]

		if not keyframeSequence or keyframeSequence.ClassName ~= "KeyframeSequence" then
			error(
				isAnimation and "invalid argument 2 to 'new' (Content inside AnimationId expected)"
					or "invalid argument 2 to 'new' (string,number expected)"
			)
		end

		self.AnimationData = Parser:parseAnimationData(keyframeSequence)
	elseif valueType == "table" then
		self.AnimationData = AnimationResolvable
	elseif isInstance then
		if AnimationResolvable.ClassName == "KeyframeSequence" then
			self.AnimationData = Parser:parseAnimationData(AnimationResolvable)
		else
			error(format("invalid argument 2 to 'new' (number,string,table,KeyframeSequence expected, got %s)", AnimationResolvable.ClassName))
		end
	else
		error(format("invalid argument 2 to 'new' (number,string,table,Instance expected, got %s)", valueType))
	end

	self.Character = Character
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

function Animator:_refreshMaps()
	self._motorMap = Utility:getMotorMap(self.Character, {
		IgnoreIn = self.MotorIgnoreInList,
		IgnoreList = self.MotorIgnoreList,
	})

	self._boneMap = Utility:getBoneMap(self.Character, {
		IgnoreIn = self.BoneIgnoreInList,
		IgnoreList = self.BoneIgnoreList,
	})

	self._mapsDirty = false
end

function Animator:_cancelTweenFor(obj)
	local tween = self._activeTweens[obj]
	if tween then
		pcall(function()
			tween:Cancel()
		end)
		self._activeTweens[obj] = nil
	end
end

function Animator:_cancelAllTweens()
	for obj, tween in pairs(self._activeTweens) do
		pcall(function()
			tween:Cancel()
		end)
		self._activeTweens[obj] = nil
	end
end

function Animator:IgnoreMotor(inst)
	if typeof(inst) ~= "Instance" then
		error(format("invalid argument 1 to 'IgnoreMotor' (Instance expected, got %s)", typeof(inst)))
	end
	if inst.ClassName ~= "Motor6D" then
		error(format("invalid argument 1 to 'IgnoreMotor' (Motor6D expected, got %s)", inst.ClassName))
	end
	tinsert(self.MotorIgnoreList, inst)
	self._mapsDirty = true
end

function Animator:IgnoreBone(inst)
	if typeof(inst) ~= "Instance" then
		error(format("invalid argument 1 to 'IgnoreBone' (Instance expected, got %s)", typeof(inst)))
	end
	if inst.ClassName ~= "Bone" then
		error(format("invalid argument 1 to 'IgnoreBone' (Bone expected, got %s)", inst.ClassName))
	end
	tinsert(self.BoneIgnoreList, inst)
	self._mapsDirty = true
end

function Animator:IgnoreMotorIn(inst)
	if typeof(inst) ~= "Instance" then
		error(format("invalid argument 1 to 'IgnoreMotorIn' (Instance expected, got %s)", typeof(inst)))
	end
	tinsert(self.MotorIgnoreInList, inst)
	self._mapsDirty = true
end

function Animator:IgnoreBoneIn(inst)
	if typeof(inst) ~= "Instance" then
		error(format("invalid argument 1 to 'IgnoreBoneIn' (Instance expected, got %s)", typeof(inst)))
	end
	tinsert(self.BoneIgnoreInList, inst)
	self._mapsDirty = true
end

function Animator:_gatherTargets(parentName, poseName)
	if self._mapsDirty or not self._motorMap or not self._boneMap then
		self:_refreshMaps()
	end

	local combined = {}

	local motorBucket = self._motorMap[parentName]
	if motorBucket then
		appendArray(combined, motorBucket[poseName] or {})
	end

	local boneBucket = self._boneMap[parentName]
	if boneBucket then
		appendArray(combined, boneBucket[poseName] or {})
	end

	return combined
end

function Animator:_playPose(pose, parent, fade)
	if not parent then
		if pose.Subpose then
			local subPose = pose.Subpose
			for count = 1, #subPose do
				local sp = subPose[count]
				self:_playPose(sp, pose, fade)
			end
		end
		return
	end

	local targets = self:_gatherTargets(parent.Name, pose.Name)
	local actualFade = fade or 0

	if actualFade ~= actualFade or actualFade == math.huge or actualFade == -math.huge then
		actualFade = 0
	end

	if actualFade < 0 then
		actualFade = 0
	end

	if isSpinSensitiveJoint(parent.Name, pose.Name) then
		if actualFade < 0.028 then
			actualFade = 0
		end
	else
		if actualFade < 0.008 then
			actualFade = 0
		end
	end

	local style = coerceEasingStyle(pose.EasingStyle)
	local direction = coerceEasingDirection(pose.EasingDirection)

	local tweenInfo
	if actualFade > 0 then
		tweenInfo = TweenInfo.new(actualFade, style, direction)
	end

	local target = {
		Transform = pose.CFrame,
	}

	for count = 1, #targets do
		local obj = targets[count]

		if self == nil or self._stopped then
			break
		end

		self:_cancelTweenFor(obj)

		if tweenInfo then
			local tween = TweenService:Create(obj, tweenInfo, target)
			self._activeTweens[obj] = tween
			tween.Completed:Connect(function()
				if self and self._activeTweens[obj] == tween then
					self._activeTweens[obj] = nil
				end
			end)
			tween:Play()
		else
			obj.Transform = pose.CFrame
		end
	end

	if pose.Subpose then
		local subPose = pose.Subpose
		for count = 1, #subPose do
			local sp = subPose[count]
			self:_playPose(sp, pose, fade)
		end
	end
end

function Animator:Play(fadeTime, weight, speed)
	fadeTime = fadeTime or 0.100000001

	if not self.Character or self.Character.Parent == nil or (self._playing and not self._isLooping) then
		return
	end

	self._playing = true
	self._isLooping = false
	self.IsPlaying = true
	self._stopped = false

	self.Speed = speed or self.Speed or 1

	self:_refreshMaps()
	self:_cancelAllTweens()

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
			if AnimateScript then
				AnimateScript.Disabled = true
			end

			if Humanoid then
				local characterAnimator = Humanoid:FindFirstChild("Animator")
				if characterAnimator then
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

	local start = clock()

	spawn(function()
		for i = 1, #self.AnimationData.Frames do
			if self._stopped then
				break
			end

			local f = self.AnimationData.Frames[i]
			local t = (f.Time or 0) / self.Speed

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
				local poseList = f.Pose
				for count = 1, #poseList do
					local p = poseList[count]
					local ft = fadeTime

					if i ~= 1 then
						local prevFrame = self.AnimationData.Frames[i - 1]
						ft = ((f.Time or 0) - (prevFrame.Time or 0)) / self.Speed
					end

					if ft ~= ft or ft == math.huge or ft == -math.huge then
						ft = 0
					end

					if ft < 0 then
						ft = 0
					end

					self:_playPose(p, nil, ft)
				end
			end

			if t > clock() - start then
				repeat
					waitTask()
				until self._stopped or clock() - start >= t
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

		self:_cancelAllTweens()

		if self.Looped and not self._stopped then
			self.DidLoop:Fire()
			self._isLooping = true
			return self:Play(fadeTime, weight, self.Speed)
		end

		waitTask()

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
	for count = 1, #self.AnimationData.Frames do
		local f = self.AnimationData.Frames[count]
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
	self._stopFadeTime = fadeTime or 0.100000001
	self._stopped = true
	self:_cancelAllTweens()
end

function Animator:Destroy()
	if not self._stopped then
		self:Stop(0)
		self.Stopped:Wait()
	end
	self._maid:DoCleaning()
	setmetatable(self, nil)
end

return Animator
