*LAB5-2 Cascaded Dynamic AND (Loading=0.1p)
**domino logic
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0  0
.param k=0.05p

.subckt  inv  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=1u
mn0	out	in	0	0	n_18	l=0.18u	w=0.5u
.ends

.subckt and2 a b CK out1 vdd gnd
mp0	out	CK	vdd	vdd	p_18	l=0.18u	w=1u
mp1	out	out1	vdd	vdd	p_18	l=0.18u	w=1u
mn0	out	a	1	gnd	n_18	l=0.18u	w=1u
mn1	1	b	2	gnd	n_18	l=0.18u	w=1u
mn2	2	CK	gnd	gnd	n_18	l=0.18u	w=1u
x1	out   out1	vdd	gnd	inv
.ends

.subckt buf in out vdd gnd
xinv1	in	1	vdd	gnd	inv
xinv2	1	out	vdd	gnd	inv
.ends

VA  A   0	pulse(1.8   0       0.1n    0.1n    0.1n    9.9n    20n)
VB  B   0	1.8
VC  C   0	1.8
VD  D   0	1.8
VE  E   0	1.8
VCK	CK  0	pulse(0     1.8     2.1n    0.1n    0.1n    1.9n    4n)

*主電路
xnand1 a	b	CK out1 vdd gnd and2
xnand2 out1	c	CK out2 vdd gnd and2
xnand3 out2	d	CK out3 vdd gnd and2
xnand4 out3	e	CK out4 vdd gnd and2
c1 out1 gnd k
c2 out2 gnd k
c3 out3 gnd k
c4 out4 gnd k

.meas	tran	delay1	trig	v(a)		val=0.9	rise=2
+				targ	v(out1)	val=0.9	rise=4

.meas	tran	delay2	trig	v(a)		val=0.9	rise=2
+				targ	v(out2)	val=0.9	rise=4

.meas tran pw avg power

.meas tran pdp=param('pw*delay1')

.tran		0.1n		60n

*buffer
* .alter
* xnand1 a	b	CK out1 vdd gnd and2
* xnand2 out11	c	CK out2 vdd gnd and2
* xnand3 out21	d	CK out3 vdd gnd and2
* xnand4 out31	e	CK out4 vdd gnd and2
* c1 out1 gnd 0.1p
* c2 out2 gnd 0.1p
* c3 out3 gnd 0.1p
* c4 out4 gnd 0.1p
* xbuf1	out1	out11 vdd gnd	buf
* xbuf2	out2	out21 vdd gnd	buf
* xbuf3	out3	out31 vdd gnd	buf
.end