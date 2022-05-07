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
        "final_value" : 568.0,
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
        "final_value" : 68000.0,
        "table_rep" : True
}

parameters = [T_in, m_dot, power, nominale]

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

    # Copio il file di input e modifico il tempo di simulazione (riduco a 40s per ottimizzare)
    os.system(copy_input_command)
    modify_RELAP_parameter(time, "input.i")

    # Modifico il parametro di riferimento
    modify_RELAP_parameter(parameter, "input.i")
    os.system("copy input.i input_{}.i".format(parameter['name']))

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
    chfr = np.divide(chf,heat_flux_output)

    max_fuel_temperature[parameter['name']] = max_fuel
    max_clad_temperature[parameter['name']] = max_clad
    MDNBR[parameter['name']] = np.min(chfr)

# ESEGUO PER LA PRESSIONE
# Pulisco la cartella
os.system("mkdir out")
while len(os.listdir('out/')) != 0:
    os.system("del input.i")
    os.system(r"del out\output")
    os.system(r"del out\output_strip")
    os.system(r"del out\rstplt")
    os.system(r"del out\stripf")
    os.system(r"del out\data.csv")

# Copio il file di input e modifico il tempo di simulazione (riduco a 40s per ottimizzare)
os.system(copy_input_command)
modify_RELAP_parameter(time, "input.i")

# Modifico il parametro di riferimento
modify_RELAP_parameter(p_in, "input.i")
modify_RELAP_parameter(p_out, "input.i")
os.system("copy input.i input_{}.i".format('pressure'))

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
chfr = np.divide(chf,heat_flux_output)

max_fuel_temperature['pressure'] = max_fuel
max_clad_temperature['pressure'] = max_clad
MDNBR['pressure'] = np.min(chfr)


##############################################
#          ELABORO E SALVO RISULTATI         #
##############################################

parameters.pop() # elimino il parametro nominale
header = [parameter['name'] for parameter in parameters]
header.append('pressure')
header = ';'.join(header)

fuel_data = []
clad_data = []
MDNBR_data = []
print("========================MDNBRRRRRRRRR=====================")
print(MDNBR)
for parameter in parameters:
    delta_input = parameter['final_value'] - parameter['initial_value']
    delta_ft = np.subtract(max_fuel_temperature[parameter['name']], max_fuel_temperature['nominale'])
    delta_ct = np.subtract(max_clad_temperature[parameter['name']], max_clad_temperature['nominale'])
    delta_mdnbr = np.subtract(MDNBR[parameter['name']], MDNBR['nominale'])
    fuel_data = np.append(fuel_data, np.divide(delta_ft,delta_input))
    clad_data = np.append(clad_data, np.divide(delta_ct,delta_input))
    MDNBR_data = np.append(MDNBR_data, np.divide(delta_mdnbr,delta_input))

# Eseguo per la pressione
delta_input = p_in['final_value'] - p_in['initial_value']
delta_ft = np.subtract(max_fuel_temperature['pressure'], max_fuel_temperature['nominale'])
delta_ct = np.subtract(max_clad_temperature['pressure'], max_clad_temperature['nominale'])
delta_mdnbr = np.subtract(MDNBR['pressure'], MDNBR['nominale'])
fuel_data = np.append(fuel_data, np.divide(delta_ft,delta_input))
clad_data = np.append(clad_data, np.divide(delta_ct,delta_input))
MDNBR_data = np.append(MDNBR_data, np.divide(delta_mdnbr,delta_input))


# SALVO IL CSV
body = np.vstack((fuel_data,clad_data,MDNBR_data))
print(header)
print(body)
np.savetxt('sensitivity_results.csv', body, delimiter=';', comments='', fmt='%.6e', header=header)




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
