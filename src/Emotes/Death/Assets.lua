return {
	Bundle = "BadWolf",

	Startup = {
		{ From = "BadWolf/HandleL", To = "Character/Left Arm" },
		{ From = "BadWolf/HandleR", To = "Character/Right Arm" },
		{ From = "BadWolf/Left", To = "Character/HumanoidRootPart", SetWolf = true },
		{ From = "BadWolf/Right", To = "Character/HumanoidRootPart", SetWolf = true },
	},

	Optional = {
		{ From = "BadWolf/Sparks2", To = "Character" },
		{ From = "BadWolf/SpinL", To = "Character/Left Arm" },
		{ From = "BadWolf/SpinR", To = "Character/Right Arm" },
	},
}
