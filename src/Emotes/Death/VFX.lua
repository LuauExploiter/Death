return {
	Startup = {
		Handles = { "HandleL", "HandleR" },
		Root = { "Left", "Right" },
	},

	Keyframes = {
		stop = {
			Action = "DisableWolfChildren",
		},

		clang = {
			Action = "EmitSparks2",
			Multiplier = 2,
		},

		restart = {
			Action = "EnableWolfChildren",
		},

		spin = {
			Action = "SpawnSpin",
			Parts = { "SpinL", "SpinR" },
			UseEmitDuration = true,
		},
	},
}
