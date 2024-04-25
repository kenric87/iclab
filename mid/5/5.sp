*pseudo-nMOS Full-adder
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0 0
.param k=0.1p


.subckt  fulladder  a b ci co s
mp4	net1	CK	vdd	vdd	p_18	l=0.18u	w=1u

mn0	net1	ci	3	gnd	n_18	l=0.18u	w=3u
mn1	3	a	gnd1	gnd	n_18	l=0.18u	w=1.5u
mn2	3	b	gnd1	gnd	n_18	l=0.18u	w=1.5u
mn3	net1	a	4	gnd	n_18	l=0.18u	w=3u
mn4	4	b	gnd1	gnd	n_18	l=0.18u	w=3u
mn14	gnd1	CK	gnd	gnd	n_18	l=0.18u	w=6u

mp5	co	net1	vdd 	vdd	p_18	l=0.18u	w=1u
mn5	co	net1	gnd	gnd	n_18	l=0.18u	w=3u

mp6	5	CK	vdd	vdd	p_18	l=0.18u	w=1u
mp9	net2	net1	5	vdd	p_18	l=0.18u	w=1u
mp12	net2	CK	5	vdd	p_18	l=0.18u	w=1u

mn6	net2	net1	8	gnd	n_18	l=0.18u	w=3u
mn7	8	a	gnd2	gnd	n_18	l=0.18u	w=1u
mn8	8	b	gnd2	gnd	n_18	l=0.18u	w=1u
mn9	8	ci	gnd2	gnd	n_18	l=0.18u	w=1u
mn15	gnd2	CK	gnd	gnd	n_18	l=0.18u	w=3u

mn10	net2	ci	9	gnd	n_18	l=0.18u	w=3u
mn11	9	a	10	gnd	n_18	l=0.18u	w=3u
mn12	10	b	gnd3	gnd	n_18	l=0.18u	w=3u
mn15	gnd3	CK	gnd	gnd	n_18	l=0.18u	w=3u

mp13	s	net2	vdd	vdd	p_18	l=0.18u	w=1u
mn13	s	net2	gnd 	gnd	n_18	l=0.18u	w=4.5u
.ends

.subckt  invde  in  out
mp0	out	in	vdd	vdd	p_18	l=0.4u	w=20u
mn0	out	in	0	0	n_18	l=0.42u	w=4.5u
.ends

.subckt  delay  in  out
x1	in	1	invde
x2	1	out	invde
.ends

*for s00
V0	a0	0	0
V1	b0	0	0
Vc	ci	0	pulse(1.8	0  1n  0.1n  0.1n  9.9n    20n)

*主電路
xfulladder0	a0	b0	ci	c0	s0	fulladder
* xdelay	s0	s00	delay
c1	c0	0	1p
c2	s0	0	1p

*for s00
.meas	tran	delay1	trig	v(ci)		val=0.9	fall=2
+				targ	v(s0)		val=0.9	fall=2
.meas	tran	delay2	trig	v(ci)		val=0.9	rise=2
+				targ	v(s0)		val=0.9	rise=2


.meas tran pw avg power
.meas tran pdp=param('pw*delay1')
.tran	0.05n	400n
.end