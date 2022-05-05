import sys
sys.path.append('../../../utils/other/')
from python_RELAP_functions import *
sys.path.append('../../"Steady State"/"Sensitivity Analysis"/PWR')

## Voglio provare a modificare il mass flow rate imposto al canale
r_file = open("prova_input.txt", "r")
list_lines = r_file.readlines()
print(list_lines)
print(list_lines[2].split())
words = list_lines[2].split()
words[1] = "500"
words.append("\n")
list_lines[2] = " ".join(words)
print(list_lines)

w_file = open("prova_input.txt", "w")
w_file.writelines(list_lines)
w_file.close()






prova_dict = {
        "name" : "pressione",
        "line" : 1,
        "word" : 3,
        "initial_value" : 17,
        "final_value" : 4.567
}


modify_RELAP_parameter(prova_dict, "prova_input.txt")
