--cron.schedule()
--refer to https://en.wikipedia.org/wiki/Cron
--for the mask "* * * * *" information
--minute, hour, day of a month, month of a year, day of the week

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

cron.schedule("* * * * *", function(e)
print("For every minute function will be executed once")
end)
cron.schedule("*/5 * * * *", function(e)
print("For every 5 minutes function will be executed once")
end)
cron.schedule("0 7 * * *", function(e)
print("\n Alarm Clock \n It is 07:00!!! \n Get UP! \n")
end)

--set your own alarm at 07:00
--please change it to 2 minutes later from now on
--and see if it will alarm you according to the synchronized time.