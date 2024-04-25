*3-input XOR
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0  0
.param k=1p

.subckt bignmos a b c d out gnd
mn0	out	a	1	gnd	n_18	l=0.18u	w=25u
mn1	1	b	2	gnd	n_18	l=0.18u	w=25u
mn2	2	c	d	gnd	n_18	l=0.18u	w=25u
.ends

.subckt  inv  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=10u
mn0	out	in	0	0	n_18	l=0.18u	w=10u
.ends

VA  A   0	pulse(1.8   0       0.1n    0.5n    0.5n    3.5n    8n)
VB  B   0	pulse(1.8   0       0.1n    0.5n    0.5n    7.5n    16n)
VC  C   0	pulse(1.8   0       0.1n    0.5n    0.5n    15.5n   32n)
VCK	CK  0	pulse(0     1.8     2.1n    0.5n    0.5n    1.5n    4n)

.subckt  invde  in  out
mp0	out	in	vdd	vdd	p_18	l=0.95u	w=50u
mn0	out	in	0	0	n_18	l=0.95u	w=50u
.ends

.subckt  delay  in  out
x1	in	1	invde
x2	1	out	invde
.ends


*主電路
xinva a  a1  vdd  gnd inv
xinvb b  b1  vdd  gnd inv
xinvc c  c1  vdd  gnd inv

xn1     a1      b       c       net1    out1     gnd     bignmos
xn2     a1      b1      c1      net1    out1     gnd     bignmos
xn3     a       b       c1      net1    out1     gnd     bignmos
xn4     a       b1      c       net1    out1     gnd     bignmos

mp0	out1	CK	vdd	vdd     p_18    l=0.18u     w=32u
mn0	net1	CK	gnd	gnd     n_18    l=0.18u     w=32u
xdelay  out1  out	delay
cl	out	gnd	k

.meas	tran	delayn1	trig	v(CK)		val=0.9	rise=1
+				targ	v(out)	val=0.9	fall=1

.meas	tran	delayn2	trig	v(CK)		val=0.9	rise=4
+				targ	v(out)	val=0.9	fall=2

.meas	tran	delayn3	trig	v(CK)		val=0.9	rise=6
+				targ	v(out)	val=0.9	fall=3

.meas	tran	delayn4	trig	v(CK)		val=0.9	rise=7
+				targ	v(out)	val=0.9	fall=4
.meas tran pw avg power
.meas tran pdp=param('pw*delayn1')
.tran		0.1n		100n

.end