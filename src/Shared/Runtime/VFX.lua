local CollectionService = game:GetService("CollectionService")

local RigMap = require(script.Parent.RigMap)

local VFXRuntime = {}
VFXRuntime.__index = VFXRuntime

local function resolveBundle(moduleResult)
	local built

	if typeof(moduleResult) == "Instance" then
		built = moduleResult:Clone()
	elseif type(moduleResult) == "function" then
		built = moduleResult()
	elseif type(moduleResult) == "table" then
		if typeof(moduleResult.Root) == "Instance" then
			built = moduleResult.Root:Clone()
		elseif type(moduleResult.Create) == "function" then
			built = moduleResult.Create()
		elseif type(moduleResult.Build) == "function" then
			built = moduleResult.Build()
		elseif type(moduleResult.New) == "function" then
			built = moduleResult.New()
		end
	end

	if typeof(built) ~= "Instance" then
		return nil
	end

	return built
end

local function emitAll(inst, multiplier)
	multiplier = multiplier or 1

	for _, d in ipairs(inst:GetDescendants()) do
		if d:IsA("ParticleEmitter") then
			local count = d:GetAttribute("EmitCount")
			if typeof(count) == "number" then
				d:Emit(math.max(1, math.floor(count * multiplier)))
			else
				d:Emit(1)
			end
		elseif d:IsA("PointLight") then
			local old = d.Enabled
			d.Enabled = true
			task.delay(0.08, function()
				if d and d.Parent then
					d.Enabled = old
				end
			end)
		end
	end
end

local function setEnabledDeep(inst, enabled)
	for _, d in ipairs(inst:GetDescendants()) do
		if d:IsA("ParticleEmitter") or d:IsA("Beam") or d:IsA("Trail") then
			d.Enabled = enabled
		elseif d:IsA("PointLight") then
			d.Enabled = enabled
		end
	end
end

local function sanitizeBasePart(part)
	part.Anchored = false
	part.CanCollide = false
	part.CanTouch = false
	part.CanQuery = false
	part.Massless = true
	part.CastShadow = false
	part.AssemblyLinearVelocity = Vector3.zero
	part.AssemblyAngularVelocity = Vector3.zero
	part.Velocity = Vector3.zero
	part.RotVelocity = Vector3.zero
end

local function sanitizeClone(root)
	for _, d in ipairs(root:GetDescendants()) do
		if d:IsA("BasePart") then
			sanitizeBasePart(d)
		elseif d:IsA("Script") or d:IsA("LocalScript") then
			pcall(function()
				d.Disabled = true
			end)
		end
	end

	if root:IsA("BasePart") then
		sanitizeBasePart(root)
	end
end

local function getAttachPartForClone(clone)
	if clone:IsA("BasePart") then
		return clone
	end

	if clone:IsA("Model") then
		return clone.PrimaryPart or clone:FindFirstChildWhichIsA("BasePart", true)
	end

	return clone:FindFirstChildWhichIsA("BasePart", true)
end

function VFXRuntime.new(context)
	local self = setmetatable({}, VFXRuntime)
	self.Context = context
	self.Bundle = nil
	self.Named = {}
	self.WolfObjects = {}
	return self
end

function VFXRuntime:loadBundle(moduleResult)
	self.Bundle = resolveBundle(moduleResult)
	return self.Bundle
end

function VFXRuntime:_tagTracked(obj, wolf)
	obj:SetAttribute("EmoteProperty", true)
	CollectionService:AddTag(obj, "emotestuff" .. self.Context.Character.Name)
	self.Context:trackObject(obj)

	if wolf then
		obj:SetAttribute("Wolf", true)
		table.insert(self.WolfObjects, obj)
	end
end

function VFXRuntime:_attach(targetPart, clone, wolf)
	if not targetPart or not clone then
		return nil
	end

	sanitizeClone(clone)
	clone.Parent = self.Context.Character

	self:_tagTracked(clone, false)

	local attachPart = getAttachPartForClone(clone)
	if not attachPart then
		return clone
	end

	if wolf then
		attachPart:SetAttribute("Wolf", true)
		table.insert(self.WolfObjects, attachPart)
	end

	attachPart.CFrame = targetPart.CFrame

	local motor = clone:FindFirstChildWhichIsA("Motor6D", true)
	if motor and attachPart ~= targetPart then
		motor.Part0 = targetPart
		motor.Part1 = attachPart
		motor.Parent = targetPart
		motor:SetAttribute("EmoteProperty", true)
		self.Context:trackObject(motor)
	else
		local weld = Instance.new("WeldConstraint")
		weld.Part0 = targetPart
		weld.Part1 = attachPart
		weld.Parent = attachPart
		weld:SetAttribute("EmoteProperty", true)
		self.Context:trackObject(weld)
	end

	return clone
