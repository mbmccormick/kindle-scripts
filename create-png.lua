local response1 = http.request {
	url = 'http://matt-kindle.webscript.io/weather/create-svg'
}

local request = [[<?xml version="1.0" encoding="utf-8" ?>
<queue>
  <apiKey>YOUR_API_KEY</apiKey>
  <targetType>image</targetType>
  <targetMethod>convert-to-png</targetMethod>
  <testMode>true</testMode>
  <width>600</width>
  <height>800</height>
	<quality>100</quality>
	<color>3</color>
  <file>
    <fileName>weather.svg</fileName>
    <fileData>
      ]] .. base64.encode(response1.content) .. [[
    </fileData>
  </file>
  <notificationUrl>http://matt-kindle.webscript.io/weather/fetch-png</notificationUrl>
</queue>]]

local response2 = http.request {
	url = 'http://api.online-convert.com/queue-insert',
	method = 'POST',
	data = {
		queue = request
	}
}

log(response2.content)