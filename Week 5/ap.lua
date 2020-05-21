wifi.setmode(wifi.STATIONAP)
--you can do it manually with
wifi.ap.config({ssid="MyNode", pwd="12345678", auth=wifi.WPA2_PSK})
enduser_setup.manual(true)
enduser_setup.start()
print("AP IP:"..wifi.ap.getip())
print("AP MAC:"..wifi.ap.getmac())
print("STA MAC:"..wifi.sta.getmac())

tmr.create():alarm(1000, tmr.ALARM_AUTO, function()
print(wifi.sta.status())

end)