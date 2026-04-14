local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

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

local function findFirstDescendant(root, predicate)
	for _, desc in ipairs(root:GetDescendants()) do
		if predicate(desc) then
			return desc
		end
	end
	return nil
end

local function clearChildrenExceptLayouts(parent)
	for _, child in ipairs(parent:GetChildren()) do
		if not child:IsA("UIListLayout") and not child:IsA("UIGridLayout") and not child:IsA("UIPadding") then
			child:Destroy()
		end
	end
end

local function setSlotText(slot, index, name)
	for _, d in ipairs(slot:GetDescendants()) do
		if d:IsA("TextLabel") then
			if d.Name == "Number" then
				d.Text = tostring(index)
			elseif d.Name == "ToolName" then
				d.Text = name
			elseif d.Name == "Quantity" then
				d.Text = ""
			elseif d.Name == "Reuse" then
				d.Visible = false
			end
		end
	end
end

function GuiRuntime.new()
	local self = setmetatable({}, GuiRuntime)
	self.PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
	self.IconObject = nil
	return self
end

function GuiRuntime:_removePlayerGuiCopy(name)
	local existing = self.PlayerGui:FindFirstChild(name)
	if existing then
		pcall(function()
			existing:Destroy()
		end)
	end
end

function GuiRuntime:_ensureStarterGui(name, serializerModuleResult)
	local existing = StarterGui:FindFirstChild(name)
	if existing and existing:IsA("ScreenGui") then
		return existing
	end

	local built = resolveBundle(serializerModuleResult)
	if not built then
		return nil
	end

	if not built:IsA("ScreenGui") then
		local wrapper = Instance.new("ScreenGui")
		wrapper.Name = name
		wrapper.ResetOnSpawn = false
		wrapper.IgnoreGuiInset = true
		built.Parent = wrapper
		built = wrapper
	end

	built.Name = name
	built.ResetOnSpawn = false
	disableEmbeddedScripts(built)
	built.Parent = StarterGui

	return built
end

function GuiRuntime:_cloneExactGui(name, serializerModuleResult)
	local starterCopy = self:_ensureStarterGui(name, serializerModuleResult)
	if not starterCopy then
		return nil
	end

	self:_removePlayerGuiCopy(name)

	local clone = starterCopy:Clone()
	clone.ResetOnSpawn = false
	disableEmbeddedScripts(clone)
	clone.Parent = self.PlayerGui
	return clone
end

function GuiRuntime:addExactHotbar(serializerModuleResult, onDeath)
	local root = self:_cloneExactGui("Hotbar", serializerModuleResult)
	if not root then
		return nil
	end

	local template = findFirstDescendant(root, function(d)
		return d:IsA("TextButton") and d.Name == "Base"
	end)

	local container = findFirstDescendant(root, function(d)
		return (d:IsA("Frame") or d:IsA("ScrollingFrame")) and d.Name == "Hotbar" and d:FindFirstChildOfClass("UIListLayout")
	end)

	if template and container then
		local layout = container:FindFirstChildOfClass("UIListLayout")
		local templateClone = template:Clone()

		clearChildrenExceptLayouts(container)
		if layout then
			layout.Parent = container
		end

		local names = { "PLACEHOLDER", "PLACEHOLDER", "PLACEHOLDER", "Death" }

		for i = 1, 4 do
			local slot = templateClone:Clone()
			slot.Visible = true
			slot.Parent = container
			setSlotText(slot, i, names[i])

			if i == 4 then
				slot.MouseButton1Click:Connect(function()
					if onDeath then
						onDeath()
					end
				end)
			else
				slot.MouseButton1Click:Connect(function() end)
			end
		end
	end

	return root
end

function GuiRuntime:addExactBar(serializerModuleResult)
	local root = self:_cloneExactGui("Bar", serializerModuleResult)
	if not root then
		return nil
	end

	for _, d in ipairs(root:GetDescendants()) do
		if d:IsA("TextLabel") and d.Text == "SERIOUS MODE" then
			d.Text = "DEATH EMOTE BY HIKLO"
		elseif d:IsA("TextLabel") and d.Text == "[G]" then
			d.Visible = false
		elseif d:IsA("ImageButton") then
			d.Visible = false
		end
	end

	return root
end

function GuiRuntime:addExactEmotes(serializerModuleResult, onDeath)
	local root = self:_cloneExactGui("Emotes", serializerModuleResult)
	if not root then
		return nil
	end

	local template = findFirstDescendant(root, function(d)
		return d:IsA("Frame") and d.Name == "Framechh" and d:FindFirstChild("Button", true)
	end)

	local list = findFirstDescendant(root, function(d)
		return d:IsA("ScrollingFrame") and d:FindFirstChildOfClass("UIListLayout")
	end)

	if template and list then
		local layout = list:FindFirstChildOfClass("UIListLayout")
		local templateClone = template:Clone()

		clearChildrenExceptLayouts(list)
		if layout then
			layout.Parent = list
		end

		for i = 1, 12 do
			local item = templateClone:Clone()
			item.Visible = true
			item.Parent = list

			for _, d in ipairs(item:GetDescendants()) do
				if d:IsA("TextLabel") then
					if d.Name == "EmoteName" then
						d.Text = "Death"
					elseif d.Name == "EmoteProperty" then
						d.Text = "1 Player"
					elseif d.Text == "Griddy" or d.Text == "NEW" then
						d.Text = "Death"
					elseif d.Text == "2 Player" or d.Text == "1 Player" then
						d.Text = "1 Player"
					end
				elseif d:IsA("TextButton") and d.Name == "Button" then
					d.MouseButton1Click:Connect(function()
						root.Enabled = false
						if onDeath then
							onDeath()
						end
					end)
				end
			end
		end
	end

	root.Enabled = false
	return root
end

function GuiRuntime:addTopbarEmotesIcon(emotesGui)
	if self.IconObject then
		pcall(function()
			if self.IconObject.destroy then
				self.IconObject:destroy()
			elseif self.IconObject.Destroy then
				self.IconObject:Destroy()
			end
		end)
		self.IconObject = nil
	end

	local packages = script.Parent.Parent.Parent:WaitForChild("Packages")
	local packageFolder = packages:FindFirstChild("NewIcon") or packages:FindFirstChild("Icon")
	if not packageFolder then
		return nil
	end

	local entryModule = packageFolder:FindFirstChild("NewIcon") or packageFolder:FindFirstChild("Icon")
	if not entryModule then
		return nil
	end

	local Icon = require(entryModule)
	if not Icon or not Icon.new then
		return nil
	end

	local icon = Icon.new()

	pcall(function()
		icon:setName("DeathEmotes")
	end)

	pcall(function()
		icon:setLabel("Emotes")
	end)

	pcall(function()
		icon:align("Center")
	end)

	if emotesGui then
		local bound = false

		pcall(function()
			icon:bindToggleItem(emotesGui)
			bound = true
		end)

		if not bound then
			pcall(function()
				icon.selected:Connect(function()
					emotesGui.Enabled = true
				end)
			end)
			pcall(function()
				icon.deselected:Connect(function()
					emotesGui.Enabled = false
				end)
			end)
		end
	end

	self.IconObject = icon
	return icon
end

return GuiRuntime
