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
print(v)
local authmode, rssi, bssid, channel = string.match(v, "([^,]+),([^,]+),([^,]+),([^,]+)")
--RSSI here will be picked
 print(string.format("%32s",ssid).."\t"..bssid.."\t "..rssi.."\t\t"..authmode.."\t\t\t"..channel)
 table.insert(RssiAP, rssi)

end
 print_r(RssiAP)
end
wifi.sta.getap(listAP)


function CalcLocation(arr)
    
end




--Function used to print arrays
--from https://stackoverflow.com/questions/7274380/how-do-i-display-array-elements-in-lua
function print_r(arr, indentLevel)
    local str = ""
    local indentStr = "#"

    if(indentLevel == nil) then
        print(print_r(arr, 0))
        return
    end

    for i = 0, indentLevel do
        indentStr = indentStr.."\t"
    end

    for index,value in pairs(arr) do
        if type(value) == "table" then
            str = str..indentStr..index..": \n"..print_r(value, (indentLevel + 1))
        else 
            str = str..indentStr..index..": "..value.."\n"
        end
    end
    return str
end