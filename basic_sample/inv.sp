inverter (loading c=0.01p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global	vdd!	gnd!
vvdd	vdd!	0	1.8
vgnd	gnd!	0	0

.subckt  inv  vi  vo
mp	vo	vi	vdd!	vdd!	P_18	l=0.18u	w=1u
mn	vo	vi	gnd!	gnd!	N_18	l=0.18u	w=0.5u
.ends

xinv	a	a_	inv
c1	out	gnd!	0.01p

va a 0 pulse(1.8 0 0.1n 0.1n 0.1n 4.9n 10n)
vb b 0 pulse(1.8 0 0.1n 0.1n 0.1n 9.9n 20n)


.meas	tran	delayN	trig	v(b)	val=0.9	fall=2
+						targ	v(out)	val=0.9	rise=2
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 50n $(sweep 	k 	0.3u  5u   0.1u)
.end
