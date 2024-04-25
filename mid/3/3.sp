*Pass-transistor 3-input XOR
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0  0
.param k=1p
.param kk=1u


.subckt ouou a b c d out vdd gnd
mn0	a	b	out	gnd	n_18	l=0.2u	w=21u
mn1	c	d	out	gnd	n_18	l=0.2u	w=88u
.ends
.subckt ouou1 a b c d out vdd gnd
mn0	a	b	out	gnd	n_18	l=0.18u	w=95.1u
mn1	c	d	out	gnd	n_18	l=0.18u	w=12u
.ends

.subckt  inv  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=10u
mn0	out	in	0	0	n_18	l=0.18u	w=1.25u
.ends
.subckt  inva  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=97.2u
mn0	out	in	0	0	n_18	l=0.18u	w=12u
.ends
.subckt  invb  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=97.2u
mn0	out	in	0	0	n_18	l=0.18u	w=12u
.ends

.subckt  xor  a  b  c  out
xinva a  a1  vdd  gnd inva
xinvb b  b1  vdd  gnd invb
xinvc c  c1  vdd  gnd inv
xinvy y  y1  vdd  gnd inv
xouou1 a b1 a1 b y   vdd gnd ouou1
xouou2 c y1 c1 y out vdd gnd ouou
.ends

.subckt  invde  in  out
mp0	out	in	vdd	vdd	p_18	l=0.7u	w=72u
mn0	out	in	0	0	n_18	l=0.7u	w=79u
.ends

.subckt  delay  in  out
x1	in	1	invde
x2	1	out	invde
.ends

va	a	0	pulse(1.8 0	0.1n	0.5n	0.5n	39.5n		80n)
vb	b	0	pulse(1.8 0	0.1n	0.5n	0.5n	79.5n		160n)
vc	c	0	pulse(1.8 0	0.1n	0.5n	0.5n	159.5n	320n)

*主電路
x1  a  b  c  out1    xor
xdelay	out1	out	delay
cl	out gnd k


.meas	tran	delay1	trig	v(a)		val=0.9	rise=1
+				targ	v(out)	val=0.9	rise=1
.meas	tran	delay2	trig	v(a)		val=0.9	rise=2
+				targ	v(out)	val=0.9	fall=2
.meas	tran	delay3	trig	v(a)		val=0.9	fall=3
+				targ	v(out)	val=0.9	rise=2
.meas	tran	delay4	trig	v(a)		val=0.9	rise=3
+				targ	v(out)	val=0.9	fall=3
.meas	tran	delay5	trig	v(a)		val=0.9	rise=4
+				targ	v(out)	val=0.9	rise=3
.meas	tran	delay6	trig	v(a)		val=0.9	fall=5
+				targ	v(out)	val=0.9	fall=4
.meas tran pw avg power
.meas tran pdp=param('pw*delay1')

.tran		0.1n		640n *(sweep kk 1u 99u 1u)
.end