* A=B, A>B, and A<B
*using pseudo-nMOS
.option	post=2
.prot 
.lib	'cic018.l'	tt
.unprot
.global	vdd	gnd
vvdd	vdd	0	1.8
vgnd	gnd	0	0
.param	k=0.25u

.subckt	inv	in	out
mp0	out	in	vdd	vdd	p_18	l=0.22u	w=4u
mn0	out	in	0	0	n_18	l=0.22u	w=4u
.ends

.subckt	nand_bac	a	b	out
mp0	out	gnd	vdd	vdd	p_18	l=0.7u	w=1.2u
mn0	out	a	net	0	n_18	l=0.4u	w=4.8u
mn1	net	b	0	0	n_18	l=0.4u	w=4.8u
.ends

.subckt	and	a	b	out
xnand1	a	b	1	nand_bac
xinv1  1	out	inv
.ends

.subckt	nor	a	b	out
mp0	out	gnd	vdd	vdd	p_18	l=0.18u	w=40u
mn0	out	a	gnd	gnd	n_18	l=0.18u	w=80u
mn1	out	b	gnd	gnd	n_18	l=0.18u	w=80u
.ends

Va	A	0	pulse(1.8	0  1n  0.5n  0.5n  4.5n   10n)
Vb	B	0	pulse(1.8	0  1n  0.5n  0.5n  9.5n  20n)

*
xinv1	a	a_	inv
xinv2	b	b_	inv
xand1	a_	b	out1	and
xand2	a	b_	out3	and
xnor	out1	out3	out2	nor
cl1	out1	gnd	0.5p
cl2	out2	gnd	0.5p
cl3	out3	gnd	0.5p

.meas	tran	delay1	trig	v(a)		val=0.9	fall=2
+					targ	v(out1)	val=0.9	rise=1
.meas	tran	delay2	trig	v(a)		val=0.9	rise=2
+					targ	v(out1)	val=0.9	fall=1
.meas	tran	delay3	trig	v(a)		val=0.9	rise=1
+					targ	v(out2)	val=0.9	fall=1
.meas	tran	delay4	trig	v(a)		val=0.9	rise=2
+					targ	v(out2)	val=0.9	rise=1
.meas	tran	delay5	trig	v(a)		val=0.9	rise=1
+					targ	v(out3)	val=0.9	rise=1
.meas	tran	delay6	trig	v(a)		val=0.9	fall=2
+					targ	v(out3)	val=0.9	fall=1

.tran	0.1n	80n
.end