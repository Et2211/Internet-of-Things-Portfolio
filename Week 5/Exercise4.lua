--Please refer to the official documentation of wifi.sta.getap()
--The available APs are scanned and listed
--With their RSSI and location, we would localize our own device
--Accuracy depends on the perfornabce of the chip
wifi.setmode(wifi.STATIONAP)
RssiAP ={}
function listAP(t)
  -- (SSID : Authmode, RSSI, BSSID, Channel)
  print("\n"..string.format("%32s","SSID").."\tBSSID\t\t\t\t RSSI\t\tAUTHMODE\tCHANNEL")
  for ssid,v in pairs(t) do

    local authmode, rssi, bssid, channel = string.match(v, "([^,]+),([^,]+),([^,]+),([^,]+)")
    --RSSI here will be picked
    print(string.format("%32s",ssid).."\t"..bssid.."\t "..rssi.."\t\t"..authmode.."\t\t\t"..channel)
    table.insert(RssiAP, rssi)

  end
  for i,v in pairs (RssiAP) do print (i, v) end
  calcLocation(RssiAP, 0.1) --Unsure on what n should be. 0.1 provides good results in user's testing
end
wifi.sta.getap(listAP)


function calcLocation(arr, n)
    length=table.getn(arr)
    distance = {}
    
    for i,v in pairs (arr) do 
        fraction = (-v/10*n) - 36 --36 is the RSSI value when 1m away from station
        d = math.pow(10, fraction)
        table.insert(distance, d)
    end
    for i,v in pairs (distance) do print (i, v) end
end

