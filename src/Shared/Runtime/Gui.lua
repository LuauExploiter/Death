local Players = game:GetService("Players")

local GuiRuntime = {}
GuiRuntime.__index = GuiRuntime

local function resolveBundle(moduleResult)
	if typeof(moduleResult) == "Instance" then
		return moduleResult:Clone()
	end

	if type(moduleResult) == "function" then
		local built = moduleResult()
		if typeof(built) == "Instance" then
			return built
		end
	end

	if type(moduleResult) == "table" then
		if typeof(moduleResult.Root) == "Instance" then
			return moduleResult.Root:Clone()
		end
		if type(moduleResult.Create) == "function" then
			local built = moduleResult.Create()
			if typeof(built) == "Instance" then
				return built
			end
		end
		if type(moduleResult.Build) == "function" then
			local built = moduleResult.Build()
			if typeof(built) == "Instance" then
				return built
			end
		end
		if type(moduleResult.New) == "function" then
			local built = moduleResult.New()
			if typeof(built) == "Instance" then
				return built
			end
		end
	end

	error("GuiRuntime: unsupported serialized GUI format")
end

local function disableEmbeddedScripts(root)
	for _, desc in ipairs(root:GetDescendants()) do
		if desc:IsA("LocalScript") or desc:IsA("Script") then
			pcall(function()
				desc.Disabled = true
			end)
		end
	end
end

local function findFirstDescendant(root, name, className)
	for _, desc in ipairs(root:GetDescendants()) do
		if desc.Name == name and (not className or desc:IsA(className)) then
			return desc
		end
	end
	return nil
end

local function clearChildrenExceptLayouts(parent)
	for _, child in ipairs(parent:GetChildren()) do
		if not child:IsA("UIListLayout") and not child:IsA("UIPadding") and not child:IsA("UIGridLayout") then
			child:Destroy()
		end
	end
end

local function makeStroke(parent, color)
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 1.5
	stroke.Color = color
	stroke.Parent = parent
	return stroke
end

