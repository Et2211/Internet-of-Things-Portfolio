mytimer = tmr.create()
mytimer:register(2000, 1, function()


pinLED1=4
pinLED2=0
LED1State = gpio.read(pinLED1)
    if LED1State ==  gpio.HIGH then
 
        gpio.mode(pinLED1, gpio.OUTPUT)
        gpio.write(pinLED1, gpio.LOW)
       
        gpio.mode(pinLED2, gpio.OUTPUT)
        gpio.write(pinLED2, gpio.HIGH)

    else

        gpio.mode(pinLED1, gpio.OUTPUT)
        gpio.write(pinLED1, gpio.HIGH)
       
        gpio.mode(pinLED2, gpio.OUTPUT)
        gpio.write(pinLED2, gpio.LOW)

        end

end)
mytimer:start()
