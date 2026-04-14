local TweenService = game:GetService("TweenService")

local function normalizeAnimationId(value)
	if typeof(value) == "Instance" and value:IsA("Animation") then
		value = value.AnimationId
	end

	if type(value) == "number" then
		return "rbxassetid://" .. tostring(value)
	end

	if type(value) == "string" then
		if value:match("^rbxassetid://") then
			return value
		end

		local digits = value:match("(%d+)")
		if digits then
			return "rbxassetid://" .. digits
		end
	end

	return nil
end

local function safeDisconnect(conn)
	pcall(function()
		if typeof(conn) == "RBXScriptConnection" and conn.Connected then
			conn:Disconnect()
		end
	end)
end

local function safeDestroy(obj)
	pcall(function()
		if obj and obj.Destroy then
			obj:Destroy()
		end
	end)
end

local function safeCancel(threadObj)
	pcall(task.cancel, threadObj)
end

local Signal = {}
Signal.__index = Signal

function Signal.new()
	return setmetatable({
		_connections = {},
	}, Signal)
end

function Signal:Connect(fn)
	local connection = {
		Connected = true,
		_fn = fn,
		_parent = self,
	}

	function connection:Disconnect()
		self.Connected = false
	end

	table.insert(self._connections, connection)
	return connection
end

function Signal:Fire(...)
	local args = table.pack(...)
	for _, connection in ipairs(self._connections) do
		if connection.Connected and connection._fn then
			connection._fn(table.unpack(args, 1, args.n))
		end
	end
end

function Signal:Wait()
	local bindable = Instance.new("BindableEvent")
	local connection
	connection = self:Connect(function(...)
		if connection then
			connection:Disconnect()
		end
		bindable:Fire(...)
	end)

	local values = table.pack(bindable.Event:Wait())
	bindable:Destroy()
	return table.unpack(values, 1, values.n)
end

function Signal:Destroy()
	for _, connection in ipairs(self._connections) do
		connection:Disconnect()
	end
	table.clear(self._connections)
end

local Maid = {}
Maid.__index = Maid

function Maid.new()
	return setmetatable({
		_tasks = {},
	}, Maid)
end

function Maid:Add(taskObj)
	table.insert(self._tasks, taskObj)
	return taskObj
end

function Maid:DoCleaning()
	for i = #self._tasks, 1, -1 do
		local taskObj = self._tasks[i]

		if typeof(taskObj) == "RBXScriptConnection" then
			safeDisconnect(taskObj)
		elseif type(taskObj) == "thread" then
			safeCancel(taskObj)
		elseif type(taskObj) == "function" then
			pcall(taskObj)
		elseif type(taskObj) == "table" then
			if taskObj.Disconnect then
				pcall(function()
					taskObj:Disconnect()
				end)
			elseif taskObj.Destroy then
				pcall(function()
					taskObj:Destroy()
				end)
			end
		elseif typeof(taskObj) == "Instance" then
			safeDestroy(taskObj)
		end

		self._tasks[i] = nil
	end
end

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

local function parsePose(pose)
	local out = {
		Name = pose.Name,
		CFrame = pose.CFrame,
		EasingDirection = tostring(pose.EasingDirection),
		EasingStyle = tostring(pose.EasingStyle),
		Weight = pose.Weight,
		Subpose = {},
	}

	for _, child in ipairs(pose:GetSubPoses()) do
		table.insert(out.Subpose, parsePose(child))
	end

	return out
end

local function parseMarkers(keyframe)
	local grouped = {}

	for _, marker in ipairs(keyframe:GetMarkers()) do
		grouped[marker.Name] = grouped[marker.Name] or {}
		table.insert(grouped[marker.Name], tostring(marker.Value))
	end

	return next(grouped) and grouped or nil
end

local function parseKeyframeSequence(keyframeSequence)
	local frames = {}
	local markers = {}

	local keyframes = keyframeSequence:GetKeyframes()
	table.sort(keyframes, function(a, b)
		return a.Time < b.Time
	end)

	for _, keyframe in ipairs(keyframes) do
		local frame = {
			Name = keyframe.Name,
			Time = keyframe.Time,
			Pose = {},
			Marker = parseMarkers(keyframe),
		}

		for _, pose in ipairs(keyframe:GetPoses()) do
			table.insert(frame.Pose, parsePose(pose))
		end

		if frame.Marker then
			for markerName in pairs(frame.Marker) do
				markers[markerName] = true
			end
		end

		table.insert(frames, frame)
	end

	local markerList = {}
	for markerName in pairs(markers) do
		table.insert(markerList, markerName)
	end
	table.sort(markerList)

	local loopValue = false
	pcall(function()
		loopValue = keyframeSequence.Loop
	end)

	local priorityValue = Enum.AnimationPriority.Action
	pcall(function()
		priorityValue = keyframeSequence.Priority
	end)

	return {
		Id = keyframeSequence.AnimationId or nil,
		Loop = loopValue,
		Looped = loopValue,
		Priority = priorityValue,
		Markers = markerList,
		Frames = frames,
	}
