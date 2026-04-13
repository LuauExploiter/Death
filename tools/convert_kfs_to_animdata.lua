local function convert(kfs)
	local out = {
		Loop = false,
		Priority = Enum.AnimationPriority.Action,
		Frames = {},
	}

	for _, keyframe in ipairs(kfs:GetKeyframes()) do
		table.insert(out.Frames, {
			Name = keyframe.Name,
			Time = keyframe.Time,
			Pose = {},
		})
	end

	return out
end

return convert
