buttonPin = 7.
dhtPin = 2
pushed = 0
count=0
tempOn=0

gpio.mode(buttonPin, gpio.INPUT)
gpio.write(buttonPin, gpio.HIGH)

mytimer = tmr.create()
mytimer2 = tmr.create()
mytimer:register(1, 1, function()

if gpio.read(buttonPin)==0 then
 pushed = 1
 count=count+1
 gpio.trig(buttonPin, "up", function()
 print(count)
  if count>=1000 then
    if tempOn ==0 then
        mytimer2:register(5000, tmr.ALARM_AUTO, function()
            
            status, temp, humi, temp_dec, humi_dec = dht.read11(dhtPin)
            if status == dht.OK then
                print("DHT Temperature:"..temp..";".."Humidity:"..humi)
            elseif status == dht.ERROR_CHECKSUM then
               print( "DHT Checksum error." )
           elseif status == dht.ERROR_TIMEOUT then
               print( "DHT timed out." )
           end
        end)
        mytimer2:start()
        tempOn=1
    else
        mytimer2:stop()
        tempOn=0
    end

 end
 count=0
 end)

 end

end)
mytimer:start()

