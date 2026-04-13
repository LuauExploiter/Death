local Util = {}

function Util.safeDisconnect(conn)
	pcall(function()
		if typeof(conn) == "RBXScriptConnection" and conn.Connected then
			conn:Disconnect()
		end
	end)
end

function Util.safeDestroy(obj)
	pcall(function()
		if obj and obj.Parent then
			obj:Destroy()
		end
	end)
end

function Util.safeCancel(threadObj)
	pcall(task.cancel, threadObj)
end

function Util.normalizeAnimationId(value)
	if type(value) == "number" then
		return "rbxassetid://" .. tostring(value)
	end
	if type(value) == "string" then
		if value:match("^rbxassetid://") then
			return value
		end
		local digits = value:match("(%d+)")
		if digits then
			return "rbxassetid://" .. digits
		end
	end
	return nil
end

function Util.deepCopy(tbl)
	local out = {}
	for k, v in pairs(tbl) do
		if type(v) == "table" then
			out[k] = Util.deepCopy(v)
		else
			out[k] = v
		end
	end
	return out
end

function Util.findDescendantByName(root, name)
	if not root then
		return nil
	end
	for _, obj in ipairs(root:GetDescendants()) do
		if obj.Name == name then
			return obj
		end
	end
	return nil
end

function Util.ensureFolder(parent, name)
	local folder = parent:FindFirstChild(name)
	if folder and folder:IsA("Folder") then
		return folder
	end
	folder = Instance.new("Folder")
	folder.Name = name
	folder.Parent = parent
	return folder
end

return Util
