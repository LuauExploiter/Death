local CollectionService = game:GetService("CollectionService")

local RigMap = require(script.Parent.RigMap)

local VFXRuntime = {}
VFXRuntime.__index = VFXRuntime

local function resolveBundle(moduleResult)
	if typeof(moduleResult) == "Instance" then
		return moduleResult:Clone()
	end

	if type(moduleResult) == "function" then
		local built = moduleResult()
		if typeof(built) == "Instance" then
			return built
		end
	end

	if type(moduleResult) == "table" then
		if typeof(moduleResult.Root) == "Instance" then
			return moduleResult.Root:Clone()
		end
		if type(moduleResult.Create) == "function" then
			local built = moduleResult.Create()
			if typeof(built) == "Instance" then
				return built
			end
		end
		if type(moduleResult.Build) == "function" then
			local built = moduleResult.Build()
			if typeof(built) == "Instance" then
				return built
			end
		end
		if type(moduleResult.New) == "function" then
			local built = moduleResult.New()
			if typeof(built) == "Instance" then
				return built
			end
		end
	end

	error("VFXRuntime: unsupported serialized bundle format")
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
			task.delay(0.1, function()
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

function VFXRuntime.new(context)
	local self = setmetatable({}, VFXRuntime)
	self.Context = context
	self.Bundle = nil
	self.Named = {}
	return self
end

function VFXRuntime:loadBundle(moduleResult)
	self.Bundle = resolveBundle(moduleResult)
	self.Bundle.Parent = nil
	return self.Bundle
end

function VFXRuntime:attachClone(part, clone, wolf)
	clone:SetAttribute("EmoteProperty", true)
	if wolf then
		clone:SetAttribute("Wolf", true)
	end

	if not part then
		return nil
	end

	clone.Parent = part
	CollectionService:AddTag(clone, "emotestuff" .. self.Context.Character.Name)
	self.Context:trackObject(clone)

	local motor = clone:FindFirstChildOfClass("Motor6D")
	if motor then
		motor:SetAttribute("EmoteProperty", true)
		motor.Part0 = part
		motor.Part1 = clone
		motor.Parent = part
		CollectionService:AddTag(motor, "emotestuff" .. self.Context.Character.Name)
		self.Context:trackObject(motor)
	elseif clone:IsA("BasePart") then
		local weld = Instance.new("WeldConstraint")
		weld.Part0 = part
		weld.Part1 = clone
		weld.Parent = clone
		weld:SetAttribute("EmoteProperty", true)
		self.Context:trackObject(weld)
	end

	return clone
end

function VFXRuntime:spawnStartup(assetsConfig)
	if not self.Bundle then
		return
	end

	for _, cfg in ipairs(assetsConfig.Startup or {}) do
		local source = self.Bundle:FindFirstChild(cfg.From:match("([^/]+)$"), true)
		if source then
			local target
			if cfg.To:find("Left Arm") then
				target = RigMap.getArm(self.Context.Character, "Left")
			elseif cfg.To:find("Right Arm") then
				target = RigMap.getArm(self.Context.Character, "Right")
			elseif cfg.To:find("HumanoidRootPart") then
				target = self.Context.Root
			else
				target = self.Context.Character:FindFirstChild(cfg.To:match("([^/]+)$"))
			end

			if target then
				local clone = source:Clone()
				self.Named[source.Name] = self:attachClone(target, clone, cfg.SetWolf)
			end
		end
	end
end

function VFXRuntime:disableWolfChildren()
	for _, child in ipairs(self.Context.Root:GetChildren()) do
		if child:GetAttribute("Wolf") then
			setEnabledDeep(child, false)
		end
	end
end

function VFXRuntime:enableWolfChildren()
	for _, child in ipairs(self.Context.Root:GetChildren()) do
		if child:GetAttribute("Wolf") then
			setEnabledDeep(child, true)
		end
	end
end

function VFXRuntime:spawnOptional(name, targetPart)
	if not self.Bundle then
		return nil
	end
	local source = self.Bundle:FindFirstChild(name, true)
	if not source then
		return nil
	end
	local clone = source:Clone()
	local attached = self:attachClone(targetPart, clone, false)
	self.Named[name] = attached
	return attached
end

function VFXRuntime:emitSparks(multiplier)
	local sparks = self.Named.Sparks2
	if not sparks then
		sparks = self:spawnOptional("Sparks2", self.Context.Root)
	end
	if sparks then
		emitAll(sparks, multiplier)
	end
end

function VFXRuntime:spawnSpin(parts)
	for _, name in ipairs(parts or {}) do
		local side = name:find("L") and "Left" or "Right"
		local part = RigMap.getArm(self.Context.Character, side)
		local spin = self.Named[name]
		if not spin then
			spin = self:spawnOptional(name, part)
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
		self.Context:trackConnection(animator:GetMarkerReachedSignal(markerName):Connect(function()
			if config.Action == "DisableWolfChildren" then
				self:disableWolfChildren()
			elseif config.Action == "EnableWolfChildren" then
				self:enableWolfChildren()
			elseif config.Action == "EmitSparks2" then
				self:emitSparks(config.Multiplier or 1)
			elseif config.Action == "SpawnSpin" then
				self:disableWolfChildren()
				self:spawnSpin(config.Parts)
			end
		end))
	end
end

return VFXRuntime
