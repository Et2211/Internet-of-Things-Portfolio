local button_pin = 7
tempOn=0
gpio.mode(button_pin, gpio.INT, gpio.PULLUP)

mytimer=tmr.create()
mytimer:register(1500, tmr.ALARM_AUTO, function()
    dhtPin = 2
    status, temp, humi, temp_dec, humi_dec = dht.read11(dhtPin)
    if status == dht.OK then
    --3 different status
    --dht.OK, dht.ERROR_CHECKSUM, dht.ERROR_TIMEOUT
     print("DHT Temperature:"..temp..";".."Humidity:"..humi)
    -- 2 dots are used for concatenation
    elseif status == dht.ERROR_CHECKSUM then
     print( "DHT Checksum error." )
    elseif status == dht.ERROR_TIMEOUT then
     print( "DHT timed out." )
    end
end
)

gpio.trig(button_pin, "up", function()
    print("Pressed ")
    if tempOn == 0 then
        mytimer:start()
        tempOn = 1
    else
        mytimer:stop()
        tempOn = 0
    end
end)


