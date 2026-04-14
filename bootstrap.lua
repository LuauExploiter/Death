local Players = game:GetService("Players")

local BASE = "https://raw.githubusercontent.com/LuauExploiter/Death/refs/heads/main/"
local ANIMATOR_SOURCE_ROOT = "src/Shared/Animator/Source/"

local MODULE_URLS = {
	["src/Loader.lua"] = BASE .. "src/Loader.lua",

	["src/Shared/Animator/Source/Main.lua"] = BASE .. "src/Shared/Animator/Source/Main.lua",
	["src/Shared/Animator/Source/Animator.lua"] = BASE .. "src/Shared/Animator/Source/Animator.lua",
	["src/Shared/Animator/Source/Parser.lua"] = BASE .. "src/Shared/Animator/Source/Parser.lua",
	["src/Shared/Animator/Source/Utility.lua"] = BASE .. "src/Shared/Animator/Source/Utility.lua",
	["src/Shared/Animator/Source/Nevermore/Signal.lua"] = BASE .. "src/Shared/Animator/Source/Nevermore/Signal.lua",
	["src/Shared/Animator/Source/Nevermore/Maid.lua"] = BASE .. "src/Shared/Animator/Source/Nevermore/Maid.lua",

	["src/Shared/Runtime/Character.lua"] = BASE .. "src/Shared/Runtime/Character.lua",
	["src/Shared/Runtime/Camera.lua"] = BASE .. "src/Shared/Runtime/Camera.lua",
	["src/Shared/Runtime/Sound.lua"] = BASE .. "src/Shared/Runtime/Sound.lua",
	["src/Shared/Runtime/Cleanup.lua"] = BASE .. "src/Shared/Runtime/Cleanup.lua",
	["src/Shared/Runtime/VFX.lua"] = BASE .. "src/Shared/Runtime/VFX.lua",
	["src/Shared/Runtime/RigMap.lua"] = BASE .. "src/Shared/Runtime/RigMap.lua",
	["src/Shared/Runtime/Input.lua"] = BASE .. "src/Shared/Runtime/Input.lua",
	["src/Shared/Runtime/Mobile.lua"] = BASE .. "src/Shared/Runtime/Mobile.lua",
	["src/Shared/Runtime/Http.lua"] = BASE .. "src/Shared/Runtime/Http.lua",
	["src/Shared/Runtime/Util.lua"] = BASE .. "src/Shared/Runtime/Util.lua",
	["src/Shared/Runtime/Gui.lua"] = BASE .. "src/Shared/Runtime/Gui.lua",

	["src/Shared/Schemas/Manifest.lua"] = BASE .. "src/Shared/Schemas/Manifest.lua",
	["src/Shared/Schemas/AnimationData.lua"] = BASE .. "src/Shared/Schemas/AnimationData.lua",
	["src/Shared/Schemas/VFXData.lua"] = BASE .. "src/Shared/Schemas/VFXData.lua",
	["src/Shared/Schemas/CameraData.lua"] = BASE .. "src/Shared/Schemas/CameraData.lua",

	["src/GameAdapters/Universal.lua"] = BASE .. "src/GameAdapters/Universal.lua",

	["src/Emotes/Death/Manifest.lua"] = BASE .. "src/Emotes/Death/Manifest.lua",
	["src/Emotes/Death/AnimationData.lua"] = BASE .. "src/Emotes/Death/AnimationData.lua",
	["src/Emotes/Death/Sounds.lua"] = BASE .. "src/Emotes/Death/Sounds.lua",
	["src/Emotes/Death/VFX.lua"] = BASE .. "src/Emotes/Death/VFX.lua",
	["src/Emotes/Death/Camera.lua"] = BASE .. "src/Emotes/Death/Camera.lua",
	["src/Emotes/Death/Cleanup.lua"] = BASE .. "src/Emotes/Death/Cleanup.lua",
	["src/Emotes/Death/Assets.lua"] = BASE .. "src/Emotes/Death/Assets.lua",

	["src/Packages/TopbarPlus/Icon/Icon.lua"] = BASE .. "src/Packages/TopbarPlus/Icon/Icon.lua",
["src/Packages/TopbarPlus/Icon/IconController.lua"] = BASE .. "src/Packages/TopbarPlus/Icon/IconController.lua",
["src/Packages/TopbarPlus/Icon/Maid.lua"] = BASE .. "src/Packages/TopbarPlus/Icon/Maid.lua",
["src/Packages/TopbarPlus/Icon/Signal.lua"] = BASE .. "src/Packages/TopbarPlus/Icon/Signal.lua",
["src/Packages/TopbarPlus/Icon/TopbarPlusGui.lua"] = BASE .. "src/Packages/TopbarPlus/Icon/TopbarPlusGui.lua",
["src/Packages/TopbarPlus/Icon/TopbarPlusReference.lua"] = BASE .. "src/Packages/TopbarPlus/Icon/TopbarPlusReference.lua",
["src/Packages/TopbarPlus/Icon/VERSION.lua"] = BASE .. "src/Packages/TopbarPlus/Icon/VERSION.lua",
["src/Packages/TopbarPlus/Icon/Themes.lua"] = BASE .. "src/Packages/TopbarPlus/Icon/Themes.lua",
["src/Packages/TopbarPlus/Icon/Themes/BlueGradient.lua"] = BASE .. "src/Packages/TopbarPlus/Icon/Themes/BlueGradient.lua",
["src/Packages/TopbarPlus/Icon/Themes/Default.lua"] = BASE .. "src/Packages/TopbarPlus/Icon/Themes/Default.lua",

["src/Packages/TopbarPlus/NewIcon/NewIcon.lua"] = BASE .. "src/Packages/TopbarPlus/NewIcon/NewIcon.lua",
["src/Packages/TopbarPlus/NewIcon/IconController.lua"] = BASE .. "src/Packages/TopbarPlus/NewIcon/IconController.lua",
["src/Packages/TopbarPlus/NewIcon/Maid.lua"] = BASE .. "src/Packages/TopbarPlus/NewIcon/Maid.lua",
["src/Packages/TopbarPlus/NewIcon/Signal.lua"] = BASE .. "src/Packages/TopbarPlus/NewIcon/Signal.lua",
["src/Packages/TopbarPlus/NewIcon/TopbarPlusGui.lua"] = BASE .. "src/Packages/TopbarPlus/NewIcon/TopbarPlusGui.lua",
["src/Packages/TopbarPlus/NewIcon/TopbarPlusReference.lua"] = BASE .. "src/Packages/TopbarPlus/NewIcon/TopbarPlusReference.lua",
["src/Packages/TopbarPlus/NewIcon/VERSION.lua"] = BASE .. "src/Packages/TopbarPlus/NewIcon/VERSION.lua",
["src/Packages/TopbarPlus/NewIcon/Themes.lua"] = BASE .. "src/Packages/TopbarPlus/NewIcon/Themes.lua",
["src/Packages/TopbarPlus/NewIcon/Themes/BlueGradient.lua"] = BASE .. "src/Packages/TopbarPlus/NewIcon/Themes/BlueGradient.lua",
["src/Packages/TopbarPlus/NewIcon/Themes/Default.lua"] = BASE .. "src/Packages/TopbarPlus/NewIcon/Themes/Default.lua",

	["assets/vfx/death/BadWolf.lua"] = BASE .. "assets/vfx/death/BadWolf.lua",
	["assets/gui/Hotbar.lua"] = BASE .. "assets/gui/Hotbar.lua",
	["assets/gui/Bar.lua"] = BASE .. "assets/gui/Bar.lua",
	["assets/gui/Emotes.lua"] = BASE .. "assets/gui/Emotes.lua",
	["assets/animations/death.lua"] = BASE .. "assets/animations/death.lua",
}

