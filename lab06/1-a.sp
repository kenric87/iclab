*Full adder
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0 0
.param k=0.1p


.subckt  fulladder  a b ci co s
mp0	1	a	vdd	vdd	p_18	l=0.18u	w=6u
mp1	2	b	1	vdd	p_18	l=0.18u	w=6u
mp2	net1	a	2	vdd	p_18	l=0.18u	w=6u
mp3	1	b	vdd	vdd	p_18	l=0.18u	w=6u
mp4	net1	ci	1	vdd	p_18	l=0.18u	w=6u
mn0	net1	ci	3	gnd	n_18	l=0.18u	w=3u
mn1	3	a	gnd	gnd	n_18	l=0.18u	w=1.5u
mn2	3	b	gnd	gnd	n_18	l=0.18u	w=1.5u
mn3	net1	a	4	gnd	n_18	l=0.18u	w=3u
mn4	4	b	gnd	gnd	n_18	l=0.18u	w=3u

mp5	co	net1	vdd 	vdd	p_18	l=0.18u	w=6u
mn5	co	net1	gnd	gnd	n_18	l=0.18u	w=3u

mp6	5	ci	vdd 	vdd	p_18	l=0.18u	w=2u
mp7	5	a	vdd	vdd	p_18	l=0.18u	w=2u
mp8	5	b	vdd	vdd	p_18	l=0.18u	w=2u
mp9	net2	net1	5	vdd	p_18	l=0.18u	w=6u
mp10	6	a	5	vdd	p_18	l=0.18u	w=6u
mp11	7	b	6	vdd	p_18	l=0.18u	w=6u
mp12	net2	ci	7	vdd	p_18	l=0.18u	w=6u

mn6	net2	net1	8	gnd	n_18	l=0.18u	w=3u
mn7	8	a	gnd	gnd	n_18	l=0.18u	w=1u
mn8	8	b	gnd	gnd	n_18	l=0.18u	w=1u
mn9	8	ci	gnd	gnd	n_18	l=0.18u	w=1u

mn10	net2	ci	9	gnd	n_18	l=0.18u	w=3u
mn11	9	a	10	gnd	n_18	l=0.18u	w=3u
mn12	10	b	gnd	gnd	n_18	l=0.18u	w=3u

mp13	s	net2	vdd	vdd	p_18	l=0.18u	w=6u
mn13	s	net2	gnd 	gnd	n_18	l=0.18u	w=3u
.ends


*記得降電壓
V0	a0	0	0
V1	b0	0	0
Vc	ci	0	pulse(1.8	0  1n  0.1n  0.1n  9.9n    20n)



*主電路
xfulladder0	a0	b0	ci	c0	s0	fulladder
c1	c0	0	0.1p
c2	s0	0	0.1p

.meas	tran	delayN	trig	v(ci)	val=0.9	rise=2
+				targ	v(s0)	val=0.9	rise=2

.meas tran pw avg power
.meas tran pdp=param('pw*delayN')
.tran	0.05n	400n
.end