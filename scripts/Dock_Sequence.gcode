;move to dock
T0 ; select extruder 0
G1 Z4 F3000 ; lift the head
G1 X%dockX% Y%dockYpre% F3000 ; move to position in front of dock
G1 X%dockX% Y%dockY% F3000 ; move into dock

