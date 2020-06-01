dc = 1023 
positive=true 
pinDim = 3
inputs = {500, 300}
index = 0
pwm.setup(pinDim, 500, dc) -- 1000 is the rate of change.
pwm.start(pinDim)
blinkDim = tmr.create()
blinkDim:alarm(200, tmr.ALARM_AUTO, function()
    flashDim(inputs)
end)

function dimLights()
    if (positive == true) then
        dc=dc-10 
    else
        dc=dc+10 
    end
        print(dc)
        pwm.setduty(pinDim,dc)  
    
    if(dc<10) then 
        positive = false
    end
    
    if(dc>1013) then 
        positive = true
    end
end

function flashDim(inputs)
    index = index + 1
    if index == #inputs + 1  then
        index = 1
    end 
    
    print(index)
    blinkDim:interval(inputs[index] + 1)
    if index == 1 then
        dimLights()
    else
        pwm.setduty(pinDim, 0)
    end
end