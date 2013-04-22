local lom = require 'lxp.lom'
local xpath = require 'xpath'

local url = xpath.selectNodes(lom.parse(request.form['queue-answer']),
	'/queue-answer/params/directDownload')[1][1]

local response = http.request {
	url = url
}

storage.weatherPNG = response.content

log('Image downloaded from conversion engine successfully.')