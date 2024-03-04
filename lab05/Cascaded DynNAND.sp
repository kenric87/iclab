*LAB5-2Cascaded Dynamic NAND (Loading=0.1p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0  0
.param k=0.1p

.subckt nand a b out vdd gnd
mp0     out a vdd   vdd p_18 l=0.18u w=1u
mp1     out b vdd   vdd p_18 l=0.18u w=1u
mn0     out a net   0   n_18 l=0.18u w=1u
mn1     net b 0     0   n_18 l=0.18u w=1u
.ends

.subckt buf in out vdd gnd
xinv1  in   1       vdd  gnd inv
xinv1  1    out     vdd  gnd inv
.ends

.subckt  inv  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=2u
mn0	out	in	0	0	n_18	l=0.18u	w=1u
.ends

VA  A   0	pulse(1.8   0       0.1n    0.1n    0.1n    9.9n    20n)
VB  B   0	1.8
VC  C   0	1.8
VD  D   0	1.8
VE  E   0	1.8
VCK	CK  0	pulse(0     1.8     2.1n    0.1n    0.1n    1.9n    4n)
*.tran	0.1n		40n	


*主電路
xnand1 a b      out1 vdd gnd nand
xnand2 c out1   out2 vdd gnd nand
xnand3 d out2   out3 vdd gnd nand
xnand4 e out3   out4 vdd gnd nand
c1 out1 gnd 0.1p
c2 out2 gnd 0.1p
c3 out3 gnd 0.1p
c4 out4 gnd 0.1p




.meas	tran	delayN	trig	v(a)	val=0.9	rise=2
+						targ	v(out)	val=0.9	fall=2

.meas tran pw avg power

.meas tran pdp=param('pw*delayN')

.tran		0.1n		40n	 $(sweep	k 	0.05p  1p   0.05p)

* *2倍
* .alter
* VA  A   0	pulse(1.8   0       0.1n    0.1n    0.1n    1.9n    4n)
* VB  B   0	pulse(1.8   0       0.1n    0.1n    0.1n    3.9n    8n)
* VC  C   0	pulse(1.8   0       0.1n    0.1n    0.1n    7.9n   16n)
* VCK	CK  0	pulse(0     1.8     2.1n    0.1n    0.1n    0.9n    2n)

* *4倍
* .alter
* VA  A   0	pulse(1.8   0       0.1n    0.1n    0.1n    0.9n    2n)
* VB  B   0	pulse(1.8   0       0.1n    0.1n    0.1n    1.9n    4n)
* VC  C   0	pulse(1.8   0       0.1n    0.1n    0.1n    3.9n    8n)
* VCK	CK  0	pulse(0     1.8     2.1n    0.1n    0.1n    0.4n    1n)

* *8倍
* .alter
* VA  A   0	pulse(1.8   0       0.1n    0.1n    0.1n    0.4n    1n)
* VB  B   0	pulse(1.8   0       0.1n    0.1n    0.1n    0.9n    2n)
* VC  C   0	pulse(1.8   0       0.1n    0.1n    0.1n    1.9n    4n)
* VCK	CK  0	pulse(0     1.8     2.1n    0.1n    0.1n    0.15n    0.5n)

.end
