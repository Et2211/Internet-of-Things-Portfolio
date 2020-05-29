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
        print("Connected")
        crawl()
        mytimer:stop()
   end 
end)
mytimer:start()

function crawl()
--url='http://httpbin.org/ip'
--url='http://wttr.in/'
url='http://www.amazon.co.uk'
--try other urls and see why they can work or why not
print(url)
headers={['user-agent'] = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36', ['content-type'] = 'json'}
for i,v in pairs(headers) do print(i,v) end
--headers to avoid the website to recognise you as a robot
--the headers here is different from the default one
--you can check it in the httpBasic.lua file on Moodle
http.request(url,'GET', headers,'',function(code, data)
    if (code<0) then
      print("HTTP request failed")
      print(code)
    else
      print(code)
      print(data)
    end
end)
end
