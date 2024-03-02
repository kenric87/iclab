2-input NOR
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0  0


.subckt nor a b out vdd gnd
mp0	1	a	vdd	vdd	p_18	l=0.18u	w=1u
mp1	out b	1	vdd p_18	l=0.18u w=1u
mn0 out a	gnd gnd n_18	l=0.18u w=1u
mn1 out b	gnd gnd n_18	l=0.18u w=1u
.ends

VA A 0 pulse(1.8 0 0.1n 0.1n 0.1n 9.9n 20n)
VB B 0 0
*.tran 0.1n 160n

*主電路
xnor a b out vdd gnd nor
c1 out gnd 0.01p

.meas	tran	delayN	trig	v(a)	val=0.9	rise=1
+						targ	v(out)	val=0.9	fall=1
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 50n
.end
