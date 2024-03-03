*Optimizing_the_Size_for_Inverter_Chain
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0  0
.param k=0.05p



.subckt  inv1  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=0.6u
mn0	out	in	0	0	n_18	l=0.18u	w=0.25u
.ends

.subckt  inv2  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=2.4u  m=16
mn0	out	in	0	0	n_18	l=0.18u	w=1u    m=16
.ends

va	a	0	pulse(1.8 0	0.1n	0.1n	0.1n	19.9n	40n) 

*主電路
xinva       a       a1      vdd     gnd     inv1
xinvb       a1      out     vdd     gnd     inv2

cl	out gnd k


.meas	tran	delayN	trig	v(a)	val=0.9	fall=2
+						targ	v(out)	val=0.9	fall=2

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
