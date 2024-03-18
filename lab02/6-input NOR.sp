6-input NOR
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0  0


.subckt nor a b c d e f out vdd gnd
mp0	1	a	vdd	vdd	p_18	l=0.18u	w=1u
mp1	2 	b	1	vdd p_18	l=0.18u w=1u
mp2	3	c	2	vdd	p_18	l=0.18u	w=1u
mp3	4	d	3	vdd p_18	l=0.18u w=1u
mp4	5	e	4	vdd	p_18	l=0.18u	w=1u
mp5	out f	5	vdd p_18	l=0.18u w=1u
mn0 out a	gnd gnd n_18	l=0.18u w=1u
mn1 out b	gnd gnd n_18	l=0.18u w=1u
mn2 out c	gnd gnd n_18	l=0.18u w=1u
mn3 out d	gnd gnd n_18	l=0.18u w=1u
mn4 out e	gnd gnd n_18	l=0.18u w=1u
mn5 out f	gnd gnd n_18	l=0.18u w=1u
.ends

VA A 0 pulse(1.8 0 0.1n 0.1n 0.1n 9.9n 20n)
VB B 0 0
VC C 0 0
VD D 0 0
VE E 0 0
VF F 0 0


*主電路
xnor a b c d e f out vdd gnd nor
c1 out gnd 0.05p

.meas	tran	delayN	trig	v(a)	val=0.9	fall=2
+						targ	v(out)	val=0.9	rise=2
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 80n
.end