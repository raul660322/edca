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

def Opuesto(alpha):
    if alpha>=180:
        return alpha-180
    else:
        return alpha+180    

def cellUpdate(valorActual,count,r): #r es la regla en 9 digitos
    modif=((0,0,1,1),(-1,0,0,-1))
    return modif[valorActual][r[count]] #devuelve -1,0,1 

def abrir(archivo,ruleList,lattice,quanta,sensorList,timeLine): #get data from file
    temporal=0
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
                if spin=="r": #random spin
                    elSpin=int(random()*360)
                else:
                    elSpin=int(spin)    
                quanta.addQuantum(int(regla),(int(origx),int(origy)),int(valor),int(r0),int(r1),elSpin,int(prior),ruleList)
        elif "R" in linea: #Random block
            if temporal:
                try:
                    lat=timeLine[temporal,"celda"] #Se almacenan temporalmente las celdas
                except KeyError:    
                    timeLine[temporal,"celda"]=CellSpace()
                    lat=timeLine[temporal,"celda"] #Se almacenan temporalmente las celdas
            else:    
                lat=lattice
            if "R+" in linea:  #Random block extended
                nada,tipo_bloque=linea.strip("\n").split(",")
                if tipo_bloque=="rectangle":
                    x,y,alto,largo,density=f.readline().strip("\n").split(",")
                    x1,y1,alto1,largo1=f.readline().strip("\n").split(",")
                    seed()
                    for i in range(int(alto)):
                        for j in range(int(largo)):
                            if not ((i+int(x)-int(x1) in range(int(alto1))) and (j+int(y)-int(y1) in range(int(largo1)))):
                                if float(density)>random(): lat.addCell((int(x)+i,int(y)+j),1,0)

                else: #circle
                    x,y,r,r1,density=f.readline().strip("\n").split(",")
                    for i in range(-int(r),int(r)):
                        coordX=i+int(x)
                        y1=int(math.sqrt(float(r)*float(r)-float(i)*float(i)))
                        if i in range(-int(r1),int(r1)):
                            y2=int(math.sqrt(float(r1)*float(r1)-float(i)*float(i)))
                        else: 
                            y2=0    
                        for j in range(-y1,y1):
                            if not ((i in range(-int(r1),int(r1))) and (j in range(-y2,y2))):
                                coordY=int(y)+j
                                if float(density)>random(): lat.addCell((coordX,coordY),1,0)
            else:    
                x,y,alto,largo,density=f.readline().strip("\n").split(",")
                seed()
                for i in range(int(alto)):
                    for j in range(int(largo)):
                        if float(density)>random(): lat.addCell((int(x)+i,int(y)+j),1,0)
        elif "M" in linea: #Gravity
            linea1=f.readline().strip("\n").split(",")
            try:
                x,y,fuerza, resolution=linea1
            except ValueError:
                x,y,fuerza=linea1   
                resolution=0.0 
            lattice.setGravity(float(fuerza),float(resolution),(int(x),int(y)))
            pass
        elif "S" in linea: #Sensor
            if "Spots by index" in linea: #Registra estado de spots individuales
                sensorList.addSensor(sensor("Spots by index",tuple(f.readline().strip("\n").split(","))))
                pass   
            elif "Temperatura" in linea: #Numero de transiciones en un area especifica
                pass  
        elif "E" in linea: #Block of ramdomly distributed spots whith given density
            if temporal:
                try:
                    qua=timeLine[temporal,"spot"] #Se almacenan temporalmente los spots
                except KeyError:
                    timeLine[temporal,"spot"]=qSpace()
                    qua=timeLine[temporal,"spot"]
            else:    
                qua=quanta
            if "E+" in linea: #Enchanced block of spots
                nada,nx,ny,densidad, tipo_bloque=linea.strip("\n").split(",")
                if tipo_bloque=="rectangle":
                    regla,origx,origy,valor,r0,r1,spin,prior=f.readline().strip("\n").split(",")
                    x1,y1,alto1,largo1=f.readline().strip("\n").split(",")
                    cx=int(origx)+int(nx)/2
                    cy=int(origy)+int(ny)/2
                    for i in range(int(nx)):
                        for j in range(int(ny)):
                            if not ((i+int(origx)-int(x1) in range(int(alto1))) and (j+int(origy)-int(y1) in range(int(largo1)))):
                                if float(densidad)>random():
                                    if spin=="r": #random spin
                                        elSpin=int(random()*360)
                                    if spin=="r": #random spin
                                        elSpin=int(random()*360)
                                    elif "f" in spin: #focused at center   
                                        dx=cx-coordX 
                                        dy=cy-coordY 
                                        try:
                                            elSpin=Atan2(dy,dx)+int(spin[1:])
                                        except ValueError:
                                            elSpin=Atan2(dy,dx)    
                                    else:
                                        elSpin=int(spin)    
                                    qua.addQuantum(int(regla),(int(origx)+i,int(origy)+j),int(valor),int(r0),int(r1),elSpin,int(prior),ruleList)
                else: #circle
                    regla,origx,origy,valor,r0,r1,spin,prior=f.readline().strip("\n").split(",")
                    radioExt,radioInt=int(nx),int(ny)
                    cx,cy=int(origx),int(origy)
                    for i in range(-radioExt,radioExt):
                        coordX=i+cx
                        y1=int(math.sqrt(float(radioExt)*float(radioExt)-float(i)*float(i)))
                        if i in range(-radioInt,radioInt):
                            y2=int(math.sqrt(float(radioInt)*float(radioInt)-float(i)*float(i)))
                        else: 
                            y2=0    
                        for j in range(-y1,y1):
                            if not ((i in range(-radioInt,radioInt)) and (j in range(-y2,y2))):
                                coordY=cy+j
                                if float(densidad)>random():
                                    if spin=="r": #random spin
                                        elSpin=int(random()*360)
                                    elif "f" in spin: #focused at center   
                                        dx=cx-coordX 
                                        dy=cy-coordY 
                                        try:
                                            elSpin=Atan2(dy,dx)+int(spin[1:])
                                            if elSpin>=360:
                                                elSpin-=360
                                        except ValueError:
                                            elSpin=Atan2(dy,dx)    
                                    else:
                                        elSpin=int(spin)    
                                    qua.addQuantum(int(regla),(coordX,coordY),int(valor),int(r0),int(r1),elSpin,int(prior),ruleList)
            else:    
                q,nx,ny,densidad=linea.strip("\n").split(",")
                regla,origx,origy,valor,r0,r1,spin,prior=f.readline().strip("\n").split(",")
                for i in range(int(nx)):
                    for j in range(int(ny)):
                        if float(densidad)>random():
                            if spin=="r": #random spin
                                elSpin=int(random()*360)
                            else:
                                elSpin=int(spin)    
                            qua.addQuantum(int(regla),(int(origx)+i,int(origy)+j),int(valor),int(r0),int(r1),elSpin,int(prior),ruleList)
        elif "F" in linea: #Fill gravity field
            nada,x,y,tipo_bloque,modo,radio,fuerza,densidad=linea.strip("\n").split(",")
            #x,y-centro, tipo_bloque-cuadrado, circulo, modo-centrado o uniforme,
            #fuerza:diferencia promedio entre celdas contiguas, 
            #densidad-probabilidad de existencia de valor en una celda
            factor=float(radio)*float(fuerza)
            for i in range(-int(radio),int(radio)):
                coordX=i+int(x)
                if tipo_bloque=="rectangle":
                    y1=int(radio)
                else:
                    y1=int(math.sqrt(float(radio)**2-float(i)**2)) #circle
                for j in range(-y1,y1):
                    if random()<float(densidad):
                        coordY=j+int(y)
                        if modo=="u": #uniforme
                            valor_de_campo=factor*random()
                        else: #centrado
                            try:
                                valor_de_campo=float(fuerza)*(float(radio)-math.sqrt(float(i)**2+float(j)**2))  
                            except ZeroDivisionError:
                                valor_de_campo=100000000.0    
                        lattice.createField((coordX,coordY),valor_de_campo)
        elif "T" in linea:
            nada,temp=linea.strip("\n").split(",")
            temporal=int(temp)
        linea=f.readline()
    f.close()

