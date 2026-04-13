return {
	Startup = {
		{ From = "BadWolf/HandleL", To = "Character/Left Arm" },
		{ From = "BadWolf/HandleR", To = "Character/Right Arm" },
		{ From = "BadWolf/Left", To = "Character/HumanoidRootPart" },
		{ From = "BadWolf/Right", To = "Character/HumanoidRootPart" },
	},
	Markers = {
		clang = { Spawn = "Sparks2" },
		spin = { Spawn = { "SpinL", "SpinR" } },
	},
}
