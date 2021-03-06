local response = http.request {
	url = 'https://api.forecast.io/forecast/YOUR_API_KEY/LATITUDE,LONGITUDE'
}

local data = json.parse(response.content)

local hours = {}
	
local i = 0
for key, value in pairs(data.hourly.data) do
	hours[i] = value	
	i = i + 1
end

local days = {}
	
local i = 0
for key, value in pairs(data.daily.data) do
	days[i] = value	
	i = i + 1
end

if data.alerts ~= nil then
	local alerts = {}

	if data.alerts ~= nil then
		local i = 0
		for key, value in pairs(data.alerts) do
			alerts[i] = value	
			i = i + 1
		end
	end

	if alerts[0]['title']:find('Warning') ~= nil then	
		local svg = storage.alertSVG
		
		local title = alerts[0]['title']:sub(0, alerts[0]['title']:find(' for') - 1)
		local expiry = os.date('%I:%M%p', alerts[0]['expires'])	
		local location = alerts[0]['title']:gsub(title .. ' for ', '')
		
		svg = svg:gsub('ALERT_TITLE', title)
		svg = svg:gsub('ALERT_EXPIRY', expiry)
		svg = svg:gsub('ALERT_LOCATION', location)
		
		return svg, {
			['Content-Type'] = 'image/svg+xml'
		}
	end
end
	
local svg = storage.weatherSVG

svg = svg:gsub('ICON_ONE', data.currently.icon)
svg = svg:gsub('CURRENT_TEMP', math.floor(data.currently.temperature))
svg = svg:gsub('CURRENT_PRECIP', math.floor((hours[2]['precipProbability'] or 0) * 100))

svg = svg:gsub('ICON_TWO', days[0]['icon'])
svg = svg:gsub('HIGH_TWO', math.floor(days[0]['temperatureMax']))
svg = svg:gsub('LOW_TWO', math.floor(days[0]['temperatureMin']))

svg = svg:gsub('DAY_THREE', os.date('%A', days[1]['time']))
svg = svg:gsub('ICON_THREE', days[1]['icon'])
svg = svg:gsub('HIGH_THREE', math.floor(days[1]['temperatureMax']))
svg = svg:gsub('LOW_THREE', math.floor(days[1]['temperatureMin']))

svg = svg:gsub('DAY_FOUR', os.date('%A', days[2]['time']))
svg = svg:gsub('ICON_FOUR', days[2]['icon'])
svg = svg:gsub('HIGH_FOUR', math.floor(days[2]['temperatureMax']))
svg = svg:gsub('LOW_FOUR', math.floor(days[2]['temperatureMin']))

return svg, {
	['Content-Type'] = 'image/svg+xml'
}