def doStep(lattice,quanta,ruleList,gauges,timed,paso):
    gauges.addData(quanta,lattice,paso)
    #Inicio de un step del CA
    lattice.newBornCandidates(ruleList)
    celdas,newBorns=lattice.grid.copy(),lattice.newBorns.copy()
    for k in quanta.quanta:
        k.procesarCeldas2(lattice,celdas,newBorns,ruleList)
    lattice.actualiza()
    #Fin del step
    #Agregar elementos temporales
    try:
        lattice.addFromTimeLine(timed[paso,"celda"].grid)
    except KeyError:
        pass
    try:
        quanta.addFromTimeLine(timed[paso,"spot"].quanta)
    except KeyError:
        pass

class sensor:
    """
    Define un sensor
    """
    def __init__(self,elTipo,losDatos):
        self.tipo=elTipo
        self.datos=losDatos
        
class SensorSpace:
    """
    Define conjunto de sensores
    """
    def __init__(self):
        self.sensors=[]
        self.headers=["T"]
        self.cols=[]
        self.cols.append(list([]))

    def addSensor(self,elSensor):
        self.sensors.append(elSensor)
        if elSensor.tipo=="Spots by index":
            for sp in elSensor.datos:
                self.headers.append("s"+str(sp)+"_X")
                self.headers.append("s"+str(sp)+"_Y")
                self.headers.append("s"+str(sp)+"_V")
                self.headers.append("s"+str(sp)+"_L")
                for i in range(0,4):
                    self.cols.append(list([]))
        elif elSensor.tipo=="Temperatura": 
            pass 

    def addData(self,quantaList,cellList,paso):
        columna=0
        self.cols[columna].append(paso)
        for s in self.sensors:
            if s.tipo=="Spots by index":
                for spx in s.datos:
                    sp=int(spx)
                    columna+=1
                    self.cols[columna].append(quantaList.quanta[sp].origen[0])
                    columna+=1
                    self.cols[columna].append(quantaList.quanta[sp].origen[1])
                    columna+=1
                    self.cols[columna].append(quantaList.quanta[sp].valor)
                    columna+=1
                    self.cols[columna].append(quantaList.quanta[sp].longevity)
            elif s.tipo=="Temperatura": 
                pass 

    def outputData(self,fichero):
        f = open(fichero, 'w')
        for h in self.headers:
            f.write(h+" ")
        f.write("\n")  
        filas=len(self.cols[0]) 
        for laFila in range(0,filas):
            for c in self.cols:
                f.write(str(c[laFila])+" ")  
            f.write("\n")
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
        self.prior=prior #Will be used as the gravitation field resolution for the given zone
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

    def enabled(self,cellObject,myRegla):
        if cellObject:
            return (cellUpdate(cellObject.valor,cellObject.cuenta,myRegla)==self.valor) and not cellObject.seen
        else:    
            return False    
    
    def forward(self): #Cuando el quantum no modifica celda y sigue expandiéndose
        self.longevity+=1

    def restart(self,c): #Cuando el quantum es modificado en la celda c
        #self.torcerSpin(c)
        self.longevity=0
        self.origen=c
        self.valor *=-1
        

    def followG(self,ini,fin,cini,cfin,fuerza):
        #El spin se tuerce 1 grado en direccion del mayor valor del campo
        dif=int(cfin-cini)
        if not (dif==0):
            x,y=ini
            cx,cy=fin
            dx=cx-x
            dy=cy-y    
            if random()<fuerza*float(cfin):
            #if random()<=1:
                difdir = int((Atan2(dy, dx) - self.spin))
                if difdir>360: difdir=difdir-360
                if difdir<-360: difdir=difdir+360
                if difdir<0: difdir=difdir+360        
                #print(Atan2(dy, dx))
                if difdir<180:
                    signo=1
                elif difdir>180:
                    signo=-1  
                elif difdir==180:
                    if random()>0.5:
                        signo=1
                    else:
                        signo=-1
                if difdir==0: signo=0    
                #print(dif)  
                #self.spin=self.spin+signo*abs(dif)
                self.spin=self.spin+signo
                #if (self.spin>=360) or (self.spin<0): self.spin=int(Atan2(dy, dx))
                if (self.spin>=360): self.spin-=360
                if self.spin<0: self.spin=360+self.spin    
                #print(self.spin)
                #print(difdir)

    #Crea llave para odenar las celdas cubiertas por el quantum, c-tupla de coordenadas de la celda
    #esta llave da la diferencia de angulo entre el spin y la direccion de la celda.
    def orden(self,c): 
        x,y=c
        cx,cy=self.origen
        dx=x-cx
        dy=y-cy
        difdir = Atan2(dy, dx) - self.spin
        #dif1 = Angle360(difdir)
        difdir = abs(difdir)
        if difdir > 180: difdir= 360 - difdir
        return difdir
    
    def procesarCeldas1(self,lasCeldas,celdas,newBorns,ruleList): #recibe el diccionario de celdas en lasCeldas y la lista de reglas
        myRegla=ruleList.reglas[self.regla]
        if self.valor==1:
            cell_List=newBorns
        else:
            cell_List=celdas
        #g={k:v for (k,v) in lasCeldas.campo.items() if self.covered(k)}    
        #b={k:v for (k,v) in cell_List.items() if self.covered(k)}
        a={k:v for (k,v) in cell_List.items() if self.covered(k) and self.enabled(v,myRegla)}
        if not a=={}:
            if self.valor==1:
                coord,objetoCelda=min(a.items(),key=lambda x: self.orden(x[0]))
            else:
                coord,objetoCelda=max(a.items(),key=lambda x: self.orden(x[0]))   
            objetoCelda.valor_nuevo=objetoCelda.valor+self.valor
            objetoCelda.seen=1
            lasCeldas.increaseField(coord,self.prior)
            inicio=self.origen
            self.restart(coord)
            coord1,objetoCelda1=max(a.items(),key=lambda x: lasCeldas.getField(x[0])) #determina la celda con mayor valor de campo
            self.followG(inicio,coord1,lasCeldas.getField(inicio),lasCeldas.getField(coord1),lasCeldas.gForce) #Torcer spin hacia el centro G
            del cell_List[coord]
            #print(lasCeldas.getField(inicio),lasCeldas.getField(coord1))
        else:
            self.forward()

    def procesarCeldas2(self,lasCeldas,celdas,newBorns,ruleList): #recibe el diccionario de celdas en lasCeldas y la lista de reglas
        if self.longevity<50:
            myRegla=ruleList.reglas[self.regla]
            if self.valor==1:
                cell_List=newBorns
            else:
                cell_List=celdas
            #g={k:v for (k,v) in lasCeldas.campo.items() if self.covered(k)}    
            #b={k:v for (k,v) in cell_List.items() if self.covered(k)}
            z0,z1=self.cZone()
            qx,qy=self.origen

            #seleccion=[(x+qx,y+qy) for x in range(-z1,z1+1) for y in range(-z1,z1+1) if not ((x in range(-z0,z0+1)) and (y in range(-z0,z0+1)))]
            seleccion=[(x+qx,y+qy) for x in range(-z1,z1+1) for y in range(-z1,-z0)]
            seleccion+=[(x+qx,y+qy) for x in range(-z1,z1+1) for y in range(z0+1,z1+1)]
            seleccion+=[(x+qx,y+qy) for x in range(-z1,-z0) for y in range(-z0,z0+1)]
            seleccion+=[(x+qx,y+qy) for x in range(z0+1,z1+1) for y in range(-z0,z0+1)]
            #a={k:cell_List.get(k) for k in seleccion if cell_List.get(k)}
            #a={k:v for (k,v) in cell_List.items() if self.covered(k) and self.enabled(v,myRegla)}
            a={k:cell_List.get(k) for k in seleccion if self.enabled(cell_List.get(k),myRegla)}
            if not a=={}:
                if self.valor==1:
                    coord,objetoCelda=min(a.items(),key=lambda x: self.orden(x[0]))
                else:
                    coord,objetoCelda=max(a.items(),key=lambda x: self.orden(x[0]))   
                objetoCelda.valor_nuevo=objetoCelda.valor+self.valor
                objetoCelda.seen=1
                lasCeldas.increaseField(coord,self.prior)
                inicio=self.origen
                self.restart(coord)
                coord1,objetoCelda1=max(a.items(),key=lambda x: lasCeldas.getField(x[0])) #determina la celda con mayor valor de campo
                self.followG(inicio,coord1,lasCeldas.getField(inicio),lasCeldas.getField(coord1),lasCeldas.gForce) #Torcer spin hacia el centro G
                del cell_List[coord]
                #print(lasCeldas.getField(inicio),lasCeldas.getField(coord1))
            else:
                self.forward()
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
        self.cuenta=0
        self.gravity=gravity # integer codifies cell's priority, por ahora no se usa
        pass   

