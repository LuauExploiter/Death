local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Loader = require(script.Parent:WaitForChild("Loader"))

local currentSession

local function stopCurrent()
	if currentSession and currentSession.Stop then
		pcall(function()
			currentSession:Stop("rerun")
		end)
	end
	currentSession = nil
end

local function runForCharacter(character)
	stopCurrent()

	local ok, result = pcall(function()
		return Loader.play(character)
	end)

	if ok then
		currentSession = result
	else
		warn("[Death] Failed to start:", result)
	end
end

local function onCharacterAdded(character)
	character:WaitForChild("Humanoid")
	character:WaitForChild("HumanoidRootPart")
	runForCharacter(character)
end

getgenv().DeathStart = function()
	local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	onCharacterAdded(character)
end

if LocalPlayer.Character then
	task.spawn(onCharacterAdded, LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
