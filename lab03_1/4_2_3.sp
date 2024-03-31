2-input inv (loading c=0.01p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  inv1  in  out
mp        out        in        vdd        vdd        P_18        l=0.18u    w=0.6u 
mn        out        in        gnd        gnd        N_18        l=0.18u    w=0.25u 
.ends

.subckt  inv2  in  out
mp        out        in        vdd        vdd        P_18        l=0.18u    w=7.559u 
mn        out        in        gnd        gnd        N_18        l=0.18u    w=3.149u 
.ends

.subckt  inv3  in  out
mp        out        in        vdd        vdd        P_18        l=0.18u    w=95.2u 
mn        out        in        gnd        gnd        N_18        l=0.18u    w=39.68uu 
.ends

.subckt  invf  in  out
mp        out        in        vdd        vdd        P_18        l=0.18u    w=2.4u m=500
mn        out        in        gnd        gnd        N_18        l=0.18u    w=1u m=500
.ends

vvdd    vdd        0        1.8
vgnd    gnd        0        0


xinv1 in out1 inv1
xinv2 out1 out2 inv2
xinv3 out2 out inv3
xinvf out outf invf

vin        in        0    pulse(1.8    0     0.1n  0.1n     0.1n 4.9n    10n)


.meas    tran    delayN    trig    v(in)    val=0.9    rise=1
+                        targ    v(out)    val=0.9    fall=1
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 10n 100n *(sweep     k     0.3u  5u   0.1u)
.end