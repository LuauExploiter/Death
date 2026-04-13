local Shared = script.Parent:WaitForChild("Shared")
local EmotesFolder = script.Parent:WaitForChild("Emotes")
local DeathFolder = EmotesFolder:WaitForChild("Death")

local Animator = require(Shared:WaitForChild("Animator"):WaitForChild("Source"):WaitForChild("Main"))

local Runtime = Shared:WaitForChild("Runtime")
local CharacterRuntime = require(Runtime:WaitForChild("Character"))
local SoundRuntime = require(Runtime:WaitForChild("Sound"))
local VFXRuntime = require(Runtime:WaitForChild("VFX"))
local CameraRuntime = require(Runtime:WaitForChild("Camera"))
local Cleanup = require(Runtime:WaitForChild("Cleanup"))
local InputRuntime = require(Runtime:WaitForChild("Input"))
local GuiRuntime = require(Runtime:WaitForChild("Gui"))

local Manifest = require(DeathFolder:WaitForChild("Manifest"))
local AnimationData = require(DeathFolder:WaitForChild("AnimationData"))
local Sounds = require(DeathFolder:WaitForChild("Sounds"))
local VFXData = require(DeathFolder:WaitForChild("VFX"))
local CameraData = require(DeathFolder:WaitForChild("Camera"))
local Assets = require(DeathFolder:WaitForChild("Assets"))

local Adapter = require(script.Parent:WaitForChild("GameAdapters"):WaitForChild("Universal"))

local Loader = {}

local cachedBadWolf
local cachedBadWolfAttempted = false

local cachedHotbar
local cachedHotbarAttempted = false

local cachedBar
local cachedBarAttempted = false

local cachedEmotes
local cachedEmotesAttempted = false

local cachedIcon
local cachedIconAttempted = false

local cachedNewIcon
local cachedNewIconAttempted = false

local function resolveBadWolfModule()
	local root = script.Parent.Parent
	local assetsFolder = root:FindFirstChild("assets")
	if not assetsFolder then
		return nil
	end

	local vfxFolder = assetsFolder:FindFirstChild("vfx")
	if not vfxFolder then
		return nil
	end

	local deathAssetsFolder = vfxFolder:FindFirstChild("death")
	if not deathAssetsFolder then
		return nil
	end

	return deathAssetsFolder:FindFirstChild("BadWolf")
end

local function resolveGuiModule(name)
	local root = script.Parent.Parent
	local assetsFolder = root:FindFirstChild("assets")
	if not assetsFolder then
		return nil
	end

	local guiFolder = assetsFolder:FindFirstChild("gui")
	if not guiFolder then
		return nil
	end

	return guiFolder:FindFirstChild(name)
end

local function preloadBadWolf()
	if cachedBadWolfAttempted then
		return
	end

	cachedBadWolfAttempted = true

	local badWolfModule = resolveBadWolfModule()
	if badWolfModule then
		local ok, result = pcall(require, badWolfModule)
		if ok then
			cachedBadWolf = result
		else
			warn("[Death] BadWolf preload failed:", result)
		end
	end
end

local function preloadGui()
	if not cachedHotbarAttempted then
		cachedHotbarAttempted = true
		local moduleScript = resolveGuiModule("Hotbar")
		if moduleScript then
			local ok, result = pcall(require, moduleScript)
			if ok then
				cachedHotbar = result
			else
				warn("[Death] Hotbar preload failed:", result)
			end
		end
	end

	if not cachedBarAttempted then
		cachedBarAttempted = true
		local moduleScript = resolveGuiModule("Bar")
		if moduleScript then
			local ok, result = pcall(require, moduleScript)
			if ok then
				cachedBar = result
			else
				warn("[Death] Bar preload failed:", result)
			end
		end
	end

	if not cachedEmotesAttempted then
		cachedEmotesAttempted = true
		local moduleScript = resolveGuiModule("Emotes")
		if moduleScript then
			local ok, result = pcall(require, moduleScript)
			if ok then
				cachedEmotes = result
			else
				warn("[Death] Emotes preload failed:", result)
			end
		end
	end

	if not cachedIconAttempted then
		cachedIconAttempted = true
		local moduleScript = resolveGuiModule("Icon")
		if moduleScript then
			local ok, result = pcall(require, moduleScript)
			if ok then
				cachedIcon = result
			end
		end
	end

	if not cachedNewIconAttempted then
		cachedNewIconAttempted = true
		local moduleScript = resolveGuiModule("NewIcon")
		if moduleScript then
			local ok, result = pcall(require, moduleScript)
			if ok then
				cachedNewIcon = result
			end
		end
	end
end

preloadBadWolf()
preloadGui()

function Loader.play(character)
	local context = CharacterRuntime.new(character)
	local sounds = SoundRuntime.new()
	local vfx = VFXRuntime.new(context)
	local camera = CameraRuntime.new(context)
	local gui = GuiRuntime.new(context)

	local session = {
		Playing = true,
		Context = context,
		Manifest = Manifest,
		Sounds = sounds,
		VFX = vfx,
		Camera = camera,
		Gui = gui,
		Animator = nil,
	}

	function session:Stop(reason)
		if not self.Playing then
			return
		end

		self.Playing = false

		if context._restoreMobileButtons then
			context._restoreMobileButtons()
		end

		Cleanup.stopSession(self, Sounds.Main and Sounds.Main.FadeOutTime or 0.08)
	end

	context:setupForManifest(Manifest)
	context:lockWalkSpeed(Manifest.WalkSpeed or 5.333333492279053)

	local animator = Animator.new(character, {
		Id = AnimationData.Id or AnimationData.AnimationId,
		Markers = AnimationData.Markers or {},
		Looped = AnimationData.Looped or Manifest.Looped,
	})

	animator.Looped = AnimationData.Looped or Manifest.Looped
	session.Animator = animator

	if cachedBadWolf then
		local ok, err = pcall(function()
			vfx:loadBundle(cachedBadWolf)
			vfx:spawnStartup(Assets)
			vfx:bindMarkers(animator, VFXData)
		end)

		if not ok then
			warn("[Death] BadWolf runtime load failed:", err)
		end
	end

	if cachedHotbar then
		pcall(function()
			gui:addHotbar(cachedHotbar)
		end)
	end

	if cachedBar then
		pcall(function()
			gui:addBar(cachedBar)
		end)
	end

	if cachedEmotes then
		pcall(function()
			gui:addEmotes(cachedEmotes)
		end)
	end

	if cachedIcon then
		pcall(function()
			gui:addIcon(cachedIcon)
		end)
	end

	if cachedNewIcon then
		pcall(function()
			gui:addNewIcon(cachedNewIcon)
		end)
	end

	camera:bindMarkers(animator, CameraData)

	animator:Play(0.03, 1, 1)

	if Sounds.Main then
		sounds:playMain(context.Root, Sounds.Main)
	end

	InputRuntime.bind(session, Adapter)

	context:trackConnection(animator.Stopped.Event:Connect(function()
		if Manifest.Infinite then
			return
		end
		session:Stop("anim-stopped")
	end))

	return session
end

return Loader
