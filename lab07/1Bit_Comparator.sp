One-Bit Comparator
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

.subckt	nand_bac	a	b	out
mp0	out	a	vdd	vdd	p_18	l=0.18u	w=2u
mp1	out	b	vdd	vdd	p_18	l=0.18u	w=2u
mn0	out	a	net	0	n_18	l=0.18u	w=2u
mn1	net	b	0	0	n_18	l=0.18u	w=2u
.ends

.subckt	and	a	b	out
xnand1	a	b	1	nand_bac
xinv1  1	out	inv
.ends

.subckt	nor	a	b	out
mp0	1	a	vdd	vdd	p_18	l=0.18u	w=4u
mp1	out	b	1	vdd	p_18	l=0.18u	w=4u
mn0	out	a	gnd	gnd	n_18	l=0.18u	w=1u
mn1	out	b	gnd	gnd	n_18	l=0.18u	w=1u
.ends

Va	A	0	pulse(1.8	0  1n  0.1n  0.1n  2.4n   5n)
Vb	B	0	pulse(1.8	0  1n  0.1n  0.1n  4.9n  10n)

*
xinv1	a	a_	inv
xinv2	b	b_	inv
xand1	a_	b	out1	and
xand2	a	b_	out3	and
xnor	out1	out3	out2	nor
cl1	out1	gnd	0.1p
cl2	out2	gnd	0.1p
cl3	out3	gnd	0.1p

.meas	tran	delayN	trig	v(a)	val=0.9	rise=2
+		targ	v(out)	val=0.9	fall=2

.meas tran pw avg power

.meas tran pdp=param('pw*delayN')

.tran	0.1n	40n	$(swee	k 	0.05p  1p   0.05p)
.end
