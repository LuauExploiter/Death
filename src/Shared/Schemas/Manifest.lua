local ManifestSchema = {}

function ManifestSchema.validate(manifest)
	assert(type(manifest) == "table", "Manifest must be a table")
	assert(type(manifest.Name) == "string", "Manifest.Name missing")
	assert(type(manifest.Animation) == "string", "Manifest.Animation missing")
	assert(type(manifest.Sounds) == "string", "Manifest.Sounds missing")
	assert(type(manifest.VFX) == "string", "Manifest.VFX missing")
	return true
end

return ManifestSchema
