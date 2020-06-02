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
        sntp.sync(tmsrv,function()
        print("Sync succeeded")
        mytimer:stop()
        stampTime()
    end,function()
        print("Synchronization failed!")
    end, 1)
   
   end 
end)
mytimer:start()

function stampTime()
    --get the stamp of the time from synchronized clock
    sec,microsec,rate = rtctime.get()
    tm = rtctime.epoch2cal(sec,microsec,rate)
    print(string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"],
    tm["hour"], tm["min"], tm["sec"]))
end