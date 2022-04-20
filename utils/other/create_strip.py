######################################
#                 INPUT              #
######################################

vol_vars = ['p', 'tempf', 'tempv', 'tempv']
jun_vars = []

CCC = '555'
nv = 50
nj = nv-1
initial_card = 1001




####################### INTRO #######################

f = open('input_strip.i', 'w+')

f.write("=strip_input \n \n")
f.write("0000100 strip fmtout \n")
f.write("103 0 \n \n \n")


#####################################################

VV = [str(vn).zfill(2) for vn in list(range(1,nv+1))]
JJ = [str(jn).zfill(2) for jn in list(range(1,nj+1))]

volumes = [CCC+vn+"0000" for vn in VV]
junctions = [CCC+jn+"0000" for jn in JJ]

card = initial_card
strip_lines = []

############## WRITES VOLUME VARIABLES ##############
for var in vol_vars:
    for v in volumes:
        strip_lines.append(str(card)+" "+var+" "+v+"\n")
        card = card+1
    strip_lines.append("* \n* \n")

############## WRITES JUNCTION VARIABLES ############
for var in jun_vars:
    for j in junctions:
        strip_lines.append(str(card)+" "+var+" "+j+"\n")
        card = card+1
    strip_lines.append("* \n* \n")

strip_lines.append(".")

# Writes lines on actual file
f.writelines(strip_lines)
