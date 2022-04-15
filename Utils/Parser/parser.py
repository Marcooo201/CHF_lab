import numpy as np

f = open('stripf', 'r')

data = f.read() #stringa contenente tutto il file

split = data.split('plotrec         ')

head = split[0]
body = split[1:]


#########################
#         HEAD          #
#########################
parti = head.split('plotnum          0')
comp_part = parti[1]
components = comp_part.split()
components.insert(0, "")

# VARIABLES
var_part = parti[0]
var_part = var_part.split('plotalf   ')
var_part = var_part[1]
variables = var_part.split()

# HEADER
header = [variables[i]+" "+components[i] for i in range(0,len(variables))]
header = ', '.join(header)


#########################
#         BODY          #
#########################

n_rows = len(body)
n_cols = len(body[0].split("   "))
matrix = np.empty((n_rows,n_cols))

for i, rec in enumerate(body):
    matrix[i,:] = rec.split("   ")

matrix = np.array(matrix, dtype=np.float32)



#########################
#         CSV           #
#########################

np.savetxt('data.csv', matrix, delimiter=', ', fmt='%.6e', header=header)
