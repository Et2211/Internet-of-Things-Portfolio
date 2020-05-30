pinADC = 0
--A0 pin
dc = adc.read(pinADC)
pinDim = 3
pwm.setup(pinDim,1000,dc)
pwm.start(pinDim)

mytimer=tmr.create()
mytimer:register(10, 1, function() 
 digitV = adc.read(pinADC)
 print(digitV)
 if digitV > 1023 then
    digitV = 1023 --Correct for too high voltage
 end
 dc = 1023 - digitV
 pwm.setduty(pinDim,dc)

end)
mytimer:start()

