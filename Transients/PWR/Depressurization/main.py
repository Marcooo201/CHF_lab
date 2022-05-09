import os
from iapws import IAPWS97 as XSteam
import numpy as np

#####################################################
#                   VARIABILI                       #
#####################################################

# TERMODINAMICA
p0 = 155.1     # [bar]
delta_p = 1.97 # [bar]
T0 = 566.25    # [°K]
p_atm = 3      # [bar]
toll = 0.1     # tolleranza per la fine della simulazione (distanza tra p_in e p_atm)

t_active_core = 31536000 # [s] (1 anno) serve per la formula di Wigner-Way
delta_t0_scram = 0.5     # [s] delay di scram dall'inizio del transitorio
delta_t_scram = 0.5      # [s] tempo di esecuzione dello scram
P0 = 66351.88            # [W] potenza nominale rod

# INPUT RELAP
line_pressureinlet_100 = 85
card_pressureinlet_100 = 1000202

line_pressureoutlet_100 = 198
card_pressureoutlet_100 = 2000202

line_power_100 = 392
card_power_100 = 20288802

# TRANSITORIO
lambdas = np.array([0.01, 0.05, 0.1, 0.2])
delta_trans = 100 # [s] durata transitorio dopo la stabilizzazione della pressione a p_atm



for l in lambdas:
    #####################################################
    #                   PRE-PROCESSING                  #
    #####################################################

    ######################### GENERO DATI  ########################

    # Creo t molto grande e seleziono solo la sezione con valori rilevanti per la simulazione
    t = np.linspace(100.5,10100, 20000)
    p_in = (p0-p_atm)*np.exp(-l*(t-100))+p_atm

    t = t[p_in-p_atm > toll]
    t_fin = t[-1]

    # Creo un nuovo spazio dei tempi imponendo il vincolo di 97 points
    t = np.linspace(100.0, t_fin, 98)
    p_in = (p0-p_atm)*np.exp(-l*(t-100))+p_atm


    # Trovo il vettore di temperature
    h0 = XSteam(T=T0, P=p0/10).h    #[kJ/kg]
    T_in = [];

    for pi in p_in:
        T_in.append(XSteam(P=pi/10, h=h0).T)
    T_in = np.array(T_in)

    # Genero il vettore di pressioni in uscita
    p_out = p_in - delta_p

    # Genero il vettore di potenza
    t_power = np.linspace(100+delta_t0_scram+delta_t_scram, t_fin+delta_trans ,97)
    P_decay = 0.0622*P0*(((t_power-(100+delta_t0_scram))**(-0.2)) - ((t_active_core + t_power - (100+delta_t0_scram))**(-0.2)))


    ############### GENERO CODICE DA SOSTITUIRE IN RELAP INPUT #############

    # Inlet pressure
    add_pressureinlet = []
    cardno = card_pressureinlet_100-1;

    for i in range(len(t)):
        cardno = cardno+1
        line = "{}  {:.1f}   {:.5e}   {:.2f}\n".format(cardno, t[i], p_in[i]*1e5, T_in[i])
        add_pressureinlet.append(line)


    # Outlet pressure
    add_pressureoutlet = []
    cardno = card_pressureoutlet_100-1;

    for i in range(len(t)):
        cardno = cardno+1
        line = "{}  {:.1f}   {:.5e}   {:.2f}\n".format(cardno, t[i], p_out[i]*1e5, T0)
        add_pressureoutlet.append(line)

    # Power
    add_power = []
    add_power.append("{}    {:.1f}     {:.2f}\n".format(card_power_100, 100+delta_t0_scram, P0)) #aggiungo la prima line per il delay di delta_t_scram

    cardno = card_power_100
    for i in range(len(t_power)):
        cardno = cardno+1
        line = "{}    {:.1f}     {:.2f}\n".format(cardno, t_power[i], P_decay[i])
        add_power.append(line)



    #####################################################
    #                 MODIFICO L'INPUT                  #
    #####################################################

    os.system("mkdir lambda_{}".format(l))      # creo la cartella apposita
    os.system(r'copy "..\..\..\Steady State\Modelli\PWR\input.i" lambda_{}\input.i'.format(l))     # copio l'input

    r_file = open(r'lambda_{}\input.i'.format(l), 'r')
    r_lines = r_file.readlines()
    r_file.close()

    # AGGIUNGO LE TABELLE (da quella più in basso a quella più in alto per mantenere la validità degli indici di line)

    # Power
    for i in range(len(add_power)):
        r_lines.insert(line_power_100, add_power[len(add_power)-1-i])

    # Outlet Pressure
    for i in range(len(add_pressureoutlet)):
        r_lines.insert(line_pressureoutlet_100, add_pressureoutlet[len(add_pressureoutlet)-1-i])

    # Inlet Pressure
    for i in range(len(add_pressureinlet)):
        r_lines.insert(line_pressureinlet_100, add_pressureinlet[len(add_pressureinlet)-1-i])

    # ALLUNGO LA SIMULAZIONE AGGIUNGENDO LA CARD 204
    r_lines.insert(38, "204     {}     1.e-8   0.05   00003   10    10    10\n".format(t_fin+delta_trans))


    # SCRIVO FILE
    w_file = open(r'lambda_{}\input.i'.format(l), 'w')
    w_file.writelines(r_lines)
    w_file.close()
