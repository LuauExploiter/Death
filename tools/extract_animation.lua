local function extract(source)
	return {
		Id = source.Id or source.AnimationId,
		Markers = source.Markers or {},
		Looped = source.Looped or source.Loop or false,
		Infinite = source.Infinite or false,
		DontDisconnectMarkers = source.DontDisconnectMarkers or false,
	}
end

return extract
