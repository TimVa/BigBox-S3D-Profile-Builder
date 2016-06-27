;purge old extruder
{IF OLDTOOL=0}T0
{IF OLDTOOL=0}G1 F400
{IF OLDTOOL=0}G1 E25 F400
{IF OLDTOOL=0}G1 E-14  F4000
{IF OLDTOOL=1}T1
{IF OLDTOOL=1}G1 F400
{IF OLDTOOL=1}G1 E25 F400
{IF OLDTOOL=1}G1 E-14  F4000

;extruder steps per mm
;uncomment if you want to use and set values
;{IF NEWTOOL=0}M92 E417.5 ; steps per mm extruder 0
;{IF NEWTOOL=1}M92 E417.5 ; steps per mm extruder 1
;{IF NEWTOOL=0}M301 P1 I2 D3 ; PID parameters extruder 0
;{IF NEWTOOL=1}M301 P1 I2 D3 ; PID parameters extruder 1

;prime new extruder
{IF NEWTOOL=0}T0
{IF NEWTOOL=1}T1
G1 F200
G1 E15 F200
G1 E5 F50
G1 E-1.5 F3000

