wifi.sta.autoconnect(1)
--autoconnect
wifi.setmode(wifi.STATION)

station_cfg={}
station_cfg.ssid="BT-3KA62F"
station_cfg.pwd="MvfRVvE6gEnvpL"
station_cfg.save=true
wifi.sta.config(station_cfg)
--wifi.sta.connect()
--wifi.sta.disconnect()
--manual connect and disconnect

pinLED1 = 1 --Green light represents a forehand shot
pinLED2 = 2 --Red light represents a backhand shot
user="none"
left="none" --left ball machine
right="none" --right ball machine
i=0

srv = net.createServer(net.TCP,30)

mytimer=tmr.create()
mytimer:register(500,1,function()

print(wifi.sta.getip())
if wifi.sta.status() == wifi.STA_GOTIP then

  --TCP, 30s for an inactive client to be disconnected
  --try srv = net.createServer(net.UDP,10)
  srv:listen(3005, function(conn)

  conn:on("connection",function(conn, s)
    print(sck)
  
   if user=="none" then
    user = conn

  elseif left=="none" then
    left = conn

  elseif right=="none" then
    right = conn
  end

  print(user)
  print(left)
  print(right)
  end)

  conn:on("disconnection", function(conn, s)
  print("Now we are disconnected\n")
  --unassign client role
  if user==conn then
    user = "none"

  elseif left==conn then
    left = "none"

  elseif right==conn then
    right = "none"
  end

  print(user)
  print(left)
  print(right)
  end)

  conn:on("receive", function(conn, s)

  if conn==user then
    i=0
    print('Ball Machine mode "' .. s .. '"\n')
    gpio.mode(pinLED1, gpio.OUTPUT)
    gpio.mode(pinLED2, gpio.OUTPUT)


    if s=='forehands' and right~="none" then

      shotTimer=tmr.create()
      shotTimer:register(4000, tmr.ALARM_AUTO, function()
        forehand() 
        i=i+1
        print(i)

       if i==10 then
         shotTimer:unregister()
         print("finished")
       end
      end)
      shotTimer:start()
      
       

    elseif s=='backhands'and left~="none" then

      shotTimer=tmr.create()
      shotTimer:register(4000, tmr.ALARM_AUTO, function()
        backhand() 
        i=i+1
        print(i)

       if i==10 then
         shotTimer:unregister()
         print("finished")
       end
      end)
      shotTimer:start()



    elseif s=="alternate" then
      shotTimer=tmr.create()
      shotTimer:register(8000, tmr.ALARM_AUTO, function()
        forehand() 
        
        tmr.create():alarm(4000, tmr.ALARM_SINGLE, function()
        backhand()
        end)
        
        i=i+1
        print(i)

       if i==5 then
         shotTimer:unregister()
         print("finished")
       end
      end)
      shotTimer:start()
   
    elseif s=="random" then

      shotTimer=tmr.create()
      shotTimer:register(5000, tmr.ALARM_AUTO, function()       
        if math.random(0,1) == 0 then
            forehand() 
        else
            backhand()            
        end
        i=i+1
        print(i)
        if i==10 then
         shotTimer:unregister()
         print("finished")
        end
        
        tmr.create():alarm(4000, tmr.ALARM_SINGLE, function()
        end)      
      end)
      shotTimer:start()
      
    else
      print("invalid mode")

    end
    gpio.write(pinLED1, gpio.LOW)
    gpio.write(pinLED2, gpio.LOW)

  else
    print("Unauthorised client. You must be the user to send commands")
  end
  end)
end
)
--srv:close()
mytimer:stop()
end

end)

function forehand()
    right:send("Fire")
    gpio.write(pinLED1, gpio.HIGH)
    
    tmr.create():alarm(1000, tmr.ALARM_SINGLE, function()
    gpio.write(pinLED1, gpio.LOW)
    end)
end

function backhand()
    left:send("Fire")
    gpio.write(pinLED2, gpio.HIGH)
    
    tmr.create():alarm(1000, tmr.ALARM_SINGLE, function()
    gpio.write(pinLED2, gpio.LOW)
    end)

end
mytimer:start()
