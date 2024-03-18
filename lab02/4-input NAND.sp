4-input NAND
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0  0
.param k=0.05p


.subckt nand a b c d out
mp0 out a vdd vdd p_18 l=0.18u w=1u
mp1 out b vdd vdd p_18 l=0.18u w=1u
mp2 out c vdd vdd p_18 l=0.18u w=1u
mp3 out d vdd vdd p_18 l=0.18u w=1u
mn0 out d net1 gnd n_18 l=0.18u w=1u
mn1 net1 c net2 gnd n_18 l=0.18u w=1u
mn2 net2 b net3 gnd n_18 l=0.18u w=1u
mn3 net3 a gnd gnd n_18 l=0.18u w=1u
.ends

VA A 0 pulse(1.8 0 0.1n 0.1n 0.1n 9.9n 20n)
VB B 0 1.8
VC C 0 1.8
VD D 0 1.8


*主電路
xnand a b c d out nand
c1 out gnd k

.meas	tran	delayN	trig	v(a)	val=0.9	rise=2
+						targ	v(out)	val=0.9	fall=2
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 80n (sweep 	k 	0.02p  0.3p   0.04p)
.end
