wifi.setmode(wifi.SOFTAP)   -- set AP parameter
config = {}
config.ssid = "NodeMCU"
config.pwd = "12345678"
wifi.ap.config(config)

config_ip = {}  -- set IP,netmask, gateway
config_ip.ip = "192.168.2.1"
config_ip.netmask = "255.255.255.0"
config_ip.gateway = "192.168.2.1"
wifi.ap.setip(config_ip)

LEDpin = 3                  -- declare LED pin
gpio.mode(LEDpin, gpio.OUTPUT)
server = net.createServer(net.TCP)-- create TCP server

function SendHTML(sck, led) -- Send LED on/off HTML page
   htmlstring = "<!DOCTYPE html>\r\n"
   htmlstring = htmlstring.."<html>\r\n"
   htmlstring = htmlstring.."<head>\r\n"
   htmlstring = htmlstring.."<title>LED Control</title>\r\n"
   htmlstring = htmlstring.."</head>\r\n"
   htmlstring = htmlstring.."<body>\r\n"
   htmlstring = htmlstring.."<h1>LED</h1>\r\n"
   htmlstring = htmlstring.."<p>Click to switch LED on and off.</p>\r\n"
   htmlstring = htmlstring.."<form method=\"get\">\r\n"
  if (led)  then
   htmlstring = htmlstring.."<input type=\"button\" value=\"LED OFF\" onclick=\"window.location.href='/ledoff'\">\r\n"
  else
   htmlstring = htmlstring.."<input type=\"button\" value=\"LED ON\" onclick=\"window.location.href='/ledon'\">\r\n"
  end
   htmlstring = htmlstring.."</form>\r\n"
   htmlstring = htmlstring.."</body>\r\n"
   htmlstring = htmlstring.."</html>\r\n"
   sck:send(htmlstring)
end

function receiver(sck, data)-- process callback on recive data from client
  if string.find(data, "GET /ledon")  then
   SendHTML(sck, true)
   gpio.write(LEDpin, gpio.HIGH)
  elseif string.find(data, "GET / ") or string.find(data, "GET /ledoff") then
   SendHTML(sck, false)
   gpio.write(LEDpin, gpio.LOW)
  else
   sck:send("<h2>Not found...!!</h2>")
   sck:on("sent", function(conn) conn:close() end)
  end
end

if server then
  server:listen(80, function(conn)-- listen to the port 80
  conn:on("receive", receiver)
  end)
end