--make sure you are online first - Dalin
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
mytimer = tmr.create()
mytimer:register(500,1,function()
print(wifi.sta.getip())

cl = net.createConnection(net.TCP, 0)
--create a TCP based not encryped client
cl:on("connection",function(conn, s)
conn:send("Now in connection, hello Dalin\n")
mytimer:stop()
end)
cl:on("disconnection",function(conn, s)
print('Now we are disconnected\n')
end)
cl:on("sent",function(conn, s)
print('Message has been sent out\n')
end)
cl:on("receive", function(conn, s)
print('What we receive from the server\n' .. s .. '\n')
end)
--on(event, function())
--event can be "connection", "reconnection", "disconnection", "receive" or "sent"
--function(net.socket[, para]) is the callback function.
--The first parameter of callback is the socket.
--If event is "receive", the second parameter is the received data as string.
--If event is "disconnection" or "reconnection", the second parameter is error code.
cl:connect(1999,'192.168.1.166')

end)
--the local IP of your test server

mytimer:start()
