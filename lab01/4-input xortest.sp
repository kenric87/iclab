4-input xor (loading c=0.01p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  inv  in  out
mp        out        in        vdd        vdd        P_18        l=0.18u    w=80u
mn        out        in        gnd        gnd        N_18        l=0.18u    w=40u
.ends

xinv1 a  out_a inv
xinv2 b  out_b inv
xinv3 c  out_c inv
xinv4 d  out_d inv

.subckt  rr a b out_c out_a out_b  j
mp1        bp2     a        vdd        vdd        P_18        l=0.18u    w=2*k
mp2      bp3        out_a  vdd        vdd        P_18        l=0.18u    w=2*k
mp3        bp1     out_b    bp2        vdd        P_18        l=0.18u    w=2*k
mp4        bp1     b        bp3     vdd        P_18        l=0.18u    w=2*k
mp5        j        out_c        bp1        vdd        P_18        l=0.18u    w=2*k
.ends
x1     a b out_c out_a out_b  j1 rr
x2     out_a b c a out_b j1 rr
x3     out_a b out_c a out_b j2 rr
x4     a b c out_a out_b  j2 rr

.subckt  rrr a b out_c out_a out_b  jj
mn1        bp1        out_a    bp2        gnd        N_18        l=0.18u    w=k
mn2        bp1        a        bp3        gnd        N_18        l=0.18u    w=k
mn3        bp2        out_b    gnd        gnd        N_18        l=0.18u    w=k
mn4        bp3        b        gnd        gnd        N_18        l=0.18u    w=k
mn5        jj        out_c        bp1        gnd        N_18        l=0.18u    w=k
.ends

x11     a b out_c out_a out_b  jj1 rrr
x22    out_a b c a out_b  jj1  rrr
x33     out_a b out_c a out_b  jj2  rrr
x44     a b c out_a out_b  jj2 rrr


mp1  out  out_d  j1    vdd    P_18    l=0.18u    w=2*k
mp2  out  d     j2   vdd    P_18   l=0.18u    w=2*k
mn1     out   out_d      jj1        gnd        N_18    l=0.18u    w=k
mn2     out     d      jj2        gnd        N_18    l=0.18u    w=k

c1 out 0 0.01p

vvdd    vdd        0        1.8
vgnd    gnd        0        0

va a 0 pulse(1.8 0 0.1n 0.1n 0.1n 4.9n 10n)
vb b 0 pulse(1.8 0 0.1n 0.1n 0.1n 9.9n 20n)
vc c 0 pulse(1.8 0 0.1n 0.1n 0.1n 19.9n 40n)
vd d 0 pulse(1.8 0 0.1n 0.1n 0.1n 39.9n 80n)

.meas    tran    delayN    trig    v(a)    val=0.9     rise=1
+                        targ    v(out)    val=0.9     rise=1
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 50n (sweep     k     0.3u  5u   0.1u)
.end
