G91 ; relative positioning
G1 Z-5 F360 ; move Z axis by -5mm to be safe for 4mm homing Z raise
G90 ; absolute positioning

M104 S0 ; turn off extruder
M84 ; disable steppers
M106 S0 ; disable cooling fans

M140 R30 ; wait for bed to reach 30° C
M140 S0 ; turn off bed

M117 Print complete

;[Version] End Script End