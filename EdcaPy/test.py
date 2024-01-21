from base4 import rules
laRegla=rules()
print(laRegla.__doc__)
for i in range(0,10):
    opcion=input("1-Corta, 2-Larga:")
    x=input("Teclee X:")
    if opcion=="1":
         laRegla.addRuleShort(int(x))
    else:
        b=[]
        for digito in x:
            b.append(int(digito))
        laRegla.addRuleLong(tuple(b))     
    print (laRegla.reglas)
    print(laRegla.total)
