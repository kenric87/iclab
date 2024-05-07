*3-input Pass-transistor
*沒用成功
.option	post=2
.prot 
.lib	'cic018.l'	tt
.unprot
.global	vdd	gnd
vvdd	vdd	0	1.8
vgnd	gnd	0	0
.param	k=0.25u

.subckt	fuck 1 2 3 4 out
mn0	1	2	out	gnd	n_18	l=0.18u	w=11u
mn1	3	4	out	gnd	n_18	l=0.18u	w=11u
.ends

.subckt	fuck2 1 2 3 4 out
mn0	1	2	out	gnd	n_18	l=0.18u	w=50u
mn1	3	4	out	gnd	n_18	l=0.18u	w=70u
.ends

.subckt	fuck3 1 2 3 4 out
mn0	1	2	out	gnd	n_18	l=0.18u	w=40u
mn1	3	4	out	gnd	n_18	l=0.18u	w=40u
.ends

.subckt	fuck4 1 2 3 4 out
mn0	1	2	out	gnd	n_18	l=0.18u	w=40u
mn1	3	4	out	gnd	n_18	l=0.18u	w=40u
.ends

.subckt	fuck5 1 2 3 4 out
mn0	1	2	out	gnd	n_18	l=0.18u	w=70u
mn1	3	4	out	gnd	n_18	l=0.18u	w=50u
.ends

.subckt	inv in out
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=50u
mn0	out	in	0	0	n_18	l=0.18u	w=20u
.ends
.subckt	invAB in out
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=20u
mn0	out	in	0	0	n_18	l=0.18u	w=20u
.ends



.subckt  invBB  in  out
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=10u
mn0	out	in	0	0	n_18	l=0.18u	w=5u
.ends
.subckt  invBD  in  out
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=2u
mn0	out	in	0	0	n_18	l=0.18u	w=1u
.ends
.subckt  invAE  in  out
mp0	out	in	vdd	vdd	p_18	l=0.7u	w=2u
mn0	out	in	0	0	n_18	l=0.7u	w=1u
.ends
.subckt  invX1  in  out
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=40u
mn0	out	in	0	0	n_18	l=0.18u	w=20u
.ends


.subckt  Buffer  in  out
x1	in	1	invBB
x2	1	out	invBB
.ends
.subckt  BufferBD  in  out
x1	in	1	invBD
x2	1	out	invBD
.ends
.subckt  BufferAE  in  out
x1	in	1	invAE
x2	1	out	invAE
.ends
.subckt  BufferX1  in  out
x1	in	1	invX1
x2	1	out	invX1
.ends



va	a	0	pulse(1.8 0	0.1n	0.5n	0.5n	9.5n		20n)
vb	b	0	pulse(1.8 0	0.1n	0.5n	0.5n	19.5n	40n)
vc	c	0	pulse(1.8 0	0.1n	0.5n	0.5n	39.5n	80n)
vd	d	0	pulse(1.8 0	0.1n	0.5n	0.5n	79.5n	160n)
ve	e	0	pulse(1.8 0	0.1n	0.5n	0.5n	159.5n	320n)

xinva	a	a_	inv
xinvb	b	b_	inv
xinvc	c	c_	inv
xinvAB	AB	AB_	invAB
xinvBD	BD	BD_	invAB

xbuf1	X1	X1+	BufferX1
xbuf2	BD	BD+	BufferBD
xbuf3	AE	AE+	BufferAE
xbuf4	AB	AB+	Buffer
xbuf5	X2	X2+	Buffer
xbuf6	out	out+	BufferX1

x1	b	a	gnd	a_	AB	fuck
x2	e	a	gnd	a_	AE	fuck2
x3	d	b	gnd	b_	BD	fuck3
x4	vdd	BD	AE	BD_	X1	fuck4
x5	X1+	c	gnd	c_	X2	fuck5
x6	vdd	AB+	X2	AB_	out	fuck4
cl	out+	gnd	0.5p

.meas	tran	delay1	trig	v(a)		val=0.9	rise=2
+					targ	v(out+)	val=0.9	rise=1
.meas	tran	delay2	trig	v(a)		val=0.9	fall=3
+					targ	v(out+)	val=0.9	fall=2
.meas	tran	delay3	trig	v(a)		val=0.9	rise=4
+					targ	v(out+)	val=0.9	rise=2
.meas	tran	delay4	trig	v(a)		val=0.9	fall=5
+					targ	v(out+)	val=0.9	fall=3
.meas	tran	delay5	trig	v(a)		val=0.9	rise=6
+					targ	v(out+)	val=0.9	rise=3
.meas	tran	delay6	trig	v(a)		val=0.9	fall=7
+					targ	v(out+)	val=0.9	fall=4
.meas	tran	delay7	trig	v(a)		val=0.9	fall=8
+					targ	v(out+)	val=0.9	rise=4
.meas	tran	delay8	trig	v(a)		val=0.9	fall=9
+					targ	v(out+)	val=0.9	fall=5
.meas	tran	delay9	trig	v(a)		val=0.9	rise=10
+					targ	v(out+)	val=0.9	rise=5
.meas	tran	delay10	trig	v(a)		val=0.9	fall=11
+					targ	v(out+)	val=0.9	fall=6
.meas	tran	delay11	trig	v(a)		val=0.9	rise=11
+					targ	v(out+)	val=0.9	rise=6
.meas	tran	delay12	trig	v(a)		val=0.9	fall=12
+					targ	v(out+)	val=0.9	fall=7
.meas	tran	delay13	trig	v(a)		val=0.9	rise=12
+					targ	v(out+)	val=0.9	rise=7
.meas	tran	delay14	trig	v(a)		val=0.9	fall=13
+					targ	v(out+)	val=0.9	fall=8
.meas	tran	delay15	trig	v(a)		val=0.9	rise=14
+					targ	v(out+)	val=0.9	rise=8
.meas	tran	delay16	trig	v(a)		val=0.9	fall=15
+					targ	v(out+)	val=0.9	fall=9
.meas	tran	delay17	trig	v(a)		val=0.9	rise=15
+					targ	v(out+)	val=0.9	rise=9
.meas	tran	delay18	trig	v(a)		val=0.9	fall=17
+					targ	v(out+)	val=0.9	fall=10


.tran	0.1n	640n $(sweep k 1u 80u 1u)
.end