;heat bed
M190 S[bed0_temperature] ; wait for bed temperature

;heat extruder 0
T0 ; select extruder 0
M109 S[extruder0_temperature] ; set extruder 0 temperature and wait

;heat extruder 1
T1 ; select extruder 1
M109 S[extruder1_temperature] ; set extruder 1 temperature and wait

