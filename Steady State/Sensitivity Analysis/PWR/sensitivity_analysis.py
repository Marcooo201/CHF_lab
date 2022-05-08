import os
import numpy as np
import sys
sys.path.append('../../../utils/other/')
from python_RELAP_functions import *
sys.path.append('../../"Steady State"/"Sensitivity Analysis"/PWR')


copy_input_command = r"copy ..\..\Modelli\PWR\input.i input.i"
simulate_command = r"..\..\..\utils\execution\relap5.exe -i input.i -o out\output -r out\rstplt -Z ..\..\..\utils\execution\tpfh2onew"
extract_command = r"py ..\..\..\utils\other\parser.py"



##############################################
#           DEFINIZIONE PARAMETRI            #
##############################################
# pressione, T_in, mass flow rate, power
nominale = {
        "name" : "nominale",
        "line" : 29,
        "word" : 1,
        "initial_value" : 0.,
        "final_value" : 0.,
        "table_rep" : False
}

time = {
        "name" : "simulation_time",
        "line" : 37,
        "word" : 1,
        "initial_value" : 100.,
        "final_value" : 100.,
        "table_rep" : False
}

p_in = {
        "name" : "InletPressure",
        "line" : 84,
        "word" : 2,
        "initial_value" : 1.551e+7,
        "final_value" : 1.6e+7,
        "table_rep" : True
}

p_out = {
        "name" : "OutletPressure",
        "line" : 197,
        "word" : 2,
        "initial_value" : 1.5313e+7,
        "final_value" : 1.5803e+7,
        "table_rep" : True
}

T_in = {
        "name" : "InletTemperature",
        "line" : 84,
        "word" : 3,
        "initial_value" : 566.25,
        "final_value" : 568.0,
        "table_rep" : True
}

m_dot = {
        "name" : "MassFlowRate",
        "line" : 108,
        "word" : 2,
        "initial_value" : 0.335,
        "final_value" : 0.34,
        "table_rep" : True
}

power = {
        "name" : "Power",
        "line" : 392,
        "word" : 2,
        "initial_value" : 66351.88,
        "final_value" : 68000.0,
        "table_rep" : True
}

He_pressure = {
        "name" : "GapPressure",
        "line" : 244,
        "word" : 1,
        "initial_value" : 2410000.0,
        "final_value" : 2500000.0,
        "table_rep" : False
}

T_init_hs = {
        "name" : "InitialHeatStrTemperature",
        "line" : 269,
        "word" : 1,
        "initial_value" : 600.0,
        "final_value" : 620.0,
        "table_rep" : False
}

gap_composition_he = {
        "name" : "GapCompositionHe",
        "line" : 373,
        "word" : 2,
        "initial_value" : 1.0,
        "final_value" : 0.9,
        "table_rep" : False
}

gap_composition_xe = {
        "name" : "GapCompositionXe",
        "line" : 374,
        "word" : 2,
        "initial_value" : 0.0,
        "final_value" : 0.1,
        "table_rep" : False
}

parameters = [[T_in], [m_dot], [power], [He_pressure], [T_init_hs], [p_in, p_out], [gap_composition_he, gap_composition_xe], [nominale]]
###### OUTPUT ######
max_fuel_temperature = {}
max_clad_temperature = {}
MDNBR = {}




##############################################
#            MODIFICA PARAMETRI              #
##############################################

