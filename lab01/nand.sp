nand (loading c=0.01p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0  0
.param k=1u

.subckt  inv  in  out

mp		out		in		vdd		vdd		P_18		l=0.18u	w=1u
mn		out		in		gnd		gnd		N_18		l=0.18u	w=0.5u
.ends

.subckt nand a b out vdd gnd
mp0 out a vdd vdd p_18 l=0.18u w=k
mp1 out b vdd vdd p_18 l=0.18u w=k
mn0 out a net 0 n_18 l=0.18u w=k
mn1 net b 0 0 n_18 l=0.18u w=k
.ends

*xinv in out inv
xnand a b out vdd gnd nand
c1 out gnd 0.01p


va a 0 pulse(1.8 0 0.1n 0.1n 0.1n 4.9n 10n)
vb b 0 pulse(1.8 0 0.1n 0.1n 0.1n 9.9n 20n)
*vc c 0 pulse(1.8 0 0.1n 0.1n 0.1n 19.9n 40n)
*vd d 0 pulse(1.8 0 0.1n 0.1n 0.1n 39.9n 80n)
*.tran 0.1n 80n

.meas	tran	delayN	trig	v(b)	val=0.9	fall=2
+						targ	v(out)	val=0.9	rise=2
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 50n $(sweep 	k 	0.3u  5u   0.1u)
.end
