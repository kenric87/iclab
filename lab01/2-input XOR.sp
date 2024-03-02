2-input aXOR

.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0  0



.subckt aXOR a b a1 b1 out vdd gnd
mp0 1 a vdd vdd p_18 l=0.18u w='2*k'
mp1 out b1 1 vdd p_18 l=0.18u w='2*k'
mp2 2 a1 vdd vdd p_18 l=0.18u w='2*k'
mp3 out b 2 vdd p_18 l=0.18u w='2*k'
mn0 out a1 3 gnd n_18 l=0.18u w=k
mn1 3 b1 gnd gnd n_18 l=0.18u w=k
mn2 out a 4 gnd n_18 l=0.18u w=k
mn3 4 b gnd gnd n_18 l=0.18u w=k
.ends

.subckt  inv  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=1u
mn0	out	in	0	0	n_18	l=0.18u	w=0.5u
.ends

xinv1 a  a1  vdd  gnd inv
xinv2 b  b1  vdd  gnd inv
xaXOR a b a1 b1 out vdd gnd aXOR
c1 out gnd 0.01p


va a 0 pulse(1.8 0 0.1n 0.1n 0.1n 4.9n 10n)
vb b 0 pulse(1.8 0 0.1n 0.1n 0.1n 9.9n 20n)
vc c 0 pulse(1.8 0 0.1n 0.1n 0.1n 19.9n 40n)
vd d 0 pulse(1.8 0 0.1n 0.1n 0.1n 39.9n 80n)
*.tran 0.1n 160n

.meas	tran	delayN	trig	v(a)	val=0.9	rise=3
+						targ	v(out)	val=0.9	rise=2
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 100n (sweep 	k 	0.3u  5u   0.1u)
.end
