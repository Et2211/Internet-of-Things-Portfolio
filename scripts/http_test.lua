pinLED1 = 1 --Green light represents a forehand shot
pinLED2 = 2 --Red light represents a backhand shot
i=0

function forehand()
    --right:send("shot fired")
    gpio.write(pinLED1, gpio.HIGH)
    
    tmr.create():alarm(1000, tmr.ALARM_SINGLE, function()
    gpio.write(pinLED1, gpio.LOW)
    end)

end

function backhand()
    --left:send("shot fired")
    gpio.write(pinLED2, gpio.HIGH)
    
    tmr.create():alarm(1000, tmr.ALARM_SINGLE, function()
    gpio.write(pinLED2, gpio.LOW)
    end)
end


svr = net.createServer(net.TCP)
function htmlUpdate(sck,flag)
--update the html file for display in your browser
 html = '<html>\r\n<head>\r\n<title>LED LAN Control</title>\r\n</head>\r\n'
 html = html..'<body>\r\n<h1>LED</h1>\r\n<p>Select mode and start.</p>\r\n<form method=\"get\">\r\n'
--method is get here, listener will try to find the get info

 html = html.."<input type=\"button\" value=\"Forehands\" onclick=\"window.location.href='/FOREHAND'\">\r\n <input type=\"button\" value=\"Backhands\" onclick=\"window.location.href='/BACKHAND'\">\r\n"
-- add the different button
 html = html.."</form>\r\n</body>\r\n</html>\r\n"
 sck:send(html)
end

function setMode(sck,data)
 gpio.mode(pinLED1, gpio.OUTPUT)
 gpio.mode(pinLED2, gpio.OUTPUT)
 print(data)

 
--check what is the data received, and figure out why we find the match pattern in the string
 if string.find(data, "GET /FOREHAND") then
shotTimer=tmr.create()
      shotTimer:register(5000, tmr.ALARM_AUTO, function()
        forehand() 
        i=i+1
        print(i)

       if i==10 then
         shotTimer:unregister()
         print("finished")
       end
      end)
      shotTimer:start()

      
 elseif string.find(data, "GET /BACKHAND ")then
 shotTimer=tmr.create()
      shotTimer:register(5000, tmr.ALARM_AUTO, function()
        backhand() 
        i=i+1
        print(i)

       if i==10 then
         shotTimer:unregister()
         print("finished")
       end
      end)
      shotTimer:start()

 end
end
print(wifi.sta.getip())
if svr then
 svr:listen(80, function(conn)
--listen to the port 80 for http
--when the event of ‘data is received’ happens, run the setMode
 conn:on("receive", setMode)
 end)

 conn:on("connection",function(conn, s)
 print("hello there")
 end)
end

