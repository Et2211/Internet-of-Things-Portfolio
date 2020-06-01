wifi.sta.autoconnect(1)
wifi.setmode(wifi.STATION)
station_cfg={}
station_cfg.ssid="BT-3KA62F"
station_cfg.pwd="MvfRVvE6gEnvpL"
station_cfg.save=true
wifi.sta.config(station_cfg)
tmsrv = "uk.pool.ntp.org"
output = ""
keyAPI = "9f418d12e2c0f5e721197b55a91010a3"
lat = ""
lon = ""
loc=""
temp=""
humi=""
urlAPI = "http://api.openweathermap.org/data/2.5/weather?q=Exeter&appid=" ..keyAPI .. "&main.temp=metric"


timer=tmr.create()

function stampTime()
  --get the stamp of the time from synchronized clock
  sec,microsec,rate = rtctime.get()
  tm = rtctime.epoch2cal(sec,microsec,rate)
  print(string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"],
  tm["hour"], tm["min"], tm["sec"]))
end

srv = net.createServer(net.TCP,30)

mytimer=tmr.create()
mytimer:register(500,1,function()

print(wifi.sta.getip())
if wifi.sta.status() == wifi.STA_GOTIP then

  sntp.sync(tmsrv,function()
  print("Sync succeeded")
  timer:stop()
  stampTime()
  end,function()
  print("Synchronization failed!")
  end, 1)

  srv:listen(80, function(conn)
  conn:on("receive", function(conn, s)
  print(s)
  conn:send(s)
  end)
  conn:on("connection",function(conn, s)

  
  cron.schedule("* 7 * * *", function(e)
  print("\n Alarm Clock \n It is 07:00!!! \n Get UP! \n")

  http.get(urlAPI, nil, function(code, data)

  if (code < 0) then
    print("http request failed")
  else
    print (code)
    print (data)
    data=sjson.decode(data)
    print(data)

    for index, value in pairs(data) do
      if type(value) =="table" then
        for key, val in pairs(value) do
          print(key, val)

          if key == "temp" then
            temp = val
          elseif key == "humidity" then
            humi = val
          end
        end

      else
        print(index, value)
        if index == "name" then
          loc=value
        end

      end
    end
      buf = ""
      buf=buf.."<html>"
      buf=buf.."<head> <title>Weather in "..loc.."</title> <meta http-equiv=\"refresh\" content=\"3\"></head>"
      buf=buf.."<body><p>Temperature: "..temp.."</p>"
      buf=buf.."<p>Humidity: "..humi.."%RH</p>"
      buf=buf.."<p>Did you spot any limitation here ? And can you improve it ?".."</p></body></html>"
      conn:send(buf)
    end
    end)

    end)



    end)
    conn:on("disconnection", function(conn, s)
    print("Now we are disconnected\n")
    end)
    conn:on("receive", function(conn, s)
    print('What we receive from the Client\n' .. s .. '\n')
    end)
  end
  )
  --srv:close()
  mytimer:stop()
end

end)

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


mytimer:start()