local function makeCorner(parent, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = radius or UDim.new(0, 6)
	corner.Parent = parent
	return corner
end

function GuiRuntime.new(context)
	local self = setmetatable({}, GuiRuntime)
	self.Context = context
	self.PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
	return self
end

function GuiRuntime:_removeExisting(name)
	local existing = self.PlayerGui:FindFirstChild(name)
	if existing then
		pcall(function()
			existing:Destroy()
		end)
	end
end

function GuiRuntime:_prepareSupport()
	shared.sfx = shared.sfx or function() end

	if not self.Context.Character:FindFirstChild("Communicate") then
		local remote = Instance.new("RemoteEvent")
		remote.Name = "Communicate"
		remote.Parent = self.Context.Character
	end
end

function GuiRuntime:mountPersistent(moduleResult, nameHint)
	self:_prepareSupport()

	local built = resolveBundle(moduleResult)
	local root

	if built:IsA("ScreenGui") then
		root = built
		root.Name = nameHint or root.Name
		root.ResetOnSpawn = false
		root.Parent = self.PlayerGui
	else
		root = Instance.new("ScreenGui")
		root.Name = nameHint or built.Name
		root.ResetOnSpawn = false
		root.IgnoreGuiInset = true
		built.Parent = root
		root.Parent = self.PlayerGui
	end

	disableEmbeddedScripts(root)
	return root
end

function GuiRuntime:_createHotbarSlot(parent, index, title, onClick, active)
	local button = Instance.new("TextButton")
	button.Name = "DeathSlot" .. tostring(index)
	button.Size = UDim2.fromOffset(64, 64)
	button.BackgroundColor3 = active and Color3.fromRGB(25, 25, 25) or Color3.fromRGB(18, 18, 18)
	button.BorderSizePixel = 0
	button.AutoButtonColor = true
	button.Text = ""
	button.Parent = parent
	makeCorner(button, UDim.new(0, 8))
	makeStroke(button, active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(90, 90, 90))

	local number = Instance.new("TextLabel")
	number.Name = "Number"
	number.BackgroundTransparency = 1
	number.Size = UDim2.fromOffset(16, 16)
	number.Position = UDim2.fromOffset(4, 2)
	number.Font = Enum.Font.GothamBold
	number.Text = tostring(index)
	number.TextColor3 = Color3.fromRGB(255, 255, 255)
	number.TextSize = 12
	number.TextXAlignment = Enum.TextXAlignment.Left
	number.Parent = button

	local label = Instance.new("TextLabel")
	label.Name = "ToolName"
	label.BackgroundTransparency = 1
	label.Size = UDim2.new(1, -8, 1, -8)
	label.Position = UDim2.fromOffset(4, 4)
	label.Font = Enum.Font.GothamBold
	label.Text = title
	label.TextWrapped = true
	label.TextScaled = true
	label.TextColor3 = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(210, 210, 210)
	label.Parent = button

	button.MouseButton1Click:Connect(function()
		if onClick then
			onClick()
		end
	end)

	return button
end

function GuiRuntime:addHotbar(moduleResult, onDeath)
	self:_removeExisting("Hotbar")
	local root = self:mountPersistent(moduleResult, "Hotbar")

	local hotbarContainer = findFirstDescendant(root, "Hotbar", "Frame")
	if not hotbarContainer then
		return root
	end

	clearChildrenExceptLayouts(hotbarContainer)

	local layout = hotbarContainer:FindFirstChildOfClass("UIListLayout")
	if not layout then
		layout = Instance.new("UIListLayout")
		layout.FillDirection = Enum.FillDirection.Horizontal
		layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		layout.VerticalAlignment = Enum.VerticalAlignment.Center
		layout.Padding = UDim.new(0, 8)
		layout.Parent = hotbarContainer
	end

	self:_createHotbarSlot(hotbarContainer, 1, "PLACEHOLDER", nil, false)
	self:_createHotbarSlot(hotbarContainer, 2, "PLACEHOLDER", nil, false)
	self:_createHotbarSlot(hotbarContainer, 3, "PLACEHOLDER", nil, false)
	self:_createHotbarSlot(hotbarContainer, 4, "Death", onDeath, true)

	return root
end

function GuiRuntime:addBar(moduleResult)
	self:_removeExisting("Bar")
	local root = self:mountPersistent(moduleResult, "Bar")

	for _, desc in ipairs(root:GetDescendants()) do
		if desc:IsA("TextLabel") then
			if desc.Text == "SERIOUS MODE" then
				desc.Text = "DEATH EMOTE BY HIKLO"
			elseif desc.Name == "Ult" or desc.Text == "[G]" then
				desc.Visible = false
			end
		elseif desc:IsA("ImageButton") then
			desc.Visible = false
		end
	end

	return root
end

function GuiRuntime:_buildEmoteList(root, onDeath)
	local host = root:FindFirstChildWhichIsA("ImageLabel", true) or root:FindFirstChildWhichIsA("Frame", true)
	if not host then
		host = root
	end

	local existing = host:FindFirstChild("DeathOverlay")
	if existing then
		existing:Destroy()
	end

	local overlay = Instance.new("Frame")
	overlay.Name = "DeathOverlay"
	overlay.BackgroundTransparency = 1
	overlay.Size = UDim2.new(0.75, 0, 0.72, 0)
	overlay.Position = UDim2.new(0.125, 0, 0.16, 0)
	overlay.Parent = host

	local list = Instance.new("ScrollingFrame")
	list.Name = "DeathList"
	list.BackgroundTransparency = 1
	list.BorderSizePixel = 0
	list.Size = UDim2.new(1, 0, 1, 0)
	list.CanvasSize = UDim2.new(0, 0, 0, 0)
	list.AutomaticCanvasSize = Enum.AutomaticSize.Y
	list.ScrollBarThickness = 6
	list.Parent = overlay

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 8)
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = list

	for i = 1, 12 do
		local button = Instance.new("TextButton")
		button.Name = "DeathEmote" .. tostring(i)
		button.Size = UDim2.new(1, -10, 0, 42)
		button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		button.BorderSizePixel = 0
		button.AutoButtonColor = true
		button.Text = "Death"
		button.Font = Enum.Font.GothamBold
		button.TextColor3 = Color3.fromRGB(255, 255, 255)
		button.TextSize = 18
		button.Parent = list
		makeCorner(button, UDim.new(0, 8))
		makeStroke(button, Color3.fromRGB(255, 255, 255))

		button.MouseButton1Click:Connect(function()
			if onDeath then
				onDeath()
			end
		end)
	end
end

function GuiRuntime:addEmotes(moduleResult, onDeath)
	self:_removeExisting("Emotes")
	local root = self:mountPersistent(moduleResult, "Emotes")

	for _, desc in ipairs(root:GetDescendants()) do
		if desc:IsA("TextLabel") and desc.Name == "EmoteName" then
			desc.Text = "Death"
		elseif desc:IsA("TextLabel") and desc.Name == "EmoteProperty" then
			desc.Text = "1 Player"
		elseif desc:IsA("TextButton") and desc.Name == "Button" then
			desc.MouseButton1Click:Connect(function()
				if onDeath then
					onDeath()
				end
			end)
		end
	end

	self:_buildEmoteList(root, onDeath)
	root.Enabled = false

	return root
end

function GuiRuntime:addTopIcon(emotesGui)
	self:_removeExisting("EmotesTopIcon")

	local root = Instance.new("ScreenGui")
	root.Name = "EmotesTopIcon"
	root.ResetOnSpawn = false
	root.IgnoreGuiInset = true
	root.Parent = self.PlayerGui

	local button = Instance.new("TextButton")
	button.Name = "Toggle"
	button.Size = UDim2.fromOffset(110, 34)
	button.Position = UDim2.new(0.5, -55, 0, 8)
	button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	button.BorderSizePixel = 0
	button.Font = Enum.Font.GothamBold
	button.Text = "EMOTES"
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.TextSize = 16
	button.Parent = root
	makeCorner(button, UDim.new(0, 8))
	makeStroke(button, Color3.fromRGB(255, 255, 255))

	button.MouseButton1Click:Connect(function()
		if emotesGui then
			emotesGui.Enabled = not emotesGui.Enabled
		end
	end)

	return root
end

return GuiRuntime
