;[Version] Start Script Begin
;relies on M83 (use relative extrusion distances)

;home
G28

M117 Preparing
M190 S50 ; wait for bed to reach 50C
M140 S[bed0_temperature] ; set bed temperature
M104 S[extruder0_temperature] T0; set extruder 0 temperature

