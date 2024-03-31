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

xinv1 in out1 inv1

.subckt  inv2  in  out
mp        out        in        vdd        vdd        P_18        l=0.18u    w=4.012u 
mn        out        in        gnd        gnd        N_18        l=0.18u    w=1.671u 
.ends

xinv2 out1 out2 inv2

.subckt  inv3  in  out
mp        out        in        vdd        vdd        P_18        l=0.18u    w=26.831u 
mn        out        in        gnd        gnd        N_18        l=0.18u    w=11.179u 
.ends
xinv3 out2 out3 inv3

.subckt  inv4  in  out
mp        out        in        vdd        vdd        P_18        l=0.18u    w=89.71u m=2 
mn        out        in        gnd        gnd        N_18        l=0.18u    w=74.758u 
.ends
xinv4 out3 out inv4

vvdd    vdd        0        1.8
vgnd    gnd        0        0

.subckt  invf  in  out
mp        out        in        vdd        vdd        P_18        l=0.18u    w=2.4u m=500
mn        out        in        gnd        gnd        N_18        l=0.18u    w=1u m=500
.ends
xinvf out outf invf

vin        in        0    pulse(1.8    0     0.1n  0.1n     0.1n 4.9n    10n)


.meas    tran    delayN    trig    v(in)    val=0.9    rise=1
+                        targ    v(out)    val=0.9    rise=1
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 10n 100n 
.end