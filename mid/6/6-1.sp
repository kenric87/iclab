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

.subckt inv in out vdd gnd		
mp1 out	  in   vdd    vdd  p_18 	l=0.18u w=0.3u
mn1 out   in   gnd    gnd  n_18 	l=0.18u w=0.25u
.ends

.subckt inv1 in out vdd gnd		
mp1 out	  in   vdd    vdd  p_18 	l=0.18u w=0.5u
mn1 out   in   gnd    gnd  n_18 	l=0.18u w=0.25u
.ends

.subckt inv2 in out vdd gnd		
mp1 out	  in   vdd    vdd  p_18 	l=0.18u w=6.4u
mn1 out   in   gnd    gnd  n_18 	l=0.18u w=1.45u
.ends

.subckt inv3 in out vdd gnd		
mp1 out	  in   vdd    vdd  p_18 	l=0.18u w=50u m=2
mn1 out   in   gnd    gnd  n_18 	l=0.18u w=0.25u
.ends

.subckt inv4 in out vdd gnd		
mp1 out	  in   vdd    vdd  p_18 	l=0.18u w=2.5u
mn1 out   in   gnd    gnd  n_18 	l=0.18u w=1u
.ends

.subckt inv5 in out vdd gnd		
mp1 out	  in   vdd    vdd  p_18 	l=0.18u w=2u
mn1 out   in   gnd    gnd  n_18 	l=0.18u w=1u
.ends

.subckt inv6 in out vdd gnd		
mp1 out	  in   vdd    vdd  p_18 	l=0.18u w=2u
mn1 out   in   gnd    gnd  n_18 	l=0.18u w=0.8u
.ends

.subckt inv7 in out vdd gnd		
mp1 out	  in   vdd    vdd  p_18 	l=0.18u w=0.35u
mn1 out   in   gnd    gnd  n_18 	l=0.18u w=0.25u
.ends

.subckt inv8 in out vdd gnd		
mp1 out	  in   vdd    vdd  p_18 	l=0.18u w=0.3u
mn1 out   in   gnd    gnd  n_18 	l=0.18u w=0.25u
.ends

.subckt inv9 in out vdd gnd		
mp1 out	  in   vdd    vdd  p_18 	l=0.18u w=0.7u
mn1 out   in   gnd    gnd  n_18 	l=0.18u w=1u
.ends

.subckt inv10 in out vdd gnd		
mp1 out	  in   vdd    vdd  p_18 	l=0.18u w=0.7u
mn1 out   in   gnd    gnd  n_18 	l=0.18u w=1u
.ends

.subckt buf in out vdd gnd		
xinv0 in n1  vdd gnd inv4
xinv1 n1 out vdd gnd inv4
.ends

.subckt buf1 in out vdd gnd		
xinv0 in n1  vdd gnd inv1
xinv1 n1 out vdd gnd inv1
.ends

.subckt buf2 in out vdd gnd		
xinv0 in n1  vdd gnd inv2
xinv1 n1 out vdd gnd inv2
.ends

.subckt buf3 in out vdd gnd		
xinv0 in n1  vdd gnd inv5
xinv1 n1 out vdd gnd inv5
.ends

.subckt buf4 in out vdd gnd		
xinv0 in n1  vdd gnd inv6
xinv1 n1 out vdd gnd inv6
.ends

.subckt test A B C D E out vdd gnd
xinv0 A  A1  vdd gnd inv
xinv1 B  B1  vdd gnd inv
xinv2 C  C1  vdd gnd inv3
xinv3 n22 n22_ vdd gnd inv8
xinv4 n11 n11_ vdd gnd inv

mn0  n1   A1   gnd    gnd  n_18 	l=0.8u  w=0.25u
mn1  n1   A    B      gnd  n_18 	l=0.18u w=0.45u  
xbuf1 n1 n11 vdd gnd buf
   
mn2  n2   B1   gnd    gnd  n_18 	l=0.18u w=1.5u
mn3  n2   B    D      gnd  n_18 	l=0.18u w=5u 
xbuf2 n2 n22 vdd gnd buf1
   
mn4  n3   A1   gnd    gnd  n_18 	l=0.18u w=0.5u
mn5  n3   A    E      gnd  n_18 	l=0.18u w=35u
xbuf3 n3 n33 vdd gnd buf
   
mn6  n4   n22   vdd    gnd  n_18 	l=0.18u w=0.5u
mn7  n4   n22_  n33    gnd  n_18 	l=0.18u w=0.5u
xbuf4 n4 n44 vdd gnd buf3
   
mn8  n5   C1    gnd    gnd  n_18 	l=0.18u w=0.5u
mn9  n5   C     n44    gnd  n_18 	l=0.18u w=2u
xbuf5 n5 n55 vdd gnd buf4

mn10 out1 n11   vdd    gnd  n_18 	l=0.18u w=0.7u
mn11 out1 n11_  n55    gnd  n_18 	l=0.18u w=2u
xbuf6 out1 out vdd gnd buf2
.ends

xtest1 A B C D E out+ vdd gnd test

va	a	0	pulse(1.8 0	0.1n	0.5n	0.5n	9.5n		20n)
vb	b	0	pulse(1.8 0	0.1n	0.5n	0.5n	19.5n	40n)
vc	c	0	pulse(1.8 0	0.1n	0.5n	0.5n	39.5n	80n)
vd	d	0	pulse(1.8 0	0.1n	0.5n	0.5n	79.5n	160n)
ve	e	0	pulse(1.8 0	0.1n	0.5n	0.5n	159.5n	320n)

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