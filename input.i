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
