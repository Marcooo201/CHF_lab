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
203   40.0   1.e-8   0.05   00003   10   10   10   
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
1000201   0.   1.551e+7   568.0   
1000202   100.   1.551e+7   568.0   
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
*crdno       Name        Type
2000000     u_tank      tmdpvol
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
*crdno   ebt   W2   W3
2000200  003
*
*crdno   Time[s]      P[Pa]      T[K]
*
2000201     0.      1.5313e+7    566.25
2000202   100.      1.5313e+7    566.25
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
$                      HEAT STRUCTURE 555 - FUEL ROD                          $
$                                                                             $
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
*
*crdno    Naxial  Nradial  Geomtype  SSFlag  Leftboundary[m]
15550000   50       10        2        0         0.0
$ ho messo np=4 perchè considero: centro del fuel pellet + esterno del fuel pellet (raggio di 0.004096 m) + interno del cladding + esterno del cladding$
$ con la SSFlag=1 RELAP prende le temperature iniziali date in input nelle card 1CCCG402-G499 e si porta in steady-state (credo sia l'opzione migliore, così possiamo $
$ analizzare i transitori partendo da una condizione di regime). Se SSFlag=0, RELAP prende come temperature iniziali quelle nella card 1CCCG401 e non si porta in $
$ steady-state condition $
*
*crdno     Initial He Pressure [Pa]    ReferenceVolume
15550001         2410000.0                555480000
*
*crdno   FuelRough CladRough  FGDispl CDRDispl  HeatStructureNo
15550011   1.0e-6    2.0e-6    0.0     0.0         50
*
*crdno     MeshLocationFlag    MeshFormatFlag
15550100          0                  1
*
*crdno     NoIntervals   Rightcoord[m]
15550101        6          0.004069
15550102        1          0.0041786
15550103        2          0.0047506
*
*crdno     Compositionno    Intervalno
15550201        111             6
15550202        222             7
15550203        333             9
*
*crdno     Source    MeshIntervalno   Source    MeshIntervalno
15550301   0.16667        6             0.            9
*
*crdno     Initialtempflag
15550400         0
*
*crdno   Initial T[K]    MeshPointNo
15550401    600.0             10
*
*
*---------------------- LEFT BOUNDARY CONDITION -------------------------
*
*crdno   Boundaryvolno  Increment    BCtype    SAcode   SAfactor     Heatstno
15550501       0            0           0        1      0.07752         50
*
*
*---------------------- RIGHT BOUNDARY CONDITION ------------------------
*
*crdno      Tableno     Increment   BCtype  SAcode  SAfactor   Heatstno
15550601   555010004      10000        1      1     0.07752       50
$ ho messo come altezza di ogni heat structure 0.07752 m, cioè 1/50 dell'altezza totale della fuel rod indicata dal Kazimi per il PWR: 3.876 m . Tuttavia viene $
$ indicata un'altezza leggermente minore relativa alla porzione di fuel rod scaldata: va chiarito quale delle 2 inserire e se/come considerare il profilo di $
$ temperatura e di potenza scambiata lungo la fuel rod $
$ la W3 andrebbe controllata meglio, ho messo 1 ad indicare uno scambio termico convettivo di default ma si può andare più nello specifico$
*
*
*------------------------------ SOURCE DATA -------------------------------
*
*crdno   SourceTyp  Multiplier     W3     W4   HeatStNo
15550701    888    0.001070538     0.     0.     1
15550702    888    0.003207030     0.     0.     2
15550703    888    0.005329790     0.     0.     3
15550704    888    0.007429727     0.     0.     4
15550705    888    0.009497848     0.     0.     5
15550706    888    0.011525298     0.     0.     6
15550707    888    0.013503395     0.     0.     7
15550708    888    0.015423668     0.     0.     8
15550709    888    0.017277895     0.     0.     9
15550710    888    0.019058136     0.     0.     10
15550711    888    0.020756766     0.     0.     11
15550712    888    0.022366513     0.     0.     12
15550713    888    0.023880483     0.     0.     13
15550714    888    0.025292193     0.     0.     14
15550715    888    0.026595597     0.     0.     15
15550716    888    0.027785116     0.     0.     16
15550717    888    0.028855654     0.     0.     17
15550718    888    0.029802628     0.     0.     18
15550719    888    0.030621983     0.     0.     19
15550720    888    0.031310210     0.     0.     20
15550721    888    0.031864361     0.     0.     21
15550722    888    0.032282064     0.     0.     22
15550723    888    0.032561531     0.     0.     23
15550724    888    0.032701564     0.     0.     24
15550725    888    0.032701564     0.     0.     25
15550726    888    0.032561531     0.     0.     26
15550727    888    0.032282064     0.     0.     27
15550728    888    0.031864361     0.     0.     28
15550729    888    0.031310210     0.     0.     29
15550730    888    0.030621983     0.     0.     30
15550731    888    0.029802628     0.     0.     31
15550732    888    0.028855654     0.     0.     32
15550733    888    0.027785116     0.     0.     33
15550734    888    0.026595597     0.     0.     34
15550735    888    0.025292193     0.     0.     35
15550736    888    0.023880483     0.     0.     36
15550737    888    0.022366513     0.     0.     37
15550738    888    0.020756766     0.     0.     38
15550739    888    0.019058136     0.     0.     39
15550740    888    0.017277895     0.     0.     40
15550741    888    0.015423668     0.     0.     41
15550742    888    0.013503395     0.     0.     42
15550743    888    0.011525298     0.     0.     43
15550744    888    0.009497848     0.     0.     44
15550745    888    0.007429727     0.     0.     45
15550746    888    0.005329790     0.     0.     46
15550747    888    0.003207030     0.     0.     47
15550748    888    0.001070538     0.     0.     48
15550749    888    0.000000000     0.     0.     49
15550750    888    0.000000000     0.     0.     50

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
15550900  0   * 9 word format
*
*crdno       Dth[m]      W2   W3   W4  W5  W6  W7   W8   Heatstno
15550901   1.17808e-2    15.  15.  0.  0.  0.  0.   1.     50
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
20122201  helium  1.0
20122202  xenon   0.0
20122251  10.126  *[J/m^3/°K]
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
*
*
*||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
*|||||||||||||||||||||||||||      CONTROLVAR      |||||||||||||||||||||||||||||
*||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
*
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$  CONTROLVAR  110 Pipe Exchanged Power [kW]                                  $
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
*
*crdno      Name     Type   Scalefactor   IV   IFlag   Limiter   Min/Max   Max
20510100   power_20     sum    1.e-3       0.     1
*crdno     A0   Ai        Vi
20510101   0.   1.   q   555010000
20510102        1.   q   555020000
20510103        1.   q   555030000
20510104        1.   q   555040000
20510105        1.   q   555050000
20510106        1.   q   555060000
20510107        1.   q   555070000
20510108        1.   q   555080000
20510109        1.   q   555090000
20510110        1.   q   555100000
20510111        1.   q   555110000
20510112        1.   q   555120000
20510113        1.   q   555130000
20510114        1.   q   555140000
20510115        1.   q   555150000
20510116        1.   q   555160000
20510117        1.   q   555170000
20510118        1.   q   555180000
20510119        1.   q   555190000
20510120        1.   q   555200000
*
*crdno      Name     Type   Scalefactor   IV   IFlag   Limiter   Min/Max   Max
20510200   power_40     sum    1.e-3       0.     1
*crdno     A0   Ai        Vi
20510201   0.   1.   q   555210000
20510202        1.   q   555220000
20510203        1.   q   555230000
20510204        1.   q   555240000
20510205        1.   q   555250000
20510206        1.   q   555260000
20510207        1.   q   555270000
20510208        1.   q   555280000
20510209        1.   q   555290000
20510210        1.   q   555300000
20510211        1.   q   555310000
20510212        1.   q   555320000
20510213        1.   q   555330000
20510214        1.   q   555340000
20510215        1.   q   555350000
20510216        1.   q   555360000
20510217        1.   q   555370000
20510218        1.   q   555380000
20510219        1.   q   555390000
20510220        1.   q   555400000
*
*crdno      Name     Type   Scalefactor   IV   IFlag   Limiter   Min/Max   Max
20510300   power_50     sum    1.e-3       0.     1
*crdno     A0   Ai        Vi
20510301   0.   1.   q   555410000
20510302        1.   q   555420000
20510303        1.   q   555430000
20510304        1.   q   555440000
20510305        1.   q   555450000
20510306        1.   q   555460000
20510307        1.   q   555470000
20510308        1.   q   555480000
20510309        1.   q   555490000
20510310        1.   q   555500000
*
*crdno      Name     Type   Scalefactor   IV   IFlag   Limiter   Min/Max   Max
20511000   power     sum       1.       0.     1
*crdno     A0   Ai           Vi
20511001   0.   1.   cntrlvar 101
20511002        1.   cntrlvar 102
20511003        1.   cntrlvar 103
*
*
*
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$  CONTROLVAR  120  Pressure drop [bar]                                       $
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
*
*crdno      Name    Type   Scalefactor   IV   IFlag   Limiter   Min/Max   Max
20512000     dp      sum      1.0e-5      0.    1
*                                                      *Between extreme volumes
*crdno     A0   Ai        Vi
20512001   0.   1.   p   555010000   *Inlet
20512002       -1.   p   555500000   *Outlet
*
*
*
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$  CONTROLVAR  130  CHF (W-3 non uniform correlation) [bar]                   $
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
*
*crdno      Name    Type   Scalefactor   IV   IFlag   Limiter   Min/Max   Max
20512000     dp      sum      1.0e-5      0.    1
*                                                      *Between extreme volumes
*crdno     A0   Ai        Vi
20512001   0.   1.   p   555010000   *Inlet
20512002       -1.   p   555500000   *Outlet
*
*
*
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$                        REQUESTED VARIABLES TO RSTPLT                        $
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
*
* Heat transfer mode
20800001 htmode 555000101
20800002 htmode 555002501
20800003 htmode 555005001
*
* Temperature profile in rod
20800004 httemp 555002501
20800005 httemp 555002502
20800006 httemp 555002503
20800007 httemp 555002504
20800008 httemp 555002505
20800009 httemp 555002506
20800010 httemp 555002507
20800011 httemp 555002508
20800012 httemp 555002509
20800013 httemp 555002510
*
* Temperature max cladding
20800014 httemp 555000108
20800015 httemp 555002508
20800016 httemp 555005008
*
* Axial profile heat transfer mode
20800101 htmode 555000101
20800102 htmode 555000201
20800103 htmode 555000301
20800104 htmode 555000401
20800105 htmode 555000501
20800106 htmode 555000601
20800107 htmode 555000701
20800108 htmode 555000801
20800109 htmode 555000901
20800110 htmode 555001001
20800111 htmode 555001101
20800112 htmode 555001201
20800113 htmode 555001301
20800114 htmode 555001401
20800115 htmode 555001501
20800116 htmode 555001601
20800117 htmode 555001701
20800118 htmode 555001801
20800119 htmode 555001901
20800120 htmode 555002001
20800121 htmode 555002101
20800122 htmode 555002201
20800123 htmode 555002301
20800124 htmode 555002401
20800125 htmode 555002501
20800126 htmode 555002601
20800127 htmode 555002701
20800128 htmode 555002801
20800129 htmode 555002901
20800130 htmode 555003001
20800131 htmode 555003101
20800132 htmode 555003201
20800133 htmode 555003301
20800134 htmode 555003401
20800135 htmode 555003501
20800136 htmode 555003601
20800137 htmode 555003701
20800138 htmode 555003801
20800139 htmode 555003901
20800140 htmode 555004001
20800141 htmode 555004101
20800142 htmode 555004201
20800143 htmode 555004301
20800144 htmode 555004401
20800145 htmode 555004501
20800146 htmode 555004601
20800147 htmode 555004701
20800148 htmode 555004801
20800149 htmode 555004901
20800150 htmode 555005001
*
* Axial profile max clad temp
20800201 httemp 555000108
20800202 httemp 555000208
20800203 httemp 555000308
20800204 httemp 555000408
20800205 httemp 555000508
20800206 httemp 555000608
20800207 httemp 555000708
20800208 httemp 555000808
20800209 httemp 555000908
20800210 httemp 555001008
20800211 httemp 555001108
20800212 httemp 555001208
20800213 httemp 555001308
20800214 httemp 555001408
20800215 httemp 555001508
20800216 httemp 555001608
20800217 httemp 555001708
20800218 httemp 555001808
20800219 httemp 555001908
20800220 httemp 555002008
20800221 httemp 555002108
20800222 httemp 555002208
20800223 httemp 555002308
20800224 httemp 555002408
20800225 httemp 555002508
20800226 httemp 555002608
20800227 httemp 555002708
20800228 httemp 555002808
20800229 httemp 555002908
20800230 httemp 555003008
20800231 httemp 555003108
20800232 httemp 555003208
20800233 httemp 555003308
20800234 httemp 555003408
20800235 httemp 555003508
20800236 httemp 555003608
20800237 httemp 555003708
20800238 httemp 555003808
20800239 httemp 555003908
20800240 httemp 555004008
20800241 httemp 555004108
20800242 httemp 555004208
20800243 httemp 555004308
20800244 httemp 555004408
20800245 httemp 555004508
20800246 httemp 555004608
20800247 httemp 555004708
20800248 httemp 555004808
20800249 httemp 555004908
20800250 httemp 555005008
*
* Axial profile specific enthalpy
20800301 hvmix 555010000
20800302 hvmix 555020000
20800303 hvmix 555030000
20800304 hvmix 555040000
20800305 hvmix 555050000
20800306 hvmix 555060000
20800307 hvmix 555070000
20800308 hvmix 555080000
20800309 hvmix 555090000
20800310 hvmix 555100000
20800311 hvmix 555110000
20800312 hvmix 555120000
20800313 hvmix 555130000
20800314 hvmix 555140000
20800315 hvmix 555150000
20800316 hvmix 555160000
20800317 hvmix 555170000
20800318 hvmix 555180000
20800319 hvmix 555190000
20800320 hvmix 555200000
20800321 hvmix 555210000
20800322 hvmix 555220000
20800323 hvmix 555230000
20800324 hvmix 555240000
20800325 hvmix 555250000
20800326 hvmix 555260000
20800327 hvmix 555270000
20800328 hvmix 555280000
20800329 hvmix 555290000
20800330 hvmix 555300000
20800331 hvmix 555310000
20800332 hvmix 555320000
20800333 hvmix 555330000
20800334 hvmix 555340000
20800335 hvmix 555350000
20800336 hvmix 555360000
20800337 hvmix 555370000
20800338 hvmix 555380000
20800339 hvmix 555390000
20800340 hvmix 555400000
20800341 hvmix 555410000
20800342 hvmix 555420000
20800343 hvmix 555430000
20800344 hvmix 555440000
20800345 hvmix 555450000
20800346 hvmix 555460000
20800347 hvmix 555470000
20800348 hvmix 555480000
20800349 hvmix 555490000
20800350 hvmix 555500000
.
