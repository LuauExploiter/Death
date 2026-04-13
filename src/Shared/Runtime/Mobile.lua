local Mobile = {}

local function isLikelyMoveButton(button)
	local name = string.lower(button.Name or "")
	local text = ""
	pcall(function()
		text = string.lower(button.Text or "")
	end)

	if name:find("jump") or name:find("dash") or name:find("block") or name:find("punch") or name:find("m1") then
		return false
	end
	if text:find("jump") or text:find("dash") or text:find("block") or text:find("punch") or text:find("m1") then
		return false
	end
	if name:find("move") or name:find("skill") or name:find("ability") then
		return true
	end
	if text:find("move") or text:find("skill") or text:find("ability") then
		return true
	end
	if name:match("^%d+$") or text:match("^%d+$") then
		return true
	end
	return false
end

function Mobile.disableLikelyMoveButtons(playerGui)
	local state = {}

	for _, obj in ipairs(playerGui:GetDescendants()) do
		if obj:IsA("GuiButton") and isLikelyMoveButton(obj) then
			state[obj] = {
				Active = obj.Active,
				AutoButtonColor = obj.AutoButtonColor,
			}
			pcall(function()
				state[obj].Interactable = obj.Interactable
			end)

			pcall(function()
				obj.Active = false
			end)
			pcall(function()
				obj.Interactable = false
			end)
			pcall(function()
				obj.AutoButtonColor = false
			end)
		end
	end

	return state
end

function Mobile.restoreButtons(state)
	for button, data in pairs(state or {}) do
		if button and button.Parent then
			pcall(function()
				button.Active = data.Active
			end)
			pcall(function()
				button.AutoButtonColor = data.AutoButtonColor
			end)
			pcall(function()
				button.Interactable = data.Interactable
			end)
		end
	end
end

function Mobile.hookNamedButtons(context, playerGui, namesToCallbacks)
	local hooked = {}

	local function connectButton(button, callback)
		if hooked[button] then
			return
		end
		hooked[button] = true
		context:trackConnection(button.MouseButton1Down:Connect(callback))
		context:trackConnection(button.Activated:Connect(callback))
	end

	local function scan()
		for name, callback in pairs(namesToCallbacks) do
			for _, obj in ipairs(playerGui:GetDescendants()) do
				if obj:IsA("GuiButton") and obj.Name == name then
					connectButton(obj, callback)
				end
			end
		end
	end

	scan()
	context:trackConnection(playerGui.DescendantAdded:Connect(function(obj)
		if obj:IsA("GuiButton") and namesToCallbacks[obj.Name] then
			connectButton(obj, namesToCallbacks[obj.Name])
		end
	end))
end

return Mobile
