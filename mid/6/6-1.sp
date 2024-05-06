*3-input Pass-transistor
.option	post=2
.prot 
.lib	'cic018.l'	tt
.unprot
.global	vdd	gnd
vvdd	vdd	0	1.8
vgnd	gnd	0	0
.param	k=1p

.subckt	fuck1 1 2 3 4

.ends
