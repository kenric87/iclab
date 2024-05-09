* A=B, A>B, and A<B
*using dynamic CMOS
*已完成
.option	post=2
.prot 
.lib	'cic018.l'	tt
.unprot
.global	vdd	gnd
vvdd	vdd	0	1.8
vgnd	gnd	0	0
.param	k=1u

.subckt	inv	in	out
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=5u
mn0	out	in	0	0	n_18	l=0.18u	w=5u
.ends

.subckt	inv_DY	in	CK	out
mp0	out	CK	vdd	vdd	p_18	l=0.18u	w=2.1u
mn0	out	in	1	gnd	n_18	l=0.18u	w=1.2u
mn1	1	CK	gnd	gnd	n_18	l=0.18u	w=1.2u
.ends

* .subckt	inv_delay1	in	out
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=2u
* mn0	out	in	0	0	n_18	l=0.18u	w=2u
* .ends

* .subckt	buffer13	in	out
* x1	in	1	inv_delay1
* x2	1	out	inv_delay1
* .ends


.subckt	nand_bac	a	b	CK	out 
mp0	out	CK	vdd	vdd	p_18	l=0.5u	w=1.3u
mn0	out	a	net	gnd	n_18	l=0.4u	w=3u	
mn1	net	b	gnd1	gnd	n_18	l=0.4u	w=3u
mn2	gnd1	CK	gnd	gnd	n_18	l=0.4u	w=2u
.ends

.subckt	and	a	b	CK	out
xnand1	a	b	CK	1	nand_bac
xinv1	1	CK	out	inv_DY
.ends

.subckt	nor	a	b	CK	out
mp0	out	CK	vdd	vdd	p_18	l=0.32u	w=4.5u
mn0	out	a	gnd2	gnd	n_18	l=0.32u	w=1.4u
mn1	out	b	gnd2	gnd	n_18	l=0.32u	w=1.5u
mn2	gnd2	CK	gnd	gnd	n_18	l=0.32u	w=2u
.ends

VCK	CK	0	pulse(1.8	0	0.1n	0.5n	0.5n	4.5n		10n)
Va	A	0	pulse(1.8	0	0.1n	0.5n	0.5n	9.5n		20n)
Vb	B	0	pulse(1.8	0	0.1n	0.5n	0.5n	19.5n	40n)

*
xinv1	a	a_	inv
xinv2	b	b_	inv
xand1	a_	b	CK	out1	and
xand2	b_	a	CK	out3	and
xnor		out1	out3	CK	out2	nor
* xbuffer1	out1	out1+	buffer13
* xbuffer3	out3	out3+	buffer13
cl1	out1	gnd	0.5p
cl2	out2	gnd	0.5p
cl3	out3	gnd	0.5p

.meas	tran	delay1	trig	v(ck)	val=0.9	rise=1
+					targ	v(out1)	val=0.9	fall=1
.meas	tran	delay2	trig	v(ck)	val=0.9	fall=2
+					targ	v(out1)	val=0.9	rise=2
.meas	tran	delay3	trig	v(ck)	val=0.9	rise=2
+					targ	v(out1)	val=0.9	fall=2
.meas	tran	delay4	trig	v(ck)	val=0.9	fall=3
+					targ	v(out1)	val=0.9	rise=3
.meas	tran	delay5	trig	v(ck)	val=0.9	rise=4
+					targ	v(out1)	val=0.9	fall=3
.meas	tran	delay6	trig	v(ck)	val=0.9	fall=5
+					targ	v(out1)	val=0.9	rise=4


.meas	tran	delay7	trig	v(ck)	val=0.9	rise=2
+					targ	v(out2)	val=0.9	fall=1
.meas	tran	delay8	trig	v(ck)	val=0.9	fall=3
+					targ	v(out2)	val=0.9	rise=1
.meas	tran	delay9	trig	v(ck)	val=0.9	rise=3
+					targ	v(out2)	val=0.9	fall=2
.meas	tran	delay10	trig	v(ck)	val=0.9	fall=4
+					targ	v(out2)	val=0.9	rise=2

* .meas	tran	delay11	trig	v(ck)	val=0.9	rise=1
* +					targ	v(out3)	val=0.9	fall=1
* .meas	tran	delay12	trig	v(ck)	val=0.9	fall=2
* +					targ	v(out3)	val=0.9	rise=2
* .meas	tran	delay13	trig	v(ck)	val=0.9	rise=3
* +					targ	v(out3)	val=0.9	fall=2
* .meas	tran	delay14	trig	v(ck)	val=0.9	fall=4
* +					targ	v(out3)	val=0.9	rise=3
* .meas	tran	delay15	trig	v(ck)	val=0.9	rise=4
* +					targ	v(out3)	val=0.9	fall=3
* .meas	tran	delay16	trig	v(ck)	val=0.9	fall=5
* +					targ	v(out3)	val=0.9	rise=4


.tran	0.1n	80n $(sweep k 1u 90u 2u)
.end