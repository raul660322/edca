#include <bits/stdc++.h>
#include <math.h>
#include <windows.h>
#include <GL/glut.h>
using namespace std;
const double pi = 3.14159265358;

struct HASH{
    size_t operator()(const pair<int,int>&x)const{
        return ((long long)x.first)^(((long long)x.second)<<32);
    }
};

int* b4(int x) /*convierte el numero en la regla de 9 dígitos*/
{
    int* b;
    b=new int [9];
    int a=x;
    for (int i=0;i<9;i++)
        {
            int c=a%4;
            b[i]=c;
            a=int(a/4);
        }
    return b; 
} 


int Atan2(int opp,int adj) /*Determina el angulo dadas las coordenadas*/
{
    /*Get the basic angle.*/
    float angle;
    if (abs(float(adj)) < 0.0000000001)
        angle = pi/2;
    else
        angle = abs(atan(float(opp) / float(adj)));
    if (adj < 0) /*See if we are in quadrant 2 or 3.*/
        angle = pi - angle; /*angle > PI/2 or angle < -PI/2.*/
    if (opp < 0) /*See if we are in quadrant 3 or 4.*/
        angle = 2 * pi - angle;
        /*Return the result.*/
    return int(angle*180/pi);
}

int cellUpdate(int valorActual,int count, int r[9]) /*r es la regla en 9 digitos*/
{
    int modif[2][4]={{0,0,1,1},{-1,0,0,-1}};
    return modif[valorActual][r[count]]; /*devuelve -1,0,1 */
}

class rules{
private:

    int ruleNum(int ruleDigits[9]) /*convierte la regla de 9 dígitos en número*/
    {
        int a=0;
        for (int i=0;i<9;i++)
        {
            a+=ruleDigits[i]*pow(4,i);
        }
        return a;
    }

    unordered_map<int, string> reglas;

public:
    void addRuleShort(int ruleNumber)
    {
        int* v=b4(ruleNumber);
        string s;
        for (int i=0;i<9;i++) s+=to_string(v[i]);
        reglas[ruleNumber]=s;  
    }

    void addRuleLong(int ruleDigits[9])
    {
        int ruleNumber=ruleNum(ruleDigits);
        string s;
        for (int i=0;i<9;i++) s+=to_string(ruleDigits[i]);
        reglas[ruleNumber]=s;  
    }

    int* getRule(int x)
    {
        int* b;
        b=new int [9]; 
        string s=reglas[x];
        /*for (int i=0;i<9;i++) b[i]=int(s[i])-48;*/
        for (int i=0;i<9;i++) b[i]=stoi(s.substr(i,1));
        /*for (int i=0;i<9;i++) std::cout << b[i];*/
        return b;
    }
};

class Cell{
public:
    int valor;
    int valor_nuevo;
    int cuenta;
    bool seen;
    /*double gravity;*/
    Cell()
    {
        valor=0, valor_nuevo=0, cuenta=0, seen= false;   
    }
    Cell(int v,int c)
    {
        valor=v;
        cuenta=c;
        valor_nuevo=v;
        seen=false;
    }
};

class CellSpace{

public:
    unordered_map<pair<int,int>,Cell,HASH> living;
    unordered_map<pair<int,int>,Cell,HASH> newBorns;
    unordered_map<pair<int,int>,int,HASH> campo;

    void increaseField(pair<int,int> coord)
    {
        if (campo.find(coord)!= campo.end())
            campo[coord]++;
        else campo[coord]=1;
    }

    
    void addCell(int x,int y, int value, int cuenta)
        {
            living[make_pair(x,y)]=Cell(value,cuenta);
        }

    bool getCell(int x,int y, Cell& laCelda)
        {
            if (living.find(make_pair(x,y))!= living.end())
            {
                laCelda=living[make_pair(x,y)];
                return true;
            }
            else return false;
        }

