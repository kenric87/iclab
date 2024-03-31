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

xinv1 in out inv1

vvdd    vdd        0        1.8
vgnd    gnd        0        0

.subckt  invf  in  out
mp        out        in        vdd        vdd        P_18        l=0.18u    w=2.4u m=500 
mn        out        in        gnd        gnd        N_18        l=0.18u    w=1u m=500
.ends
xinvf out outf invf

vin        in        0    pulse(1.8    0     0.1n  0.1n     0.1n 4.9n    10n)


.meas    tran    delayN    trig    v(in)    val=0.9    rise=1
+                        targ    v(out)    val=0.9    fall=1
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 10n 100n 
.end