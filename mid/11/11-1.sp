*MUX
*夾數，技巧:在平板中先規劃好思路，每一個pass transistor 都各別設計，才可以個別調整
.option	post=2
.prot 
.lib	'cic018.l'	tt
.unprot
.global	vdd	gnd
vvdd	vdd	0	1.8
vgnd	gnd	0	0
.param	k=1u

*先用pass transistor
*buf
.subckt	inv1	in	out
mp0	out	in	vdd	vdd	p_18	l=0.5u	w=10u
mn0	out	in	0	0	n_18	l=0.5u	w=10u
.ends
.subckt	buf1	in	out
x0	in	1	inv1
x1	1	out	inv1
.ends

.subckt	inv2	in	out
mp0	out	in	vdd	vdd	p_18	l=0.5u	w=10u
mn0	out	in	0	0	n_18	l=0.5u	w=10u
.ends
.subckt	buf2	in	out
x0	in	1	inv2
x1	1	out	inv2
.ends

.subckt	inv3	in	out
mp0	out	in	vdd	vdd	p_18	l=0.5u	w=10u
mn0	out	in	0	0	n_18	l=0.5u	w=10u
.ends
.subckt	buf3	in	out
x0	in	1	inv3
x1	1	out	inv3
.ends

.subckt	inv4	in	out
mp0	out	in	vdd	vdd	p_18	l=0.5u	w=10u
mn0	out	in	0	0	n_18	l=0.5u	w=10u
.ends
.subckt	buf4	in	out
x0	in	1	inv4
x1	1	out	inv4
.ends

.subckt	inv5	in	out
mp0	out	in	vdd	vdd	p_18	l=0.5u	w=2u
mn0	out	in	0	0	n_18	l=0.5u	w=2u
.ends
.subckt	buf5	in	out
x0	in	1	inv5
x1	1	out	inv5
.ends
*
.subckt	inva	in	out
mp0	out	in	vdd	vdd	p_18	l=0.5u	w=2u
mn0	out	in	0	0	n_18	l=0.5u	w=1u
.ends

.subckt	invb	in	out
mp0	out	in	vdd	vdd	p_18	l=0.5u	w=2u
mn0	out	in	0	0	n_18	l=0.5u	w=1u
.ends

.subckt	invc	in	out
mp0	out	in	vdd	vdd	p_18	l=0.5u	w=2u
mn0	out	in	0	0	n_18	l=0.5u	w=1u
.ends

.subckt	inve	in	out
mp0	out	in	vdd	vdd	p_18	l=0.5u	w=2u
mn0	out	in	0	0	n_18	l=0.5u	w=1u
.ends

.subckt	invbde	in	out
mp0	out	in	vdd	vdd	p_18	l=0.5u	w=10u
mn0	out	in	0	0	n_18	l=0.5u	w=5u
.ends

.subckt	invout1	in	out
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=4u
mn0	out	in	0	0	n_18	l=0.18u	w=4u
.ends

.subckt	invout2	in	out
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=4u
mn0	out	in	0	0	n_18	l=0.18u	w=4u
.ends

.subckt	and1	1 2 3 4 5
mn0	1	2	5	gnd	n_18	l=0.18u	w=10u
mn1	3	4	5	gnd	n_18	l=0.18u	w=2u
.ends

.subckt	and2	1 2 3 4 5
mn0	1	2	5	gnd	n_18	l=0.18u	w=4u
mn1	3	4	5	gnd	n_18	l=0.18u	w=2u
.ends

.subckt	and3	1 2 3 4 5
mn0	1	2	5	gnd	n_18	l=0.18u	w=4u
mn1	3	4	5	gnd	n_18	l=0.18u	w=2u
.ends

.subckt	or1	1 2 3 4 5
mn0	1	2	5	gnd	n_18	l=0.18u	w=4u
mn1	3	4	5	gnd	n_18	l=0.18u	w=2u
.ends

.subckt	or2	1 2 3 4 5
mn0	1	2	5	gnd	n_18	l=0.18u	w=8u
mn1	3	4	5	gnd	n_18	l=0.18u	w=2u
.ends

.subckt	pass	a b c d e out1+
xinva	a	a_	inva
xinvb	b	b_	invb
xinvc	c	c_	invc
xinve	e	e_	inve
xinvbde	bde	bde_	invbde

xand1	b	a	gnd	a_	ab	and1
xbuf1	ab	ab+	buf1
xand2	d	b	gnd	b_	bd	and2
xand3	bd	e	gnd	e_	bde	and3
xbuf3	bde	bde+	buf3
xor1		vdd	c	ab+	c_	ab+c	or1
xbuf2	ab+c	ab+c+	buf2
xor2		vdd	bde+	ab+c+	bde_	out1	or2
xbuf4	out1	out1+	buf4
.ends

.subckt	dyn	CK a b c d e	1
mp0	1	CK	vdd	vdd	p_18	l=0.18u	w=10u
mn0	1	a	2	gnd	n_18	l=0.18u	w=1u
mn1	2	b	3	gnd	n_18	l=0.18u	w=1u
mn2	1	c	3	gnd	n_18	l=0.18u	w=1u
mn3	1	b	4	gnd	n_18	l=0.18u	w=1u
mn4	4	d	5	gnd	n_18	l=0.18u	w=1u
mn5	5	e	3	gnd	n_18	l=0.18u	w=1u
mn6	3	CK	gnd	gnd	n_18	l=0.18u	w=3u
.ends


Vclk	CK	0	pulse(1.8	0	0.1n	0.1n	0.1n	0.4n		1n)
Va	a	0	pulse(1.8	0	0.1n	0.1n	0.1n	0.9n		2n)
Vb	b	0	pulse(1.8	0	0.1n	0.1n	0.1n	1.9n		4n)
Vc	c	0	pulse(1.8	0	0.1n	0.1n	0.1n	3.9n		8n)
Vd	d	0	pulse(1.8	0	0.1n	0.1n	0.1n	7.9n		16n)
Ve	e	0	pulse(1.8	0	0.1n	0.1n	0.1n	15.9n	32n)

*主電路
xpass	a b c d e out1	pass
xdyn		CK a b c d e	out2	dyn
xinvout1	out1	out1_	invout1
xinvout2	out2	out2_	invout2
xbuf5	out2	out2+	buf5
mp0	out3	CK		vdd	vdd	p_18	l=0.18u	w=10u
mn0	out3	out1		1	gnd	n_18	l=0.18u	w=4u
mn1	1	out2+	3	gnd	n_18	l=0.18u	w=4u
mn2	out3	out1_	2	gnd	n_18	l=0.18u	w=4u
mn3	2	out2_	3	gnd	n_18	l=0.18u	w=4u
mn4	3	CK		gnd	gnd	n_18	l=0.18u	w=4u
cl	out3	gnd	0.1p

* .meas	tran	delay1	trig	v(CK)	val=0.9	fall=2
* +					targ	v(out3)	val=0.9	rise=1

* .meas	tran	delay1	trig	v(CK)	val=0.9	fall=2
* +					targ	v(out3)	val=0.9	rise=1
.tran	0.1n	80n $(sweep k 1u 90u 2u)
.end