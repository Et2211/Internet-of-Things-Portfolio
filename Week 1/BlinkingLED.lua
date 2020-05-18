pinLED1=1

mytimer = tmr.create()
mytimer:register(2000, 1, function()

    if (gpio.read(pinLED1)) then
        gpio.mode(pinLED1, gpio.OUTPUT)
        gpio.write(pinLED1, gpio.LOW)
    else
        gpio.mode(pinLED1, gpio.OUTPUT)
        gpio.write(pinLED1, gpio.HIGH)
    end
end)

mytimer:start()