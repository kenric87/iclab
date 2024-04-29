*pseudo-nMOS Full-adder
*這個功能OK，delay 在看S的時候OK，但還沒開始測abc都變的delay
*C功能不完整
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0 0
.param k=1u


.subckt  fulladder  a b ci c0 s
mp4	net1	gnd	vdd	vdd	p_18	l=0.18u	w=2.3u

mn0	net1	ci	3	gnd	n_18	l=0.18u	w=6u
mn1	3	a	gnd	gnd	n_18	l=0.18u	w=4.5u
mn2	3	b	gnd	gnd	n_18	l=0.18u	w=6u
mn3	net1	a	4	gnd	n_18	l=0.35u	w=2.1u
mn4	4	b	gnd	gnd	n_18	l=0.18u	w=6u

mp5	c0	net1	vdd 	vdd	p_18	l=0.18u	w=2u
mn5	c0	net1	gnd	gnd	n_18	l=0.18u	w=6u


mp6	5	gnd	vdd	vdd	p_18	l=0.18u	w=2.3u
mp9	net2	net1	5	vdd	p_18	l=0.18u	w=2.3u
mp12	net2	gnd	5	vdd	p_18	l=0.18u	w=2.3u

mn6	net2	net1	8	gnd	n_18	l=0.18u	w=6u
mn7	8	a	gnd	gnd	n_18	l=0.18u	w=5u
mn8	8	b	gnd	gnd	n_18	l=0.18u	w=6u
mn9	8	ci	gnd	gnd	n_18	l=0.18u	w=20.05u

mn10	net2	ci	9	gnd	n_18	l=0.18u	w=10u
mn11	9	a	10	gnd	n_18	l=0.18u	w=5u
mn12	10	b	gnd	gnd	n_18	l=0.18u	w=6u

mp13	s	net2	vdd	vdd	p_18	l=0.18u	w=10u
mn13	s	net2	gnd 	gnd	n_18	l=0.18u	w=5u
.ends

.subckt  invde  in  out
mp0	out	in	vdd	vdd	p_18	l=0.24u	w=7.05u
mn0	out	in	0	0	n_18	l=0.25u	w=3.5u
.ends

.subckt  delay  in  out
x1	in	1	invde
x2	1	out	invde
.ends

*for s00
V0	a0	0	pulse(1.8	0  1n  0.1n  0.1n  2.4n    5n)
V1	b0	0	pulse(1.8	0  1n  0.1n  0.1n  4.9n    10n)
Vc	ci	0	pulse(1.8	0  1n  0.1n  0.1n  9.9n    20n)

*主電路
xfulladder0	a0	b0	ci	c0	s0	fulladder
xdelay	s0	s00	delay
c1	c0	0	1p
c2	s00	0	1p

*for s00
.meas	tran	delay1	trig	v(a0)		val=0.9	rise=1
+				targ	v(s00)	val=0.9	rise=1
.meas	tran	delay2	trig	v(a0)		val=0.9	rise=2
+				targ	v(s00)	val=0.9	fall=2
.meas	tran	delay3	trig	v(a0)		val=0.9	fall=3
+				targ	v(s00)	val=0.9	rise=2
.meas	tran	delay4	trig	v(a0)		val=0.9	rise=3
+				targ	v(s00)	val=0.9	fall=3
.meas	tran	delay5	trig	v(a0)		val=0.9	rise=4
+				targ	v(s00)	val=0.9	rise=3
.meas	tran	delay6	trig	v(a0)		val=0.9	fall=5
+				targ	v(s00)	val=0.9	fall=4



.meas tran pw avg power
.meas tran pdp=param('pw*delay1')
.tran	0.05n	100n $(sweep k 1u 10u 0.05u)
.end