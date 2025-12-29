#macro nodeCount 120
#macro nodeSpawnRange 1150

#macro nodeMaxConnectionDist 420
#macro nodeCertainConnectionDist 100

#macro nodeMinimumConnectionStrength .05

#macro nodeConnectionOutlineColor c_white

#macro nodeRumorLengthBase 2
#macro nodeRumorLengthScale 32
#macro nodeRumorWidth 11

#macro nodeHoverRadiusBuffer 25

#macro popupYOff 150






#macro c_random make_color_rgb(irandom(255), irandom(255), irandom(255))
#macro c_randomGray var _brightness = random(255) make_color_rgb(_brightness, _brightness, _brightness)

#macro CONFIG_DBG os_get_config() == "debug"

#macro dbg show_debug_message

#macro sgt sprite_get_texture

