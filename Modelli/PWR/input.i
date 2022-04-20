$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$$                                                                           $$
$$                            PWR HEATED CHANNEL                             $$
$$                                                                           $$
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$[Mazzocco, Musile Tanzi, Tagliabue]$$$$$$
*
*Titlecard
=pwr_channel
*
*crdno  Probtype    Option
100       new      transnt
*
*crdno  Check_or_Run
101         run
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
201        1.        1.e-8    0.001     00003   500      500     500
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
* Dobbiamo inserirli per far partire la simulazione (forse)
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
$                        COMPONENT 100 - LOWER RESERVOIR                      $
$                                                                             $
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
*
*crdno       Name        Type
1000000     l_tank    tmdpvol
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
1000201     0.      1.551e+7    566.25
1000202    25.      1.551e+7    566.25
1000203    30.      1.551e+7    266.25
1000204    40.      1.551e+7    266.25
1000205    80.      1.551e+7    666.25
1000206   100.      1.551e+7    666.25
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
1100101    100010000  555010001      0.
*
*--------------------------- JUNCTION DATA ----------------------------
*
*crdno    Controlword    W2   W3   W4
1100200       1 *  (0 = velocity ; 1 = mass flow rate)
*
*crdno    Time[s]   Ml[kg/s]   Mv[kg/s]   Vint[m/s]
*
1100201      0.      0.335         0.          0.
1100202     50.      0.335         0.          0.
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
5550000    channel   pipe
*
*crdno   Number of volumes
5550001        50
*
*crdno  Volflowarea[m^2]  Volno
5550101    8.79e-5         50
*
*crdno Junctionflowarea[m^2]  Junno
5550201        0.               49
*
*crdno    Vollength[m]   Volno
5550301     7.752e-2      50
*
*crdno   Volumevol[m^3]    Volno
5550401       0.            50
*
*crdno   Azangle  Volno
5550501     0.     50
*
*crdno   Vertangle  Volno
5550601    90.       50
*
*crdno    Rough[m]    Dhyd[m]   Volno
5550801   1.52e-6   1.17808e-2   50
*
*crdno   Forloss  Revloss  Junno
5550901    0.      0.       49
*
*crdno   Volume Control Flags   Volno
5551001        0000000           50
*
*
*crdno   Junction Control Flags   Junno
5551101        0001000             49
*
*
*--------------------------- VOLUMES IC -------------------------------
*
*crdno    ebt    P[Pa]     T[K]    W4   W5   W6    Volno
5551201   003   15.51e+6   566.25   0.   0.   0.    50
*
*-------------------------- JUNCTIONS IC ------------------------------
*
*crdno   Control Word
5551300       1
*
*crdno   Ml[kg/s]     Mg[kg/s]   Vint[m/s]   Junno
5551301    0.           0.         0.         49
* ?= Non so se è più veloce porre queste a zero o al mass flow rate nominale per arrivare a steady state prima
*-----------------------------------------------------------------------------
*
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$                                                                             $
$                       COMPONENT 200 - UPPER RESERVOIR                       $
$                                                                             $
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
*
*crdno     Name      Type
2000000   u_tank    snglvol
*
*crdno    Volflowarea[m^2]   Vollength[m]   Volvolume[m^3]
2000101       1.e+5               1.             0.
*
*crdno    Azangle   Vertangle   Elevchange[m]
2000102      0.        90.          1.
*
*crdno   Rough[m]  Dhyd[m]    Control Flags
2000103      0.       0.         0000000
*
*--------------------------- VOLUME DATA ----------------------------
*
*crdno   ebt    P[Pa]     T[K]
2000200  003   1.5313e+7  566.25
*
*------------------------------------------------------------------------------
*
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$                                                                             $
$                      COMPONENT 210 - OUTLET JUNCTION                        $
$                                                                             $
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
*
*crdno     Name     Type
2100000   outlet   sngljun
*
*crdno       From        To      Junarea[m^2]
2100101    555500002  200010000      0.
*
*crdno     Area[m^2]    Loss K fwd    Loss K bwd
2100102       0.             0.           0.
*
*--------------------------- JUNCTION IC ----------------------------
*
*crdno    Controlword        Ml[kg/s]      Mv[kg/s]      Vint[m/s]
2100201        1                0.             0.            0.
*
*------------------------------------------------------------------------------
*
*
*
*||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
*|||||||||||||||||||||||||||    HEAT STRUCTURES    ||||||||||||||||||||||||||||
*||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
*
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$                                                                             $
$                      HEAT STRUCTURE 200 - FUEL ROD                          $
$                                                                             $
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
*
*crdno    Naxial  Nradial  Geomtype  SSFlag  Leftboundary[m]
12000000   50       10        2        0         0.0
$ ho messo np=4 perchè considero: centro del fuel pellet + esterno del fuel pellet (raggio di 0.004096 m) + interno del cladding + esterno del cladding$
$ con la SSFlag=1 RELAP prende le temperature iniziali date in input nelle card 1CCCG402-G499 e si porta in steady-state (credo sia l'opzione migliore, così possiamo $
$ analizzare i transitori partendo da una condizione di regime). Se SSFlag=0, RELAP prende come temperature iniziali quelle nella card 1CCCG401 e non si porta in $
$ steady-state condition $
*
*crdno     Initial He Pressure [Pa]    ReferenceVolume
12000001         5000000.0                555480000
*
*crdno   FuelRough CladRough  FGDispl CDRDispl  HeatStructureNo
12000011   1.0e-6    2.0e-6    0.0     0.2         50
*
*crdno     MeshLocationFlag    MeshFormatFlag
12000100          0                  1
*
*crdno     NoIntervals   Rightcoord[m]
12000101        6          0.004069
12000102        1          0.0041786
12000103        2          0.0047506
*
*crdno     Compositionno    Intervalno
12000201        111             6
12000202        222             7
12000203        333             9
*
*crdno     Source    MeshIntervalno   Source    MeshIntervalno
12000301   0.16667        6             0.            9
*
*crdno     Initialtempflag
12000400         0
*
*crdno   Initial T[K]    MeshPointNo
12000401   1573.15           10
*
*
*---------------------- LEFT BOUNDARY CONDITION -------------------------
*
*crdno   Boundaryvolno  Increment    BCtype    SAcode   SAfactor     Heatstno
12000501       0            0           0        1      0.07752         50
*
*
*---------------------- RIGHT BOUNDARY CONDITION ------------------------
*
*crdno      Tableno     Increment   BCtype  SAcode  SAfactor   Heatstno
12000601   555010004      10000        1      1     0.07752       50
$ ho messo come altezza di ogni heat structure 0.07752 m, cioè 1/50 dell'altezza totale della fuel rod indicata dal Kazimi per il PWR: 3.876 m . Tuttavia viene $
$ indicata un'altezza leggermente minore relativa alla porzione di fuel rod scaldata: va chiarito quale delle 2 inserire e se/come considerare il profilo di $
$ temperatura e di potenza scambiata lungo la fuel rod $
$ la W3 andrebbe controllata meglio, ho messo 1 ad indicare uno scambio termico convettivo di default ma si può andare più nello specifico$
*
*
*------------------------------ SOURCE DATA -------------------------------
*
*crdno   Sourcetype  SourceMult  DMHMleft  DMHMright  Heatstno
12000701    888         0.02         0.       0.         50
$ se la SSFlag nella W4 della card 1CCCG000 è 1 allora devo dare in input una potenza iniziale, se invece è 0 non ce n'è bisogno $
$ dalla general table 888 ricevo in input nella W1 la potenza termica generata nella fuel rod. La W2 indica la frazione di questa $
$ potenza totale associata a ciascuna heat structure. Le W3 e W4 indicano quanta di questa potenza è trasferita per irraggiamento $
$ (direct heating) al fluido. La somma di questi fattori tra tutte le heat structures deve essere 1 $
$$$$$ PROFILO ASSIALE DELLA POTENZA TERMICA NELLA FUEL ROD DA SISTEMARE $$$$$
*
*
*------------------ ADDITIONAL RIGHT BOUNDARY CONDITION -------------------
*
*crdno    W1
12000900  0   * 9 word format
*
*crdno       Dth[m]      W2   W3   W4  W5  W6  W7   W8   Heatstno
12000901   1.17808e-2    15.  15.  0.  0.  0.  0.   1.     50
$$$$$ LA W2 e W3 SONO DA RIFAREEEEE $$$$$
*
*
*--------------------------------------------------------------------------
*
*||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
*|||||||||||||||||||||||||||      GENERAL TABLES      |||||||||||||||||||||||||
*||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
*
*
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$                                                                             $
$                               TABLE - MATERIALS                             $
$                                                                             $
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
*
20111100  uo2
20122200  tbl/fctn  3   1       * gas mixture
20122201  nitrogen  0.4
20122202  xenon     0.6
20122251  7.5000e-5
20133300  zr
$ la card 001 della heat structure richiede che la W2 della card 00 sia 3. Ma la W2 in teoria è necessaria solo se inseriamo manualmente $
$ i dati sui materiali, quindi non dovrebbe essere necessaria. Vediamo se il codice funziona o no e in base a quello decidiamo $
*
*
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$                                                                             $
$                  TABLE 888 - GENERATED POWER vs TIME                        $
$                                                                             $
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
*
*crdno      Tabletype   Trip   Factors
20288800     power
*
*crdno         t[s]     Power [W]
20288801        0.      66351.88
20288802       100.     66351.88
$ potenza ottenuta moltiplicando la potenza media del core (17.86 kW/m) per la l'altezza totale della fuel rod (3.658 m) basandosi sui dati del Kazimi $
$ 100 secondi è il tempo finale della simulazione $
*

.
