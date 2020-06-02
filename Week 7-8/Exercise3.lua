keyAPI = "9f418d12e2c0f5e721197b55a91010a3"
--This free API key allows no more than 1 request per second
--You can register your own if it fails which is free - Dalin
lat = ""
lon = ""
--Using the longitude and latitude of Portsmouth to retrieve weather data
urlAPI = "http://api.openweathermap.org/data/2.5/weather?q=Exeter&appid=" ..keyAPI .. "&main.temp=metric"

wifi.sta.sethostname("uopNodeMCU")
wifi.setmode(wifi.STATION)
station_cfg={}
station_cfg.ssid="BT-3KA62F"
station_cfg.pwd="MvfRVvE6gEnvpL"
station_cfg.save=true
wifi.sta.config(station_cfg)
wifi.sta.connect()


mytimer = tmr.create()
mytimer:register(3000, 1, function()
if wifi.sta.getip()==nil then
  print("Connecting to AP...\n")
else
  http.get(urlAPI, nil, function(code, data)
  if (code < 0) then
    --200 is success code
    --for the rest, refer to https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
    print("http request failed")
  else
    print (code)
    print (data)
    data = sjson.decode(data)
    for k,v in pairs(data) do
      if type(v) == "table" then
        print (k)
        print_r(v)
      else
        print(k,v)
      end
    end
  end
  end)
  mytimer:stop()

end
end)
mytimer:start()



--Function used to print arrays
--from https://stackoverflow.com/questions/7274380/how-do-i-display-array-elements-in-lua
function print_r(arr, indentLevel)
  local str = ""
  local indentStr = "#"

  if(indentLevel == nil) then
    print(print_r(arr, 0))
    return
  end

  for i = 0, indentLevel do
    indentStr = indentStr.."\t"
  end

  for index,value in pairs(arr) do
    if type(value) == "table" then
      str = str..indentStr..index..": \n"..print_r(value, (indentLevel + 1))
    else
      str = str..indentStr..index..": "..value.."\n"
    end
  end
  return str
end