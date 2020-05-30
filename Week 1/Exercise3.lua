pinLED1=4
input={100,2000,300,4000,500}
length = table.getn(input)
time=0

if length == 1 then
    if input[1] == 0 then
        gpio.mode(pinLED1, gpio.OUTPUT)
        gpio.write(pinLED1, gpio.LOW)

    elseif input[1] == 1 then 
        gpio.mode(pinLED1, gpio.OUTPUT)
        gpio.write(pinLED1, gpio.HIGH)
    end

elseif length == 0 then
    print("error, invalid length")

else
    for i=1, length, 1 do
        time=time+input[i] 
        tmr.create():alarm(time, tmr.ALARM_SINGLE, function (t) 
        
        if (gpio.read(pinLED1)) == 1 then
            gpio.mode(pinLED1, gpio.OUTPUT)
            gpio.write(pinLED1, gpio.LOW)
        else
            gpio.mode(pinLED1, gpio.OUTPUT)
            gpio.write(pinLED1, gpio.HIGH)
        end     
        t:unregister() 
        end)      
    end
end