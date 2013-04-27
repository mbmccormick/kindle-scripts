local response = http.request {
	url = 'http://yourserver.com/path/to/grayscale.php'
}

return response.content, { ['Content-Type'] = 'image/png' }