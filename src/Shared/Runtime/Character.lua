local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")

local Util = require(script.Parent.Util)
local RigMap = require(script.Parent.RigMap)

local CharacterRuntime = {}
CharacterRuntime.__index = CharacterRuntime

function CharacterRuntime.new(character)
	local self = setmetatable({}, CharacterRuntime)

	self.Character = character
	self.Humanoid = character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid")
	self.Root = RigMap.getRoot(character) or character:WaitForChild("HumanoidRootPart")
	self.Objects = {}
	self.Connections = {}
	self.Threads = {}
	self.RenderStepName = "DEATH_RUNTIME_" .. tostring(math.random(1, 1e9))
	self.WalkSpeed = nil
	self.StartTick = 0

	self.OriginalWalkSpeed = self.Humanoid.WalkSpeed
	self.OriginalAutoRotate = self.Humanoid.AutoRotate
	self.OriginalJumpPower = self.Humanoid.JumpPower
	self.OriginalJumpHeight = self.Humanoid.JumpHeight

	return self
end

function CharacterRuntime:trackObject(obj)
	table.insert(self.Objects, obj)
	return obj
end

function CharacterRuntime:trackConnection(conn)
	table.insert(self.Connections, conn)
	return conn
end

function CharacterRuntime:trackThread(threadObj)
	table.insert(self.Threads, threadObj)
	return threadObj
end

function CharacterRuntime:createFolder(name, parent, attributes)
	local folder = Instance.new("Folder")
	folder.Name = name
	folder.Parent = parent or self.Character

	if attributes then
		for k, v in pairs(attributes) do
			folder:SetAttribute(k, v)
		end
	end

	return self:trackObject(folder)
end

function CharacterRuntime:createBodyGyro()
	local gyro = Instance.new("BodyGyro")
	gyro.Name = "BODYGYRO"
	gyro.MaxTorque = Vector3.new(0, 9e9, 0)
	gyro.P = 90000
	gyro.D = 1000
	gyro.CFrame = self.Root.CFrame
	gyro.Parent = self.Root
	gyro:SetAttribute("EmoteProperty", true)
	CollectionService:AddTag(gyro, "emotestuff" .. self.Character.Name)
	self:trackObject(gyro)

	RunService:BindToRenderStep(self.RenderStepName, Enum.RenderPriority.Character.Value + 1, function()
		if not gyro.Parent or not self.Root.Parent then
			RunService:UnbindFromRenderStep(self.RenderStepName)
			return
		end

		local moveDir = self.Humanoid.MoveDirection
		if moveDir.Magnitude > 0.05 then
			local flat = Vector3.new(moveDir.X, 0, moveDir.Z)
			gyro.CFrame = CFrame.lookAt(self.Root.Position, self.Root.Position + flat.Unit)
		else
			gyro.CFrame = CFrame.lookAt(self.Root.Position, self.Root.Position + self.Root.CFrame.LookVector)
		end
	end)

	return gyro
end

function CharacterRuntime:setupForManifest(manifest)
	self.StartTick = tick()
	self.Character:SetAttribute("EmoteStarted", self.StartTick)
	self.Character:SetAttribute("SideDashDisable", self.StartTick)

	self:createFolder("DoingEmote", self.Character, {
		Name = manifest.Name,
		FixRotation = true,
		EmoteProperty = true,
	})

	if manifest.HideWeapon then
		self:createFolder("HideWeapon", self.Character, {
			EmoteProperty = true,
		})
	end

	if manifest.Stun then
		self:createFolder(manifest.Stun, self.Character, {
			EmoteProperty = true,
		})
	end

	self:createBodyGyro()
end

function CharacterRuntime:lockWalkSpeed(speed)
	self.WalkSpeed = speed
	self.Humanoid.WalkSpeed = speed
	self.Humanoid.AutoRotate = false

	self:trackConnection(self.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
		if self.WalkSpeed then
			self.Humanoid.WalkSpeed = self.WalkSpeed
		end
	end))

	self:trackConnection(RunService.Heartbeat:Connect(function()
		if self.WalkSpeed then
			self.Humanoid.WalkSpeed = self.WalkSpeed
			self.Humanoid.Jump = false
		end
	end))
end

function CharacterRuntime:cleanup()
	for _, conn in ipairs(self.Connections) do
		Util.safeDisconnect(conn)
	end
	table.clear(self.Connections)

	for _, threadObj in ipairs(self.Threads) do
		Util.safeCancel(threadObj)
	end
	table.clear(self.Threads)

	RunService:UnbindFromRenderStep(self.RenderStepName)

	for _, obj in ipairs(self.Objects) do
		Util.safeDestroy(obj)
	end
	table.clear(self.Objects)

	for _, desc in ipairs(self.Character:GetDescendants()) do
		if desc:GetAttribute("EmoteProperty") then
			Util.safeDestroy(desc)
		end
	end

	local bodyGyro = self.Root:FindFirstChild("BODYGYRO")
	if bodyGyro then
		Util.safeDestroy(bodyGyro)
	end

	local slowed = self.Character:FindFirstChild("Slowed")
	if slowed then
		Util.safeDestroy(slowed)
	end

	local doingEmote = self.Character:FindFirstChild("DoingEmote")
	if doingEmote then
		Util.safeDestroy(doingEmote)
	end

	local hideWeapon = self.Character:FindFirstChild("HideWeapon")
	if hideWeapon then
		Util.safeDestroy(hideWeapon)
	end

	self.WalkSpeed = nil

	pcall(function()
		self.Root.Anchored = false
	end)

	pcall(function()
		self.Root.AssemblyLinearVelocity = Vector3.new(self.Root.AssemblyLinearVelocity.X, 0, self.Root.AssemblyLinearVelocity.Z)
	end)

	pcall(function()
		self.Humanoid.WalkSpeed = self.OriginalWalkSpeed
	end)

	pcall(function()
		self.Humanoid.AutoRotate = self.OriginalAutoRotate
	end)

	pcall(function()
		self.Humanoid.JumpPower = self.OriginalJumpPower
	end)

	pcall(function()
		self.Humanoid.JumpHeight = self.OriginalJumpHeight
	end)

	pcall(function()
		self.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
	end)

	pcall(function()
		self.Humanoid.PlatformStand = false
	end)

	pcall(function()
		self.Humanoid.Jump = false
	end)

	pcall(function()
		self.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
	end)
end

return CharacterRuntime
