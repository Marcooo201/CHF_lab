#############################
#    VARIABLES TO STRIP     #
#############################

p = True
tempf = True

f = open('input_strip.i', 'w+')    # Se volessi appendere alla fine del file senza sostituire userei 'a'


#############################
#            INTRO          #
#############################

f.write("=strip_input \n \n")
f.write("0000100 strip fmtout \n")
f.write("103 0 \n \n \n")


####################
nv = 50
nj = nv-1


#############################
#              P            #
#############################
CCC = "555"
initial_card_p = 1001
VV = [str(vn).zfill(2) for vn in list(range(1,nv+1))]
JJ = [str(jn).zfill(2) for jn in list(range(1,nj+1))]

volumes = [CCC+vn+"0000" for vn in VV]
junctions = [CCC+jn+"0000" for jn in JJ]

i=0
strip_lines_p = []
for v in volumes:
    strip_lines_p.append(str(initial_card_p+i)+" p "+v+"\n")
    i=i+1


f.writelines(strip_lines_p)
f.write("* \n* \n")



#############################
#           tempf           #
#############################
CCC = "555"
initial_card_tempf = 1051
VV = [str(vn).zfill(2) for vn in list(range(1,nv+1))]
JJ = [str(jn).zfill(2) for jn in list(range(1,nj+1))]

volumes = [CCC+vn+"0000" for vn in VV]
junctions = [CCC+jn+"0000" for jn in JJ]

i=0
strip_lines_tempf = []
for v in volumes:
    strip_lines_tempf.append(str(initial_card_tempf+i)+" tempf "+v+"\n")
    i=i+1


f.writelines(strip_lines_tempf)
f.write("* \n* \n")



f.write(".")
