greenPin=3
yellowPin=2
redPin=1
greenDC=1023
yellowDC=0
redDC = 0
greenOn=1

pwm.setup(greenPin, 1000, greenDC)
pwm.setup(yellowPin, 1000, yellowDC)
pwm.setup(redPin, 1000, redDC)
pwm.start(greenPin)
pwm.start(yellowPin)
pwm.start(redPin)

mytimer=tmr.create()
mytimer:register(8000, tmr.ALARM_AUTO, function() 

    pwm.setduty(greenPin,0) 
    pwm.setduty(yellowPin,1023)

    tmr.create():alarm(2000, tmr.ALARM_SINGLE, function()
        pwm.setduty(yellowPin,0) 
        pwm.setduty(redPin,1023)

        tmr.create():alarm(2000, tmr.ALARM_SINGLE, function()
            pwm.setduty(yellowPin,1023) 
            pwm.setduty(redPin,0)

            tmr.create():alarm(2000, tmr.ALARM_SINGLE, function()
                pwm.setduty(yellowPin,0) 
                pwm.setduty(greenPin,1023)
            end)
        end)
    end)
    
end)
mytimer:start()