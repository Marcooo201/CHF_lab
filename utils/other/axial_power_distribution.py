# Suppongo che la distribuzione della densità di potenza sia q = q_max * cos(x*pi/L)
# In questo caso si calcola facilmente che q_max = q_avg * pi / 2

# Inoltre si calcola che la media integrale tra due punti arbitrari a e b è
# q_avg_ab = (L*q_avg / 2*H) * [ sin(pi*b/L) - sin(pi*a/L)]

import numpy as np

nvt = 50
nv = 48
L = 3.658

nn = nv+1
H = L/nv

nodes = np.linspace(-L/2,L/2,nn)

factors = np.empty(nv)

for i in range(len(nodes)-1):
    a = nodes[i]
    b = nodes[i+1]
    factors[i] = (nv/2)*(np.sin(b*np.pi/L) - np.sin(a*np.pi/L))

factors = factors/nv


f = open('relap_distribution_input.txt', 'w+')

for i, factor in enumerate(factors):
    line = str(15550701+i)+"    888    "+str(factor)[:11]+"     0.     0.     "+str(1+i)+"\n"
    f.write(line)

for i in range(nvt-nv):
    line = str(15550701+len(factors)+i)+"    888    "+"0.000000000"+"     0.     0.     "+str(nv+1+i)+"\n"
    f.write(line)