class CellSpace:
    """
    Define el espacio de celdas
    """
    def __init__(self):
        self.grid={}  
        self.newBorns={}
        self.campo={}
        self.gForce=0 #Amplifica el efecto de torsión gravitatoria sobre el spin
        self.gRes=0 #Diferencia de valor de campo entre celdas contiguas para la generación del campo
                    #Cada vez que se invoque el metodo increaseField, el valor del campo en la celda
                    #aumentará en el valor de gRes
                    #Por ahora no se usará, en su lugar se usará el campo quantum.prior.
        self.gCenter=(0,0)

    def addCell(self,c,v,g):    
        self.grid[c]=celda(v,g)
        #self.campo[c]=0.0  campo gravitacional escalar, registra la cantidad de cambios de estado de la celda c

    def increaseField(self,point,res):
        try:
            self.campo[point]+=res
        except KeyError:
            self.campo[point]=res

    def createField(self,point,value):
        self.campo[point]=value

    def getField(self,point):
        try:
            return self.campo[point]
        except KeyError:
            return 0.0

    def enabled_to_1(self,cellObject,myRegla):
        return (cellUpdate(cellObject.valor,cellObject.cuenta,myRegla)==1)
    
    def setGravity(self,f,r,c):
        self.gForce=f
        self.gCenter=c
        self.gRes=r

    def gravityFunction(self,coords):
        x=coords[0]-self.gCenter[0]
        y=coords[1]-self.gCenter[1]
        r=math.sqrt(x*x+y*y)
        try:
            return (1-random()*0.2)/math.sqrt(r)
        except ZeroDivisionError:
            return 9999999.9    

    def newBornCandidates(self,rulelist):
        #Crea las nuevas posibles celdas a nacer, calcula la cantidad de vecinos para las celdas existentes y las
        #nuevas
        #La cantidad de vecinos se obtiene indirectamente por las veces que la celda dada es referenciada por sus vecinos
        newCells={}
        for coords in self.grid: #asumiendo que solo quedan las vivas en el diccionario grid
            x,y=coords
            for i in range(-1,2):
                for j in range(-1,2):
                    if (i or j):
                        try: 
                            self.grid[(x+i,y+j)].cuenta+=1
                        except KeyError:    
                            try:
                                newCells[(x+i,y+j)].cuenta+=1
                            except KeyError:
                                a=celda(0,0)
                                a.cuenta=1
                                newCells[(x+i,y+j)]=a
        #self.grid.update(newCells)                
        #newCells.clear()
        myRegla=rulelist.total
        #Devuelve en la lista de newBorns solo las celdas habilitadas para nacer según la regla totalizadora
        self.newBorns=dict(filter(lambda x: self.enabled_to_1(x[1],myRegla),newCells.items()))

    def actualiza(self):
        self.grid.update(dict(filter(lambda x: x[1].valor_nuevo==1,self.newBorns.items())))
        d=list(self.grid.keys())
        for i in d:
            self.grid[i].valor=self.grid[i].valor_nuevo
            self.grid[i].seen=0
            self.grid[i].cuenta=0
            if self.grid[i].valor==0: del self.grid[i] 
        d.clear()         
    
    def contarVecinos(self,c): #Optimizar: usar comprehension--Ojooooo:No se usa--
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

    def addFromTimeLine(self,celdas):
        self.grid.update(dict(celdas))

class qSpace:
    """
    Define el conjunto de quanta
    """
    def __init__(self):
        self.quanta=[] 
   
    def addQuantum(self,r,orig,v,r0,r1,s,p,ruleList):
        self.quanta.append(quantum(r,orig,v,r0,r1,s,p))
        ruleList.addRuleShort(r)

    def addFromTimeLine(self,spots):
        self.quanta+=list(spots)


        
