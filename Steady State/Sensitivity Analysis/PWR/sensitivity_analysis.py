import os
import sys
sys.path.append('../../../utils/other/')
from python_RELAP_functions import *
sys.path.append('../../"Steady State"/"Sensitivity Analysis"/PWR')


copy_input_command = r"copy ..\..\Modelli\PWR\input.i input.i"
simulate_command = r"..\..\..\utils\execution\relap5.exe -i input.i -o output -r rstplt -Z ..\..\..\utils\execution\tpfh2onew"

##############################################
#           DEFINIZIONE PARAMETRI            #
##############################################
# pressione, T_in, mass flow rate, power
time = {
        "name" : "simulation_time",
        "line" : 37,
        "word" : 1,
        "initial_value" : 100.,
        "final_value" : 40.,
        "table_rep" : False
}

p_in = {
        "name" : "inlet_pressure",
        "line" : 84,
        "word" : 2,
        "initial_value" : 1.551e+7,
        "final_value" : 1.6e+7,
        "table_rep" : True
}

p_out = {
        "name" : "outlet_pressure",
        "line" : 197,
        "word" : 2,
        "initial_value" : 1.5313e+7,
        "final_value" : 1.5803e+7,
        "table_rep" : True
}

T_in = {
        "name" : "inlet_temperature",
        "line" : 84,
        "word" : 3,
        "initial_value" : 566.25,
        "final_value" : 567.0,
        "table_rep" : True
}

m_dot = {
        "name" : "mass_flow_rate",
        "line" : 108,
        "word" : 2,
        "initial_value" : 0.335,
        "final_value" : 0.34,
        "table_rep" : True
}

power = {
        "name" : "power",
        "line" : 392,
        "word" : 2,
        "initial_value" : 66351.88,
        "final_value" : 67000.0,
        "table_rep" : True
}

parameters = [p_in, p_out, T_in, m_dot, power]

################### Faccio una prova con T_in
# Pulisco la cartella
os.system("del input.i")
os.system("del output")
os.system("del rstplt")

# Copio il file di input e modifico il tempo di simulazione
os.system(copy_input_command)
modify_RELAP_parameter(time, "input.i")

#os.system(simulate_command)
os.system("del read_steam_comment.o")
os.system("del screen")
