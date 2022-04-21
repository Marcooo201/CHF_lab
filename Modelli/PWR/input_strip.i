=strip_input

0000100 strip fmtout
103 0


1001 cntrlvar 110                       $ Potenza Totale
*
1002 tempf 555500000                    $ Temperatura in uscita
*
1003 httemp 555000101                   $ Temperatura max fuel pellet (low, medium, high)
1004 httemp 555002501
1005 httemp 555005001
*
1006 httemp 555000108                   $ Temperatura max cladding (low, medium, high)
1007 httemp 555002508
1008 httemp 555005008
*
1009 httemp 555002501                   $ Profilo temperatura rod (volume 25)
1010 httemp 555002502
1011 httemp 555002503
1012 httemp 555002504
1013 httemp 555002505
1014 httemp 555002506
1015 httemp 555002507
1016 httemp 555002508
1017 httemp 555002509
1018 httemp 555002510
*
1019 cntrlvar 120                       $ Caduta di pressione
*
1020 htmode 555000101                   $ Heat transfer mode (low, medium, high)
1021 htmode 555002501
1022 htmode 555005001
*
1023 htchfr 555000101                   $ CHFR (low, medium, high)
1024 htchfr 555002501
1025 htchfr 555005001
*
*
.
