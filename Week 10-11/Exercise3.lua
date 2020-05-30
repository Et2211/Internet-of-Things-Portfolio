wifi.sta.sethostname("uopNodeMCU")
wifi.setmode(wifi.STATION)
station_cfg={}
station_cfg.ssid="BT-3KA62F"
station_cfg.pwd="MvfRVvE6gEnvpL"
station_cfg.save=true
wifi.sta.config(station_cfg)
wifi.sta.connect()
text=""
Tfile="samplefile.txt"
mytimer = tmr.create()
mytimer:register(3000, 1, function() 
   if wifi.sta.getip()==nil then
        print("Connecting to AP...\n")
   else
       mytimer:stop()

       crawl()
       mytimer2 = tmr.create()
       mytimer2:register(300, 1, function() 
        if text ~= nil then
            --print(text)
            mytimer2:stop()

            writeFile(Tfile, text)
            textF = readFile(Tfile)
            put(textF)
        end
       end)
       mytimer2:start()
        --writeFile("")
        --readFile()
        --post()
        --put()
        --delete()
        --can not be concurrent requests
        --comment out 2 and execute 1
     
   end        
end)
mytimer:start()

function crawl()
url='http://httpbin.org/ip'
--url='http://wttr.in/'
--url='http://www.amazon.co.uk'
--try other urls and see why they can work or why not
print(url)
headers={['user-agent'] = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36', ['content-type'] = 'json'}
for i,v in pairs(headers) do print(i,v) end
--headers to avoid the website to recognise you as a robot
--the headers here is different from the default one
--you can check it in the httpBasic.lua file on Moodle
http.request(url,'GET', headers,'',function(code, data)
    if (code<0) then
      print("HTTP request failed")
      print(code)
    else
      print(code)
      print(data)
      text = data
    end
end)

end


function put(text)
http.put('http://httpbin.org/put',
  'Content-Type: text/plain\r\n',
  text,
  function(code,data)
    if (code < 0) then
      print("HTTP request failed")
    else
      print(code)
      print(data)
    end
  end)
end

function writeFile(Tfile, text) 

    fileList = file.list()
    print(type(fileList))

    for name,size in pairs(fileList) do
        print("File name: "..name.." with size of "..size.." bytes")
    end

    fd= file.open(Tfile,'w') 
    if fd then
        fd:writeline(text)
    --file.write('second string')
    --file.write('third string')
    --fd:close(); fd = nil
    --fd= file.open('samplefile.txt','r')
        --print(fd:readline())
        --fd:close(); fd = nil
    else
        print("file not found")
    end

end

function readFile(Tfile) 

    fileList = file.list()
    --print(type(fileList))

    for name,size in pairs(fileList) do
        print("File name: "..name.." with size of "..size.." bytes")
    end

    fd= file.open(Tfile,'r') 
    if fd then
        --print(fd:read())
        text = fd:read()
        return text
    
    else
        print("file not found")
    end

end

