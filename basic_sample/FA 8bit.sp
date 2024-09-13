*full_adder
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global	vdd	gnd
vvdd	vdd	0	1.8
vgnd	gnd	0	0

.subckt	inv	in	out
mp0	out	in	vdd	vdd	P_18	l=0.18u	w=1u
mn0	out	in	gnd	gnd	N_18	l=0.18u	w=0.5u
.ends

.subckt	xor	a	b	out
xinv1	a	a_	inv
xinv2	b	b_	inv
mp0	n1	a	vdd	vdd	P_18	l=0.18u	w=1u
mp1	out	b_	n1	vdd	P_18	l=0.18u	w=1u
mp2	n2	a_	vdd	vdd	P_18	l=0.18u	w=1u
mp3	out	b	n2	vdd	P_18	l=0.18u	w=1u
mn0	out	a_	n3	gnd	N_18	l=0.18u	w=0.5u
mn1	n3	b_	gnd	gnd	N_18	l=0.18u	w=0.5u
mn2	out	a	n4	gnd	N_18	l=0.18u	w=0.5u
mn3	n4	b	gnd	gnd	N_18	l=0.18u	w=0.5u
.ends	xor

.subckt	nand	a	b	out
mp0	out	a	vdd	vdd	P_18	l=0.18u	w=0.5u
mp1	out	b	vdd	vdd	P_18	l=0.18u	w=0.5u
mn0	out	a	n1	gnd	N_18	l=0.18u	w=0.5u
mn1	n1	b	gnd	gnd	N_18	l=0.18u	w=0.5u
.ends	nand

.subckt	FA1b	a	b	ci	co	s
xor1	a	b	n1	xor
xor2	n1	ci	s	xor
xnand1	n1	ci	n2	nand
xnand2	a	b	n3	nand
xnand3	n2	n3	co	nand
.ends	FA1b

.subckt	FA_8bit	A0 A1 A2 A3 A4 A5 A6 A7 B0	B1	B2	B3	B4	B5	B6	B7	C0	C1	C2	C3	C4	C5	C6	C7 	Cout	S0	S1	S2	S3	S4	S5	S6	S7
xFA1b0	A0 B0 C0 C1   S0	FA1b
xFA1b1	A1 B1 C1 C2   S1	FA1b
xFA1b2	A2 B2 C2 C3   S2	FA1b
xFA1b3	A3 B3 C3 C4   S3	FA1b
xFA1b4	A4 B4 C4 C5   S4	FA1b
xFA1b5	A5 B5 C5 C6   S5	FA1b
xFA1b6	A6 B6 C6 C7   S6	FA1b
xFA1b7	A7 B7 C7 Cout S7	FA1b
.ends	FA_8bit

* .include "FA_8bit.pex.netlist"
* XFA_8bit	VDD C1 A0 B0 B1 A1 C0 C2 GND C3 A2 B2 B3 A3 C4 C5 A4 B4 B5 A5
* + C6 C7 A6 B6 B7 A7 S1 S0 S3 S2 S5 S4 S7 COUT S6 FA_8bit
x1 A0 A1 A2 A3 A4 A5 A6 A7 B0	B1	B2	B3	B4	B5	B6	B7	C0	C1	C2	C3	C4	C5	C6	C7 	Cout	S0	S1	S2	S3	S4	S5	S6	S7 FA_8bit

va0 a0 0 pulse(1.8 0 0.1n 0.1n 0.1n 4.9n 10n)
va1 a1 0 pulse(1.8 0 0.1n 0.1n 0.1n 4.9n 10n)
va2 a2 0 pulse(1.8 0 0.1n 0.1n 0.1n 4.9n 10n)
va3 a3 0 pulse(1.8 0 0.1n 0.1n 0.1n 4.9n 10n)
va4 a4 0 pulse(1.8 0 0.1n 0.1n 0.1n 4.9n 10n)
va5 a5 0 pulse(1.8 0 0.1n 0.1n 0.1n 4.9n 10n)
va6 a6 0 pulse(1.8 0 0.1n 0.1n 0.1n 4.9n 10n)
va7 a7 0 pulse(1.8 0 0.1n 0.1n 0.1n 4.9n 10n)
vb0 b0 0 pulse(1.8 0 0.1n 0.1n 0.1n 9.9n 20n)
vb1 b1 0 pulse(1.8 0 0.1n 0.1n 0.1n 9.9n 20n)
vb2 b2 0 pulse(1.8 0 0.1n 0.1n 0.1n 9.9n 20n)
vb3 b3 0 pulse(1.8 0 0.1n 0.1n 0.1n 9.9n 20n)
vb4 b4 0 pulse(1.8 0 0.1n 0.1n 0.1n 9.9n 20n)
vb5 b5 0 pulse(1.8 0 0.1n 0.1n 0.1n 9.9n 20n)
vb6 b6 0 pulse(1.8 0 0.1n 0.1n 0.1n 9.9n 20n)
vb7 b7 0 pulse(1.8 0 0.1n 0.1n 0.1n 9.9n 20n)
vc0 c0 0 pulse(1.8 0 0.1n 0.1n 0.1n 19.9n 40n)

.tran 0.1n 100n
.end