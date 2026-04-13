local RigMap = {}

local ARM_NAMES = {
	Left = {
		"Left Arm",
		"LeftHand",
		"LeftLowerArm",
		"LeftUpperArm",
	},
	Right = {
		"Right Arm",
		"RightHand",
		"RightLowerArm",
		"RightUpperArm",
	},
}

function RigMap.getRoot(character)
	return character:FindFirstChild("HumanoidRootPart")
end

function RigMap.getTorso(character)
	return character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
end

function RigMap.getHead(character)
	return character:FindFirstChild("Head")
end

function RigMap.getArm(character, side)
	local names = ARM_NAMES[side]
	if not names then
		return nil
	end
	for _, name in ipairs(names) do
		local found = character:FindFirstChild(name)
		if found then
			return found
		end
	end
	return nil
end

return RigMap
