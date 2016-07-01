G91 ; relative positioning
G1 Z-5 F360 ; move Z axis by -5mm to be safe for 4mm homing Z raise
G90 ; absolute positioning

M104 S0 T0; turn off extruder 0
M104 S0 T1; turn off extruder 1
M140 S0 ; turn off bed
M84 ; disable steppers
M106 S0 ; disable cooling fans
T0 ; select extruder 0

M117 Print complete

;[Version] End Script End