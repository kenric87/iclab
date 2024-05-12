*MUX
*夾數，技巧:在平板中先規劃好思路，每一個pass transistor 都各別設計，才可以個別調整
.option	post=2
.prot 
.lib	'cic018.l'	tt
.unprot
.global	vdd	gnd
vvdd	vdd	0	1.8
vgnd	gnd	0	0
.param	k=1u

.subckt	inva	in	out
mp0	out	in	vdd	vdd	p_18	l=0.5u	w=8u
mn0	out	in	0	0	n_18	l=0.5u	w=8u
.ends

.subckt	invs	in	out
mp0	out	in	vdd	vdd	p_18	l=0.5u	w=10u
mn0	out	in	0	0	n_18	l=0.5u	w=10u
.ends

.subckt	invout1	in	out
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=4u
mn0	out	in	0	0	n_18	l=0.18u	w=2u
.ends

.subckt	or0	1 2 3 4 5
mn0	1	2	5	gnd	n_18	l=0.18u	w=15u
mn1	3	4	5	gnd	n_18	l=0.18u	w=2u
.ends

.subckt	and0	1 2 3 4 5
mn0	1	2	5	gnd	n_18	l=1u	w=5u
mn1	3	4	5	gnd	n_18	l=2u	w=1u
.ends

.subckt	and1	1 2 3 4 5
mn0	1	2	5	gnd	n_18	l=0.18u	w=18u
mn1	3	4	5	gnd	n_18	l=0.18u	w=2u
.ends

.subckt	and2	1 2 3 4 5
mn0	1	2	5	gnd	n_18	l=0.7u	w=2u
mn1	3	4	5	gnd	n_18	l=1.25u	w=0.25u
.ends

.subckt	or1	1 2 3 4 5
mn0	1	2	5	gnd	n_18	l=0.18u	w=5u
mn1	3	4	5	gnd	n_18	l=0.18u	w=2u
.ends

.subckt	ibf1	in	out
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=4u
mn0	out	in	0	0	n_18	l=0.18u	w=2u
.ends

.subckt	ibf2	in	out
mp0	out	in	vdd	vdd	p_18	l=0.7u	w=2u
mn0	out	in	0	0	n_18	l=0.7u	w=2u
.ends

.subckt	buf1	in	out
x1	in	1	ibf1
x2	1	out	ibf1
.ends

.subckt	buf2	in	out
x1	in	1	ibf2
x2	1	out	ibf2
.ends

*主電路
xinva	a	a_		inva
xinvs	s	s_		invs
xinvout1	out1	out1_	invout1

xor0		vdd	a		b		a_		a+b	or0
xand0	b	a		gnd		a_		ab	and0
xand1	a+b	s		gnd		s_		out1	and1
xand2	ab	s_		gnd		s		out2	and2

xbuf1	out1	out1+	buf1
xbuf2	out2	out2+	buf2

xor1		vdd	out1+	out2+	out1_	out	or1

cl	out1	gnd	2p
Va	A	0	pulse(1.8	0	0.1n	0.5n	0.5n	9.5n		20n)
Vb	B	0	pulse(1.8	0	0.1n	0.5n	0.5n	19.5n	40n)
Vs	S	0	pulse(1.8	0	0.1n	0.5n	0.5n	39.5n	80n)

.meas	tran	delay1	trig	v(a)		val=0.9	rise=2
+					targ	v(out)	val=0.9	rise=1
.meas	tran	delay2	trig	v(a)		val=0.9	fall=3
+					targ	v(out)	val=0.9	fall=2
.meas	tran	delay3	trig	v(a)		val=0.9	rise=3
+					targ	v(out)	val=0.9	rise=2
.meas	tran	delay4	trig	v(a)		val=0.9	fall=5
+					targ	v(out)	val=0.9	fall=3

.tran	0.1n	180n $(sweep k 1u 90u 2u)
.end