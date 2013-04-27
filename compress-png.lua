local response1 = http.request {
	url = 'http://tinypng.org/api/shrink',
	method = 'POST',
	data = storage.weatherPNG,
	headers = {
		['Content-Type'] = 'image/png'
	}
}

local data = json.parse(response1.content)

local response2 = http.request {
	url = data.output.url
}

return response2.content, { ['Content-Type'] = 'image/png' }