    void incrementarCuenta(int x, int y)
        {
            if (living.find(make_pair(x,y))!= living.end())
            {
                living[make_pair(x,y)].cuenta++;
            }
            else if (newBorns.find(make_pair(x,y))!= newBorns.end())
                newBorns[make_pair(x,y)].cuenta++;
            else
                newBorns[make_pair(x,y)]=Cell(0,1);
        }

    void newBornCandidates()
    {
        newBorns.clear();
        for (auto const& pair: living)
        {
            int x=pair.first.first;
            int y=pair.first.second;
            for (int i=-1;i<2;i++)
                for (int j=-1;j<2;j++) 
                    if ((i!=0) || (j!=0))
                        incrementarCuenta(x+i,y+j);  
        }
    }  

    void actualiza()
    {
        /*living.insert(newBorns.begin(),newBorns.end());*/
        for (auto const& pair: newBorns)
            if (pair.second.valor_nuevo==1) living[pair.first]=pair.second;

        auto it=living.begin();
        while (it!=living.end())
        {
            ((*it).second).seen=false;
            ((*it).second).cuenta=0;
            ((*it).second).valor=((*it).second).valor_nuevo;
            if (((*it).second).valor==0) it=living.erase(it); else ++it; 

        }
    }  

};

class Quantum{
public:
    int regla;
    pair<int,int> origen;
    int valor;
    int r0;
    int r1;
    int spin;
    int priority; /*Will be used as the gravitation field resolution for the given zone*/
    int longevity;

    Quantum(int r, int x, int y, int v, int r_0, int r_1, int s, int p)
    {
        regla=r;
        origen=make_pair(x,y);
        valor=v;
        r0=r_0;
        r1=r_1;
        spin=s;
        priority=p;
        longevity=0;
    }
    void forward()
    {
        longevity++;
    }
    void restart(pair<int,int> c)
    {
        longevity=0;
        origen=c;
        valor *=-1;       
    }

    int orden(int x,int y)
    { 
        int dx=x-origen.first;
        int dy=y-origen.second;
        int difdir = Atan2(dy, dx) -spin;
        difdir = abs(difdir);
        if (difdir > 180) difdir= 360 - difdir;
        return difdir;
    }

    pair<int,int> cZone()
    {
        int d0=r1+longevity*r0; /*radio interior*/
        int d1=r1+(longevity+1)*r0; /*radio exterior*/
        return make_pair(d0,d1);
    }

    bool enabled(Cell& cellObject,int myRegla[9])
    {
        return (cellUpdate(cellObject.valor,cellObject.cuenta,myRegla)==valor) && !cellObject.seen;
    }

