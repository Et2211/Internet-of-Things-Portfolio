wifi.sta.autoconnect(1)
--autoconnect
wifi.setmode(wifi.STATION)
station_cfg={}
station_cfg.ssid="BT-3KA62F"
station_cfg.pwd="MvfRVvE6gEnvpL"
station_cfg.save=true
wifi.sta.config(station_cfg)
--wifi.sta.connect()
--wifi.sta.disconnect()
--manual connect and disconnect

srv = net.createServer(net.TCP,30)

mytimer=tmr.create()
mytimer:register(500,1,function()

print(wifi.sta.getip())
if wifi.sta.status() == wifi.STA_GOTIP then

--TCP, 30s for an inactive client to be disconnected
--try srv = net.createServer(net.UDP,10)
srv:listen(80, function(conn)
conn:on("receive", function(conn, s)
print(s)
 conn:send(s)
end)
conn:on("connection",function(conn, s)


pinDHT = 2
local status, temp, humi , temp_dec, humi_dec = dht.read11(pinDHT)

if status == dht.OK then
print("DHT Temperature:"..temp.." Humidity:"..humi.."\n")
buf = ""
buf=buf.."<html>"
buf=buf.."<head> <title>DHT11 LAN update</title> <meta http-equiv=\"refresh\" content=\"3\"></head>"
buf=buf.."<body><p>Temperature: "..temp.."."..temp_dec.."C</p>" 
buf=buf.."<p>Humidity: "..humi.."."..humi_dec.."%RH</p>"
buf=buf.."<p>Did you spot any limitation here ? And can you improve it ?".."</p></body></html>"

end

conn:send(buf)

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


mytimer:start()
