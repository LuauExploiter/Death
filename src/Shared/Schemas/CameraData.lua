local CameraSchema = {}

function CameraSchema.validate(data)
	assert(type(data) == "table", "CameraData must be a table")
	return true
end

return CameraSchema
