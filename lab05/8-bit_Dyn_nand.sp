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


.subckt helfadder p g CK ci co vdd gnd
mn0 ci  p   out gnd n_18    l=0.18u w=0.5u
mn1 out g   1   gnd n_18    l=0.18u w=0.5u
mn2 1   CK  gnd gnd n_18    l=0.18u w=0.5u
mp0 out CK  vdd vdd p_18    l=0.18u w=1u
xinv1  out  co  vdd  gnd inv
.ends

vck	clk	gnd	pulse(0		1.8	2.1n	0.1n	0.1n	1.9n	4n)
va	a	gnd	pulse(1.8	0	0.1n	0.1n	0.1n	3.9n	8n)
vb	b	gnd	pulse(1.8	0	0.1n	0.1n	0.1n	7.9n	16n)
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
xaXOR0 a b p0 vdd gnd aXOR
xaXOR1 a1 b1 p1 vdd gnd aXOR
xaXOR2 a2 b2 p2 vdd gnd aXOR
xaXOR3 a3 b3 p3 vdd gnd aXOR
xaXOR4 a4 b4 p4 vdd gnd aXOR
xaXOR5 a5 b5 p5 vdd gnd aXOR
xaXOR6 a6 b6 p6 vdd gnd aXOR
xaXOR7 a7 b7 p7 vdd gnd aXOR

xand0  a  b  g0  vdd  gnd and
xand1  a1  b1  g1  vdd  gnd and
xand2  a2  b2  g2  vdd  gnd and
xand3  a3  b3  g3  vdd  gnd and
xand4  a4  b4  g4  vdd  gnd and
xand5  a5  b5  g5  vdd  gnd and
xand6  a6  b6  g6  vdd  gnd and
xand7  a7  b7  g7  vdd  gnd and

xblock0 p0 g0 clk ci c0 vdd gnd helfadder
xblock1 p1 g1 clk c0 c1 vdd gnd helfadder
xblock2 p2 g2 clk c1 c2 vdd gnd helfadder
xblock3 p3 g3 clk c2 c3 vdd gnd helfadder
xblock4 p4 g4 clk c3 c4 vdd gnd helfadder
xblock5 p5 g5 clk c4 c5 vdd gnd helfadder
xblock6 p6 g6 clk c5 c6 vdd gnd helfadder
xblock7 p7 g7 clk c6 c7 vdd gnd helfadder

cl0 c0 gnd 0.05p
cl1 c1 gnd 0.05p
cl2 c2 gnd 0.05p
cl3 c3 gnd 0.05p
cl4 c4 gnd 0.05p
cl5 c5 gnd 0.05p
cl6 c6 gnd 0.05p
cl7 c7 gnd 0.05p


.meas	tran	delayN	trig	v(a)	val=0.9	rise=2
+						targ	v(out)	val=0.9	fall=2

.meas tran pw avg power

.meas tran pdp=param('pw*delayN')

.tran		0.1n		100n	 $(sweep	k 	0.05p  1p   0.05p)
.end
