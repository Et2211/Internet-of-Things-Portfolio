pinADC = 0
--A0 pin
dc = adc.read(pinADC)
pinDim = 3
pwm.setup(pinDim,1000,dc)
pwm.start(pinDim)
stopped=0
multiplier=5

mytimer=tmr.create()
mytimer:register(10, 1, function() 
 digitV = adc.read(pinADC)
 print(digitV)
 if digitV > 1023 then
    digitV = 1023 --Correct for too high voltage
 end
 --dc = 1023 - digitV
 pwm.setduty(pinDim,digitV/multiplier)

end)
mytimer:start()

buttonPin = 7
gpio.mode(buttonPin, gpio.INPUT)
gpio.write(buttonPin, gpio.HIGH)
pushed = 0
mytimerPush = tmr.create()
mytimerRelease = tmr.create()

mytimerPush:register(100, 1, function()
if gpio.read(buttonPin)==0 and pushed ==0 then
 pushed = 1
 print("Button Push detected")
  if stopped==0 then
   mytimer:stop()
   stopped=1
 pwm.setduty(pinDim,0)
 
  else 
   mytimer:start()
   stopped=0
  end
 
end

end)

mytimerRelease:register(100, 1, function()
if gpio.read(buttonPin)==1 and pushed == 1 then
 pushed = 0
end
end)

mytimerPush:start()
mytimerRelease:start()

buttonPin2 = 6
gpio.mode(buttonPin2, gpio.INPUT)
gpio.write(buttonPin2, gpio.HIGH)
pushed2 = 0
mytimerPush2 = tmr.create()
mytimerRelease2 = tmr.create()

mytimerPush2:register(100, 1, function()
if gpio.read(buttonPin2)==0 and pushed2 ==0 then
 pushed2 = 1
 multiplier = multiplier - 1
 if multiplier < 1 then
  multiplier = 5
  
 end
print(multiplier)
end
end)

mytimerRelease2:register(100, 1, function()
if gpio.read(buttonPin2)==1 and pushed2 == 1 then
 pushed2 = 0
end
end)

mytimerPush2:start()
mytimerRelease2:start()