    void procesarCeldas(CellSpace& lasCeldas)
    {
        if (longevity<120)
        {
            unordered_map<pair<int,int>,Cell,HASH>* cell_List;
            int* myRegla = b4(regla);
            if (valor==1)
                cell_List=&lasCeldas.newBorns;
            else
                cell_List=&lasCeldas.living;
            int z0=cZone().first;
            int z1=cZone().second;
            int qx=origen.first;
            int qy=origen.second;
            list<pair<int,int>> seleccion;
            for (int x=-z1;x<-z0;x++) for (int y=-z0;y<=z0;y++)
                seleccion.push_back(make_pair(x+qx,y+qy));
            for (int x=z0+1;x<=z1;x++) for (int y=-z0;y<=z0;y++)
                seleccion.push_back(make_pair(x+qx,y+qy));
            for (int x=-z1;x<=z1;x++) for (int y=-z1;y<-z0;y++)
                seleccion.push_back(make_pair(x+qx,y+qy));   
            for (int x=-z1;x<=z1;x++) for (int y=z0+1;y<=z1;y++)
                seleccion.push_back(make_pair(x+qx,y+qy));                            
            int minAngle=99999999;
            int maxAngle=-99999999;
            Cell* plaCelda;
            Cell* pselectedCell;
            pair<int,int> coord;
            bool hayCell=false;
            for (auto const& pair: seleccion)
            {
                /*cout <<"Par: "<<pair.first<<" "<<pair.second<<"\n";*/
                if ((*cell_List).find(pair)!= (*cell_List).end())
                {
                    plaCelda=&(*cell_List)[pair];
                    switch(valor)
                    {
                        case 1:
                            if (enabled((*plaCelda),myRegla) && (orden(pair.first,pair.second)<minAngle))
                            {
                                minAngle=orden(pair.first,pair.second);
                                pselectedCell=plaCelda;
                                coord=pair;
                                hayCell=true;
                            }
                            break;
                        case -1:
                            if (enabled((*plaCelda),myRegla) && (orden(pair.first,pair.second)>maxAngle))
                            {
                                maxAngle=orden(pair.first,pair.second);
                                pselectedCell=plaCelda;
                                coord=pair;
                                hayCell=true;
                            } 
                            break;
                        default: {}
                    }                                  
                }
            }           
            if (hayCell)   
            {
                (*pselectedCell).valor_nuevo=(*pselectedCell).valor+valor;
                (*pselectedCell).seen=true;
                /*(*cell_List)[coord].valor_nuevo=(*cell_List)[coord].valor+valor;
                (*cell_List)[coord].seen=true;*/
                lasCeldas.increaseField(coord);
                restart(coord);
            } 

            else
                forward();
            delete[] myRegla;    
        }
        else
            forward();
    }
};

class QSpace{
public:
    int spotActivityLimit;
    vector<Quantum> quanta;
    void addSpot(int r, int x, int y, int v, int r_0, int r_1, int s, int p)
    {
        quanta.push_back(Quantum(r,x,y,v,r_0,r_1,s,p)); 
    }

    void desordenar()
    {
        for (int i=0;i<quanta.size();i++)
        {
            int iaux=rand()%quanta.size();
            Quantum temp=quanta[i];
            quanta[i]=quanta[iaux];
            quanta[iaux]=temp;
        }
    }
};

class Sensor{
public:
    string tipo;
    vector<int> datos;
    Sensor(const string elTipo,const vector<int>& losDatos)
    {
        tipo=elTipo;
        datos=losDatos;
    }
};

class SensorSpace{
public:
    vector<Sensor> sensors;
    vector<string> headers{"T"};
    vector<vector<int>> cols{{}};

    void addSensor(Sensor& elSensor)
    {    
        sensors.push_back(elSensor);
        if (elSensor.tipo=="SBI")
        {
            for (int sp=0;sp<elSensor.datos.size();sp++)
            {
                headers.push_back("s"+to_string(elSensor.datos[sp])+"_X");
                headers.push_back("s"+to_string(elSensor.datos[sp])+"_Y");
                headers.push_back("s"+to_string(elSensor.datos[sp])+"_V");
                headers.push_back("s"+to_string(elSensor.datos[sp])+"_L");
                for (int i=0;i<4;i++)
                    cols.push_back((vector<int>){});
            }        
        }
    }

    void addData(QSpace quantaList,CellSpace cellList,int paso)
    {
        int columna=0;
        cols[columna].push_back(paso);
        for (int s=0;s<sensors.size();s++)
            if (sensors[s].tipo=="SBI")
                for (int sp=0;sp<sensors[s].datos.size();sp++)
                {
                    columna++;
                    cols[columna].push_back(quantaList.quanta[sp].origen.first);
                    columna++;
                    cols[columna].push_back(quantaList.quanta[sp].origen.second);
                    columna++;
                    cols[columna].push_back(quantaList.quanta[sp].valor);
                    columna++;
                    cols[columna].push_back(quantaList.quanta[sp].longevity);
                }
    }

