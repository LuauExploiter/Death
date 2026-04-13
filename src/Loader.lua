local Shared = script.Parent:WaitForChild("Shared")
local EmotesFolder = script.Parent:WaitForChild("Emotes")
local DeathFolder = EmotesFolder:WaitForChild("Death")

local Animator = require(Shared.Animator:WaitForChild("Main"))
local CharacterRuntime = require(Shared.Runtime:WaitForChild("Character"))
local SoundRuntime = require(Shared.Runtime:WaitForChild("Sound"))
local VFXRuntime = require(Shared.Runtime:WaitForChild("VFX"))
local CameraRuntime = require(Shared.Runtime:WaitForChild("Camera"))
local Cleanup = require(Shared.Runtime:WaitForChild("Cleanup"))
local InputRuntime = require(Shared.Runtime:WaitForChild("Input"))
local Util = require(Shared.Runtime:WaitForChild("Util"))

local Manifest = require(DeathFolder:WaitForChild("Manifest"))
local AnimationData = require(DeathFolder:WaitForChild("AnimationData"))
local Sounds = require(DeathFolder:WaitForChild("Sounds"))
local VFXData = require(DeathFolder:WaitForChild("VFX"))
local CameraData = require(DeathFolder:WaitForChild("Camera"))
local Assets = require(DeathFolder:WaitForChild("Assets"))
local Adapter = require(script.Parent:WaitForChild("GameAdapters"):WaitForChild("Universal"))

local Loader = {}

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

	local deathFolder = vfxFolder:FindFirstChild("death")
	if not deathFolder then
		return nil
	end

	return deathFolder:FindFirstChild("BadWolf")
end

function Loader.play(character)
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

	local animator = Animator.new(character, {
		Id = AnimationData.Id or AnimationData.AnimationId,
		Markers = AnimationData.Markers or {},
		Looped = AnimationData.Looped or Manifest.Looped,
	})
	animator.Looped = AnimationData.Looped or Manifest.Looped
	session.Animator = animator

	local badWolfModule = resolveBadWolfModule()
	if badWolfModule then
		local ok, result = pcall(require, badWolfModule)
		if ok then
			vfx:loadBundle(result)
			vfx:spawnStartup(Assets)
			vfx:bindMarkers(animator, VFXData)
		end
	end

	camera:bindMarkers(animator, CameraData)

	local mainSound
	if Sounds.Main then
		mainSound = sounds:playMain(context.Root, Sounds.Main)
	end

	animator:Play(0.03, 1, 1)

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
