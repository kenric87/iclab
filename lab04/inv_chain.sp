*Optimizing_the_Size_for_Inverter_Chain
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0  0
.param k=0.05p


* *兩顆
* .subckt  inv1  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=0.6u
* mn0	out	in	0	0	n_18	l=0.18u	w=0.25u
* .ends
* .subckt  inv2  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=2.4u  m=16
* mn0	out	in	0	0	n_18	l=0.18u	w=1u    m=16
* .ends

* *三顆
* .subckt  inv1  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=0.6u
* mn0	out	in	0	0	n_18	l=0.18u	w=0.25u
* .ends
* .subckt  inv2  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=4.8u
* mn0	out	in	0	0	n_18	l=0.18u	w=2u
* .ends
* .subckt  inv3  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=2.4u  m=16
* mn0	out	in	0	0	n_18	l=0.18u	w=1u    m=16
* .ends

* *四顆
* .subckt  inv1  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=0.6u
* mn0	out	in	0	0	n_18	l=0.18u	w=0.25u
* .ends
* .subckt  inv2  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=2.4u
* mn0	out	in	0	0	n_18	l=0.18u	w=1u
* .ends
* .subckt  inv3  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=9.6u
* mn0	out	in	0	0	n_18	l=0.18u	w=4u
* .ends
* .subckt  inv4  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=2.4u  m=16
* mn0	out	in	0	0	n_18	l=0.18u	w=1u    m=16
* .ends

* *5顆
* .subckt  inv1  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=0.6u
* mn0	out	in	0	0	n_18	l=0.18u	w=0.25u
* .ends
* .subckt  inv2  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=1.68u
* mn0	out	in	0	0	n_18	l=0.18u	w=0.7u
* .ends
* .subckt  inv3  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=2.35u  m=2
* mn0	out	in	0	0	n_18	l=0.18u	w=1.96u
* .ends
* .subckt  inv4  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=3.3u   m=4
* mn0	out	in	0	0	n_18	l=0.18u	w=1.83u  m=3
* .ends
* .subckt  inv5  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=2.4u  m=16
* mn0	out	in	0	0	n_18	l=0.18u	w=1u    m=16
* .ends

*6顆
.subckt  inv1  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=0.6u
mn0	out	in	0	0	n_18	l=0.18u	w=0.25u
.ends
.subckt  inv2  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=1.38u
mn0	out	in	0	0	n_18	l=0.18u	w=0.58u
.ends
.subckt  inv3  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=3.17u
mn0	out	in	0	0	n_18	l=0.18u	w=1.32u
.ends
.subckt  inv4  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=7.3u
mn0	out	in	0	0	n_18	l=0.18u	w=3.04u
.ends
.subckt  inv5  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=16.8u
mn0	out	in	0	0	n_18	l=0.18u	w=7u
.ends

.subckt  inv6  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=2.4u  m=16
mn0	out	in	0	0	n_18	l=0.18u	w=1u    m=16
.ends


va	a	0	pulse(1.8 0	0.1n	0.1n	0.1n	19.9n	40n) 

*主電路
xinv1       a       a1      vdd     gnd     inv1
xinv2       a1      a2      vdd     gnd     inv2
xinv3       a2      a3      vdd     gnd     inv3
xinv4       a3      a4      vdd     gnd     inv4
xinv5       a4      a5      vdd     gnd     inv5
xinv6       a5      out     vdd     gnd     inv6
cl	out gnd k

*雙數顆
.meas	tran	delayN	trig	v(a)	val=0.9	rise=2
+						targ	v(out)	val=0.9	rise=2

* *單數顆
* .meas	tran	delayN	trig	v(a)	val=0.9	rise=2
* +						targ	v(out)	val=0.9	fall=2

.meas tran pw avg power

.meas tran pdp=param('pw*delayN')

.tran		0.1n		200n	$(sweep	k 	0.05p  0.5p   0.05p)

.end