end

local function getKeyframeSequenceFromResolvable(animationResolvable)
	if typeof(animationResolvable) == "Instance" then
		if animationResolvable:IsA("KeyframeSequence") then
			return animationResolvable
		end

		if animationResolvable:IsA("Animation") then
			local id = normalizeAnimationId(animationResolvable)
			if not id then
				return nil
			end

			local objects = game:GetObjects(id)
			return objects[1]
		end
	end

	if type(animationResolvable) == "string" or type(animationResolvable) == "number" then
		local id = normalizeAnimationId(animationResolvable)
		if not id then
			return nil
		end

		local objects = game:GetObjects(id)
		return objects[1]
	end

	return nil
end

local function buildJointMaps(character, motorIgnoreInList, motorIgnoreList, boneIgnoreInList, boneIgnoreList)
	local motorMap = {}
	local boneMap = {}

	local function ignoredByAncestor(inst, list)
		for _, ancestor in ipairs(list) do
			if inst:IsDescendantOf(ancestor) then
				return true
			end
		end
		return false
	end

	for _, desc in ipairs(character:GetDescendants()) do
		if desc:IsA("Motor6D") then
			if not table.find(motorIgnoreList, desc) and not ignoredByAncestor(desc, motorIgnoreInList) then
				local parentName = (desc.Part0 and desc.Part0.Name) or desc.Parent.Name
				local keyA = desc.Name
				local keyB = (desc.Part1 and desc.Part1.Name) or desc.Name

				motorMap[parentName] = motorMap[parentName] or {}
				motorMap[parentName][keyA] = motorMap[parentName][keyA] or {}
				table.insert(motorMap[parentName][keyA], desc)

				motorMap[parentName][keyB] = motorMap[parentName][keyB] or {}
				table.insert(motorMap[parentName][keyB], desc)
			end
		elseif desc:IsA("Bone") then
			if not table.find(boneIgnoreList, desc) and not ignoredByAncestor(desc, boneIgnoreInList) then
				local parentName = desc.Parent.Name
				local keyA = desc.Name

				boneMap[parentName] = boneMap[parentName] or {}
				boneMap[parentName][keyA] = boneMap[parentName][keyA] or {}
				table.insert(boneMap[parentName][keyA], desc)
			end
		end
	end

	return motorMap, boneMap
end

local Animator = {}
Animator.__index = Animator
Animator.ClassName = "Animator"

function Animator.isAnimator(value)
	return type(value) == "table" and getmetatable(value) == Animator
end