    void outputData(string fichero)
    {   
        ofstream f(fichero);
        for (int h=0;h<headers.size();h++)
            f << headers[h] <<" ";
        f << "\n";  
        int filas=cols[0].size(); 
        for (int laFila=0;laFila<filas;laFila++)
        {
            for (int c=0;c<cols.size();c++)
                f <<cols[c][laFila]<<" ";  
            f<<"\n";
        }
        f.close();
    }
};

class CellAuto{
public:
    QSpace Spots;
    CellSpace Cells;
    rules Reglas;
    SensorSpace gauges;
    
    void putCell(int x,int y)
    {
        Cells.addCell(x,y,1,0);
    }

    void putSpot(int r, int x, int y, int v, int r_0, int r_1, int s, int p)
    {
        Spots.addSpot(r,x,y,v,r_0,r_1,s,p);
    }

    void desordenarSpots()
    {
        Spots.desordenar();
    }
    
    void getExtCellBlock(ifstream& mif,string& lalinea)
    {
        char I;
        string tipo_bloque;
        stringstream ss(lalinea);
        int x,y,alto,largo,alto1,largo1,r,r1; double density;
        ss >>I>>I>>I>>tipo_bloque;
        if (tipo_bloque=="rectangle")
        {
            mif >>x>>I>>y>>I>>alto>>I>>largo>>I>>density;
            mif >>alto1>>I>>largo1;
            for (int i=-alto;i<alto;i++)
                for (int j=-largo;j<largo;j++)
                    if (!((i>-alto1) and (i<alto1) and (j>-largo1) and (j<largo1)))
                        if (density>(double)rand()/(double)RAND_MAX) putCell(x+i,y+j);                
        }
        else /*circle*/
        {
            mif >>x>>I>>y>>I>>r>>I>>r1>>I>>density;
            int y2,coordY;
            for (int i=-r;i<=r;i++)
            {
                int coordX=i+x;
                int y1=int(sqrt(float(r)*float(r)-float(i)*float(i)));
                if ((i >=-r1) and (i<=r1))
                    y2=int(sqrt(float(r1)*float(r1)-float(i)*float(i)));
                else
                    y2=0;    
                for (int j=-y1;j<=y1;j++)
                    if (!((i>=-r1) and (i<r1) and (j>=-y2) and (j<y2)))
                    {
                        coordY=y+j;
                        if (density>(double)rand()/(double)RAND_MAX) putCell(coordX,coordY);   
                    }
            }                     
        }

    }