end

function VFXRuntime:_findSource(path)
	if not self.Bundle then
		return nil
	end

	local name = path:match("([^/]+)$") or path
	return self.Bundle:FindFirstChild(name, true)
end

function VFXRuntime:_resolveTarget(path)
	local name = path:match("([^/]+)$") or path

	if name == "HumanoidRootPart" then
		return self.Context.Root
	elseif name == "Left Arm" then
		return RigMap.getArm(self.Context.Character, "Left")
	elseif name == "Right Arm" then
		return RigMap.getArm(self.Context.Character, "Right")
	else
		return self.Context.Character:FindFirstChild(name)
	end
end

function VFXRuntime:spawnStartup(assetsConfig)
	if not self.Bundle then
		return
	end

	for _, cfg in ipairs(assetsConfig.Startup or {}) do
		local source = self:_findSource(cfg.From)
		local target = self:_resolveTarget(cfg.To)

		if source and target then
			local clone = source:Clone()
			local attached = self:_attach(target, clone, cfg.SetWolf)
			if attached then
				self.Named[source.Name] = attached
			end
		end
	end
end

function VFXRuntime:disableWolfChildren()
	for _, inst in ipairs(self.WolfObjects) do
		if inst and inst.Parent then
			setEnabledDeep(inst, false)
		end
	end
end

function VFXRuntime:enableWolfChildren()
	for _, inst in ipairs(self.WolfObjects) do
		if inst and inst.Parent then
			setEnabledDeep(inst, true)
		end
	end
end

function VFXRuntime:spawnOptional(name, targetPart)
	if not self.Bundle then
		return nil
	end

	local source = self.Bundle:FindFirstChild(name, true)
	if not source or not targetPart then
		return nil
	end

	local clone = source:Clone()
	local attached = self:_attach(targetPart, clone, false)
	if attached then
		self.Named[name] = attached
	end
	return attached
end

function VFXRuntime:emitSparks(multiplier)
	local sparks = self.Named.Sparks2
	if not sparks then
		sparks = self:spawnOptional("Sparks2", self.Context.Root)
	end

	if sparks then
		emitAll(sparks, multiplier or 1)
	end
end

function VFXRuntime:spawnSpin(parts)
	for _, name in ipairs(parts or {}) do
		local target = name:find("L") and RigMap.getArm(self.Context.Character, "Left") or RigMap.getArm(self.Context.Character, "Right")
		local spin = self.Named[name]

		if not spin then
			spin = self:spawnOptional(name, target)
		end

		if spin then
			for _, d in ipairs(spin:GetDescendants()) do
				if d:IsA("ParticleEmitter") then
					task.spawn(function()
						d.Enabled = true
						local dur = d:GetAttribute("EmitDuration")
						if typeof(dur) ~= "number" then
							dur = 1.7
						end
						task.wait(dur)
						if d and d.Parent then
							d.Enabled = false
						end
					end)
				end
			end
		end
	end
end

function VFXRuntime:bindMarkers(animator, vfxConfig)
	for markerName, config in pairs(vfxConfig.Keyframes or {}) do
		local signal = animator:GetMarkerReachedSignal(markerName)
		if signal and signal.Connect then
			self.Context:trackConnection(signal:Connect(function()
				if config.Action == "DisableWolfChildren" then
					self:disableWolfChildren()
				elseif config.Action == "EnableWolfChildren" then
					self:enableWolfChildren()
				elseif config.Action == "EmitSparks2" then
					self:emitSparks(config.Multiplier or 1)
				elseif config.Action == "SpawnSpin" then
					self:disableWolfChildren()
					self:spawnSpin(config.Parts or {})
				end
			end))
		end
	end
end

return VFXRuntime
