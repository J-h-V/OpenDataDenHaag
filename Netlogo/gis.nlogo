__includes [ "import-data.nls" "simulation.nls" "update-data.nls"]
extensions [ gis csv profiler ]
globals [
  ;KPIs
  KPI-available_buy_houses
  KPI-available_part_rent_houses
  KPI-available_social_rent_houses
  KPI-avg_income
  KPI-avg_price
  KPI-avg_utility
  KPI-citizen-count
  KPI-p-sc-lower
  KPI-p-sc-working
  KPI-p-sc-middle
  KPI-p-sc-upper
  KPI-p-dutch
  KPI-p-other-western
  KPI-p-antilles
  KPI-p-morocco
  KPI-p-suriname
  KPI-p-turkey
  KPI-p-indonesian
  KPI-p-eastern-eu
  KPI-p-other-nonwestern
  KPI-homeless
  KPI-homeless-migrants
  ;datasets
  neighborhood-data
  neighborhood-codes
  nhc
  factor-data
  factors
  crime-data
  daycare-data
  shape-data
  housing-data
  migration-data
  ethnicity-data
  amenities-data
  income-data
  education-data
  movementage-data
  nhs-with-houses
  ;ov-data < currently not used.
  ;other globals
  biggest-avg-household mixed-use-nhs move-counter q y available-neighborhoods-part-rent available-neighborhoods-social-rent available-neighborhoods-buy p_edu_low p_edu_middle p_edu_high]
breed [ neighborhoods neighborhood ]
breed [ citizens citizen ]
undirected-link-breed [ social-rent-links social-rent-link ]
undirected-link-breed [ part-rent-links part-rent-link ]
undirected-link-breed [ buy-links buy-link ]
social-rent-links-own [ utility ]
part-rent-links-own [ utility ]
buy-links-own [ utility ]
patches-own [ buurtcode buurtname ]
neighborhoods-own [ buurtnumber population citizen-count houses crimes nat_change avg_household_size avg_price p_free available_buy_houses available_part_rent_houses available_social_rent_houses owned_properties part_rent_properties social_rent_properties
  men women a_young a_middle a_old c_dutch c_other_western c_antilles c_morocco c_suriname c_turkey c_indonesian c_eastern_eu c_other_nonwestern p-dutch p-other-western p-antilles p-morocco p-suriname p-turkey p-indonesian p-eastern-eu p-other-nonwestern p-sc-lower p-sc-working p-sc-middle p-sc-upper b_horeca b_amenities a_health a_schools d_super daycare_per_citizen e_low e_middle e_high avg_income]
citizens-own [ current-neighborhood income budget education ethnicity social-class age lifephase migrant? housing-type]


;Imagine looking at the source expecting a lot of code. This place is deserted.
;Might want to check the info tab or GitHub repository if this confuses you..
@#$#@#$#@
GRAPHICS-WINDOW
210
10
1256
711
-1
-1
1.35
1
10
1
1
1
0
0
0
1
-384
384
-256
256
0
0
1
ticks
30.0

BUTTON
10
10
70
43
setup
setup
NIL
1
T
OBSERVER
NIL
S
NIL
NIL
1

BUTTON
10
45
100
78
draw the map
startup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
105
45
205
78
reset the model
clear-all
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
75
10
135
43
go
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
10
245
205
278
aggregate-cluster-size
aggregate-cluster-size
1
100
10.0
1
1
NIL
HORIZONTAL

PLOT
1265
10
1875
345
social-class per neighborhood
buurtcode
percentage-social-class
0.0
114.0
0.0
1.0
false
true
"" "clear-plot"
PENS
"upper" 0.25 1 -14070903 true "" "let nh neighborhoods with [count citizens with [current-neighborhood = myself] > 0 ]\nask nh [ plotxy [who] of self + 0.75 ( count citizens with [current-neighborhood = myself and social-class = \"upper\"] / count citizens with [current-neighborhood = myself] ) ]"
"middle" 0.25 1 -14439633 true "" "let nh neighborhoods with [count citizens with [current-neighborhood = myself] > 0 ]\nask nh [ plotxy [who] of self + 0.5 ( count citizens with [current-neighborhood = myself and social-class = \"middle\"] / count citizens with [current-neighborhood = myself] )  ]"
"working" 0.25 1 -4079321 true "" "let nh neighborhoods with [count citizens with [current-neighborhood = myself] > 0 ]\nask nh [ plotxy [who] of self + 0.25  ( count citizens with [current-neighborhood = myself and social-class = \"working\"] / count citizens with [current-neighborhood = myself] )  ]"
"lower" 0.25 1 -5298144 true "" "let nh neighborhoods with [count citizens with [current-neighborhood = myself] > 0 ]\nask nh[ plotxy [who] of self  ( count citizens with [current-neighborhood = myself and social-class = \"lower\"] / count citizens with [current-neighborhood = myself] )  ]"

MONITOR
1040
20
1127
65
NIL
move-counter
17
1
11

MONITOR
1190
20
1247
65
year
y
17
1
11

MONITOR
1130
20
1187
65
quarter
q
17
1
11

BUTTON
10
80
135
125
HELP
error \"Welcome to the Agent-Based Model on the effects of migration on the city of The Hague. If you are new to Netlogo (or this model), please refer to the Info tab for a detailed description, or press CTRL + 2 to get there!\"
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
140
10
205
43
go-once
go
NIL
1
T
OBSERVER
NIL
G
NIL
NIL
1

