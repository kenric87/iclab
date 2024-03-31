3-input XOR
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0  0
.param k=0.05p

.subckt bigpmos a b c out vdd gnd
mp0	1	a	vdd	vdd	p_18 l=0.18u w=6u
mp1 2	b	1	vdd p_18 l=0.18u w=6u
mp2 out	c	2	vdd p_18 l=0.18u w=6u
.ends

.subckt bignmos a b c out vdd gnd
mn0	out	a	1	gnd	n_18 l=0.18u w=3u
mn1 1	b	2	gnd n_18 l=0.18u w=3u
mn2 2	c	gnd	gnd n_18 l=0.18u w=3u
.ends

.subckt  inv  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=2u
mn0	out	in	0	0	n_18	l=0.18u	w=1u
.ends

.subckt  xor  a  b  c  out
xinva a  a1  vdd  gnd inv
xinvb b  b1  vdd  gnd inv
xinvc c  c1  vdd  gnd inv
xp1	a1	b	c	out	vdd	gnd bigpmos
xp2	a	b1	c	out	vdd	gnd bigpmos
xp3	a	b	c1	out	vdd	gnd bigpmos
xp4	a1	b1	c1	out	vdd	gnd bigpmos
xn1	a1	b	c	out	vdd	gnd bignmos
xn2	a	b1	c	out	vdd	gnd bignmos
xn3	a	b	c1	out	vdd	gnd bignmos
xn4	a1	b1	c1	out	vdd	gnd bignmos
.ends

va	a	0	pulse(1.8 0	0.1n	0.1n	0.1n	39.9n	80n)
vb	b	0	pulse(1.8 0	0.1n	0.1n	0.1n	79.9n	160n)
vc	c	0	pulse(1.8 0	0.1n	0.1n	0.1n	159.9n	320n)

x1  a  b  c  out    xor
cl	out gnd k



.meas	tran	delayN	trig	v(a)	val=0.9	fall=3
+						targ	v(out)	val=0.9	rise=2

.meas tran pw avg power

.meas tran pdp=param('pw*delayN')

.tran		0.1n		640n	(sweep	k 	0.05p  0.5p   0.05p)

* .alter  
* va	a	0	pulse(1.8 0	0.1n	0.1n	0.1n	19.9n	40n)
* vb	b	0	pulse(1.8 0	0.1n	0.1n	0.1n	39.9n	80n)
* vc	c	0	pulse(1.8 0	0.1n	0.1n	0.1n	79.9n	160n)

* .alter 
* va	a	0	pulse(1.8 0	0.1n	0.1n	0.1n	9.9n	20n)
* vb	b	0	pulse(1.8 0	0.1n	0.1n	0.1n	19.9n	40n)
* vc	c	0	pulse(1.8 0	0.1n	0.1n	0.1n	39.9n	80n)

* .alter 
* va	a	0	pulse(1.8 0	0.1n	0.1n	0.1n	4.9n	10n)
* vb	b	0	pulse(1.8 0	0.1n	0.1n	0.1n	9.9n	20n)
* vc	c	0	pulse(1.8 0	0.1n	0.1n	0.1n	19.9n	40n)

* .alter 
* va	a	0	pulse(1.8 0	0.1n	0.1n	0.1n	2.4n	5n)
* vb	b	0	pulse(1.8 0	0.1n	0.1n	0.1n	4.9n	10n)
* vc	c	0	pulse(1.8 0	0.1n	0.1n	0.1n	9.9n	20n)

.end
