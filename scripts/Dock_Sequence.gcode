; lift the head
G91 ; relative positioning
G1 Z5 F360 ; move Z axis by 5mm
G90 ; absolute positioning

;move to dock
T0 ; select extruder 0
G1 X%dockX% Y%dockYpre% F3000 ; move to position in front of dock
G1 X%dockX% Y%dockY% F3000 ; move into dock

