wifi.setmode(wifi.STATIONAP)
--you can do it manually with
--wifi.ap.config({ssid="nameyournodeMCU", pwd="yourpassword", auth=wifi.WPA2_PSK})
--enduser_setup.manual(true)
enduser_setup.start()
print("AP IP:"..wifi.ap.getip())
print("AP MAC:"..wifi.ap.getmac())
print("STA MAC:"..wifi.sta.getmac())