    void getExtSpotsBlock(ifstream& mif,string& lalinea)
    {
        char I;
        string tipo_bloque;
        stringstream ss(lalinea);
        int regla,origx,origy,valor,r0,r1,spin,prior;
        int x1,y1,y2,nx,ny,alto1,largo1,coordX,coordY,elSpin;
        int x,y,alto,largo; double densidad;

        ss >>I>>I>>I>>nx>>I>>ny>>I>>densidad>>I>>tipo_bloque;
        if (tipo_bloque=="rectangle")
        {
            mif >>regla>>I>>origx>>I>>origy>>I>>valor>>I>>r0>>I>>r1>>I>>spin>>I>>prior;
            mif >>x1>>I>>y1>>I>>alto1>>I>>largo1;  
            int cx=origx;
            int cy=origy;
            for (int i=-nx;i<nx;i++)
                for (int j=-ny;j<ny;j++)
                    if (!((i>-alto1) and (i<alto1) and (j>-largo1) and (j<largo1)))
                        if (densidad>(double)rand()/(double)RAND_MAX) 
                        {
                            coordX,coordY=int(origx)+i,int(origy)+j;
                            if (spin<0) /*random spin*/
                                elSpin=rand()%360;
                            else if (spin>=1000) /*focused at center*/  
                            {    
                                int dx=cx-coordX; 
                                int dy=cy-coordY; 
                                elSpin=Atan2(dy,dx)+spin-1000;
                                if (elSpin>=360) elSpin-=360;                                            
                            }
                            else elSpin=spin;    
                            putSpot(regla,origx+i,origy+j,valor,r0,r1,elSpin,prior);
                        }         
        }   
        else /*circle*/
        {
            mif >>regla>>I>>origx>>I>>origy>>I>>valor>>I>>r0>>I>>r1>>I>>spin>>I>>prior;
            int cx=origx;
            int cy=origy;
            int radioExt=nx; int radioInt=ny;  
            for (int i=-radioExt;i<radioExt;i++)
            {   
                coordX=i+cx;
                y1=int(sqrt(float(radioExt)*float(radioExt)-float(i)*float(i)));
                if ((i >=-radioInt) and (i<radioInt))
                    y2=int(sqrt(float(radioInt)*float(radioInt)-float(i)*float(i)));
                else 
                    y2=0;    
                for (int j=-y1;j<y1;j++)
                    if (!((i>=-radioInt) and (i<radioInt) and (j>=-y2) and (j<y2)))
                    {    
                        coordY=cy+j;
                        if (densidad>(double)rand()/(double)RAND_MAX)
                        {
                            if (spin<0) /*random spin*/
                                elSpin=rand()%360;
                            else if (spin>=1000) /*focused at center*/  
                            {    
                                int dx=cx-coordX; 
                                int dy=cy-coordY; 
                                elSpin=Atan2(dy,dx)+spin-1000;
                                if (elSpin>=360) elSpin-=360;                                            
                            }
                            else elSpin=spin;  
                            /*cout<<elSpin<<"\n"; */
                            putSpot(regla,coordX,coordY,valor,r0,r1,elSpin,prior);
                        }
                    }    
            }                     
        }  
        desordenarSpots();  
    }

    bool abrir(string archivo)
    {
        ifstream f(archivo);
        cout <<archivo<<"\n";
        string linea, entrada;
        char I;
        int x,y,n,s_index;
        int regla,origx,origy,valor,r0,r1,spin,prior;
        vector<int> sensorList;
        string tipo_sensor;
        map<string,int> caso(
            {{"B",1},{"R",2},{"Q",3},{"E",4},{"S",5}}); 
        srand(getpid());
        if (!f.is_open()) return false;
        while (!f.eof())
        {
            linea="";
            f >> linea;
            if (linea!="")
            {
                stringstream ss(linea);
                int elcaso=caso[linea.substr(0,1)];
                switch(elcaso)
                {
                    case 1: /*"B":Block of cells. Solo "0s" y "1s" no spaces, please */ 
                        f >>x>>I>>y>>I>>n;
                        for (int i=0;i<n;i++)
                            {
                                f >> linea;
                                for (int j=0;j<linea.length();j++)
                                    if (linea.substr(j,1)=="1") putCell(x+i,y+j);
                            }
                        break;
                    case 2:     /*"R":Random block of cells*/ 
                        if (linea.substr(0,2)=="R+")
                            getExtCellBlock(f,linea);
                        else  
                        {  
                        int alto,largo;
                        double density;
                        f >>x>>I>>y>>I>>alto>>I>>largo>>I>>density;
                        for (int i=0;i<alto;i++)
                            for (int j=0;j<largo;j++)
                                if (density>(double)rand()/(double)RAND_MAX) putCell(x+i,y+j);
                        }        
                        break;
                    case 3: /*"Q":Block of n Spots*/
                        ss >>I>>I>>n;
                        for (int i=0;i<n;i++)
                            {
                                f >>regla>>I>>origx>>I>>origy>>I>>valor>>I>>r0>>I>>r1>>I>>spin>>I>>prior;
                                putSpot(regla,origx,origy,valor,r0,r1,spin,prior);
                            }
                        break;
                    case 4:  /*"E":Block of random spots*/
                        if (linea.substr(0,2)=="E+")
                            getExtSpotsBlock(f,linea);
                        else  
                        {
                            int nx,ny,elSpin; double densidad;
                            ss >>I>>I>>nx>>I>>ny>>I>>densidad;
                            f >>regla>>I>>origx>>I>>origy>>I>>valor>>I>>r0>>I>>r1>>I>>spin>>I>>prior;
                            if (spin<0) elSpin=rand()%360; else elSpin=spin;
                            for (int i=0;i<nx;i++)
                                for (int j=0;j<ny;j++)
                                    if (densidad>(double)rand()/(double)RAND_MAX) putSpot(regla,origx+i,origy+j,valor,r0,r1,elSpin,prior);                
                            desordenarSpots();        
                        }
                        break;
                    case 5:  /*"S":Sensors*/
                        ss >> I>>I>>tipo_sensor;
                        if (tipo_sensor=="SBI") /*Registra estado de spots individuales*/
                        {
                            f >> linea;
                            cout << linea << "\n";
                            stringstream s1(linea);
                            while (!s1.eof()) 
                            {
                                s1 >> s_index;
                                sensorList.push_back(s_index);
                                s1 >>I; 
                            } 
                            cout << "Sensores \n";
                            for (int i=0;i<sensorList.size();i++)
                                cout << sensorList[i] <<"\n";
                            Sensor miSensor(tipo_sensor,sensorList);
                            gauges.addSensor(miSensor);
                        }
                        break;    
                    default: 
                        cout <<"nope\n";   
                }
            
            }
        }    
        f.close(); 
        return true;
    }

