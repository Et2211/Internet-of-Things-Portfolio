wifi.setmode(wifi.STATIONAP)
station_cfg={}  
station_cfg.ssid="BT-3KA62F"
station_cfg.pwd="MvfRVvE6gEnvpL"
station_cfg.save=true
wifi.sta.config(station_cfg)  

mytimer=tmr.create()
mytimer:register(500, tmr.ALARM_AUTO, function()  
     if wifi.sta.getip()==nil then  
      print("Connecting to AP...")  
     else  
        mytimer:stop()
      print("Connected as: " .. wifi.sta.getip())  
       cfg={}  
       cfg.ssid="intarwebs"  
       wifi.ap.config(cfg)
     end  
   end)  
mytimer:start()  

--requires port forwarding
--extremely poor performance. No images/large files
--http://www.areresearch.net/2015/10/using-esp8266-as-wifi-range-extender.html