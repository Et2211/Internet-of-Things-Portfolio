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
 
end
print(pushed)
end)

mytimerRelease:register(100, 1, function()
if gpio.read(buttonPin)==1 and pushed == 1 then
 pushed = 0
end
end)

mytimerPush:start()
mytimerRelease:start()
