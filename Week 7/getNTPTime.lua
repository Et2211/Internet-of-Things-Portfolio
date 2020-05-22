tmsrv = "uk.pool.ntp.org"
--an optional NTP server
mytimer=tmr.create()

function stampTime()
    --get the stamp of the time from synchronized clock
    sec,microsec,rate = rtctime.get()
    tm = rtctime.epoch2cal(sec,microsec,rate)
    print(string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"],
    tm["hour"], tm["min"], tm["sec"]))
end

mytimer:alarm(2000, 1, function()
    sntp.sync(tmsrv,function()
        print("Sync succeeded")
        mytimer:stop()
        stampTime()
    end,function()
        print("Synchronization failed!")
    end, 1)
end)