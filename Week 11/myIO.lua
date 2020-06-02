myIO = {}
local led1, led2 = 4, 0
local led1mode, led2mode = gpio.OUTPUT, gpio.OUTPUT

function myIO.gpioInit()
  gpio.mode(led1, led1mode)
  gpio.mode(led2, led2mode)
  return true
end

function myIO.setLED(x)
  if x == 1 then
    gpio.write(led1, gpio.LOW)
    gpio.write(led2, gpio.HIGH)
  else
    gpio.write(led2, gpio.LOW)
    gpio.write(led1, gpio.HIGH)
  end
end

return myIO