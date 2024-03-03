*3-input XOR
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0  0
.param k=0.1p

.subckt bignmos a b c d out gnd
mn0	out	a	1	gnd	n_18 l=0.18u w=4u
mn1 1	b	2	gnd n_18 l=0.18u w=4u
mn2 2	c	d	gnd n_18 l=0.18u w=4u
.ends

.subckt  inv  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=2u
mn0	out	in	0	0	n_18	l=0.18u	w=1u
.ends

VA  A   0	pulse(1.8   0       0.1n    0.1n    0.1n    3.9n    8n)
VB  B   0	pulse(1.8   0       0.1n    0.1n    0.1n    7.9n    16n)
VC  C   0	pulse(1.8   0       0.1n    0.1n    0.1n    15.9n   32n)
VCK	CK  0	pulse(0     1.8     2.1n    0.1n    0.1n    1.9n    4n)
*.tran	0.1n		40n	


*主電路
xinva a  a1  vdd  gnd inv
xinvb b  b1  vdd  gnd inv
xinvc c  c1  vdd  gnd inv

xn1     a1      b       c       net1    out     gnd     bignmos
xn2     a1      b1      c1      net1    out     gnd     bignmos
xn3     a       b       c1      net1    out     gnd     bignmos
xn4     a       b1      c       net1    out     gnd     bignmos

mp0 out     CK  vdd     vdd     p_18    l=0.18u     w=2u
mn0 net1    CK  gnd     gnd     n_18    l=0.18u     w=4u
cl	out gnd k


.meas	tran	delayN	trig	v(a)	val=0.9	rise=2
+						targ	v(out)	val=0.9	fall=2

.meas tran pw avg power

.meas tran pdp=param('pw*delayN')

.tran		0.1n		40n	(sweep	k 	0.05p  1p   0.05p)

*2倍
.alter
VA  A   0	pulse(1.8   0       0.1n    0.1n    0.1n    1.9n    4n)
VB  B   0	pulse(1.8   0       0.1n    0.1n    0.1n    3.9n    8n)
VC  C   0	pulse(1.8   0       0.1n    0.1n    0.1n    7.9n   16n)
VCK	CK  0	pulse(0     1.8     2.1n    0.1n    0.1n    0.9n    2n)

*4倍
.alter
VA  A   0	pulse(1.8   0       0.1n    0.1n    0.1n    0.9n    2n)
VB  B   0	pulse(1.8   0       0.1n    0.1n    0.1n    1.9n    4n)
VC  C   0	pulse(1.8   0       0.1n    0.1n    0.1n    3.9n    8n)
VCK	CK  0	pulse(0     1.8     2.1n    0.1n    0.1n    0.4n    1n)

*8倍
.alter
VA  A   0	pulse(1.8   0       0.1n    0.1n    0.1n    0.4n    1n)
VB  B   0	pulse(1.8   0       0.1n    0.1n    0.1n    0.9n    2n)
VC  C   0	pulse(1.8   0       0.1n    0.1n    0.1n    1.9n    4n)
VCK	CK  0	pulse(0     1.8     2.1n    0.1n    0.1n    0.15n    0.5n)

.end