    void doStep(int paso)
    {
        if (gauges.sensors.size()>0)
            gauges.addData(Spots,Cells,paso);
        Cells.newBornCandidates();
        for (int i=0;i<Spots.quanta.size();i++) 
            Spots.quanta[i].procesarCeldas(Cells);
        Cells.actualiza();
    }

    void saveSnapShot(string& fichero, double dx, double dy, double sc)
    {
        ofstream f(fichero);
        cout << fichero<<"\n";
        f<<"Cells \n";
        for (auto const& pair: Cells.living)
        {
            int y=pair.first.first;
            int x=pair.first.second;
            double xr=((double)x*6.0/1000.0+dx)*sc;
            double yr=((double)y*6.0/1000.0+dy)*sc;
            if ((-1.0<xr && xr<1.0) and (-1.0<yr && yr<1.0))
                f <<x<<" "<<y<<"\n";
        }
        f<<"Field \n";
        for (auto const& pair: Cells.campo)
        {
            int y=pair.first.first;
            int x=pair.first.second;
            double xr=((double)x*6.0/1000.0+dx)*sc;
            double yr=((double)y*6.0/1000.0+dy)*sc;
            if ((-1.0<xr && xr<1.0) and (-1.0<yr && yr<1.0))
                f <<x<<" "<<y<<" "<<pair.second<<"\n";
        }        
        f.close();
    }

};
/*-----mouse variables-------------------------*/
double mouseIniX=0,mouseIniY=0,mouseX=0,mouseY=0;
int mouseAbajo=0,mouseRight=0;
double dx=0, dy=0, sc=1;
/*---------------------------------------------*/
/*---------Temporizador------------------------*/
DWORD Timer=256;
/*---------------------------------------------*/

int paso=0,timeOut=1000000;
bool stop=false, showEnergy=true;
CellAuto MiCA;

void initGraphic(double xinit,double xfinal,double yinit, double yfinal)
{
    glClearColor(0.0, 0.0, 0.0, 1.0);
    gluOrtho2D(xinit, xfinal, yinit, yfinal);
}

void punto(double iy, double ix) /* x y y intercambiadas para tener x-vertical, y-horizontal*/
{
    double x=6*ix;
    double y=6*iy;
    /*cout <<x<<" "<<y<<"\n";
    cout.flush();*/
    glVertex2f((x-2)/1000.0, (y-2)/1000.0);
    glVertex2f((x-2)/1000.0, (y+2)/1000.0);
    glVertex2f((x+2)/1000.0, (y+2)/1000.0);
    glVertex2f((x+2)/1000.0, (y-2)/1000.0); 
}

