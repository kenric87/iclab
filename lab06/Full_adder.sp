Full adder
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0  0
.param k=0.1p


.subckt buf in out vdd gnd
xinv1  in   1       vdd  gnd inv
xinv2  1    out     vdd  gnd inv
.ends

.subckt  inv  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=2u
mn0	out	in	0	0	n_18	l=0.18u	w=1u
.ends

.subckt  fulladder  a b ci co s
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=2u
mn0	out	in	0	0	n_18	l=0.18u	w=1u
.ends


*記得降電壓
V0	a0	0	1.8v
V1	a1	0	1.8v
V2	a2	0	1.8v
V3	a3	0	1.8v
V4	a4	0	1.8v
V5	a5	0	1.8v
V6	a6	0	1.8v
V7	a7	0	1.8v

V8	b0	0	0
V9	b1	0	0
V10	b2	0	0
V11	b3	0	0
V12	b4	0	0
V13	b5	0	0
V14	b6	0	0
V15	b7	0	0


Vc	ci	0	pulse(1.8	0  1n  0.1n  0.1n  9.9n    20n)



*主電路
xnand1 a b      CK out1 vdd gnd nand2
xnand2 c out1   CK out2 vdd gnd nand2
xnand3 d out2   CK out3 vdd gnd nand2
xnand4 e out3   CK out4 vdd gnd nand2
c1 out1 gnd 0.1p
c2 out2 gnd 0.1p
c3 out3 gnd 0.1p
c4 out4 gnd 0.1p




.meas	tran	delayN	trig	v(a)	val=0.9	rise=2
+						targ	v(out)	val=0.9	fall=2

.meas tran pw avg power

.meas tran pdp=param('pw*delayN')

.tran	0.05n	400n $(sweep	k 	0.05p  1p   0.05p)
.end
