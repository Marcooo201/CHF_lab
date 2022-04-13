$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$$                                                                           $$
$$                            PWR HEATED CHANNEL                             $$
$$                                                                           $$
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$[Mazzocco, Musile, Tagliabue]$$$$$$
*
*Titlecard
=pwr_channel
*
*crdno  Probtype    Option
100       new      transnt
*
*crdno  CheckorRun
101 run
*101 inp-chk
*
*crdno   Inunits  Outunits
102        si        si
*
*
*
*******************************************************************************
*                         TIME STEP CONTROL CARDS                             *
*******************************************************************************
*
*crdno   Initialtime[s]
200           0.
*crdno   Endtime[s] Mindt[s]  Maxdt[s]   ctrl  Minedit  Majedit   Rst
201        1.        1.e-8     0.001     00003   500      500     500
*
*crdno   Endtime[s] Mindt[s]  Maxdt[s]   ctrl  Minedit  Majedit   Rst
202        10.       1.e-8     0.01     00003    50       50      50
*
*crdno   Endtime[s] Mindt[s]  Maxdt[s]   ctrl  Minedit  Majedit   Rst
203        100.      1.e-8     0.05     00003   10        10      10
*
* (201 writes every 0.5 s)
* (202 writes every 0.5 s)
* (203 writes every 0.5 s)
*
*
*
******************************************************************************
*                                   TRIPS                                    *
******************************************************************************
*
* Dobbiamo inserirli per far partire la simulazione
*
*
*
*
*||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
*|||||||||||||||||||||||||||     Hydraulic components    ||||||||||||||||||||||
*||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
*
**
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$                                                                             $
$                        COMPONENT 100 - Lower Reservoir                      $
$                                                                             $
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
*
*crdno       Name        Type
1000000   lower_tank    tmdpvol
*
*crdno    Volflowarea[m^2]   Vollength[m]   Volvolume[m^3]
1000101       1.e+5               1.             0.
*
*crdno    Azangle   Vertangle   Elevchange[m]
1000102      0.        90.          1.
*
*crdno   Rough[m]  Dhyd[m]    Control Flags
1000103      0.       0.           0000000
*
*--------------------------- VOLUME DATA ----------------------------
*
*crdno   ebt   W2   W3
1000200  003
*
*crdno   Time[s]      P[Pa]      T[K]
*
1000201     0.      15.51e+6    566.25
1000202   100.      15.51e+6    566.25
*
*------------------------------------------------------------------------------
*
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$                                                                             $
$                      COMPONENT 110 - INLET JUNCTION                         $
$                                                                             $
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
*
*crdno     Name     Type
1100000   feedin   tmdpjun
*
*crdno       From        To      Junarea[m^2]
1100101   100000000   555010001      0.
*
*--------------------------- JUNCTION DATA ----------------------------
*
*crdno    Controlword    W2   W3   W4
1100200       1 *  (0 = velocity ; 1 = mass flow rate)
*
*crdno    Time[s]   Ml[kg/s]   Mv[kg/s]   Vint[m/s]
*
1100201      0.        ???         0.          0.
1100202    100.        ???         0.          0.
*
*----------------------------------------------------------------------
*
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$                                                                             $
$                      COMPONENT 555 - HEATED CHANNEL                         $
$                                                                             $
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
*
*crdno      Name     Type
1200000    channel   pipe
*
*crdno   Number of volumes
1200001         ??? (nv)
*
*crdno  Volflowarea[m^2]  Volno
1200101       ???          (nv)
*
*crdno Junctionflowarea[m^2] Junno
1200201        0.            (nv-1)
*
*crdno  Vollength[m]  Volno
1200301     ???        (nv)
*
*crdno   Volumevol[m^3]    Volno
1200401       0.           (nv)
*
*crdno   Azangle  Volno
1200501     0.    (nv)
*
*crdno   Vertangle  Volno
1200601    0.       (nv)
*
*crdno   Elevchange[m]  Volno
1200701     0.          (nv)
*
*crdno    Rough[m]    Dhyd[m]   Volno
1200801   1.52e-6     0.07366    (nv)
*
*crdno   Forloss  Revloss  Junno
1200901    0.      0.      (nv-1)
*
*crdno   Volume Control Flags   Volno
1201001        0000000           (nv)
*
*
*crdno   Junction Control Flags   Junno
1201101        0001000            (nv-1)
*
*
*--------------------------- VOLUMES IC -------------------------------
*
*crdno    ebt    P[Pa]     T[K]    W4   W5   W6    Volno
1201201   003   15.51e+6   566.25   0.   0.   0.    20
*
*-------------------------- JUNCTIONS IC ------------------------------
*
*crdno   Control Word
1201300       1
*
*crdno   Ml[kg/s]     Mg[kg/s]   Vint[m/s]   Junno
1201301    0.           0.         0.         19
*
*-----------------------------------------------------------------------------
*
