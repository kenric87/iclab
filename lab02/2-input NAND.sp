2-input NAND
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0  0


.subckt nand a b out vdd gnd
mp0 out a vdd vdd p_18 l=0.18u w=k
mp1 out b vdd vdd p_18 l=0.18u w=k
mn0 out a net 0 n_18 l=0.18u w=k
mn1 net b 0 0 n_18 l=0.18u w=k
.ends

VA A 0 pulse(1.8 0 0.1n 0.1n 0.1n 9.9n 20n)
VB B 0 1.8
*.tran 0.1n 160n

*主電路
xnand a b out vdd gnd nand
c1 out gnd 0.05p

.meas	tran	delayN	trig	v(a)	val=0.9	fall=3
+						targ	v(out)	val=0.9	rise=2
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 100n (sweep 	k 	0.3u  5u   0.1u)
.end
