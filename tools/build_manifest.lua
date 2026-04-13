local function build(name, animationPath, soundsPath, vfxPath, cameraPath, cleanupPath, assetsPath)
	return {
		Name = name,
		Animation = animationPath,
		Sounds = soundsPath,
		VFX = vfxPath,
		Camera = cameraPath,
		Cleanup = cleanupPath,
		Assets = assetsPath,
	}
end

return build
