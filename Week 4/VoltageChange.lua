pinADC = 0
--A0 pin
mytimer:register(500, 1, function() 
 digitV = adc.read(pinADC)
 --the maximum for NodeMCU ADC is 1.1v
 --it is a 10-bit ADC, can represent 0-1023
 --1023 represent 1.1v or larger
 print(digitV)
end
mytimer:start()