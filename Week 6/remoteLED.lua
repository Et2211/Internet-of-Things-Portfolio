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
pinLED = 3

srv = net.createServer(net.TCP,30)

mytimer=tmr.create()
mytimer:register(500,1,function()

print(wifi.sta.getip())
if wifi.sta.status() == wifi.STA_GOTIP then

--TCP, 30s for an inactive client to be disconnected
--try srv = net.createServer(net.UDP,10)
srv:listen(3005, function(conn)
conn:send("Send to all clients who connect to Port 80, hello world! \n")
conn:on("receive", function(conn, s)
print(s)
end)
conn:on("connection",function(conn, s)
 conn:send("connected") 
end)
conn:on("disconnection", function(conn, s)
 print("disconnected\n")
end)
conn:on("sent",function(conn, s)
 print('Message has been sent out from the Server\n')
end)
conn:on("receive", function(conn, s)
 print('What we receive from the Client\n' .. s .. '\n')
 if s == 'on' then 
        gpio.mode(pinLED, gpio.OUTPUT)
        gpio.write(pinLED, gpio.HIGH) 
 elseif s=='off' then
        gpio.mode(pinLED, gpio.OUTPUT)
        gpio.write(pinLED, gpio.LOW) 
 end
end)
end
)
--srv:close()
mytimer:stop()
end

end)


mytimer:start()
