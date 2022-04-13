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
201        550.     1.e-8      0.01     00003   500      500     500
*
*crdno   Endtime[s] Mindt[s]  Maxdt[s]   ctrl  Minedit  Majedit   Rst
202        2500.     1.e-8      0.04     00003   200      200     200
*
*crdno   Endtime[s] Mindt[s]  Maxdt[s]   ctrl  Minedit  Majedit   Rst
203        3000.     1.e-7      0.04     00003   500      500     500
*
*crdno   Endtime[s] Mindt[s]  Maxdt[s]   ctrl  Minedit  Majedit   Rst
204        5000.     1.e-7      0.04     00003  1000     1000    1000
*
*crdno   Endtime[s] Mindt[s]  Maxdt[s]   ctrl  Minedit  Majedit   Rst
205       30000.     1.e-7      0.04     00003  6000     6000    6000
*
* (201 writes every 5 s)
* (202 writes every 8 s)
* (203 writes every 20 s)
* (204 writes every 40 s)
* (205 writes every 240 s)
