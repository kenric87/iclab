*Full adder
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.param k=0.6
.param kk='k/2'
.param j=20000000n
.param jj='(j/2)-0.1n'
.param jjj='2*j'

vvdd vdd 0 k
vgnd gnd 0 0

.subckt  fulladder  a b ci co s
mp0	1	a	vdd	vdd	p_18	l=0.18u	w=9u
mp1	2	b	1	vdd	p_18	l=0.18u	w=9u
mp2	net1	a	2	vdd	p_18	l=0.18u	w=9u
mp3	1	b	vdd	vdd	p_18	l=0.18u	w=9u
mp4	net1	ci	1	vdd	p_18	l=0.18u	w=9u
mn0	net1	ci	3	gnd	n_18	l=0.18u	w=4.5u
mn1	3	a	gnd	gnd	n_18	l=0.18u	w=4.5u
mn2	3	b	gnd	gnd	n_18	l=0.18u	w=4.5u
mn3	net1	a	4	gnd	n_18	l=0.18u	w=4.5u
mn4	4	b	gnd	gnd	n_18	l=0.18u	w=4.5u

mp5	co	net1	vdd 	vdd	p_18	l=0.18u	w=9u
mn5	co	net1	gnd	gnd	n_18	l=0.18u	w=4.5u

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
V0	a0	0	k
V1	a1	0	k
V2	a2	0	k
V3	a3	0	k
V4	a4	0	k
V5	a5	0	k
V6	a6	0	k
V7	a7	0	k
V8	b0	0	0
V9	b1	0	0
V10	b2	0	0
V11	b3	0	0
V12	b4	0	0
V13	b5	0	0
V14	b6	0	0
V15	b7	0	0
Vc	ci	0	pulse(k	0  1n  0.1n  0.1n  jj    j)

*主電路
xfulladder0	a0	b0	ci	c0	s0	fulladder
xfulladder1	a1	b1	c0	c1	s1	fulladder
xfulladder2	a2	b2	c1	c2	s2	fulladder
xfulladder3	a3	b3	c2	c3	s3	fulladder
xfulladder4	a4	b4	c3	c4	s4	fulladder
xfulladder5	a5	b5	c4	c5	s5	fulladder
xfulladder6	a6	b6	c5	c6	s6	fulladder
xfulladder7	a7	b7	c6	c7	s7	fulladder
cc0	c0	gnd	0.1p
cc1	c1	gnd	0.1p
cc2	c2	gnd	0.1p
cc3	c3	gnd	0.1p
cc4	c4	gnd	0.1p
cc5	c5	gnd	0.1p
cc6	c6	gnd	0.1p
cc7	c7	gnd	0.1p
cs0	s0	gnd	0.1p
cs1	s1	gnd	0.1p
cs2	s2	gnd	0.1p
cs3	s3	gnd	0.1p
cs4	s4	gnd	0.1p
cs5	s5	gnd	0.1p
cs6	s6	gnd	0.1p
cs7	s7	gnd	0.1p

.meas	tran	delayN	trig	v(ci)	val=kk	rise=2
+				targ	v(c7)	val=kk	rise=2
.meas tran pw avg power
.meas tran pdp=param('pw*delayN')

.tran	1.5n	jjj
.end