8-input NAND
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0  0


.subckt nand a b c d  e f g h out
mp0 out a vdd vdd p_18 l=0.18u w=1u
mp1 out b vdd vdd p_18 l=0.18u w=1u
mp2 out c vdd vdd p_18 l=0.18u w=1u
mp3 out d vdd vdd p_18 l=0.18u w=1u
mp4 out e vdd vdd p_18 l=0.18u w=1u
mp5 out f vdd vdd p_18 l=0.18u w=1u
mp6 out g vdd vdd p_18 l=0.18u w=1u
mp7 out h vdd vdd p_18 l=0.18u w=1u
mn0 out h	1	gnd n_18	l=0.18u w=1u
mn1	1	g	2	gnd	n_18	l=0.18u	w=1u
mn2 2	f	3	gnd n_18	l=0.18u w=1u
mn3 3	e	4	gnd n_18	l=0.18u w=1u
mn4 4	d	5	gnd n_18	l=0.18u w=1u
mn5 5	c	6	gnd n_18	l=0.18u w=1u
mn6 6	b	7	gnd n_18	l=0.18u w=1u
mn7 7	a	gnd	gnd n_18	l=0.18u w=1u
.ends

VA A 0 pulse(1.8 0 0.1n 0.1n 0.1n 9.9n 20n)
VB B 0 1.8
VC C 0 1.8
VD D 0 1.8
VE E 0 1.8
VF F 0 1.8
VG G 0 1.8
VH H 0 1.8

*主電路
xnand a b c d e f g h out nand
c1 out gnd 0.01p

.meas	tran	delayN	trig	v(a)	val=0.9	rise=2
+						targ	v(out)	val=0.9	fall=2
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 80n
.end
