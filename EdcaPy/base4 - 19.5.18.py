import math
from random import random,seed

def b4(x): #convierte el numero en la regla de 9 dígitos
    b=[]
    a=format(x,'0>18b')
    for i in range(0,17,2):
        b.append(int(a[i])*2+int(a[i+1]))
    b.reverse() 
    return tuple(b)  
def ruleSum(r1,r2):
    a=((0,0,3,3),(0,1,2,3),(3,2,2,3),(3,3,3,3))
    return a[r1][r2]
def ruleNum(ruleDigits): #convierte la regla de 9 dígitos en número
    a=0
    for i in range(0,9):
        a+=ruleDigits[i]*4**i
    return a

def Atan2(opp,adj): #Determina el angulo dadas las coordenadas
    # Get the basic angle.
    if abs(float(adj)) < 0.0000000001:
        angle = math.pi / 2
    else:
        angle = abs(math.atan(float(opp) / float(adj)))
    if adj < 0: #See if we are in quadrant 2 or 3.
        angle = math.pi - angle #angle > PI/2 or angle < -PI/2.
    if opp < 0: #See if we are in quadrant 3 or 4.
        angle = 2 * math.pi - angle
        #Return the result.
    return math.degrees(angle)

def Angle360(alpha):
    if alpha > 180:
        return alpha - 360
    else:
        if alpha < -180:
            return alpha + 360
        else:
            return alpha
def cellUpdate(valorActual,count,r): #r es la regla en 9 digitos
    modif=((0,0,1,1),(-1,0,0,-1))
    return modif[valorActual][r[count]] #devuelve -1,0,1 

def abrir(archivo,ruleList,lattice,quanta): #get data from file
    f=open(archivo,'r')
    linea=f.readline()
    while not linea=="":
        if "B" in linea:
            linea=f.readline()
            x,y,n=linea.strip("\n").split(",")
            for i in range(int(n)):
                linea=f.readline().strip("\n")
                for j,v in enumerate(linea):
                    if int(v)!=0: lattice.addCell((int(x)+i,int(y)+j),int(v),0)
        elif "Q" in linea:
            q,n=linea.strip("\n").split(",")
            for i in range(int(n)):
                regla,origx,origy,valor,r0,r1,spin,prior=f.readline().strip("\n").split(",") 
                quanta.addQuantum(int(regla),(int(origx),int(origy)),int(valor),int(r0),int(r1),int(spin),int(prior),ruleList)
        elif "R" in linea: #Random block
            x,y,alto,largo,density=f.readline().strip("\n").split(",")
            seed()
            for i in range(int(alto)):
                for j in range(int(alto)):
                    if float(density)>random(): lattice.addCell((int(x)+i,int(y)+j),1,0)
        linea=f.readline()
    f.close()
    

class rules:
    """
    Esta clase mantiene la lista de reglas usadas en el modelo
    el metodo addRuleShort(x) adiciona la regla con numero x
    addRuleLong(x) adiciona la regla a partir de la tupla de nueve digitos x
    total es la regla totalizadora
    """
    def __init__(self):
        self.reglas={}
        self.total=(1,1,1,1,1,1,1,1,1)
    def addRuleShort(self,ruleNumber):
        if not ruleNumber in self.reglas:
            c=b4(ruleNumber)
            self.reglas[ruleNumber]=c
            b=[]
            for digito in range(0,9):
                b.append(ruleSum(self.total[digito],c[digito]))
            self.total=tuple(b)    
    def addRuleLong(self,ruleDigits):
        c=ruleNum(ruleDigits)
        if not c in self.reglas:
            self.reglas[c]=ruleDigits
            b=[]
            for digito in range(0,9):
                b.append(ruleSum(self.total[digito],ruleDigits[digito]))
            self.total=tuple(b)  