MONITOR
220
20
310
65
total households
count citizens
17
1
11

PLOT
1670
650
1875
785
distribution of social-class
NIL
NIL
1.0
5.0
0.0
10.0
true
false
"" "clear-plot"
PENS
"default" 1.0 1 -5298144 true "" "plotxy 1 count citizens with [social-class = \"lower\"]"
"pen-1" 1.0 1 -4079321 true "" "plotxy 2 count citizens with [social-class = \"working\"]"
"pen-2" 1.0 1 -14439633 true "" "plotxy 3 count citizens with [social-class = \"middle\"]"
"pen-3" 1.0 1 -14070903 true "" "plotxy 4 count citizens with [social-class = \"upper\"]"

PLOT
1265
650
1470
785
distribution of income
NIL
NIL
1.0
4.0
0.0
10.0
true
false
"" "clear-plot"
PENS
"default" 1.0 1 -5298144 true "" "plotxy 1 count citizens with [income = \"low\"]"
"pen-1" 1.0 1 -4079321 true "" "plotxy 2 count citizens with [income = \"middle\"]"
"pen-2" 1.0 1 -14439633 true "" "plotxy 3 count citizens with [income = \"high\"]"

SLIDER
10
315
205
348
avg_migrant_income
avg_migrant_income
10000
25000
19000.0
1000
1
Euro
HORIZONTAL

MONITOR
315
20
372
65
migrants
count citizens with [migrant? = true]
17
1
11

MONITOR
140
80
205
125
NIL
count links
17
1
11

PLOT
1265
345
1875
650
income per neighborhood
buurtcode
avg_income
0.0
114.0
0.0
100000.0
false
true
"" "clear-plot"
PENS
"income" 1.0 1 -13345367 true "" "ask neighborhoods with [avg_income > 0 and houses > 0][ plotxy [who] of self avg_income]"

