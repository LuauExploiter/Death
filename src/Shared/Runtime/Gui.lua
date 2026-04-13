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

	return nil
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

local function makeCorner(parent, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = radius or UDim.new(0, 8)
	corner.Parent = parent
	return corner
end

local function makeStroke(parent, color)
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 1.5
	stroke.Color = color or Color3.fromRGB(255, 255, 255)
	stroke.Parent = parent
	return stroke
end

local function clearChildren(parent)
	for _, child in ipairs(parent:GetChildren()) do
		child:Destroy()
	end
end

function GuiRuntime.new()
	local self = setmetatable({}, GuiRuntime)
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

function GuiRuntime:_mountRoot(name, moduleResult)
	self:_removeExisting(name)

	local built = resolveBundle(moduleResult)
	local root

	if built and built:IsA("ScreenGui") then
		root = built
		root.Name = name
		root.ResetOnSpawn = false
		root.Parent = self.PlayerGui
	elseif built then
		root = Instance.new("ScreenGui")
		root.Name = name
		root.ResetOnSpawn = false
		root.IgnoreGuiInset = true
		built.Parent = root
		root.Parent = self.PlayerGui
	else
		root = Instance.new("ScreenGui")
		root.Name = name
		root.ResetOnSpawn = false
		root.IgnoreGuiInset = true
		root.Parent = self.PlayerGui
	end

	disableEmbeddedScripts(root)
	return root
end

function GuiRuntime:_makeHotbarButton(parent, index, text, active, callback)
	local button = Instance.new("TextButton")
	button.Name = "DeathHotbarButton" .. tostring(index)
	button.Size = UDim2.fromOffset(70, 70)
	button.BackgroundColor3 = active and Color3.fromRGB(28, 28, 28) or Color3.fromRGB(18, 18, 18)
	button.BorderSizePixel = 0
	button.Text = ""
	button.AutoButtonColor = true
	button.Parent = parent
	makeCorner(button, UDim.new(0, 10))
	makeStroke(button, active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(100, 100, 100))

	local keyLabel = Instance.new("TextLabel")
	keyLabel.Name = "KeyLabel"
	keyLabel.BackgroundTransparency = 1
	keyLabel.Size = UDim2.fromOffset(16, 16)
	keyLabel.Position = UDim2.fromOffset(6, 4)
	keyLabel.Font = Enum.Font.GothamBold
	keyLabel.Text = tostring(index)
	keyLabel.TextSize = 12
	keyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	keyLabel.TextXAlignment = Enum.TextXAlignment.Left
	keyLabel.Parent = button

	local textLabel = Instance.new("TextLabel")
	textLabel.Name = "MoveName"
	textLabel.BackgroundTransparency = 1
	textLabel.Size = UDim2.new(1, -8, 1, -8)
	textLabel.Position = UDim2.fromOffset(4, 4)
	textLabel.Font = Enum.Font.GothamBold
	textLabel.TextScaled = true
	textLabel.TextWrapped = true
	textLabel.Text = text
	textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	textLabel.Parent = button

	if callback then
		button.MouseButton1Click:Connect(callback)
	end

	return button
end

function GuiRuntime:addHotbar(moduleResult, onDeath)
	local root = self:_mountRoot("Hotbar", moduleResult)

	local overlay = root:FindFirstChild("DeathHotbarOverlay")
	if not overlay then
		overlay = Instance.new("Frame")
		overlay.Name = "DeathHotbarOverlay"
		overlay.BackgroundTransparency = 1
		overlay.AnchorPoint = Vector2.new(0.5, 1)
		overlay.Position = UDim2.new(0.5, 0, 1, -28)
		overlay.Size = UDim2.fromOffset(340, 80)
		overlay.Parent = root
	end

	clearChildren(overlay)

	local layout = Instance.new("UIListLayout")
	layout.FillDirection = Enum.FillDirection.Horizontal
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.Padding = UDim.new(0, 10)
	layout.Parent = overlay

	self:_makeHotbarButton(overlay, 1, "PLACEHOLDER", false, nil)
	self:_makeHotbarButton(overlay, 2, "PLACEHOLDER", false, nil)
	self:_makeHotbarButton(overlay, 3, "PLACEHOLDER", false, nil)
	self:_makeHotbarButton(overlay, 4, "Death", true, onDeath)

	return root
end

function GuiRuntime:addBar(moduleResult)
	local root = self:_mountRoot("Bar", moduleResult)

	local banner = root:FindFirstChild("DeathBarOverlay")
	if not banner then
		banner = Instance.new("Frame")
		banner.Name = "DeathBarOverlay"
		banner.AnchorPoint = Vector2.new(0.5, 0)
		banner.Position = UDim2.new(0.5, 0, 0, 6)
		banner.Size = UDim2.fromOffset(360, 40)
		banner.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
		banner.BorderSizePixel = 0
		banner.Parent = root
		makeCorner(banner, UDim.new(0, 10))
		makeStroke(banner, Color3.fromRGB(255, 255, 255))
	end

	clearChildren(banner)

	local title = Instance.new("TextLabel")
	title.Name = "Title"
	title.BackgroundTransparency = 1
	title.Size = UDim2.new(1, -12, 1, 0)
	title.Position = UDim2.fromOffset(6, 0)
	title.Font = Enum.Font.GothamBold
	title.Text = "DEATH EMOTE BY HIKLO"
	title.TextScaled = true
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.Parent = banner

	return root
end

function GuiRuntime:addEmotes(moduleResult, onDeath)
	local root = self:_mountRoot("Emotes", moduleResult)
	root.Enabled = false

	local panel = root:FindFirstChild("DeathEmotesOverlay")
	if not panel then
		panel = Instance.new("Frame")
		panel.Name = "DeathEmotesOverlay"
		panel.AnchorPoint = Vector2.new(0.5, 0.5)
		panel.Position = UDim2.new(0.5, 0, 0.54, 0)
		panel.Size = UDim2.fromOffset(340, 360)
		panel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
		panel.BorderSizePixel = 0
		panel.Parent = root
		makeCorner(panel, UDim.new(0, 12))
		makeStroke(panel, Color3.fromRGB(255, 255, 255))
	end

	clearChildren(panel)

	local title = Instance.new("TextLabel")
	title.Name = "Title"
	title.BackgroundTransparency = 1
	title.Size = UDim2.new(1, 0, 0, 34)
	title.Font = Enum.Font.GothamBold
	title.Text = "EMOTES"
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.TextScaled = true
	title.Parent = panel

	local list = Instance.new("ScrollingFrame")
	list.Name = "List"
	list.BackgroundTransparency = 1
	list.BorderSizePixel = 0
	list.Position = UDim2.fromOffset(10, 42)
	list.Size = UDim2.new(1, -20, 1, -52)
	list.AutomaticCanvasSize = Enum.AutomaticSize.Y
	list.CanvasSize = UDim2.new()
	list.ScrollBarThickness = 6
	list.Parent = panel

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 8)
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.Parent = list

	for i = 1, 12 do
		local button = Instance.new("TextButton")
		button.Name = "DeathEmote" .. tostring(i)
		button.Size = UDim2.new(1, -4, 0, 38)
		button.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
		button.BorderSizePixel = 0
		button.AutoButtonColor = true
		button.Text = "Death"
		button.Font = Enum.Font.GothamBold
		button.TextColor3 = Color3.fromRGB(255, 255, 255)
		button.TextScaled = true
		button.Parent = list
		makeCorner(button, UDim.new(0, 8))
		makeStroke(button, Color3.fromRGB(255, 255, 255))

		button.MouseButton1Click:Connect(function()
			if onDeath then
				onDeath()
			end
			root.Enabled = false
		end)
	end

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
	button.AnchorPoint = Vector2.new(0.5, 0)
	button.Position = UDim2.new(0.5, 0, 0, 6)
	button.Size = UDim2.fromOffset(120, 36)
	button.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
	button.BorderSizePixel = 0
	button.Font = Enum.Font.GothamBold
	button.Text = "EMOTES"
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.TextScaled = true
	button.Parent = root
	makeCorner(button, UDim.new(0, 10))
	makeStroke(button, Color3.fromRGB(255, 255, 255))

	button.MouseButton1Click:Connect(function()
		if emotesGui then
			emotesGui.Enabled = not emotesGui.Enabled
		end
	end)

	return root
end

return GuiRuntime
