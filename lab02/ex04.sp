2-input NAND
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0  0


.subckt nand a b out vdd gnd
mp0 out a vdd vdd p_18 l=0.18u w=1u
mp1 out b vdd vdd p_18 l=0.18u w=1u
mn0 out a net 0 n_18 l=0.18u w=1u
mn1 net b 0 0 n_18 l=0.18u w=1u
.ends

va	a	0	pulse(1.8 0	0.1n	0.1n	0.1n	39.9n	80n)
vb	b	0	pulse(1.8 0	0.1n	0.1n	0.1n	79.9n	160n)
vc	c	0	pulse(1.8 0	0.1n	0.1n	0.1n	159.9n	320n)
VD D 0 1.8
VE E 0 1.8


*主電路
xnand1 a	b		out1	vdd gnd nand
xnand2 c	out1	out2	vdd	gnd	nand
xnand3 d	out2	out3	vdd	gnd	nand
xnand4 e	out3	out4	vdd	gnd	nand
c1	out1	gnd	0.02p
c2	out2	gnd	0.02p
c3	out3	gnd	0.02p
c4	out4	gnd	0.02p

.meas	tran	delayN1	trig	v(a)	val=0.9	rise=2
+						targ	v(out1)	val=0.9	fall=2
.meas	tran	delayN2	trig	v(a)	val=0.9	rise=2
+						targ	v(out2)	val=0.9	rise=2
.meas	tran	delayN3	trig	v(a)	val=0.9	rise=2
+						targ	v(out3)	val=0.9	fall=2
.meas	tran	delayN4	trig	v(a)	val=0.9	rise=2
+						targ	v(out4)	val=0.9	rise=2
.meas tran pw avg power

.meas tran pdp=param('pw*delayN1')


.tran		0.1n		640n$(sweep 	k 	0.3u  5u   0.1u)
.end
