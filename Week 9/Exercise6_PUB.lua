pinADC=0
digitV=0

wifi.sta.sethostname("uopNodeMCU")
wifi.setmode(wifi.STATION)
station_cfg={}
station_cfg.ssid="BT-3KA62F"
station_cfg.pwd="MvfRVvE6gEnvpL"
station_cfg.save=true
wifi.sta.config(station_cfg)
wifi.sta.connect()

mytimer = tmr.create()
mytimer:register(3000, 1, function() 
   if wifi.sta.getip()==nil then
        print("Connecting to AP...\n")
   else
        ip, nm, gw=wifi.sta.getip()
        mac = wifi.sta.getmac()
        rssi = wifi.sta.getrssi()
        print("IP Info: \nIP Address: ",ip)
        print("Netmask: ",nm)
        print("Gateway Addr: ",gw)
        print("MAC: ",mac)  
        print("RSSI: ",rssi,"\n")
        mytimer:stop()
   end 
end)
mytimer:start()

HOST="io.adafruit.com"--adafruit host
PORT=1883--1883 or 8883(1883 for default TCP, 8883 for encrypted SSL or other ways)
PUBLISH_TOPIC='etienne2211/feeds/ADCVoltage' -- put your topic of publish shown on the IoT platform/broker site
SUBSCRIBE_TOPIC='etienne2211/feeds/ADCVoltage' -- put your topic of subscribe shown on the IoT platform/broker site
ADAFRUIT_IO_USERNAME="etienne2211"--put your own username here
ADAFRUIT_IO_KEY="aio_hmND614xlAk6kTWnKj1vqfjK0lFn"--put your own io_key here
-- init mqtt client with logins, keepalive timer 300 seconds
m=mqtt.Client("Client1",300,ADAFRUIT_IO_USERNAME,ADAFRUIT_IO_KEY)
-- setup Last Will and Testament (optional)
-- Broker will publish a message with qos = 1, retain = 0, data = "offline"
-- to topic "/lwt" if client does not send keepalive packet
m:lwt("/lwt","Now offline",1,0)
--on different event "connect","offline","message",...
m:on("connect",function(client) 
    print("Client connected") 
    print("MQTT client connected to"..HOST)
    client:subscribe(SUBSCRIBE_TOPIC,1,function(client)
        print("Subscribe successfully") 
        end)
    pubADC(client)
end)
m:on("offline",function(client)
    print("Client offline")
end)


m:connect(HOST,PORT,false,false,function(conn) end,function(conn,reason)
    print("Fail! Failed reason is: "..reason)
end)

mytimerADC = tmr.create()
mytimerADC:register(400, 1, function() 
    digitV = adc.read(pinADC)
end
)
mytimerADC:start()

function pubADC(client)
    mytimerPublish = tmr.create()
    mytimerPublish:register(2000,1,function()
    client:publish(PUBLISH_TOPIC,tostring(digitV),1,0,function(client)
    print("ADC reading sent: ",digitV) 
        end)
    end)
    mytimerPublish:start()
end

