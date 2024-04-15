*
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0  0
.param k=0.1p

.subckt  inv  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=2u
mn0	out	in	0	0	n_18	l=0.18u	w=1u
.ends

.subckt aXOR a b out vdd gnd
xinv1  a  a1  vdd  gnd inv
xinv2  b  b1  vdd  gnd inv
mp0 1 a vdd vdd p_18 l=0.18u w=2u
mp1 out b1 1 vdd p_18 l=0.18u w=2u
mp2 2 a1 vdd vdd p_18 l=0.18u w=2u
mp3 out b 2 vdd p_18 l=0.18u w=2u
mn0 out a1 3 gnd n_18 l=0.18u w=1u
mn1 3 b1 gnd gnd n_18 l=0.18u w=1u
mn2 out a 4 gnd n_18 l=0.18u w=1u
mn3 4 b gnd gnd n_18 l=0.18u w=1u
.ends

.subckt  nand_bac   a  b  out  vdd  gnd
mp0	out	a	vdd	vdd	p_18	l=0.18u	w=2u
mp1	out	b	vdd	vdd	p_18	l=0.18u	w=2u
mn0	out	a	net	0	n_18	l=0.18u	w=2u
mn1	net	b	0	0	n_18	l=0.18u	w=2u
.ends

.subckt  and   a  b  out  vdd  gnd
xnand1   a  b  1  vdd  gnd nand_bac
xinv1  1  out  vdd  gnd inv
.ends


.subckt halfadder p g CK ci out co
mn0 ci  p   out gnd n_18    l=0.18u w=0.5u
mn1 out g   1   gnd n_18    l=0.18u w=0.5u
mn2 1   CK  gnd gnd n_18    l=0.18u w=0.5u
mp0 out CK  vdd vdd p_18    l=0.18u w=1u
xinv1  out  co  vdd  gnd inv
.ends

vck	clk	gnd	pulse(0		1.8	2.1n	0.1n	0.1n	1.9n	4n)
va0	a	gnd	pulse(1.8	0	0.1n	0.1n	0.1n	3.9n	8n)
vb0	b	gnd	pulse(1.8	0	0.1n	0.1n	0.1n	7.9n	16n)
vci	ci	gnd	0
va1	a1	gnd	1.8
vb1	b1	gnd	1.8
va2	a2	gnd	1.8
vb2	b2	gnd	1.8
va3	a3	gnd	1.8
vb3	b3	gnd	1.8
va4	a4	gnd	1.8
vb4	b4	gnd	1.8
va5	a5	gnd	1.8
vb5	b5	gnd	1.8
va6	a6	gnd	1.8
vb6	b6	gnd	1.8
va7	a7	gnd	1.8
vb7	b7	gnd	1.8

*
xaXOR0 a  b  p0 vdd gnd aXOR
xaXOR1 a1 b1 p1 vdd gnd aXOR
xaXOR2 a2 b2 p2 vdd gnd aXOR
xaXOR3 a3 b3 p3 vdd gnd aXOR
xaXOR4 a4 b4 p4 vdd gnd aXOR
xaXOR5 a5 b5 p5 vdd gnd aXOR
xaXOR6 a6 b6 p6 vdd gnd aXOR
xaXOR7 a7 b7 p7 vdd gnd aXOR

xand0  a   b   g0  vdd  gnd and
xand1  a1  b1  g1  vdd  gnd and
xand2  a2  b2  g2  vdd  gnd and
xand3  a3  b3  g3  vdd  gnd and
xand4  a4  b4  g4  vdd  gnd and
xand5  a5  b5  g5  vdd  gnd and
xand6  a6  b6  g6  vdd  gnd and
xand7  a7  b7  g7  vdd  gnd and

xinv  ci  ci1  vdd  gnd inv

