local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local Shared = script.Parent:WaitForChild("Shared")
local EmotesFolder = script.Parent:WaitForChild("Emotes")
local DeathFolder = EmotesFolder:WaitForChild("Death")

local AnimatorSource = Shared:WaitForChild("Animator"):WaitForChild("Source")
local AnimatorModule = AnimatorSource:FindFirstChild("Animator") or AnimatorSource:FindFirstChild("Main")
local Animator = require(AnimatorModule)

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

local Root = script.Parent.Parent
local assetsFolder = Root:FindFirstChild("assets")
local animationsFolder = assetsFolder and assetsFolder:FindFirstChild("animations")
local guiFolder = assetsFolder and assetsFolder:FindFirstChild("gui")
local vfxFolder = assetsFolder and assetsFolder:FindFirstChild("vfx")
local deathAnimModule = animationsFolder and animationsFolder:FindFirstChild("death")
local deathVfxFolder = vfxFolder and vfxFolder:FindFirstChild("death")
local badWolfModule = deathVfxFolder and deathVfxFolder:FindFirstChild("BadWolf")

local HotbarModule = guiFolder and guiFolder:FindFirstChild("Hotbar")
local BarModule = guiFolder and guiFolder:FindFirstChild("Bar")
local EmotesModule = guiFolder and guiFolder:FindFirstChild("Emotes")

local AnimationAsset = deathAnimModule and require(deathAnimModule) or nil

local Loader = {}

local persistentGui = GuiRuntime.new()
local persistentGuiBuilt = false
local cachedBadWolf
local currentSession

local function ensureCompatChild(parent, className, name)
	local existing = parent:FindFirstChild(name)
	if existing and existing:IsA(className) then
		return existing
	end
	if existing then
		existing:Destroy()
	end
	local obj = Instance.new(className)
	obj.Name = name
	obj.Parent = parent
	return obj
end

local function ensureGuiCompatScaffold()
	do
		local hotbar = ensureCompatChild(StarterGui, "ScreenGui", "Hotbar")
		hotbar.ResetOnSpawn = false
		local backpack = ensureCompatChild(hotbar, "Frame", "Backpack")
		backpack.BackgroundTransparency = 1
		backpack.Size = UDim2.fromScale(1, 1)
		ensureCompatChild(backpack, "LocalScript", "LocalScript")
	end

	do
		local emotes = ensureCompatChild(StarterGui, "ScreenGui", "Emotes")
		emotes.ResetOnSpawn = false
		ensureCompatChild(emotes, "LocalScript", "LocalScript")
	end

	do
		local bar = ensureCompatChild(StarterGui, "ScreenGui", "Bar")
		bar.ResetOnSpawn = false
	end
end

local function ensureCompatEmotesFolder()
	local folder = ReplicatedStorage:FindFirstChild("Emotes")
	if folder then
		return folder, false
	end

	folder = Instance.new("Folder")
	folder.Name = "Emotes"
	folder.Parent = ReplicatedStorage
	return folder, true
end

local function requireDetachedBadWolf()
	if cachedBadWolf ~= nil then
		return cachedBadWolf
	end

	if not badWolfModule then
		cachedBadWolf = false
		return nil
	end

	local compatFolder, createdCompat = ensureCompatEmotesFolder()

	local ok, result = pcall(require, badWolfModule)
	if ok then
		cachedBadWolf = result
	else
		warn("[Death] BadWolf preload failed:", result)
		cachedBadWolf = false
	end

	if createdCompat and compatFolder and compatFolder.Parent then
		pcall(function()
			compatFolder:Destroy()
		end)
	end

	if cachedBadWolf == false then
		return nil
	end

	return cachedBadWolf
end

local function buildAnimationResolvable()
	local merged = {}

	if type(AnimationData) == "table" then
		for k, v in pairs(AnimationData) do
			merged[k] = v
		end
	end

	if type(AnimationAsset) == "table" then
		for k, v in pairs(AnimationAsset) do
			merged[k] = v
		end
	end

	if next(merged) then
		return merged
	end

	return {
		Id = AnimationData.Id or AnimationData.AnimationId,
		Markers = AnimationData.Markers or {},
		Looped = AnimationData.Looped or Manifest.Looped,
	}
end

local function triggerDeath()
	local localPlayer = Players.LocalPlayer
	if not localPlayer then
		return
	end

	local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()

	if currentSession and currentSession.Stop then
		pcall(function()
			currentSession:Stop("ui-rerun")
		end)
	end

	local ok, result = pcall(function()
		return Loader.play(character)
	end)

	if ok then
		currentSession = result
	else
		warn("[Death] Trigger failed:", result)
	end
end

local function ensureExactGui()
	if persistentGuiBuilt then
		return
	end

	persistentGuiBuilt = true

	ensureGuiCompatScaffold()

	local hotbarBuilt = nil
	local barBuilt = nil
	local emotesBuilt = nil

	if HotbarModule then
		local ok, result = pcall(require, HotbarModule)
		if ok then
			hotbarBuilt = result
		else
			warn("[Death] Hotbar require failed:", result)
		end
	end

	if BarModule then
		local ok, result = pcall(require, BarModule)
		if ok then
			barBuilt = result
		else
			warn("[Death] Bar require failed:", result)
		end
	end

	if EmotesModule then
		local ok, result = pcall(require, EmotesModule)
		if ok then
			emotesBuilt = result
		else
			warn("[Death] Emotes require failed:", result)
		end
	end

	persistentGui:addExactHotbar(hotbarBuilt, triggerDeath)
	persistentGui:addExactBar(barBuilt)
	local emotesGui = persistentGui:addExactEmotes(emotesBuilt, triggerDeath)

	pcall(function()
		persistentGui:addTopbarEmotesIcon(emotesGui)
	end)
end

function Loader.play(character)
	ensureExactGui()

	local context = CharacterRuntime.new(character)
	local sounds = SoundRuntime.new()
	local vfx = VFXRuntime.new(context)
	local camera = CameraRuntime.new(context)

	local session = {
		Playing = true,
		Context = context,
		Manifest = Manifest,
		Sounds = sounds,
		VFX = vfx,
		Camera = camera,
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

	local animationResolvable = buildAnimationResolvable()
	local animator = Animator.new(character, animationResolvable)
	animator.Looped = animationResolvable.Looped or animationResolvable.Loop or Manifest.Looped
	session.Animator = animator

	local detachedBadWolf = requireDetachedBadWolf()
	if detachedBadWolf then
		local ok, err = pcall(function()
			vfx:loadBundle(detachedBadWolf)
			vfx:spawnStartup(Assets)
			vfx:bindMarkers(animator, VFXData)
		end)

		if not ok then
			warn("[Death] BadWolf runtime load failed:", err)
		end
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

	currentSession = session
	return session
end

return Loader