local moduleCache = {}
local nodeByPath = {}

local methods = {}

local NodeMT = {
	__index = function(self, key)
		local method = methods[key]
		if method ~= nil then
			return method
		end

		local children = rawget(self, "__children")
		if children and children[key] ~= nil then
			return children[key]
		end

		return rawget(self, key)
	end,
}

function methods:FindFirstChild(name)
	return self.__children[name]
end

function methods:WaitForChild(name)
	local child = self.__children[name]
	if child then
		return child
	end
	error(("FakeInstance %s missing child %s"):format(self.__path, tostring(name)))
end

function methods:GetChildren()
	local out = {}
	for _, child in pairs(self.__children) do
		table.insert(out, child)
	end
	return out
end

function methods:IsA(className)
	if className == "ModuleScript" then
		return self.__isModule
	end
	if className == "Folder" then
		return not self.__isModule
	end
	return false
end

local function makeNode(name, path, parent, isModule)
	local node = setmetatable({
		Name = name,
		Parent = parent,
		__path = path,
		__parent = parent,
		__children = {},
		__isModule = isModule or false,
	}, NodeMT)

	nodeByPath[path] = node
	return node
end

local root = makeNode("root", "", nil, false)

local function addChild(parent, child)
	parent.__children[child.Name] = child
	child.Parent = parent