xblock0 p0 g0 clk ci1   out0 c0 halfadder
xblock1 p1 g1 clk out0 out1 c1 halfadder
xblock2 p2 g2 clk out1 out2 c2 halfadder
xblock3 p3 g3 clk out2 out3 c3 halfadder
xblock4 p4 g4 clk out3 out4 c4 halfadder
xblock5 p5 g5 clk out4 out5 c5 halfadder
xblock6 p6 g6 clk out5 out6 c6 halfadder
xblock7 p7 g7 clk out6 out7 c7 halfadder

cl0 c0 gnd 0.05p
cl1 c1 gnd 0.05p
cl2 c2 gnd 0.05p
cl3 c3 gnd 0.05p
cl4 c4 gnd 0.05p
cl5 c5 gnd 0.05p
cl6 c6 gnd 0.05p
cl7 c7 gnd 0.05p


.meas	tran	delay0	trig	v(clk)	val=0.9	rise=4
+				targ	v(c0)		val=0.9	rise=1
.meas	tran	delay1	trig	v(clk)	val=0.9	rise=4
+				targ	v(c1)		val=0.9	rise=4
.meas	tran	delay2	trig	v(clk)	val=0.9	rise=4
+				targ	v(c2)		val=0.9	rise=4
.meas	tran	delay3	trig	v(clk)	val=0.9	rise=4
+				targ	v(c3)		val=0.9	rise=4
.meas	tran	delay4	trig	v(clk)	val=0.9	rise=4
+				targ	v(c4)		val=0.9	rise=4
.meas	tran	delay5	trig	v(clk)	val=0.9	rise=4
+				targ	v(c5)		val=0.9	rise=4
.meas	tran	delay6	trig	v(clk)	val=0.9	rise=4
+				targ	v(c6)		val=0.9	rise=4
.meas	tran	delay7	trig	v(clk)	val=0.9	rise=4
+				targ	v(c7)		val=0.9	rise=4
.meas tran pw avg power
.tran		0.1n		200n

*2
.alter
vck	clk	gnd	pulse(0		1.8	2.1n	0.1n	0.1n	1.9n	4n)
va0	a	gnd	pulse(1.8	0	0.1n	0.1n	0.1n	3.9n	8n)
vb0	b	gnd	pulse(1.8	0	0.1n	0.1n	0.1n	7.9n	16n)
vci	ci	gnd	0
va1	a1	gnd	1.8
vb1	b1	gnd	0
va2	a2	gnd	1.8
vb2	b2	gnd	0
va3	a3	gnd	1.8
vb3	b3	gnd	0
va4	a4	gnd	1.8
vb4	b4	gnd	0
va5	a5	gnd	1.8
vb5	b5	gnd	0
va6	a6	gnd	1.8
vb6	b6	gnd	0
va7	a7	gnd	1.8
vb7	b7	gnd	0

*3
.alter
vck	clk	gnd	pulse(0		1.8	2.1n	0.1n	0.1n	1.9n	4n)
va0	a	gnd	pulse(1.8	0	0.1n	0.1n	0.1n	7.9n	16n)
vb0	b	gnd	pulse(1.8	0	0.1n	0.1n	0.1n	15.9n	32n)
vci	ci	gnd	0
va1	a1	gnd	1.8
vb1	b1	gnd	0
va2	a2	gnd	1.8
vb2	b2	gnd	0
va3	a3	gnd	1.8
vb3	b3	gnd	0
va4	a4	gnd	1.8
vb4	b4	gnd	0
va5	a5	gnd	1.8
vb5	b5	gnd	0
va6	a6	gnd	1.8
vb6	b6	gnd	0
va7	a7	gnd	1.8
vb7	b7	gnd	0

