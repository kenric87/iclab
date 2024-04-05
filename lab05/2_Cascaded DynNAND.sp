*LAB5-2 Cascaded Dynamic NAND (Loading=0.1p)(no buffer & buffer)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0  0
.param k=0.1p

.subckt nand a b CK out vdd gnd
mp0     out CK vdd   vdd p_18 l=0.18u w=2u
mn0     out a 1   gnd   n_18 l=0.18u w=3u
mn1     1 b 2     gnd   n_18 l=0.18u w=3u
mn2     2 CK gnd     gnd   n_18 l=0.18u w=3u
.ends

.subckt buf in out vdd gnd
xinv1  in   1       vdd  gnd inv
xinv2  1    out     vdd  gnd inv
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


*主電路 no buffer
xnand1 a b      CK out1 vdd gnd nand
xnand2 c out1   CK out2 vdd gnd nand
xnand3 d out2   CK out3 vdd gnd nand
xnand4 e out3   CK out4 vdd gnd nand
c1 out1 gnd 0.1p
c2 out2 gnd 0.1p
c3 out3 gnd 0.1p
c4 out4 gnd 0.1p




.meas	tran	delayN	trig	v(a)	val=0.9	rise=2
+						targ	v(out)	val=0.9	fall=2

.meas tran pw avg power

.meas tran pdp=param('pw*delayN')

.tran		0.1n		100n	 $(sweep	k 	0.05p  1p   0.05p)
.alter $have buffer
xnand1 a b      CK out1 vdd gnd nand
xnand2 c out11   CK out2 vdd gnd nand
xnand3 d out21   CK out3 vdd gnd nand
xnand4 e out31   CK out4 vdd gnd nand
xbuf1 out1 out11 vdd gnd buf
xbuf2 out2 out21 vdd gnd buf
xbuf3 out3 out31 vdd gnd buf
c1 out1 gnd 0.1p
c2 out2 gnd 0.1p
c3 out3 gnd 0.1p
c4 out4 gnd 0.1p
.end
