*half_adder(loading c=0.01p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global	vdd!	gnd!
vvdd	vdd!	0	1.8
vgnd	gnd!	0	0

.subckt	inv	vi	vo
mp	vo	vi	vdd!	vdd!	P_18	l=0.18u	w=1u
mn	vo	vi	gnd!	gnd!	N_18	l=0.18u	w=0.5u
.ends

.subckt	nor2	vi1	vi2	vo
mp0	net1	vi1	vdd!	vdd!	P_18	l=0.18u	w=1u
mp1	vo	vi2	net1	vdd!	P_18	l=0.18u	w=1u
mn0	vo	vi1	gnd!	gnd!	N_18	l=0.18u	w=0.5u
mn1	vo	vi2	gnd!	gnd!	N_18	l=0.18u	w=0.5u
.ends

.subckt	or2	vi1	vi2	vo
xnor	vi1	vi2	net1	nor2
xinv	net1	vo	inv
.ends

.subckt	nand2	vi1	vi2	vo
mp0	vo	vi1	vdd!	vdd!	P_18	l=0.18u	w=1u
mp1	vo	vi2	vdd!	vdd!	P_18	l=0.18u	w=1u
mn0	vo	vi1	net1	gnd!	N_18	l=0.18u	w=0.5u
mn1	net1	vi2	gnd!	gnd!	N_18	l=0.18u	w=0.5u
.ends

.subckt	and2	vi1	vi2	vo
xnand	vi1	vi2	net1	nand2
xinv	net1	vo	inv
.ends

.subckt	xor	vi1	vi2	vo
xinv1	vi1	vi1_	inv
xinv2	vi2	vi2_	inv
xand1	vi1_	vi2	vo1	and2
xand2	vi1	vi2_	vo2	and2
xor	vo1	vo2	vo	or2
.ends

.subckt	half_adder	a	b	c	s
xand	a	b	c	and2
xxor	a	b	s	xor
.ends

xhalf_adder	a	b	c	s	half_adder

va a 0 pulse(1.8 0 0.1n 0.1n 0.1n 4.9n 10n)
vb b 0 pulse(1.8 0 0.1n 0.1n 0.1n 9.9n 20n)


.meas	tran	delayN	trig	v(b)	val=0.9	fall=2
+						targ	v(out)	val=0.9	rise=2
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 50n $(sweep 	k 	0.3u  5u   0.1u)
.end