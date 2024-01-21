import base4
lattice=base4.CellSpace()
ruleList=base4.rules()
quanta=base4.qSpace()
base4.abrir("d:/EdcaPy/prueba0.mex",ruleList,lattice,quanta)
for k,v in lattice.grid.items(): print(k,v.valor)
b=quanta.quanta    
for i,k in enumerate(b): 
    print(i,base4.b4(k.regla),k.valor,k.origen,k.spin)

for i in range(10):
    lattice.newBornCandidates()
    for k in b:
       k.procesarCeldas1(lattice,ruleList)
    lattice.actualiza()
    for k,v in lattice.grid.items(): print(k,v.valor)
    for i,k in enumerate(b): 
        print(i,base4.b4(k.regla),k.valor,k.origen,k.spin)
