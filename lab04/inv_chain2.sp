*Optimizing_the_Size_for_Inverter_Chain
*這次只有奇數顆
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd
vvdd vdd 0 1.8
vgnd gnd 0  0
.param k=0.05p

* *2顆
* .subckt  inv1  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=0.6u
* mn0	out	in	0	0	n_18	l=0.18u	w=0.25u
* .ends
* .subckt  inv2  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=2.4u  m=500
* mn0	out	in	0	0	n_18	l=0.18u	w=1u    m=500
* .ends

* *3顆
* .subckt  inv1  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=0.6u
* mn0	out	in	0	0	n_18	l=0.18u	w=0.25u
* .ends
* .subckt  inv2  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=26.83u
* mn0	out	in	0	0	n_18	l=0.18u	w=11.12u
* .ends
* .subckt  inv3  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=2.4u  m=500
* mn0	out	in	0	0	n_18	l=0.18u	w=1u    m=500
* .ends

* *4顆
* .subckt  inv1  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=0.6u
* mn0	out	in	0	0	n_18	l=0.18u	w=0.25u
* .ends
* .subckt  inv2  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=7.56u
* mn0	out	in	0	0	n_18	l=0.18u	w=3.15u
* .ends
* .subckt  inv3  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=95.25u
* mn0	out	in	0	0	n_18	l=0.18u	w=39.69u
* .ends
* .subckt  inv4  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=2.4u  m=500
* mn0	out	in	0	0	n_18	l=0.18u	w=1u    m=500
* .ends

* *5顆 6.6874
* .subckt  inv1  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=0.6u
* mn0	out	in	0	0	n_18	l=0.18u	w=0.25u
* .ends
* .subckt  inv2  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=4.01u
* mn0	out	in	0	0	n_18	l=0.18u	w=1.67u
* .ends
* .subckt  inv3  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=26.83u
* mn0	out	in	0	0	n_18	l=0.18u	w=11.18u
* .ends
* .subckt  inv4  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=90u  m=2
* mn0	out	in	0	0	n_18	l=0.18u	w=74.77u
* .ends
* .subckt  inv5  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=2.4u  m=500
* mn0	out	in	0	0	n_18	l=0.18u	w=1u    m=500
* .ends

* *6顆 4.573
* .subckt  inv1  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=0.6u
* mn0	out	in	0	0	n_18	l=0.18u	w=0.25u
* .ends
* .subckt  inv2  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=2.74u
* mn0	out	in	0	0	n_18	l=0.18u	w=1.14u
* .ends
* .subckt  inv3  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=12.55u
* mn0	out	in	0	0	n_18	l=0.18u	w=5.23u
* .ends
* .subckt  inv4  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=57.38u
* mn0	out	in	0	0	n_18	l=0.18u	w=23.9u
* .ends
* .subckt  inv5  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=65.6u  m=4
* mn0	out	in	0	0	n_18	l=0.18u	w=36.44u    m=3
* .ends
* .subckt  inv6  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=2.4u  m=500
* mn0	out	in	0	0	n_18	l=0.18u	w=1u    m=500
* .ends

* *7顆 3.54954
* .subckt  inv1  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=0.6u
* mn0	out	in	0	0	n_18	l=0.18u	w=0.25u
* .ends
* .subckt  inv2  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=2.13u
* mn0	out	in	0	0	n_18	l=0.18u	w=0.89u
* .ends
* .subckt  inv3  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=7.56u
* mn0	out	in	0	0	n_18	l=0.18u	w=3.15u
* .ends
* .subckt  inv4  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=26.83u
* mn0	out	in	0	0	n_18	l=0.18u	w=11.18u
* .ends
* .subckt  inv5  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=95.24u
* mn0	out	in	0	0	n_18	l=0.18u	w=39.69u
* .ends
* .subckt  inv6  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=84.52u  m=4
* mn0	out	in	0	0	n_18	l=0.18u	w=70.43u    m=2
* .ends
* .subckt  inv7  in  out  vdd  gnd
* mp0	out	in	vdd	vdd	p_18	l=0.18u	w=2.4u  m=500
* mn0	out	in	0	0	n_18	l=0.18u	w=1u    m=500
* .ends

*8顆 2.962
.subckt  inv1  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=0.6u
mn0	out	in	0	0	n_18	l=0.18u	w=0.25u
.ends
.subckt  inv2  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=1.78u
mn0	out	in	0	0	n_18	l=0.18u	w=0.74u
.ends
.subckt  inv3  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=5.26u
mn0	out	in	0	0	n_18	l=0.18u	w=2.19u
.ends
.subckt  inv4  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=15.59u
mn0	out	in	0	0	n_18	l=0.18u	w=6.5u
.ends
.subckt  inv5  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=46.18u
mn0	out	in	0	0	n_18	l=0.18u	w=19.24u
.ends
.subckt  inv6  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=68.4u m=2
mn0	out	in	0	0	n_18	l=0.18u	w=57u
.ends
.subckt  inv7  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=81.04u  m=5
mn0	out	in	0	0	n_18	l=0.18u	w=84.41u    m=2
.ends
.subckt  inv8  in  out  vdd  gnd
mp0	out	in	vdd	vdd	p_18	l=0.18u	w=2.4u  m=500
mn0	out	in	0	0	n_18	l=0.18u	w=1u    m=500
.ends


va	a	0	pulse(1.8 0	0.1n	0.1n	0.1n	4.9n	10n) 

*主電路
xinv1       a       a1      vdd     gnd     inv1
xinv2       a1      a2      vdd     gnd     inv2
xinv3       a2      a3      vdd     gnd     inv3
xinv4       a3      a4      vdd     gnd     inv4
xinv5       a4      a5      vdd     gnd     inv5
xinv6       a5      a6      vdd     gnd     inv6
xinv7       a6      a7      vdd     gnd     inv7
xinv8       a7      out      vdd     gnd     inv8
*cl	out gnd k 不需用

*雙數顆
.meas	tran	delayN	trig	v(a)	val=0.9	rise=2
+						targ	v(out)	val=0.9	rise=2

* *單數顆
* .meas	tran	delayN	trig	v(a)	val=0.9	rise=2
* +						targ	v(out)	val=0.9	fall=2

.meas tran pw avg power

.meas tran pdp=param('pw*delayN')

.tran		0.1n		50n	$(sweep	k 	0.05p  0.5p   0.05p)

.end
