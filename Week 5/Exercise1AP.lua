wifi.setmode(wifi.SOFTAP)
ap_cfg={}
ap_cfg.ssid="yourapname"
ap_cfg.pwd="2020a202"
--the rest have default value
--check them by yourself, which is helpful to know how it works - Dalin
wifi.ap.config(ap_cfg)