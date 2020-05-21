--Please refer to the official documentation of wifi.sta.getap()
--The available APs are scanned and listed
--With their RSSI and location, we would localize our own device
--Accuracy depends on the perfornabce of the chip
wifi.setmode(wifi.STATIONAP)
function listAP(t)
-- (SSID : Authmode, RSSI, BSSID, Channel)
print("\n"..string.format("%32s","SSID").."\tBSSID\t\t\t\t RSSI\t\tAUTHMODE\tCHANNEL")
for ssid,v in pairs(t) do
local authmode, rssi, bssid, channel = string.match(v, "([^,]+),([^,]+),([^,]+),([^,]+)")
--RSSI here will be picked
 print(string.format("%32s",ssid).."\t"..bssid.."\t "..rssi.."\t\t"..authmode.."\t\t\t"..channel)
end
end
wifi.sta.getap(listAP)