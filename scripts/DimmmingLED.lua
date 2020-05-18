dc=1023 
pinDim = 3
pwm.setup(pinDim, 1000, dc)
pwm.start(pinDim)
mytimer = tmr.create()
positive=true
mytimer:alarm(2,tmr.ALARM_AUTO, function()

    if (positive == true) then
        dc=dc-10
        print(dc)
        pwm.setduty(pinDim,dc)  

    else
        dc=dc+10
        print(dc)
        pwm.setduty(pinDim,dc)  

    end
    
    if(dc<10) then 
        positive = false
    end
    
    if(dc>1013) then 
        positive = true
    end
end
)