for parameter in parameters:
    # Pulisco la cartella
    os.system("mkdir out")
    while len(os.listdir('out/')) != 0:
        os.system("del input.i")
        os.system(r"del out\output")
        os.system(r"del out\output_strip")
        os.system(r"del out\rstplt")
        os.system(r"del out\stripf")
        os.system(r"del out\data.csv")

    # Copio il file di input e modifico il tempo di simulazione (riduco per ottimizzare)
    os.system(copy_input_command)
    modify_RELAP_parameter(time, "input.i")

    # Modifico il parametro di riferimento
    for _ in parameter:
        modify_RELAP_parameter(_, "input.i")
    os.system("copy input.i input_{}.i".format(parameter[0]['name']))

    # Eseguo simulazione relap
    os.system(simulate_command)
    os.system("del read_steam_comment.o")

    # Estraggo i dati
    os.system(r"..\..\..\utils\execution\relap5.exe -i input_strip.i -o out\output_strip -r out\rstplt -s out\stripf")
    os.system(extract_command)

    # Leggo i dati
    data = np.genfromtxt("out\data.csv", delimiter=';')
    data = data[-1, :] # seleziono gli elementi dell'ultima riga (risultati steady state)

    fuel_temp = data[1:51]
    clad_temp = data[51:101]
    p_output = data[101:151]
    x_output = data[151:201]
    hf_output = data[201:251]
    heat_flux_output = data[251:301]
    mass_flow_output = data[301]

    max_fuel = max(fuel_temp)
    max_clad = max(clad_temp)
    chf = CHF_W3(p_output, x_output, mass_flow_output, hf_output, heat_flux_output, 8.79e-5, 1.17808e-2, 3.876)
    chfr = np.divide(chf,heat_flux_output)*1000

    max_fuel_temperature[parameter[0]['name']] = max_fuel
    max_clad_temperature[parameter[0]['name']] = max_clad
    MDNBR[parameter[0]['name']] = np.min(chfr)


##############################################
#          ELABORO E SALVO RISULTATI         #
##############################################

parameters.pop() # elimino il parametro nominale
header = [parameter[0]['name'] for parameter in parameters]
header = ';'.join(header)

fuel_absolute = []
fuel_relative = []
clad_absolute = []
clad_relative = []
MDNBR_absolute = []
MDNBR_relative = []

for parameter in parameters:
    delta_input = parameter[0]['final_value'] - parameter[0]['initial_value']
    delta_input_rel = 100*delta_input/parameter[0]['initial_value'] # pctg points
    delta_ft = np.subtract(max_fuel_temperature[parameter[0]['name']], max_fuel_temperature['nominale'])
    delta_ct = np.subtract(max_clad_temperature[parameter[0]['name']], max_clad_temperature['nominale'])
    delta_mdnbr = np.subtract(MDNBR[parameter[0]['name']], MDNBR['nominale'])
    fuel_absolute = np.append(fuel_absolute, np.divide(delta_ft,delta_input))
    fuel_relative = np.append(fuel_relative, np.divide(delta_ft,delta_input_rel))
    clad_absolute = np.append(clad_absolute, np.divide(delta_ct,delta_input))
    clad_relative = np.append(clad_relative, np.divide(delta_ct,delta_input_rel))
    MDNBR_absolute = np.append(MDNBR_absolute, np.divide(delta_mdnbr,delta_input))
    MDNBR_relative = np.append(MDNBR_relative, np.divide(delta_mdnbr,delta_input_rel))


# SALVO IL CSV
body_asbolute = np.vstack((fuel_absolute,clad_absolute,MDNBR_absolute))
body_relative = np.vstack((fuel_relative,clad_relative,MDNBR_relative))
np.savetxt('sensitivity_absolute.csv', body_asbolute, delimiter=';', comments='', fmt='%.6e', header=header)
np.savetxt('sensitivity_relative.csv', body_relative, delimiter=';', comments='', fmt='%.6e', header=header)



##############################################
#             PULISCO LA CARTELLA            #
##############################################
# elimino file superflui
os.system(r"del screen")
os.system(r"del input.i")
while len(os.listdir('out/')) != 0:
    os.system("del input.i")
    os.system(r"del out\output")
    os.system(r"del out\output_strip")
    os.system(r"del out\rstplt")
    os.system(r"del out\stripf")
    os.system(r"del out\data.csv")
os.system(r"rd out")
