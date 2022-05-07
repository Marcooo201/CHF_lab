import numpy as np

###########################################################################
#                                                                         #
#                    INTERACTION WITH RELAP FILES                         #
#                                                                         #
###########################################################################


def modify_RELAP_parameter(parameter, filepath):
# La funzione prende in input un dictionary (parameter) con indicate le seguenti informazioni
# ("name", "line", "word", "initial_value", "final_value", "table_rep"). La funzione identifica il valore cercato,
# modifica il valore con quello indicato e riscrive il file.

    # APRO FILE
    r_file = open(filepath, 'r')
    lines = r_file.readlines()

    target_line = lines[parameter['line']-1]
    words = target_line.split()

    # CAMBIO LA TARGET WORD
    words[parameter['word']] = str(parameter['final_value'])
    words.append("\n")
    lines[parameter['line']-1] = "   ".join(words)

    if parameter['table_rep']: # caso in cui ho una tabella temporale
        target_line_t = lines[parameter['line']]
        words_t = target_line_t.split()
        words_t[parameter['word']] = str(parameter['final_value'])
        words_t.append("\n")
        lines[parameter['line']] = "   ".join(words_t)

    # SCRIVO FILE
    w_file = open(filepath, 'w')
    w_file.writelines(lines)
    w_file.close()

    return






###########################################################################
#                                                                         #
#                               CORRELATIONS                              #
#                                                                         #
###########################################################################


def CHF_W3(p, x_e, m_dot, h_f, q, A, D_e, L):
# W-3 CHF CORRELATION
#
# INPUTS:
#       - p     [Pa]
#       - x_e           : equilibrium quality (quale)
#       - m_dot [kg/s]  : mass flow rate (mflowj)
#       - h_f   [J/kg]  : specific sat fluid enthalpy (sathf)
#       - q     [W/m^2] : heat flux (htrnr)
#       - A     [m^2]   : flow cross section area
#       - D_e   [m]     : hydraulic disameter
#       - L     [m]     : total lenght of the channel
#
# OUTPUT:
#       - CHF [kW/m^2]
#
#
    # convert input lists to numpy arrays
    p = np.array(p)
    x_e = np.array(x_e)
    h_f = np.array(h_f)
    q = np.array(q)

    # convert variables to desired units
    p = p/1000000
    h_f = h_f/1000

    # compute derived variables
    G = m_dot/A
    delta_Z = L/50
    Z = np.linspace(delta_Z/2, L - delta_Z/2, 50)
    h_in = h_f[0]

    ##########################
    #   Compute uniform CHF  #
    ##########################

    M1 = (2.022-0.06238*p) + (0.1722 - 0.01427*p)*np.exp((18.177 - 0.5987*p)*x_e)
    M2 = (0.1484 - 1.596*x_e + 0.1729*x_e*abs(x_e))*2.326*G + 3271
    M3 = 1.157 - 0.869*x_e
    M4 = 0.2664 + 0.8357*np.exp(-124.1*D_e)
    M5 = 0.8258 + 0.0003413*(h_f - h_in)

    CHF_uniform = M1 * M2 * M3 * M4 * M5

    ##########################
    #   Compute factor  F    #
    ##########################

    # Compute C
    C = 185.6*((1-x_e)**(4.31))/(G**0.478)

    # Compute denominator
    D = q*(1-np.exp(-C*Z))

    # Compute integral
    I = np.zeros([1,50])
    print("======================= DEBUG =========================")
    print("======================= DEBUG =========================")
    print("======================= DEBUG =========================")

    for i in range(Z.size):
        I_i = 0
        for j in range(i):
            I_i = I_i + q[j]*np.exp(-C[j]*(Z[i]-Z[j]))*delta_Z;
            print(-C[j]*(Z[i]-Z[j]))
        np.append(I, I_i)

    print("======================= DEBUG =========================")
    print("======================= DEBUG =========================")
    print("======================= DEBUG =========================")
    print('I: {}'.format(I))

    # Compute F
    F = C*I/D

    ##########################
    #     Compute   CHF      #
    ##########################
    CHF = CHF_uniform/F;

    return CHF
