import sys
sys.path.append('../../../utils/other/')
from python_RELAP_functions import *
sys.path.append('../../"Steady State"/"Sensitivity Analysis"/PWR')


###### COME USARE LA FUNZIONE :)))
prova_dict = {
        "name" : "pressione",
        "line" : 1,
        "word" : 3,
        "initial_value" : 17,
        "final_value" : 4.567
}


modify_RELAP_parameter(prova_dict, "prova_input.txt")
