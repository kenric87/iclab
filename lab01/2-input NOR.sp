2-input NOR
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0  0



.subckt nor a b c d out vdd gnd
mp0 1 a vdd vdd p_18 l=0.18u w='4*k'
mp1 out b 1 vdd p_18 l=0.18u w='4*k'
mn0 out a gnd gnd n_18 l=0.18u w=k
mn1 out b gnd gnd n_18 l=0.18u w=k
.ends


xnor a b c d out vdd gnd nor
c1 out gnd 0.01p


va a 0 pulse(1.8 0 0.1n 0.1n 0.1n 4.9n 10n)
vb b 0 pulse(1.8 0 0.1n 0.1n 0.1n 9.9n 20n)
*vc c 0 pulse(1.8 0 0.1n 0.1n 0.1n 19.9n 40n)
*vd d 0 pulse(1.8 0 0.1n 0.1n 0.1n 39.9n 80n)
*.tran 0.1n 160n

.meas	tran	delayN	trig	v(a)	val=0.9	fall=3
+						targ	v(out)	val=0.9	rise=2
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 100n (sweep 	k 	0.25u  2.5u   0.05u)
.end $我是傻逼