void plotSpot(Quantum& spot)
{
    double y=spot.origen.first;
    double x=spot.origen.second;
    if (spot.valor==1)
        glColor4f(0.0, 1.0, 0.0, 0.3); /*Spot positivo verde, transparencia 0.3*/
    else
        glColor4f(1.0, 0.0, 0.0, 0.3); /*Spot negativo rojo, transparencia 0.3*/
    double span=spot.r1+(spot.longevity+1)*spot.r0;
    double x1=(x-span)*0.001*6; double x2=x1;
    double x3=(x+span)*0.001*6; double x4=x3;
    double y1=(y-span)*0.001*6; double y4=y1;
    double y2=(y+span)*0.001*6; double y3=y2;
    glVertex2f(x1,y1);
    glVertex2f(x2,y2);
    glVertex2f(x3,y3);
    glVertex2f(x4,y4);
    /*cout <<x1<<" "<<y1<<" "<<x2<<" " << y2<< "\n";*/
}

void displaySpots()
{
    glPolygonMode(GL_FRONT, GL_LINE);
    glPolygonMode(GL_BACK, GL_LINE);
    glBegin(GL_QUADS);
    for (int i=0;i<MiCA.Spots.quanta.size();i++)
        plotSpot(MiCA.Spots.quanta[i]);
    glEnd();
}

void display() 
{

}

void renderString(double x, double y,string texto)
{
    glPushMatrix();
    glLoadIdentity();
    glColor3f(1.0,1.0,1.0);
    for (int i=0;i<texto.length();i++)
    {
        char c=texto[i];
        
        glRasterPos2f(x+0.02*i,y);
        glutBitmapCharacter(GLUT_BITMAP_TIMES_ROMAN_10,c);
    }
    glPopMatrix();
    
}

void plotpoints()
{
    if (true)
    { 
        glClear(GL_COLOR_BUFFER_BIT);
        glColor4f(1.0, 1.0, 1.0, 0.7); /*Celdas vivas color blanco*/
        glPolygonMode(GL_FRONT, GL_FILL);
        glPolygonMode(GL_BACK, GL_FILL);
        glBegin(GL_QUADS);    
        for (auto const& pair: MiCA.Cells.living)
        {
            int x=pair.first.first;
            int y=pair.first.second;
            punto(x,y);
        }
        glEnd();
        if (showEnergy) displaySpots();
        renderString(-0.95, 0.95,"Step: "+to_string(paso)+"  Speed: "+to_string(2048/Timer));
        /*Display Spots
        /*if not HEnergy.get(): */
        /*if lattice.gForce>0:
            plotG(lattice.gCenter)
        */
        glFlush();
        if ((!stop) and (paso<timeOut))
        {
            paso++;
            MiCA.doStep(paso);
            Sleep(Timer);
        }
    }    
}

void keyboard (unsigned char key, int x, int y)
{
    string fichero;
    switch (key) 
    {
    case ' ': /*Start/Stop*/
        stop=!stop;
    break;
    case '+': /*Speed UP*/
        if (Timer>1) Timer/=2;
    break;
    case '-': /*Slow Down*/
        if (Timer<2048)Timer*=2;
    break;
    case 'e': /*Toggle Energy*/
        showEnergy=!showEnergy;
    break;
    case 's': /*Save Snapshot */
        cout <<"Enter file name: ";cin >> fichero;
        MiCA.saveSnapShot(fichero,dx,dy,sc);
        cout <<"File "<<fichero<<" "<<"saved\n";
    break;    
    case 'g': /*Save Sensors */
        cout <<"Enter file name: ";cin >> fichero;
        MiCA.gauges.outputData(fichero);
        cout <<"File "<<fichero<<" "<<"saved\n";
    break;    
    default:
        cout <<int(key)<<"\n";
    break;
    }
}

