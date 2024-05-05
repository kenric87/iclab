*Full adder
*5-2:連同inverter也有加dynamic
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0 0
.param k=0.1p


.subckt  fulladder  a b ci CK co s
mp0	net1	CK	vdd	vdd	p_18	l=0.18u	w=6u

mn0	net1	ci	3	gnd	n_18	l=0.18u	w=3u
mn1	3	a	gnd1	gnd	n_18	l=0.18u	w=1.5u
mn2	3	b	gnd1	gnd	n_18	l=0.18u	w=1.5u
mn3	net1	a	4	gnd	n_18	l=0.18u	w=3u
mn4	4	b	gnd1	gnd	n_18	l=0.18u	w=3u
mn21	gnd1	CK	gnd	gnd	n_18	l=0.18u	w=1u

mp5	co	CK	vdd 	vdd	p_18	l=0.18u	w=6u
mn5	co	net1	gnd3	gnd	n_18	l=0.18u	w=3u
mn25	gnd3	CK	gnd	gnd	n_18	l=0.18u	w=3u

mp9	net2	CK	vdd	vdd	p_18	l=0.18u	w=6u


mn6	net2	net1	8	gnd	n_18	l=0.18u	w=3u
mn7	8	a	gnd2	gnd	n_18	l=0.18u	w=1u
mn8	8	b	gnd2	gnd	n_18	l=0.18u	w=1u
mn9	8	ci	gnd2	gnd	n_18	l=0.18u	w=1u

mn10	net2	ci	9	gnd	n_18	l=0.18u	w=3u
mn11	9	a	10	gnd	n_18	l=0.18u	w=3u
mn12	10	b	gnd2	gnd	n_18	l=0.18u	w=3u
mn22	gnd2	CK	gnd	gnd	n_18	l=0.18u	w=1u

mp13	s	CK	vdd	vdd	p_18	l=0.18u	w=6u
mn13	s	net2	gnd4 	gnd	n_18	l=0.18u	w=3u
mn26	gnd4	CK	gnd 	gnd	n_18	l=0.18u	w=3u
.ends

.subckt  invde  in  out
mp0	out	in	vdd	vdd	p_18	l=0.24u	w=7.05u
mn0	out	in	0	0	n_18	l=0.25u	w=3.5u
.ends

.subckt  delay  in  out
x1	in	1	invde
x2	1	out	invde
.ends


*記得降電壓
Vclk	CK	0	pulse(1.8	0	1n	0.1n	0.1n	9.9n	20n)
V0	a0	0	pulse(1.8	0	1n	0.1n	0.1n	19.9n	40n)
V1	b0	0	pulse(1.8	0	1n	0.1n	0.1n	39.9n	80n)
Vc	ci	0	pulse(1.8	0	1n	0.1n	0.1n	79.9n	160n)

*主電路
xfulladder0	a0	b0	ci	CK	c0	s0	fulladder
c1	c0	0	1p
c2	s0	0	1p

.meas	tran	delay1	trig	v(CK)	val=0.9	rise=4
+				targ	v(c0)	val=0.9	rise=1
.meas	tran	delay2	trig	v(CK)	val=0.9	fall=5
+				targ	v(c0)	val=0.9	fall=2
.meas	tran	delay3	trig	v(CK)	val=0.9	rise=6
+				targ	v(c0)	val=0.9	rise=2
.meas	tran	delay4	trig	v(CK)	val=0.9	fall=9
+				targ	v(c0)	val=0.9	fall=3
.meas	tran	delay5	trig	v(CK)	val=0.9	rise=4
+				targ	v(s0)	val=0.9	rise=1

.meas tran pw avg power
.meas tran pdp=param('pw*delay1')
.probe
.tran	0.05n	200n
.end