end

local function ensureFolder(path)
	if path == "" then
		return root
	end

	if nodeByPath[path] then
		return nodeByPath[path]
	end

	local parentPath, name = path:match("^(.*)/([^/]+)$")
	if not parentPath then
		parentPath = ""
		name = path
	end

	local parent = ensureFolder(parentPath)
	local folder = makeNode(name, path, parent, false)
	addChild(parent, folder)
	return folder
end

local function addModule(path)
	local parentPath, fileName = path:match("^(.*)/([^/]+)%.lua$")
	local parent = ensureFolder(parentPath)
	local name = fileName
	local moduleNode = makeNode(name, path, parent, true)
	addChild(parent, moduleNode)
	return moduleNode
end

for path in pairs(MODULE_URLS) do
	addModule(path)
end

local realRequire = require
local httpRequireCache = getgenv().httpRequireCache or {}
getgenv().httpRequireCache = httpRequireCache

local function normalizeModulePath(path)
	path = tostring(path or ""):gsub("\\", "/")
	path = path:gsub("^%./", "")
	path = path:gsub("^/", "")
	return path
end

local function resolveAnimatorModulePath(path)
	path = normalizeModulePath(path)

	if MODULE_URLS[path] then
		return path
	end

	local sourcePath = ANIMATOR_SOURCE_ROOT .. path
	if MODULE_URLS[sourcePath] then
		return sourcePath
	end

	return nil
end

local function loadChunkFromUrl(url, chunkName, sharedEnv)
	local source = game:HttpGet(url, true)
	local chunk, err = loadstring(source, chunkName)
	if not chunk then
		error("Failed loading " .. tostring(chunkName) .. ": " .. tostring(err))
	end
	setfenv(chunk, sharedEnv)
	return chunk()
end

local customRequire

local function makeModuleEnv(target)
	local env

	local function HttpRequire(path, noCache)
		path = tostring(path)

		if path:sub(1, 8) == "https://" or path:sub(1, 7) == "http://" then
			if not noCache and httpRequireCache[path] ~= nil then
				return httpRequireCache[path]
			end

			local result = loadChunkFromUrl(path, "@" .. path, env)
			httpRequireCache[path] = result
			return result
		end

		local resolved = resolveAnimatorModulePath(path)
		if resolved then
			return customRequire(nodeByPath[resolved])
		end

		return realRequire(path)
	end

	local function animatorRequire(path)
		local resolved = resolveAnimatorModulePath(path)
		if not resolved then
			error("animatorRequire could not resolve " .. tostring(path))
		end
		return customRequire(nodeByPath[resolved])
	end

	env = setmetatable({
		script = target,
		require = function(mod)
			if type(mod) == "string" then
				local resolved = resolveAnimatorModulePath(mod)
				if resolved then
					return customRequire(nodeByPath[resolved])
				end
			end
			return customRequire(mod)
		end,
		HttpRequire = HttpRequire,
		animatorRequire = animatorRequire,
		httpRequireCache = httpRequireCache,
	}, {
		__index = getfenv(),
	})

	return env
end

customRequire = function(target)
	if type(target) == "table" and target.__path and target.__isModule then
		if moduleCache[target.__path] ~= nil then
			return moduleCache[target.__path]
		end

		local url = MODULE_URLS[target.__path]
		if not url then
			error("No raw URL mapped for module: " .. tostring(target.__path))
		end

		local source = game:HttpGet(url, true)
		local chunk, err = loadstring(source, "@" .. target.__path)
		if not chunk then
			error("Failed loading " .. target.__path .. ": " .. tostring(err))
		end

		local env = makeModuleEnv(target)
		setfenv(chunk, env)

		local result = chunk()
		moduleCache[target.__path] = result
		return result
	end

	return realRequire(target)
end

local Loader = customRequire(root.src.Loader)

local LocalPlayer = Players.LocalPlayer
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
		warn("[Death bootstrap] Failed to start:", result)
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
