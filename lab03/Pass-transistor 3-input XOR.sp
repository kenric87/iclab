*Pass-transistor 3-input XOR
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0  0
.param k=0.05p


.subckt ouou a b c d out vdd gnd
mn0	a	b	out	gnd	n_18 l=0.18u w=1u
mn1 c	d	out	gnd n_18 l=0.18u w=1u
.ends

.subckt  inv  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=2u
mn0	out	in	0	0	n_18	l=0.18u	w=1u
.ends

.subckt  xor  a  b  c  out
xinva a  a1  vdd  gnd inv
xinvb b  b1  vdd  gnd inv
xinvc c  c1  vdd  gnd inv
xinvy y  y1  vdd  gnd inv
xouou1 a b1 a1 b y   vdd gnd ouou
xouou2 c y1 c1 y out vdd gnd ouou
.ends

va	a	0	pulse(1.8 0	0.1n	0.1n	0.1n	39.9n	80n)
vb	b	0	pulse(1.8 0	0.1n	0.1n	0.1n	79.9n	160n)
vc	c	0	pulse(1.8 0	0.1n	0.1n	0.1n	159.9n	320n)

*主電路
x1  a  b  c  out    xor
cl	out gnd k


.meas	tran	delayN	trig	v(a)	val=0.9	fall=3
+						targ	v(out)	val=0.9	rise=2

.meas tran pw avg power

.meas tran pdp=param('pw*delayN')

.tran		0.1n		640n	$(sweep	k 	0.05p  0.5p   0.05p)

.alter 
va	a	0	pulse(1.8 0	0.1n	0.1n	0.1n	19.9n	40n)  
vb	b	0	pulse(1.8 0	0.1n	0.1n	0.1n	39.9n	80n)
vc	c	0	pulse(1.8 0	0.1n	0.1n	0.1n	79.9n	160n)

.alter 
va	a	0	pulse(1.8 0	0.1n	0.1n	0.1n	9.9n	20n)
vb	b	0	pulse(1.8 0	0.1n	0.1n	0.1n	19.9n	40n)
vc	c	0	pulse(1.8 0	0.1n	0.1n	0.1n	39.9n	80n)

.alter 
va	a	0	pulse(1.8 0	0.1n	0.1n	0.1n	4.9n	10n)
vb	b	0	pulse(1.8 0	0.1n	0.1n	0.1n	9.9n	20n)
vc	c	0	pulse(1.8 0	0.1n	0.1n	0.1n	19.9n	40n)

.alter 
va	a	0	pulse(1.8 0	0.1n	0.1n	0.1n	2.4n	5n)
vb	b	0	pulse(1.8 0	0.1n	0.1n	0.1n	4.9n	10n)
vc	c	0	pulse(1.8 0	0.1n	0.1n	0.1n	9.9n	20n)

.end