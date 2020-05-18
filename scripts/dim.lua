pinY = 1
pinG = 2
pinR = 3
dc_b = 1023
dc_y = 1023
dc_r = 1023
pwm.setup(pinG, 1000, dc_b)
pwm.setup(pinY, 1000, dc_y)
pwm.setup(pinR, 1000, dc_r)

pwm.start(pinG)
pwm.start(pinY)
pwm.start(pinR)

