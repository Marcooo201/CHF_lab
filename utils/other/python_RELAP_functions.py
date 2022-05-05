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