function Animator.new(character, animationResolvable)
	if typeof(character) ~= "Instance" then
		error(("invalid argument 1 to 'new' (Instance expected, got %s)"):format(typeof(character)))
	end

	local animationData

	if type(animationResolvable) == "table" then
		animationData = animationResolvable
	else
		local keyframeSequence = getKeyframeSequenceFromResolvable(animationResolvable)
		if not keyframeSequence or not keyframeSequence:IsA("KeyframeSequence") then
			error(("invalid argument 2 to 'new' (table, Animation, KeyframeSequence, string, or number expected, got %s)"):format(typeof(animationResolvable)))
		end
		animationData = parseKeyframeSequence(keyframeSequence)
	end

	local self = setmetatable({
		AnimationData = animationData,
		Character = character,

		BoneIgnoreInList = {},
		MotorIgnoreInList = {},
		BoneIgnoreList = {},
		MotorIgnoreList = {},

		handleVanillaAnimator = true,
		Looped = animationData.Looped or animationData.Loop or false,
		Length = 0,
		Speed = 1,
		IsPlaying = false,

		_markerSignal = {},
		_maid = Maid.new(),
		_stopped = false,
		_playing = false,
		_isLooping = false,
	}, Animator)

	if animationData.Frames and animationData.Frames[#animationData.Frames] then
		self.Length = animationData.Frames[#animationData.Frames].Time or 0
	end

	self.DidLoop = Signal.new()
	self.Stopped = Signal.new()
	self.KeyframeReached = Signal.new()

	self._maid:Add(self.DidLoop)
	self._maid:Add(self.Stopped)
	self._maid:Add(self.KeyframeReached)

	for _, markerName in ipairs(animationData.Markers or {}) do
		local signal = Signal.new()
		self._markerSignal[markerName] = signal
		self._maid:Add(signal)
	end

	return self
end

function Animator:IgnoreMotor(inst)
	if typeof(inst) ~= "Instance" or not inst:IsA("Motor6D") then
		error("invalid argument 1 to 'IgnoreMotor' (Motor6D expected)")
	end
	table.insert(self.MotorIgnoreList, inst)
end

function Animator:IgnoreBone(inst)
	if typeof(inst) ~= "Instance" or not inst:IsA("Bone") then
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

function Animator:_playPose(pose, parentPose, fade)
	if pose.Subpose then
		for _, subpose in ipairs(pose.Subpose) do
			self:_playPose(subpose, pose, fade)
		end
	end

	if not parentPose then
		return
	end

	local motorMap, boneMap = buildJointMaps(
		self.Character,
		self.MotorIgnoreInList,
		self.MotorIgnoreList,
		self.BoneIgnoreInList,
		self.BoneIgnoreList
	)

	local targets = {}

	local motorsForParent = motorMap[parentPose.Name]
	if motorsForParent and motorsForParent[pose.Name] then
		for _, motor in ipairs(motorsForParent[pose.Name]) do
			table.insert(targets, motor)
		end
	end

	local bonesForParent = boneMap[parentPose.Name]
	if bonesForParent and bonesForParent[pose.Name] then
		for _, bone in ipairs(bonesForParent[pose.Name]) do
			table.insert(targets, bone)
		end
	end

	local effectiveFade = fade or 0
	if effectiveFade ~= effectiveFade or effectiveFade == math.huge or effectiveFade == -math.huge then
		effectiveFade = 0
	end
	if effectiveFade < 0 then
		effectiveFade = 0
	end

	for _, obj in ipairs(targets) do
		if self._stopped then
			break
		end

		if effectiveFade > 0.012 then
			local tweenInfo = TweenInfo.new(
				effectiveFade,
				coerceEasingStyle(pose.EasingStyle),
				coerceEasingDirection(pose.EasingDirection)
			)

			local tween = TweenService:Create(obj, tweenInfo, {
				Transform = pose.CFrame,
			})
			tween:Play()
			self._maid:Add(tween)
		else
			obj.Transform = pose.CFrame
		end
	end
end

function Animator:Play(fadeTime, weight, speed)
	fadeTime = fadeTime or 0.1
	self.Speed = speed or self.Speed or 1

	if not self.Character or not self.Character.Parent or (self._playing and not self._isLooping) then
		return
	end

	self._playing = true
	self._isLooping = false
	self._stopped = false
	self.IsPlaying = true

	local humanoid = self.Character:FindFirstChildOfClass("Humanoid")
	local animateScript = self.Character:FindFirstChild("Animate")

	if self.handleVanillaAnimator and animateScript and animateScript:IsA("LocalScript") then
		animateScript.Disabled = true
	end

	local deathConnection
	if humanoid then
		deathConnection = humanoid.Died:Connect(function()
			self:Destroy()
		end)
		self._maid:Add(deathConnection)
	end

	local ancestryConnection = self.Character.AncestryChanged:Connect(function(_, parent)
		if not parent then
			self:Destroy()
		end
	end)
	self._maid:Add(ancestryConnection)

	local startedAt = os.clock()

	task.spawn(function()
		for i = 1, #(self.AnimationData.Frames or {}) do
			if self._stopped then
				break
			end

			local frame = self.AnimationData.Frames[i]
			local frameTime = (frame.Time or 0) / self.Speed

			if frame.Name and frame.Name ~= "Keyframe" then
				self.KeyframeReached:Fire(frame.Name)
			end

			if frame.Marker then
				for markerName, values in pairs(frame.Marker) do
					local signal = self._markerSignal[markerName]
					if signal then
						for _, value in ipairs(values) do
							signal:Fire(value)
						end
					end
				end
			end

			if frame.Pose then
				for _, pose in ipairs(frame.Pose) do
					local ft = fadeTime
					if i ~= 1 then
						local prevFrame = self.AnimationData.Frames[i - 1]
						ft = ((frame.Time or 0) - (prevFrame.Time or 0)) / self.Speed
					end

					if ft ~= ft or ft == math.huge or ft == -math.huge then
						ft = 0
					end
					if ft < 0 then
						ft = 0
					end

					self:_playPose(pose, nil, ft)
				end
			end

			while not self._stopped and (os.clock() - startedAt) < frameTime do
				task.wait()
			end
		end

		if self.Looped and not self._stopped then
			self.DidLoop:Fire()
			self._isLooping = true
			self._playing = false
			self.IsPlaying = false
			self:Play(fadeTime, weight, self.Speed)
			return
		end

		if animateScript and self.handleVanillaAnimator and animateScript:IsA("LocalScript") then
			animateScript.Disabled = false
		end

		self._playing = false
		self.IsPlaying = false
		self.Stopped:Fire()
	end)
end

function Animator:GetTimeOfKeyframe(keyframeName)
	for _, frame in ipairs(self.AnimationData.Frames or {}) do
		if frame.Name == keyframeName then
			return frame.Time or 0
		end
	end
	return 0
end

function Animator:GetMarkerReachedSignal(name)
	local signal = self._markerSignal[name]
	if not signal then
		signal = Signal.new()
		self._markerSignal[name] = signal
		self._maid:Add(signal)
	end
	return signal
end

function Animator:AdjustSpeed(speed)
	self.Speed = speed
end

function Animator:Stop()
	self._stopped = true
end

function Animator:Destroy()
	if not self._stopped then
		self:Stop()
	end

	self._maid:DoCleaning()
	setmetatable(self, nil)
end

return Animator
