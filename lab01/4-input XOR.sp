4-input aXOR
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0  0



.subckt one a b c d e out vdd
mp0 1 a vdd vdd p_18 l=0.18u w='2*k'
mp1 2 b 1 vdd p_18 l=0.18u w='2*k'
mp2 3 c vdd vdd p_18 l=0.18u w='2*k'
mp3 2 d 3 vdd p_18 l=0.18u w='2*k'
mp4 out e 2 vdd p_18 l=0.18u w='2*k'
.ends

.subckt two a b c d e out gnd
mn0 1 a 2 gnd n_18 l=0.18u w=k
mn1 2 b gnd gnd n_18 l=0.18u w=k
mn2 1 c 3 gnd n_18 l=0.18u w=k
mn3 3 d gnd gnd n_18 l=0.18u w=k
mn4 out e 1 gnd n_18 l=0.18u w=k
.ends

.subckt  inv  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w='2*k'
mn0	out	in	0	0	n_18	l=0.18u	w=k
.ends


*主電路
xinv1 a  a1  vdd  gnd inv
xinv2 b  b1  vdd  gnd inv
xinv3 c  c1  vdd  gnd inv
xinv4 d  d1  vdd  gnd inv
xone_1 a b1 a1 b c1 1 vdd one
xone_2 a1 b1 a b c 1 vdd one
xone_3 a1 b1 a b c1 2 vdd one
xone_4 a b1 a1 b c 2 vdd one
xtwo_1 a1 b1 a b c1 3 gnd two
xtwo_2 a b1 a1 b c 3 gnd two
xtwo_3 a b1 a1 b c1 4 gnd two
xtwo_4 a1 b1 a b c 4 gnd two
mp1 out d1 1 vdd p_18 l=0.18u w='2*k'
mp2 out d 2 vdd p_18 l=0.18u w='2*k'
mn1 out d1 3 gnd n_18 l=0.18u w=k
mn2 out d 4 gnd n_18 l=0.18u w=k
c1 out gnd 0.01p


va a 0 pulse(1.8 0 0.1n 0.1n 0.1n 4.9n 10n)
vb b 0 pulse(1.8 0 0.1n 0.1n 0.1n 9.9n 20n)
vc c 0 pulse(1.8 0 0.1n 0.1n 0.1n 19.9n 40n)
vd d 0 pulse(1.8 0 0.1n 0.1n 0.1n 39.9n 80n)
*.tran 0.1n 160n

.meas	tran	delayN	trig	v(a)	val=0.9	fall=3
+						targ	v(out)	val=0.9	rise=2
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 50n (sweep 	k 	0.3u  5u   0.1u)
.end