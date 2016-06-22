;[Version] Start Script Begin
;relies on M83 (use relative extrusion distances)

M117 Preparing
M190 S60 ; wait for bed to reach 60° C
M140 S[bed0_temperature] ; set bed temperature
T0 ; select extruder 0
M104 S[extruder0_temperature] ; set extruder 0 temperature

;home
G28

