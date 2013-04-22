local response = http.request {
	url = 'https://api.forecast.io/forecast/YOUR_API_KEY/LATITUDE,LONGITUDE'
}

local data = json.parse(response.content)

local days = {}

local i = 0
for key1, value1 in pairs(data.daily.data) do
	local day = {}
	
	local j = 0
	for key2, value2 in pairs(value1) do
		day[j] = value2
		j = j + 1
	end
	
	days[i] = day
	i = i + 1
end

local svg = storage.weatherSVG

svg = svg:gsub('ICON_ONE', days[0][5])
svg = svg:gsub('HIGH_ONE', math.floor(days[0][8]))
svg = svg:gsub('LOW_ONE', math.floor(days[0][15]))

svg = svg:gsub('ICON_TWO', days[0][5])
svg = svg:gsub('HIGH_TWO', math.floor(days[1][8]))
svg = svg:gsub('LOW_TWO', math.floor(days[1][15]))

svg = svg:gsub('DAY_THREE', os.date('%A', days[2][3]))
svg = svg:gsub('ICON_THREE', days[0][5])
svg = svg:gsub('HIGH_THREE', math.floor(days[2][8]))
svg = svg:gsub('LOW_THREE', math.floor(days[2][15]))

svg = svg:gsub('DAY_FOUR', os.date('%A', days[3][3]))
svg = svg:gsub('ICON_FOUR', days[0][5])
svg = svg:gsub('HIGH_FOUR', math.floor(days[3][8]))
svg = svg:gsub('LOW_FOUR', math.floor(days[3][15]))

return svg, {
	['Content-Type'] = 'image/svg+xml'
}