MONITOR
375
20
437
65
Homeless
count citizens with [housing-type = \"homeless\"]
17
1
11

PLOT
1470
650
1670
785
GINI
NIL
NIL
0.0
100.0
0.0
1.0
false
false
"" "clear-plot"
PENS
"default" 1.0 0 -16777216 true "" "foreach [0 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100] [ x -> plotxy x calc-GINI x ]"
"pen-1" 1.0 0 -2674135 true "" "foreach [0 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100] [ x -> plotxy x x / 100 ]"

SLIDER
10
210
205
243
size-of-std
size-of-std
0
1
0.05
0.01
1
averages
HORIZONTAL

SWITCH
10
280
205
313
random-attributes?
random-attributes?
1
1
-1000

SLIDER
10
385
205
418
migrant-multiplier
migrant-multiplier
0
4
1.0
0.1
1
x
HORIZONTAL

SWITCH
10
350
205
383
housing-market-inflation?
housing-market-inflation?
1
1
-1000

CHOOSER
10
130
205
175
citizen-color
citizen-color
"housing type" "social group" "ethnicity" "age"
1

SWITCH
385
715
555
748
increase-social-housing?
increase-social-housing?
1
1
-1000

SWITCH
210
715
380
748
build-more-houses?
build-more-houses?
1
1
-1000

SWITCH
910
715
1080
748
improve-safety?
improve-safety?
1
1
-1000

SWITCH
1085
715
1255
748
improve-health?
improve-health?
1
1
-1000

SLIDER
910
750
1080
783
amount-of-safety-improved
amount-of-safety-improved
1
10
5.0
1
1
NIL
HORIZONTAL

SLIDER
1085
750
1255
783
amount-of-health-improved
amount-of-health-improved
1
10
5.0
1
1
NIL
HORIZONTAL

SLIDER
385
750
555
783
increase-percent
increase-percent
1
15
10.0
0.5
1
%
HORIZONTAL

SLIDER
210
750
380
783
build-percent
build-percent
0
10
2.5
0.5
1
%
HORIZONTAL

SLIDER
560
750
730
783
transformed-percentage
transformed-percentage
0
100
50.0
5
1
%
HORIZONTAL

SWITCH
560
715
730
748
transform-houses?
transform-houses?
1
1
-1000

SWITCH
735
715
905
748
mixed-use-zoning?
mixed-use-zoning?
1
1
-1000

SLIDER
735
750
905
783
amount-of-mixed-nhs
amount-of-mixed-nhs
0
8
4.0
1
1
NIL
HORIZONTAL

SWITCH
10
175
205
208
recolor-agents?
recolor-agents?
1
1
-1000

@#$#@#$#@
# The Impact of Migration on the Urban Fabric
## A Data-Driven Agent-Based Model on the effects of migration on the city of The Hague


This document is a work in progress, as I am still in the process of building the model I will very infrequently update the manual. Afterwards, this tab will give an explanation of the model and its inner workings in such a way that it is not necessary to understand the Netlogo code to be able to comprehend what is happening.

## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

This model is made by J.H.Vlug as part of his Master's Thesis for the MSc Engineering and Policy Analysis of The University of Technology in Delft. The model is made using the MIT Licence. Everything is Open Source and available on GitHub (see link below). If you would like to use this model for your own research or work, please contact me (for example on Twitter) for more information.

GitHub: https://github.com/Jochem285/OpenDataDenHaag
Twitter: https://twitter.com/JochemVlug
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="normal_run" repetitions="160" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>KPI-available_buy_houses</metric>
    <metric>KPI-available_part_rent_houses</metric>
    <metric>KPI-available_social_rent_houses</metric>
    <metric>KPI-avg_income</metric>
    <metric>KPI-avg_price</metric>
    <metric>KPI-avg_utility</metric>
    <metric>KPI-citizen-count</metric>
    <metric>KPI-p-sc-lower</metric>
    <metric>KPI-p-sc-working</metric>
    <metric>KPI-p-sc-middle</metric>
    <metric>KPI-p-sc-upper</metric>
    <metric>KPI-p-dutch</metric>
    <metric>KPI-p-other-western</metric>
    <metric>KPI-p-antilles</metric>
    <metric>KPI-p-morocco</metric>
    <metric>KPI-p-suriname</metric>
    <metric>KPI-p-turkey</metric>
    <metric>KPI-p-indonesian</metric>
    <metric>KPI-p-eastern-eu</metric>
    <metric>KPI-p-other-nonwestern</metric>
    <enumeratedValueSet variable="size-of-std">
      <value value="0.125"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avg_migrant_income">
      <value value="19000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="random-attributes?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="housing-market-inflation?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="aggregate-cluster-size">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="migrant-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="full-verification" repetitions="16" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>KPI-available_buy_houses</metric>
    <metric>KPI-available_part_rent_houses</metric>
    <metric>KPI-available_social_rent_houses</metric>
    <metric>KPI-avg_income</metric>
    <metric>KPI-avg_price</metric>
    <metric>KPI-avg_utility</metric>
    <metric>KPI-citizen-count</metric>
    <metric>KPI-p-sc-lower</metric>
    <metric>KPI-p-sc-working</metric>
    <metric>KPI-p-sc-middle</metric>
    <metric>KPI-p-sc-upper</metric>
    <metric>KPI-p-dutch</metric>
    <metric>KPI-p-other-western</metric>
    <metric>KPI-p-antilles</metric>
    <metric>KPI-p-morocco</metric>
    <metric>KPI-p-suriname</metric>
    <metric>KPI-p-turkey</metric>
    <metric>KPI-p-indonesian</metric>
    <metric>KPI-p-eastern-eu</metric>
    <metric>KPI-p-other-nonwestern</metric>
    <enumeratedValueSet variable="size-of-std">
      <value value="0.125"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transform-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avg_migrant_income">
      <value value="19000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-health-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="aggregate-cluster-size">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-health?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-mixed-nhs">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="citizen-color">
      <value value="&quot;social group&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-percent">
      <value value="2.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-safety-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recolor-agents?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-social-housing?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-more-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="random-attributes?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-percent">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="housing-market-inflation?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transformed-percentage">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="migrant-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mixed-use-zoning?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-safety?">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="full-run-1" repetitions="32" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>KPI-available_buy_houses</metric>
    <metric>KPI-available_part_rent_houses</metric>
    <metric>KPI-available_social_rent_houses</metric>
    <metric>KPI-avg_income</metric>
    <metric>KPI-avg_price</metric>
    <metric>KPI-avg_utility</metric>
    <metric>KPI-citizen-count</metric>
    <metric>KPI-p-sc-lower</metric>
    <metric>KPI-p-sc-working</metric>
    <metric>KPI-p-sc-middle</metric>
    <metric>KPI-p-sc-upper</metric>
    <metric>KPI-p-dutch</metric>
    <metric>KPI-p-other-western</metric>
    <metric>KPI-p-antilles</metric>
    <metric>KPI-p-morocco</metric>
    <metric>KPI-p-suriname</metric>
    <metric>KPI-p-turkey</metric>
    <metric>KPI-p-indonesian</metric>
    <metric>KPI-p-eastern-eu</metric>
    <metric>KPI-p-other-nonwestern</metric>
    <enumeratedValueSet variable="size-of-std">
      <value value="0.125"/>
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transform-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avg_migrant_income">
      <value value="19000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-health-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="aggregate-cluster-size">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-health?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-mixed-nhs">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="citizen-color">
      <value value="&quot;social group&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-percent">
      <value value="2.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-safety-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recolor-agents?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-social-housing?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-more-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="random-attributes?">
      <value value="false"/>
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-percent">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="housing-market-inflation?">
      <value value="false"/>
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transformed-percentage">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="migrant-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mixed-use-zoning?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-safety?">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="full-run-2" repetitions="32" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>KPI-available_buy_houses</metric>
    <metric>KPI-available_part_rent_houses</metric>
    <metric>KPI-available_social_rent_houses</metric>
    <metric>KPI-avg_income</metric>
    <metric>KPI-avg_price</metric>
    <metric>KPI-avg_utility</metric>
    <metric>KPI-citizen-count</metric>
    <metric>KPI-p-sc-lower</metric>
    <metric>KPI-p-sc-working</metric>
    <metric>KPI-p-sc-middle</metric>
    <metric>KPI-p-sc-upper</metric>
    <metric>KPI-p-dutch</metric>
    <metric>KPI-p-other-western</metric>
    <metric>KPI-p-antilles</metric>
    <metric>KPI-p-morocco</metric>
    <metric>KPI-p-suriname</metric>
    <metric>KPI-p-turkey</metric>
    <metric>KPI-p-indonesian</metric>
    <metric>KPI-p-eastern-eu</metric>
    <metric>KPI-p-other-nonwestern</metric>
    <enumeratedValueSet variable="size-of-std">
      <value value="0.125"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transform-houses?">
      <value value="false"/>
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avg_migrant_income">
      <value value="19000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-health-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="aggregate-cluster-size">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-health?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-mixed-nhs">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="citizen-color">
      <value value="&quot;social group&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-percent">
      <value value="2.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-safety-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recolor-agents?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-social-housing?">
      <value value="false"/>
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-more-houses?">
      <value value="false"/>
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="random-attributes?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-percent">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="housing-market-inflation?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transformed-percentage">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="migrant-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mixed-use-zoning?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-safety?">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="full-run-3" repetitions="32" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>KPI-available_buy_houses</metric>
    <metric>KPI-available_part_rent_houses</metric>
    <metric>KPI-available_social_rent_houses</metric>
    <metric>KPI-avg_income</metric>
    <metric>KPI-avg_price</metric>
    <metric>KPI-avg_utility</metric>
    <metric>KPI-citizen-count</metric>
    <metric>KPI-p-sc-lower</metric>
    <metric>KPI-p-sc-working</metric>
    <metric>KPI-p-sc-middle</metric>
    <metric>KPI-p-sc-upper</metric>
    <metric>KPI-p-dutch</metric>
    <metric>KPI-p-other-western</metric>
    <metric>KPI-p-antilles</metric>
    <metric>KPI-p-morocco</metric>
    <metric>KPI-p-suriname</metric>
    <metric>KPI-p-turkey</metric>
    <metric>KPI-p-indonesian</metric>
    <metric>KPI-p-eastern-eu</metric>
    <metric>KPI-p-other-nonwestern</metric>
    <enumeratedValueSet variable="size-of-std">
      <value value="0.125"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transform-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avg_migrant_income">
      <value value="19000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-health-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="aggregate-cluster-size">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-health?">
      <value value="false"/>
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-mixed-nhs">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="citizen-color">
      <value value="&quot;social group&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-percent">
      <value value="2.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-safety-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recolor-agents?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-social-housing?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-more-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="random-attributes?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-percent">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="housing-market-inflation?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transformed-percentage">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="migrant-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mixed-use-zoning?">
      <value value="false"/>
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-safety?">
      <value value="false"/>
      <value value="true"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="full-run-4" repetitions="32" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>KPI-available_buy_houses</metric>
    <metric>KPI-available_part_rent_houses</metric>
    <metric>KPI-available_social_rent_houses</metric>
    <metric>KPI-avg_income</metric>
    <metric>KPI-avg_price</metric>
    <metric>KPI-avg_utility</metric>
    <metric>KPI-citizen-count</metric>
    <metric>KPI-p-sc-lower</metric>
    <metric>KPI-p-sc-working</metric>
    <metric>KPI-p-sc-middle</metric>
    <metric>KPI-p-sc-upper</metric>
    <metric>KPI-p-dutch</metric>
    <metric>KPI-p-other-western</metric>
    <metric>KPI-p-antilles</metric>
    <metric>KPI-p-morocco</metric>
    <metric>KPI-p-suriname</metric>
    <metric>KPI-p-turkey</metric>
    <metric>KPI-p-indonesian</metric>
    <metric>KPI-p-eastern-eu</metric>
    <metric>KPI-p-other-nonwestern</metric>
    <enumeratedValueSet variable="size-of-std">
      <value value="0.125"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transform-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avg_migrant_income">
      <value value="16000"/>
      <value value="19000"/>
      <value value="22000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-health-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="aggregate-cluster-size">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-health?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-mixed-nhs">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="citizen-color">
      <value value="&quot;social group&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-percent">
      <value value="2.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-safety-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recolor-agents?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-social-housing?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-more-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="random-attributes?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-percent">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="housing-market-inflation?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transformed-percentage">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="migrant-multiplier">
      <value value="0.5"/>
      <value value="1"/>
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mixed-use-zoning?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-safety?">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="sensitivity-size-of-std" repetitions="32" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>KPI-homeless</metric>
    <metric>KPI-homeless-migrants</metric>
    <metric>KPI-available_buy_houses</metric>
    <metric>KPI-available_part_rent_houses</metric>
    <metric>KPI-available_social_rent_houses</metric>
    <metric>KPI-avg_income</metric>
    <metric>KPI-avg_price</metric>
    <metric>KPI-avg_utility</metric>
    <metric>KPI-citizen-count</metric>
    <metric>KPI-p-sc-lower</metric>
    <metric>KPI-p-sc-working</metric>
    <metric>KPI-p-sc-middle</metric>
    <metric>KPI-p-sc-upper</metric>
    <metric>KPI-p-dutch</metric>
    <metric>KPI-p-other-western</metric>
    <metric>KPI-p-antilles</metric>
    <metric>KPI-p-morocco</metric>
    <metric>KPI-p-suriname</metric>
    <metric>KPI-p-turkey</metric>
    <metric>KPI-p-indonesian</metric>
    <metric>KPI-p-eastern-eu</metric>
    <metric>KPI-p-other-nonwestern</metric>
    <enumeratedValueSet variable="size-of-std">
      <value value="0"/>
      <value value="0.05"/>
      <value value="0.1"/>
      <value value="0.15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transform-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avg_migrant_income">
      <value value="19000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-health-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="aggregate-cluster-size">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-health?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-mixed-nhs">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="citizen-color">
      <value value="&quot;social group&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-percent">
      <value value="2.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-safety-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-social-housing?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recolor-agents?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-more-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-percent">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="random-attributes?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="housing-market-inflation?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transformed-percentage">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="migrant-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mixed-use-zoning?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-safety?">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="sensitivity-migration-influx" repetitions="32" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>KPI-homeless</metric>
    <metric>KPI-homeless-migrants</metric>
    <metric>KPI-available_buy_houses</metric>
    <metric>KPI-available_part_rent_houses</metric>
    <metric>KPI-available_social_rent_houses</metric>
    <metric>KPI-avg_income</metric>
    <metric>KPI-avg_price</metric>
    <metric>KPI-avg_utility</metric>
    <metric>KPI-citizen-count</metric>
    <metric>KPI-p-sc-lower</metric>
    <metric>KPI-p-sc-working</metric>
    <metric>KPI-p-sc-middle</metric>
    <metric>KPI-p-sc-upper</metric>
    <metric>KPI-p-dutch</metric>
    <metric>KPI-p-other-western</metric>
    <metric>KPI-p-antilles</metric>
    <metric>KPI-p-morocco</metric>
    <metric>KPI-p-suriname</metric>
    <metric>KPI-p-turkey</metric>
    <metric>KPI-p-indonesian</metric>
    <metric>KPI-p-eastern-eu</metric>
    <metric>KPI-p-other-nonwestern</metric>
    <enumeratedValueSet variable="size-of-std">
      <value value="0.05"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transform-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avg_migrant_income">
      <value value="19000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-health-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="aggregate-cluster-size">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-health?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-mixed-nhs">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="citizen-color">
      <value value="&quot;social group&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-percent">
      <value value="2.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-safety-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-social-housing?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recolor-agents?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-more-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-percent">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="random-attributes?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="housing-market-inflation?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transformed-percentage">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="migrant-multiplier">
      <value value="0.5"/>
      <value value="1"/>
      <value value="1.5"/>
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mixed-use-zoning?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-safety?">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="sensitivity-migration-income" repetitions="32" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>KPI-homeless</metric>
    <metric>KPI-homeless-migrants</metric>
    <metric>KPI-available_buy_houses</metric>
    <metric>KPI-available_part_rent_houses</metric>
    <metric>KPI-available_social_rent_houses</metric>
    <metric>KPI-avg_income</metric>
    <metric>KPI-avg_price</metric>
    <metric>KPI-avg_utility</metric>
    <metric>KPI-citizen-count</metric>
    <metric>KPI-p-sc-lower</metric>
    <metric>KPI-p-sc-working</metric>
    <metric>KPI-p-sc-middle</metric>
    <metric>KPI-p-sc-upper</metric>
    <metric>KPI-p-dutch</metric>
    <metric>KPI-p-other-western</metric>
    <metric>KPI-p-antilles</metric>
    <metric>KPI-p-morocco</metric>
    <metric>KPI-p-suriname</metric>
    <metric>KPI-p-turkey</metric>
    <metric>KPI-p-indonesian</metric>
    <metric>KPI-p-eastern-eu</metric>
    <metric>KPI-p-other-nonwestern</metric>
    <enumeratedValueSet variable="size-of-std">
      <value value="0.05"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transform-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avg_migrant_income">
      <value value="15000"/>
      <value value="17000"/>
      <value value="19000"/>
      <value value="21000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-health-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="aggregate-cluster-size">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-health?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-mixed-nhs">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="citizen-color">
      <value value="&quot;social group&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-percent">
      <value value="2.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-safety-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-social-housing?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recolor-agents?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-more-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-percent">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="random-attributes?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="housing-market-inflation?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transformed-percentage">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="migrant-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mixed-use-zoning?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-safety?">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="full-run-aggregation-20" repetitions="32" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>KPI-homeless</metric>
    <metric>KPI-homeless-migrants</metric>
    <metric>KPI-available_buy_houses</metric>
    <metric>KPI-available_part_rent_houses</metric>
    <metric>KPI-available_social_rent_houses</metric>
    <metric>KPI-avg_income</metric>
    <metric>KPI-avg_price</metric>
    <metric>KPI-avg_utility</metric>
    <metric>KPI-citizen-count</metric>
    <metric>KPI-p-sc-lower</metric>
    <metric>KPI-p-sc-working</metric>
    <metric>KPI-p-sc-middle</metric>
    <metric>KPI-p-sc-upper</metric>
    <metric>KPI-p-dutch</metric>
    <metric>KPI-p-other-western</metric>
    <metric>KPI-p-antilles</metric>
    <metric>KPI-p-morocco</metric>
    <metric>KPI-p-suriname</metric>
    <metric>KPI-p-turkey</metric>
    <metric>KPI-p-indonesian</metric>
    <metric>KPI-p-eastern-eu</metric>
    <metric>KPI-p-other-nonwestern</metric>
    <enumeratedValueSet variable="size-of-std">
      <value value="0.05"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transform-houses?">
      <value value="true"/>
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avg_migrant_income">
      <value value="19000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-health-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="aggregate-cluster-size">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-health?">
      <value value="true"/>
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-mixed-nhs">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="citizen-color">
      <value value="&quot;social group&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-percent">
      <value value="2.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-safety-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recolor-agents?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-social-housing?">
      <value value="true"/>
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-more-houses?">
      <value value="true"/>
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="housing-market-inflation?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="random-attributes?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-percent">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transformed-percentage">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="migrant-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mixed-use-zoning?">
      <value value="true"/>
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-safety?">
      <value value="true"/>
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="sensitivity-random-attributes" repetitions="32" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>KPI-homeless</metric>
    <metric>KPI-homeless-migrants</metric>
    <metric>KPI-available_buy_houses</metric>
    <metric>KPI-available_part_rent_houses</metric>
    <metric>KPI-available_social_rent_houses</metric>
    <metric>KPI-avg_income</metric>
    <metric>KPI-avg_price</metric>
    <metric>KPI-avg_utility</metric>
    <metric>KPI-citizen-count</metric>
    <metric>KPI-p-sc-lower</metric>
    <metric>KPI-p-sc-working</metric>
    <metric>KPI-p-sc-middle</metric>
    <metric>KPI-p-sc-upper</metric>
    <metric>KPI-p-dutch</metric>
    <metric>KPI-p-other-western</metric>
    <metric>KPI-p-antilles</metric>
    <metric>KPI-p-morocco</metric>
    <metric>KPI-p-suriname</metric>
    <metric>KPI-p-turkey</metric>
    <metric>KPI-p-indonesian</metric>
    <metric>KPI-p-eastern-eu</metric>
    <metric>KPI-p-other-nonwestern</metric>
    <enumeratedValueSet variable="size-of-std">
      <value value="0.05"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transform-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avg_migrant_income">
      <value value="19000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-health-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="aggregate-cluster-size">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-health?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-mixed-nhs">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="citizen-color">
      <value value="&quot;social group&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-percent">
      <value value="2.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-safety-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-social-housing?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recolor-agents?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-more-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-percent">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="random-attributes?">
      <value value="true"/>
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="housing-market-inflation?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transformed-percentage">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="migrant-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mixed-use-zoning?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-safety?">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="sensitivity-inflation" repetitions="32" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>KPI-homeless</metric>
    <metric>KPI-homeless-migrants</metric>
    <metric>KPI-available_buy_houses</metric>
    <metric>KPI-available_part_rent_houses</metric>
    <metric>KPI-available_social_rent_houses</metric>
    <metric>KPI-avg_income</metric>
    <metric>KPI-avg_price</metric>
    <metric>KPI-avg_utility</metric>
    <metric>KPI-citizen-count</metric>
    <metric>KPI-p-sc-lower</metric>
    <metric>KPI-p-sc-working</metric>
    <metric>KPI-p-sc-middle</metric>
    <metric>KPI-p-sc-upper</metric>
    <metric>KPI-p-dutch</metric>
    <metric>KPI-p-other-western</metric>
    <metric>KPI-p-antilles</metric>
    <metric>KPI-p-morocco</metric>
    <metric>KPI-p-suriname</metric>
    <metric>KPI-p-turkey</metric>
    <metric>KPI-p-indonesian</metric>
    <metric>KPI-p-eastern-eu</metric>
    <metric>KPI-p-other-nonwestern</metric>
    <enumeratedValueSet variable="size-of-std">
      <value value="0.05"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transform-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avg_migrant_income">
      <value value="19000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-health-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="aggregate-cluster-size">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-health?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-mixed-nhs">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="citizen-color">
      <value value="&quot;social group&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-percent">
      <value value="2.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-safety-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-social-housing?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recolor-agents?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-more-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-percent">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="random-attributes?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="housing-market-inflation?">
      <value value="true"/>
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transformed-percentage">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="migrant-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mixed-use-zoning?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-safety?">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="sensitivity-aggregation size" repetitions="32" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>KPI-homeless</metric>
    <metric>KPI-homeless-migrants</metric>
    <metric>KPI-available_buy_houses</metric>
    <metric>KPI-available_part_rent_houses</metric>
    <metric>KPI-available_social_rent_houses</metric>
    <metric>KPI-avg_income</metric>
    <metric>KPI-avg_price</metric>
    <metric>KPI-avg_utility</metric>
    <metric>KPI-citizen-count</metric>
    <metric>KPI-p-sc-lower</metric>
    <metric>KPI-p-sc-working</metric>
    <metric>KPI-p-sc-middle</metric>
    <metric>KPI-p-sc-upper</metric>
    <metric>KPI-p-dutch</metric>
    <metric>KPI-p-other-western</metric>
    <metric>KPI-p-antilles</metric>
    <metric>KPI-p-morocco</metric>
    <metric>KPI-p-suriname</metric>
    <metric>KPI-p-turkey</metric>
    <metric>KPI-p-indonesian</metric>
    <metric>KPI-p-eastern-eu</metric>
    <metric>KPI-p-other-nonwestern</metric>
    <enumeratedValueSet variable="size-of-std">
      <value value="0.05"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transform-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avg_migrant_income">
      <value value="19000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-health-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="aggregate-cluster-size">
      <value value="1"/>
      <value value="5"/>
      <value value="10"/>
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-health?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-mixed-nhs">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="citizen-color">
      <value value="&quot;social group&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-percent">
      <value value="2.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-safety-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-social-housing?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recolor-agents?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-more-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-percent">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="random-attributes?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="housing-market-inflation?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transformed-percentage">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="migrant-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mixed-use-zoning?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-safety?">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="policy-transform" repetitions="32" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>KPI-homeless</metric>
    <metric>KPI-homeless-migrants</metric>
    <metric>KPI-available_buy_houses</metric>
    <metric>KPI-available_part_rent_houses</metric>
    <metric>KPI-available_social_rent_houses</metric>
    <metric>KPI-avg_income</metric>
    <metric>KPI-avg_price</metric>
    <metric>KPI-avg_utility</metric>
    <metric>KPI-citizen-count</metric>
    <metric>KPI-p-sc-lower</metric>
    <metric>KPI-p-sc-working</metric>
    <metric>KPI-p-sc-middle</metric>
    <metric>KPI-p-sc-upper</metric>
    <metric>KPI-p-dutch</metric>
    <metric>KPI-p-other-western</metric>
    <metric>KPI-p-antilles</metric>
    <metric>KPI-p-morocco</metric>
    <metric>KPI-p-suriname</metric>
    <metric>KPI-p-turkey</metric>
    <metric>KPI-p-indonesian</metric>
    <metric>KPI-p-eastern-eu</metric>
    <metric>KPI-p-other-nonwestern</metric>
    <enumeratedValueSet variable="size-of-std">
      <value value="0.05"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transform-houses?">
      <value value="true"/>
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avg_migrant_income">
      <value value="19000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-health-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="aggregate-cluster-size">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-health?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-mixed-nhs">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="citizen-color">
      <value value="&quot;social group&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-percent">
      <value value="2.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-safety-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recolor-agents?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-social-housing?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-more-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="housing-market-inflation?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="random-attributes?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-percent">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transformed-percentage">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="migrant-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mixed-use-zoning?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-safety?">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="policy-health" repetitions="32" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>KPI-homeless</metric>
    <metric>KPI-homeless-migrants</metric>
    <metric>KPI-available_buy_houses</metric>
    <metric>KPI-available_part_rent_houses</metric>
    <metric>KPI-available_social_rent_houses</metric>
    <metric>KPI-avg_income</metric>
    <metric>KPI-avg_price</metric>
    <metric>KPI-avg_utility</metric>
    <metric>KPI-citizen-count</metric>
    <metric>KPI-p-sc-lower</metric>
    <metric>KPI-p-sc-working</metric>
    <metric>KPI-p-sc-middle</metric>
    <metric>KPI-p-sc-upper</metric>
    <metric>KPI-p-dutch</metric>
    <metric>KPI-p-other-western</metric>
    <metric>KPI-p-antilles</metric>
    <metric>KPI-p-morocco</metric>
    <metric>KPI-p-suriname</metric>
    <metric>KPI-p-turkey</metric>
    <metric>KPI-p-indonesian</metric>
    <metric>KPI-p-eastern-eu</metric>
    <metric>KPI-p-other-nonwestern</metric>
    <enumeratedValueSet variable="size-of-std">
      <value value="0.05"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transform-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avg_migrant_income">
      <value value="19000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-health-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="aggregate-cluster-size">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-health?">
      <value value="true"/>
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-mixed-nhs">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="citizen-color">
      <value value="&quot;social group&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-percent">
      <value value="2.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-safety-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recolor-agents?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-social-housing?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-more-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="housing-market-inflation?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="random-attributes?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-percent">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transformed-percentage">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="migrant-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mixed-use-zoning?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-safety?">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="policy-social" repetitions="32" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>KPI-homeless</metric>
    <metric>KPI-homeless-migrants</metric>
    <metric>KPI-available_buy_houses</metric>
    <metric>KPI-available_part_rent_houses</metric>
    <metric>KPI-available_social_rent_houses</metric>
    <metric>KPI-avg_income</metric>
    <metric>KPI-avg_price</metric>
    <metric>KPI-avg_utility</metric>
    <metric>KPI-citizen-count</metric>
    <metric>KPI-p-sc-lower</metric>
    <metric>KPI-p-sc-working</metric>
    <metric>KPI-p-sc-middle</metric>
    <metric>KPI-p-sc-upper</metric>
    <metric>KPI-p-dutch</metric>
    <metric>KPI-p-other-western</metric>
    <metric>KPI-p-antilles</metric>
    <metric>KPI-p-morocco</metric>
    <metric>KPI-p-suriname</metric>
    <metric>KPI-p-turkey</metric>
    <metric>KPI-p-indonesian</metric>
    <metric>KPI-p-eastern-eu</metric>
    <metric>KPI-p-other-nonwestern</metric>
    <enumeratedValueSet variable="size-of-std">
      <value value="0.05"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transform-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avg_migrant_income">
      <value value="19000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-health-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="aggregate-cluster-size">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-health?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-mixed-nhs">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="citizen-color">
      <value value="&quot;social group&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-percent">
      <value value="2.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-safety-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recolor-agents?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-social-housing?">
      <value value="true"/>
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-more-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="housing-market-inflation?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="random-attributes?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-percent">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transformed-percentage">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="migrant-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mixed-use-zoning?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-safety?">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="policy-build" repetitions="32" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>KPI-homeless</metric>
    <metric>KPI-homeless-migrants</metric>
    <metric>KPI-available_buy_houses</metric>
    <metric>KPI-available_part_rent_houses</metric>
    <metric>KPI-available_social_rent_houses</metric>
    <metric>KPI-avg_income</metric>
    <metric>KPI-avg_price</metric>
    <metric>KPI-avg_utility</metric>
    <metric>KPI-citizen-count</metric>
    <metric>KPI-p-sc-lower</metric>
    <metric>KPI-p-sc-working</metric>
    <metric>KPI-p-sc-middle</metric>
    <metric>KPI-p-sc-upper</metric>
    <metric>KPI-p-dutch</metric>
    <metric>KPI-p-other-western</metric>
    <metric>KPI-p-antilles</metric>
    <metric>KPI-p-morocco</metric>
    <metric>KPI-p-suriname</metric>
    <metric>KPI-p-turkey</metric>
    <metric>KPI-p-indonesian</metric>
    <metric>KPI-p-eastern-eu</metric>
    <metric>KPI-p-other-nonwestern</metric>
    <enumeratedValueSet variable="size-of-std">
      <value value="0.05"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transform-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avg_migrant_income">
      <value value="19000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-health-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="aggregate-cluster-size">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-health?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-mixed-nhs">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="citizen-color">
      <value value="&quot;social group&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-percent">
      <value value="2.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-safety-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recolor-agents?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-social-housing?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-more-houses?">
      <value value="true"/>
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="housing-market-inflation?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="random-attributes?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-percent">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transformed-percentage">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="migrant-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mixed-use-zoning?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-safety?">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="policy-mixed" repetitions="32" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>KPI-homeless</metric>
    <metric>KPI-homeless-migrants</metric>
    <metric>KPI-available_buy_houses</metric>
    <metric>KPI-available_part_rent_houses</metric>
    <metric>KPI-available_social_rent_houses</metric>
    <metric>KPI-avg_income</metric>
    <metric>KPI-avg_price</metric>
    <metric>KPI-avg_utility</metric>
    <metric>KPI-citizen-count</metric>
    <metric>KPI-p-sc-lower</metric>
    <metric>KPI-p-sc-working</metric>
    <metric>KPI-p-sc-middle</metric>
    <metric>KPI-p-sc-upper</metric>
    <metric>KPI-p-dutch</metric>
    <metric>KPI-p-other-western</metric>
    <metric>KPI-p-antilles</metric>
    <metric>KPI-p-morocco</metric>
    <metric>KPI-p-suriname</metric>
    <metric>KPI-p-turkey</metric>
    <metric>KPI-p-indonesian</metric>
    <metric>KPI-p-eastern-eu</metric>
    <metric>KPI-p-other-nonwestern</metric>
    <enumeratedValueSet variable="size-of-std">
      <value value="0.05"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transform-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avg_migrant_income">
      <value value="19000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-health-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="aggregate-cluster-size">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-health?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-mixed-nhs">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="citizen-color">
      <value value="&quot;social group&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-percent">
      <value value="2.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-safety-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recolor-agents?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-social-housing?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-more-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="housing-market-inflation?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="random-attributes?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-percent">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transformed-percentage">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="migrant-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mixed-use-zoning?">
      <value value="true"/>
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-safety?">
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="policy-security" repetitions="32" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>KPI-homeless</metric>
    <metric>KPI-homeless-migrants</metric>
    <metric>KPI-available_buy_houses</metric>
    <metric>KPI-available_part_rent_houses</metric>
    <metric>KPI-available_social_rent_houses</metric>
    <metric>KPI-avg_income</metric>
    <metric>KPI-avg_price</metric>
    <metric>KPI-avg_utility</metric>
    <metric>KPI-citizen-count</metric>
    <metric>KPI-p-sc-lower</metric>
    <metric>KPI-p-sc-working</metric>
    <metric>KPI-p-sc-middle</metric>
    <metric>KPI-p-sc-upper</metric>
    <metric>KPI-p-dutch</metric>
    <metric>KPI-p-other-western</metric>
    <metric>KPI-p-antilles</metric>
    <metric>KPI-p-morocco</metric>
    <metric>KPI-p-suriname</metric>
    <metric>KPI-p-turkey</metric>
    <metric>KPI-p-indonesian</metric>
    <metric>KPI-p-eastern-eu</metric>
    <metric>KPI-p-other-nonwestern</metric>
    <enumeratedValueSet variable="size-of-std">
      <value value="0.05"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transform-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avg_migrant_income">
      <value value="19000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-health-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="aggregate-cluster-size">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-health?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-mixed-nhs">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="citizen-color">
      <value value="&quot;social group&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-percent">
      <value value="2.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="amount-of-safety-improved">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recolor-agents?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-social-housing?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="build-more-houses?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="housing-market-inflation?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="random-attributes?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="increase-percent">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="transformed-percentage">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="migrant-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mixed-use-zoning?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="improve-safety?">
      <value value="true"/>
      <value value="false"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
1
@#$#@#$#@
