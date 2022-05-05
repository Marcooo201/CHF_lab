def modify_RELAP_parameter(parameter, filepath):
# La funzione prende in input un dictionary (parameter) con indicate le seguenti informazioni
# ("name", "line", "word", "initial_value", "final_value"). La funzione identifica il valore cercato,
# verifica che il valore trovato sia uguale a quello indicato nel dict (misura di sicurezza), modificar
# il valore con quello indicato e riscrive il file.

    # APRO FILE
    r_file = open(filepath, 'r')
    lines = r_file.readlines()
    target_line = lines[parameter['line']-1]

    words = target_line.split()

    # Controllo che il valore sia quello indicato
    target_word = words[parameter['word']]
    if target_word != str(parameter['initial_value']):
        print('ERRORE: il parametro {nome} (line: {line}, word: {word}, initial_value: {init_val}) rilevato non corrisponde al valore iniziale indicato (valore_rilevato: {real_val})'.format(nome=parameter['name'], line=parameter['line'], word = parameter['word'], init_val=parameter['initial_value'], real_val=target_word))
        return

    # Cambio la word target
    words[parameter['word']] = str(parameter['final_value'])

    # SCRIVO FILE
    w_file = open(filepath, 'w')
    words.append("\n")
    lines[parameter['line']-1] = " ".join(words)
    w_file.writelines(lines)
    w_file.close()

    return
