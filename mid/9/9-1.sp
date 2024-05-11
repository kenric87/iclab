*Comparator
*pass-transistor
*完成
.option	post=2
.prot 
.lib	'cic018.l'	tt
.unprot
.global	vdd	gnd
vvdd	vdd	0	1.8
vgnd	gnd	0	0
.param	k=1u

.subckt	inv	in	out
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=15u
mn0	out	in	0	0	n_18	l=1u		w=4.6u
.ends

.subckt	invout1	in	out
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=17u
mn0	out	in	0	0	n_18	l=0.18u	w=0.25u
.ends

.subckt	invout3	in	out
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=20u
mn0	out	in	0	0	n_18	l=0.18u	w=55u
.ends

.subckt	ouou1	1 2 3 4 5
mn0	1	2	5	gnd	n_18	l=0.18u	w=9u
mn1	3	4	5	gnd	n_18	l=0.5u	w=2u
.ends

.subckt	ouou2	1 2 3 4 5
mn0	1	2	5	gnd	n_18	l=0.19u	w=9.1u
mn1	3	4	5	gnd	n_18	l=0.34u	w=3.5u
.ends

.subckt	ouou3	1 2 3 4 5
mn0	1	2	5	gnd	n_18	l=0.18u	w=6u
mn1	3	4	5	gnd	n_18	l=0.18u	w=20u
.ends

*主電路
xinva	a	a_		inv
xinvb	b	b_		inv
xinvout1	out1	out1_	invout1
xinvout3	out3	out3_	invout3
xand1	a_	b	gnd	b_	out1		ouou1
xand2	b_	a	gnd	a_	out3		ouou2
xnor0	gnd	out1	out3_	out1_	out2	ouou3
cl1	out1	gnd	2p
cl2	out2	gnd	2p
cl3	out3	gnd	2p
Va	A	0	pulse(1.8	0	0.1n	0.5n	0.5n	9.5n		20n)
Vb	B	0	pulse(1.8	0	0.1n	0.5n	0.5n	19.5n	40n)

.meas	tran	delay1	trig	v(a)		val=0.9	fall=2
+					targ	v(out1)	val=0.9	rise=1
.meas	tran	delay2	trig	v(a)		val=0.9	rise=2
+					targ	v(out1)	val=0.9	fall=1

.meas	tran	delay3	trig	v(a)		val=0.9	rise=1
+					targ	v(out3)	val=0.9	rise=1
.meas	tran	delay4	trig	v(a)		val=0.9	fall=2
+					targ	v(out3)	val=0.9	fall=1

.meas	tran	delay5	trig	v(a)		val=0.9	rise=1
+					targ	v(out2)	val=0.9	fall=1
.meas	tran	delay6	trig	v(a)		val=0.9	rise=2
+					targ	v(out2)	val=0.9	rise=1


.tran	0.1n	80n $(sweep k 1u 90u 2u)
.end