void specialkeys(int key,int x,int y)
{
    switch(key)
    {
    case GLUT_KEY_DOWN:
        if (Timer<2048)Timer*=2;
    break;
    case GLUT_KEY_UP:
        if (Timer>1) Timer/=2;
    break;   
    default:
        cout <<int(key)<<"\n";
    break;        
    }
}

void mouse(int button, int status, int x, int y)
{
    if (button == GLUT_LEFT_BUTTON and status == GLUT_DOWN)
    {    
        mouseIniX=mouseX=x;
        mouseIniY=mouseY=y;
        mouseAbajo=1;
    }
    if (button == GLUT_LEFT_BUTTON and status == GLUT_UP)
    {
        mouseIniX=mouseX=x;
        mouseIniY=mouseY=y;
        mouseAbajo=0;
    }
    if (button == GLUT_RIGHT_BUTTON and status == GLUT_DOWN)
    {
        mouseIniX=mouseX=x;
        mouseIniY=mouseY=y;
        mouseRight=1;
    }
    if (button == GLUT_RIGHT_BUTTON and status == GLUT_UP)
    {
        mouseIniX=mouseX=x;
        mouseIniY=mouseY=y;
        mouseRight=0;
    }
}

void mousemotion(int x, int y)
{
    mouseX = x;
    mouseY = y;
    if (mouseAbajo) /*Mover los puntos;*/
    {   
        dx+=(mouseX-mouseIniX)/1000.0;
        dy+=(mouseIniY-mouseY)/1000.0;
        glTranslatef((mouseX-mouseIniX)/1000.0,(mouseIniY-mouseY)/1000.0,0);
    }
    if (mouseRight) /* Escalar los puntos;*/
    {
        double escala=1.0;
        if (mouseIniY-mouseY>0)
            escala=1.01;
        else if (mouseIniY-mouseY<0)
            escala=0.99;
        glScalef(escala,escala,1.0);
        glTranslatef((escala-1)*(dx),(escala-1)*(dy),0);
        sc*=escala;
    }
    mouseIniX=mouseX=x;
    mouseIniY=mouseY=y;
}



int main(int argc, char* argv[])
{

    string f1=argv[1];
    cout << "file:" << f1 <<"\n";
    timeOut=atoi(argv[2]);
    cout <<timeOut<<"\n";
    
    if (MiCA.abrir(f1))
    {
        cout << "Celdas:\n";
        cout <<"Energy: "<<MiCA.Spots.quanta.size()<<"\n";
    /*    for (auto const& pair: MiCA.Cells.living)
        {
            int x=pair.first.first;
            int y=pair.first.second;
            cout <<x<<" "<<y<<"\n";
        }
    */
        cout <<"ok \n"; 
    }
    else
        cout <<"File not found \n";

	/* Main function: GLUT runs as a console application starting at main()  */
	stop=true;
    glutInit(&argc, argv);  
    glutInitDisplayMode(GLUT_SINGLE|GLUT_RGB);              // Initialize GLUT
    glutInitWindowSize(800, 800);   // Set the window's initial width & height
    glutInitWindowPosition(50, 50); // Position the window's initial top-left corner
    glutCreateWindow(("Running EDCA: "+f1).c_str()); // Create a window with the given title
    glutDisplayFunc(display); // Register display callback handler for window re-paint
    glutIdleFunc(plotpoints);
    glutMotionFunc(mousemotion);
    glutMouseFunc(mouse);
    glutKeyboardFunc(keyboard);
    glutSpecialFunc(specialkeys);
    initGraphic(-1.0,1.0,-1.0,1.0);
    /*Habilitar Transparencia---------------------------*/
    glEnable (GL_BLEND);
    glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    /*--------------------------------------------------*/    
    glutMainLoop();           // Enter the infinitely event-processing loop
    
    return 0;
}
