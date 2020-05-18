dc=1023
pinDim = 3
pwm.setup(pinDim,1000,dc)
pwm.start(pinDim)
pause=false
mytimer = tmr.create()
mytimer:alarm(200,tmr.ALARM_AUTO,function()

    if pause==false then
        dc=dc-10
        print(dc)
        pwm.setduty(pinDim,dc)
        if (dc<10) then
            dc=1023
        end
    end
end)

mytimer2 = tmr.create()
mytimer2:alarm(5000, tmr.ALARM_AUTO, function()
    pause = true
    pwm.setduty(pinDim, 0)
    
    mytimer2:alarm(3000, tmr.ALARM_SINGLE, function()
        pwm.setduty(pinDim, dc)
        pause = false
    end)    
end)
