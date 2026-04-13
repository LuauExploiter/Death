local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local Mobile = require(script.Parent.Mobile)

local InputRuntime = {}

local MOVE_BLOCK_ACTION = "DEATH_MOVE_BLOCK"
local JUMP_CANCEL_ACTION = "DEATH_JUMP_CANCEL"

local MOVE_KEYS = {
	Enum.KeyCode.One,
	Enum.KeyCode.Two,
	Enum.KeyCode.Three,
	Enum.KeyCode.Four,
	Enum.KeyCode.Five,
	Enum.KeyCode.Six,
	Enum.KeyCode.Seven,
	Enum.KeyCode.Eight,
	Enum.KeyCode.Nine,
	Enum.KeyCode.Zero,
	Enum.KeyCode.E,
	Enum.KeyCode.R,
	Enum.KeyCode.T,
	Enum.KeyCode.Y,
	Enum.KeyCode.G,
	Enum.KeyCode.Z,
	Enum.KeyCode.X,
	Enum.KeyCode.C,
	Enum.KeyCode.V,
}

local function beginJumpSuppress(context)
	local root = context.Root
	local humanoid = context.Humanoid

	if not root or not root.Parent or not humanoid or not humanoid.Parent then
		return
	end

	local startPos = root.Position
	local oldAnchored = root.Anchored
	local originalJumpPower = context.OriginalJumpPower or humanoid.JumpPower
	local originalJumpHeight = context.OriginalJumpHeight or humanoid.JumpHeight

	humanoid.Jump = false

	pcall(function()
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
	end)

	pcall(function()
		humanoid.JumpPower = 0
	end)

	pcall(function()
		humanoid.JumpHeight = 0
	end)

	task.spawn(function()
		if root and root.Parent then
			root.Anchored = true
		end

		for _ = 1, 2 do
			if not root or not root.Parent or not humanoid or not humanoid.Parent then
				break
			end

			humanoid.Jump = false

			pcall(function()
				humanoid:ChangeState(Enum.HumanoidStateType.Running)
			end)

			local pos = root.Position
			local vel = root.AssemblyLinearVelocity

			root.AssemblyLinearVelocity = Vector3.new(vel.X, 0, vel.Z)
			root.CFrame = CFrame.new(pos.X, startPos.Y, pos.Z) * (root.CFrame - root.Position)

			task.wait()
		end

		if root and root.Parent then
			root.Anchored = oldAnchored
			local pos = root.Position
			root.CFrame = CFrame.new(pos.X, startPos.Y, pos.Z) * (root.CFrame - root.Position)
		end

		if humanoid and humanoid.Parent then
			pcall(function()
				humanoid.JumpPower = originalJumpPower
			end)

			pcall(function()
				humanoid.JumpHeight = originalJumpHeight
			end)

			pcall(function()
				humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
			end)

			pcall(function()
				humanoid.PlatformStand = false
			end)

			pcall(function()
				humanoid.AutoRotate = context.OriginalAutoRotate
			end)

			pcall(function()
				humanoid.Jump = false
			end)

			pcall(function()
				humanoid:ChangeState(Enum.HumanoidStateType.Running)
			end)
		end
	end)
end

function InputRuntime.bind(session, adapter)
	local context = session.Context
	local manifest = session.Manifest
	local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
	local blockedButtonsState = nil

	if manifest.BlockMoves then
		blockedButtonsState = Mobile.disableLikelyMoveButtons(playerGui)
	end

	local function stop(reason)
		session:Stop(reason)
	end

	ContextActionService:BindActionAtPriority(
		JUMP_CANCEL_ACTION,
		function(_, inputState)
			if not session.Playing then
				return Enum.ContextActionResult.Pass
			end

			if inputState == Enum.UserInputState.Begin then
				beginJumpSuppress(context)
				stop("jump")
			end

			return Enum.ContextActionResult.Sink
		end,
		false,
		5000,
		Enum.KeyCode.Space,
		Enum.PlayerActions.CharacterJump
	)

	ContextActionService:BindActionAtPriority(
		MOVE_BLOCK_ACTION,
		function(_, inputState)
			if not session.Playing or not manifest.BlockMoves then
				return Enum.ContextActionResult.Pass
			end

			if inputState == Enum.UserInputState.Begin then
				return Enum.ContextActionResult.Sink
			end

			return Enum.ContextActionResult.Pass
		end,
		false,
		5000,
		unpack(MOVE_KEYS)
	)

	context:trackConnection(UserInputService.InputBegan:Connect(function(input, processed)
		if processed or not session.Playing then
			return
		end

		if input.KeyCode == Enum.KeyCode.Q or input.KeyCode == Enum.KeyCode.ButtonY then
			stop("dash")
			return
		end

		if input.KeyCode == Enum.KeyCode.F
			or input.KeyCode == Enum.KeyCode.ButtonX
			or input.UserInputType == Enum.UserInputType.MouseButton2 then
			stop("block")
			return
		end

		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			stop("m1")
			return
		end
	end))

	context:trackConnection(context.Character.ChildAdded:Connect(function(child)
		if table.find(adapter.DashChildren or {}, child.Name) then
			stop("dashchild")
			return
		end

		if table.find(adapter.M1Children or {}, child.Name) then
			stop("m1child")
			return
		end
	end))

	if adapter.BlockAttribute then
		context:trackConnection(context.Character:GetAttributeChangedSignal(adapter.BlockAttribute):Connect(function()
			if context.Character:GetAttribute(adapter.BlockAttribute) then
				stop("blocking-attr")
			end
		end))
	end

	if adapter.EmoteStartedAttribute then
		context:trackConnection(context.Character:GetAttributeChangedSignal(adapter.EmoteStartedAttribute):Connect(function()
			local value = context.Character:GetAttribute(adapter.EmoteStartedAttribute)
			if typeof(value) == "number" and math.abs(value - context.StartTick) > 0.001 then
				stop("other-emote")
			end
		end))
	end

	Mobile.hookNamedButtons(context, playerGui, {
		[(adapter.MobileButtons and adapter.MobileButtons.Jump) or "JumpButton"] = function()
			beginJumpSuppress(context)
			stop("mobile-jump")
		end,
		[(adapter.MobileButtons and adapter.MobileButtons.Dash) or "DashButton"] = function()
			stop("mobile-dash")
		end,
		[(adapter.MobileButtons and adapter.MobileButtons.Block) or "BlockButton"] = function()
			stop("mobile-block")
		end,
		[(adapter.MobileButtons and adapter.MobileButtons.M1) or "PunchButton"] = function()
			stop("mobile-m1")
		end,
	})

	context:trackConnection(context.Humanoid.Died:Connect(function()
		stop("died")
	end))

	context._restoreMobileButtons = function()
		Mobile.restoreButtons(blockedButtonsState)
		ContextActionService:UnbindAction(JUMP_CANCEL_ACTION)
		ContextActionService:UnbindAction(MOVE_BLOCK_ACTION)
	end
end

return InputRuntime