class quantum:
    """
    Esta clase implementa el objeto quantum (spot)
    """
    def __init__(self,regla,orig,valor,r0,r1,spin,prior):
        self.regla=regla
        self.origen=orig
        self.valor=valor
        self.r0=r0
        self.r1=r1
        self.spin=spin
        self.prior=prior
        self.longevity=0
        pass

    def cZone(self):
        d0=self.r1+self.longevity*self.r0 #radio interior
        d1=self.r1+(self.longevity+1)*self.r0 #radio exterior
        return d0,d1

    def covered(self,c): #Permite seleccionar las celdas cubiertas por el quantum, c-tupla de coordenadas de la celda
        x,y=c
        z0,z1=self.cZone()
        qx,qy=self.origen
        return ((abs(x-qx)>z0) or (abs(y-qy)>z0)) and (abs(x-qx)<=z1) and (abs(y-qy)<=z1)

    def enabled(self,c,cellObject,lattice,myRegla):
        return (cellUpdate(cellObject.valor,lattice.contarVecinos(c),myRegla)==self.valor) and not cellObject.seen
    
    def forward(self): #Cuando el quantum no modifica celda y sigue expandiéndose
        self.longevity+=1

    def restart(self,c): #Cuando el quantum es modificado en la celda c
        self.longevity=0
        self.origen=c
        self.valor *=-1

    def orden(self,c): #Crea llave para odenar las celdas cubiertas por el quantum, c-tupla de coordenadas de la celda
        x,y=c
        cx,cy=self.origen
        dx=x-cx
        dy=y-cy
        difdir = Atan2(dy, dx) - self.spin
        #dif1 = Angle360(difdir)
        difdir = abs(difdir)
        if difdir > 180: difdir= 360 - difdir
        return difdir

    def procesarCeldas1(self,lasCeldas,ruleList): #recibe el diccionario de celdas en lasCeldas y la lista de reglas
        myRegla=ruleList.reglas[self.regla]
        a={k:v for (k,v) in lasCeldas.grid.items() if self.covered(k) if self.enabled(k,v,lasCeldas,myRegla)}
        if not a=={}:
            if self.valor==1:
                coord,objetoCelda=min(a.items(),key=lambda x: self.orden(x[0]))
            else:
                coord,objetoCelda=max(a.items(),key=lambda x: self.orden(x[0]))        
            objetoCelda.valor_nuevo=objetoCelda.valor+self.valor
            objetoCelda.seen=1
            self.restart(coord)
        else:
            self.forward()

class celda:
    """
    Esta clase implementa el objeto celda
    """
    def __init__(self,valor,gravity):
        self.valor=valor # [0,1]
        self.valor_nuevo=self.valor
        self.seen=0
        self.gravity=gravity # integer codifies cell's priority
        pass   

class CellSpace:
    """
    Define el espacio de celdas
    """
    def __init__(self):
        self.grid={}  
    
    def addCell(self,c,v,g):    
        self.grid[c]=celda(v,g)
    
    def newBornCandidates(self):
        newCells={}
        for coords in self.grid: #asumiendo que solo quedan las vivas en el diccionario grid
            x,y=coords
            for i in range(-1,2):
                for j in range(-1,2):
                    if (i or j) and (not (x+i,y+j) in self.grid): newCells[(x+i,y+j)]=celda(0,0)
        self.grid.update(newCells)                
        newCells.clear()

    def actualiza(self):
        d=list(self.grid.keys())
        for i in d:
            self.grid[i].valor=self.grid[i].valor_nuevo
            self.grid[i].seen=0
            if self.grid[i].valor==0: del self.grid[i] 
        d.clear()         
    
    def contarVecinos(self,c): #Optimizar: usar comprehension
        #return len([(i,j) for i in range(-1,2) for j in range(-1,2) if (i or j) and (x+i,y+j) in self.grid])
        x,y=c
        suma=0
        for i in range(-1,2):
            for j in range(-1,2):
                if i or j:
                    try:
                        suma+=self.grid[x+i,y+j].valor
                    except KeyError:
                        pass
        return suma


class qSpace:
    """
    Define el conjunto de quanta
    """
    def __init__(self):
        self.quanta=[] 
   
    def addQuantum(self,r,orig,v,r0,r1,s,p,ruleList):
        self.quanta.append(quantum(r,orig,v,r0,r1,s,p))
        ruleList.addRuleShort(r)

        