*4
.alter
vck	clk	gnd	pulse(0		1.8	2.1n	0.1n	0.1n	1.9n	4n)
va0	a	gnd	pulse(1.8	0	0.1n	0.1n	0.1n	3.9n	8n)
vb0	b	gnd	pulse(1.8	0	0.1n	0.1n	0.1n	15.9n	32n)
vci	ci	gnd	0
va1	a1	gnd	1.8
vb1	b1	gnd	0
va2	a2	gnd	1.8
vb2	b2	gnd	0
va3	a3	gnd	1.8
vb3	b3	gnd	0
va4	a4	gnd	1.8
vb4	b4	gnd	0
va5	a5	gnd	1.8
vb5	b5	gnd	0
va6	a6	gnd	1.8
vb6	b6	gnd	0
va7	a7	gnd	1.8
vb7	b7	gnd	0

*5
.alter
vck	clk	gnd	pulse(0		1.8	2.1n	0.1n	0.1n	1.9n	4n)
va0	a	gnd	pulse(1.8	0	0.1n	0.1n	0.1n	3.9n	8n)
vb0	b	gnd	pulse(1.8	0	0.1n	0.1n	0.1n	31.9n	64n)
vci	ci	gnd	0
va1	a1	gnd	1.8
vb1	b1	gnd	0
va2	a2	gnd	1.8
vb2	b2	gnd	0
va3	a3	gnd	1.8
vb3	b3	gnd	0
va4	a4	gnd	1.8
vb4	b4	gnd	0
va5	a5	gnd	1.8
vb5	b5	gnd	0
va6	a6	gnd	1.8
vb6	b6	gnd	0
va7	a7	gnd	1.8
vb7	b7	gnd	0

*6
.alter
vck	clk	gnd	pulse(0		1.8	2.1n	0.1n	0.1n	1.9n	4n)
va0	a	gnd	pulse(1.8	0	0.1n	0.1n	0.1n	7.9n	16n)
vb0	b	gnd	pulse(1.8	0	0.1n	0.1n	0.1n	31.9n	64n)
vci	ci	gnd	0
va1	a1	gnd	1.8
vb1	b1	gnd	0
va2	a2	gnd	1.8
vb2	b2	gnd	0
va3	a3	gnd	1.8
vb3	b3	gnd	0
va4	a4	gnd	1.8
vb4	b4	gnd	0
va5	a5	gnd	1.8
vb5	b5	gnd	0
va6	a6	gnd	1.8
vb6	b6	gnd	0
va7	a7	gnd	1.8
vb7	b7	gnd	0

*7
.alter
vck	clk	gnd	pulse(0		1.8	2.1n	0.1n	0.1n	1.9n	4n)
va0	a	gnd	pulse(1.8	0	0.1n	0.1n	0.1n	15.9n	32n)
vb0	b	gnd	pulse(1.8	0	0.1n	0.1n	0.1n	31.9n	64n)
vci	ci	gnd	0
va1	a1	gnd	1.8
vb1	b1	gnd	0
va2	a2	gnd	1.8
vb2	b2	gnd	0
va3	a3	gnd	1.8
vb3	b3	gnd	0
va4	a4	gnd	1.8
vb4	b4	gnd	0
va5	a5	gnd	1.8
vb5	b5	gnd	0
va6	a6	gnd	1.8
vb6	b6	gnd	0
va7	a7	gnd	1.8
vb7	b7	gnd	0

*8
.alter
vck	clk	gnd	pulse(0		1.8	2.1n	0.1n	0.1n	1.9n	4n)
va0	a	gnd	pulse(1.8	0	0.1n	0.1n	0.1n	15.9n	32n)
vb0	b	gnd	pulse(1.8	0	0.1n	0.1n	0.1n	15.9n	32n)
vci	ci	gnd	0
va1	a1	gnd	1.8
vb1	b1	gnd	0
va2	a2	gnd	1.8
vb2	b2	gnd	0
va3	a3	gnd	1.8
vb3	b3	gnd	0
va4	a4	gnd	1.8
vb4	b4	gnd	0
va5	a5	gnd	1.8
vb5	b5	gnd	0
va6	a6	gnd	1.8
vb6	b6	gnd	0
va7	a7	gnd	1.8
vb7	b7	gnd	0

.end