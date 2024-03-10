*4Bit Comparator
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0  0
.param k=0.1p


.subckt	inv	in	out
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=2u
mn0	out	in	0	0	n_18	l=0.18u	w=1u
.ends

.subckt	nand	a	b	out
mp0	out	a	vdd	vdd	p_18	l=0.18u	w=2u
mp1	out	b	vdd	vdd	p_18	l=0.18u	w=2u
mn0	out	a	net	0	n_18	l=0.18u	w=2u
mn1	net	b	0	0	n_18	l=0.18u	w=2u
.ends

.subckt	and	a	b	out
xnand1	a	b	1	nand
xinv1  1	out	inv
.ends

.subckt	nor	a	b	out
mp0	1	a	vdd	vdd	p_18	l=0.18u	w=4u
mp1	out	b	1	vdd	p_18	l=0.18u	w=4u
mn0	out	a	gnd	gnd	n_18	l=0.18u	w=1u
mn1	out	b	gnd	gnd	n_18	l=0.18u	w=1u
.ends

.subckt	or	a	b	out
xnor1	a	b	1	nor
xinv1  1	out	inv
.ends


Va0	a0	0	pulse(1.8	0  1n  0.1n  0.1n  2.4n   5n)
Vb0	b0	0	pulse(1.8	0  1n  0.1n  0.1n  4.9n  10n)
Va1	a1	0	pulse(1.8	0  1n  0.1n  0.1n  4.9n  10n)
Vb1	b1	0	pulse(1.8	0  1n  0.1n  0.1n  4.9n  10n)
Va2	a2	0	pulse(1.8	0  1n  0.1n  0.1n  2.4n   5n)
Vb2	b2	0	pulse(1.8	0  1n  0.1n  0.1n  9.9n  20n)
Va3	a3	0	pulse(1.8	0  1n  0.1n  0.1n  9.9n  20n)
Vb3	b3	0	pulse(1.8	0  1n  0.1n  0.1n  9.9n  20n)


.subckt	com2b	a1	a0	b1	b0	9	10	11
xinv1	a1	a1_	inv
xinv2	a0	a0_	inv
xinv3	b1	b1_	inv
xinv4	b0	b0_	inv
xc1	a1_	b1	1	nor
xc2	a1_	b1	2	nand
xc3	b0	a0_	3	nand
xd2	a1	b1_	4	nand
xd3	a0	b0_	5	nand
xd1	b1_	a1	6	nor
xc4	1	3	7	or
xc5	7	2	9	nand
xd4	5	6	8	or
xd5	4	8	11	nand
xe1	9	11	10	nor
.ends

*main
xcom2b1	a1	a0	b1	b0	4	5	6	com2b
xcom2b2	a3	a2	b3	b2	1	2	3	com2b
xf1	2	4	7	and
xf2	2	6	8	and
xf3	1	7	out1	or
xf4	2	5	out2	and
xf5	3	8	out3	or
cl1	out1	gnd	0.1p
cl2	out2	gnd	0.1p
cl3	out3	gnd	0.1p




.meas	tran	delayN	trig	v(b0)		val=0.9	rise=3
+			targ	v(out1)	val=0.9	rise=4

.meas tran pw avg power

.meas tran pdp=param('pw*delayN')

.tran	0.1n	40n	$(swee	k 	0.05p  1p   0.05p)
.end
