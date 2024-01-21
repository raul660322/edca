#include <bits/stdc++.h>
#include <math.h>

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
    }
};

class CellSpace{

public:
    unordered_map<pair<int,int>,Cell,HASH> living;
    unordered_map<pair<int,int>,Cell,HASH> newBorns;
    
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
                /*Cell* plaCelda=&living[make_pair(x,y)];
                (*plaCelda).cuenta+=1;*/
                living[make_pair(x,y)].cuenta+=1;
            }
            else newBorns[make_pair(x,y)]=Cell(0,1);
        }

    void newBornCandidates()
    {
        newBorns.clear();
        for (auto const& pair: living)
        {
            int x=pair.first.first;
            int y=pair.first.second;
            for (int i=-1;i<2;i++)
                for (int j=-1;i<2;i++) 
                    if ((i!=0) and (j!=0))
                        incrementarCuenta(x+i,y+j);  
        }
    }  

    void actualiza()
    {
        living.insert(newBorns.begin(),newBorns.end());
        auto it=living.begin();
        while (it!=living.end())
        {
           ((*it).second).seen=false;
           ((*it).second).cuenta=0;
           ((*it).second).valor=((*it).second).valor_nuevo;
           if (((*it).second).cuenta==0) it=living.erase(it); else ++it; 
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
    }
    void forward()
    {
        longevity+=1;
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
        return (cellUpdate(cellObject.valor,cellObject.cuenta,myRegla)==valor) and !cellObject.seen;
    }

    void procesarCeldas(CellSpace& lasCeldas)
    {
        if (longevity<50)
        {
            unordered_map<pair<int,int>,Cell,HASH> cell_List;
            int* myRegla = b4(regla);
            if (valor==1)
                cell_List=lasCeldas.newBorns;
            else
                cell_List=lasCeldas.living;

            int z0=cZone().first;
            int z1=cZone().second;
            int qx=origen.first;
            int qy=origen.second;
            list<pair<int,int>> seleccion;
            for (int x=-z1;x<=z1;x++) for (int y=-z1;y<-z0;y++)
                seleccion.push_back(make_pair(x+qx,y+qy));
            for (int x=-z1;x<=z1;x++) for (int y=z0+1;y<=-z1;y++)
                seleccion.push_back(make_pair(x+qx,y+qy));
            for (int x=-z1;x<-z0;x++) for (int y=-z0;y<=z0;y++)
                seleccion.push_back(make_pair(x+qx,y+qy));
            for (int x=z0+1;x<=z1;x++) for (int y=-z0;y<=z0;y++)
                seleccion.push_back(make_pair(x+qx,y+qy));

            /*seleccion=[(x+qx,y+qy) for x in range(-z1,z1+1) for y in range(-z1,-z0)]*/
            /*seleccion+=[(x+qx,y+qy) for x in range(-z1,z1+1) for y in range(z0+1,z1+1)]*/
            /*seleccion+=[(x+qx,y+qy) for x in range(-z1,-z0) for y in range(-z0,z0+1)]*/
            /*seleccion+=[(x+qx,y+qy) for x in range(z0+1,z1+1) for y in range(-z0,z0+1)]*/
            int minAngle=99999999;
            int maxAngle=-99999999;
            Cell* plaCelda;
            Cell* pselectedCell;
            pair<int,int> coord;
            bool hayCell=false;
            for (auto const& pair: seleccion)
            {
                if (cell_List.find(pair)!= cell_List.end())
                {
                    plaCelda=&cell_List[pair];
                    switch(valor)
                    {
                        case 1:
                            if (enabled((*plaCelda),myRegla) and orden(pair.first,pair.second)<minAngle)
                            {
                                minAngle=orden(pair.first,pair.second);
                                pselectedCell=plaCelda;
                                coord=pair;
                                hayCell=true;
                            }
                            break;
                        case -1:
                            if (enabled((*plaCelda),myRegla) and orden(pair.first,pair.second)>maxAngle)
                            {
                                minAngle=orden(pair.first,pair.second);
                                pselectedCell=plaCelda;
                                coord=pair;
                                hayCell=true;
                            }  
                    }                                  
                }
            }           
            if (hayCell)   
            {
                (*pselectedCell).valor_nuevo=(*pselectedCell).valor+valor;
                (*pselectedCell).seen=1;
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

};

class CellAuto{
public:
    QSpace Spots;
    CellSpace Cells;
    rules Reglas;
    void putCell(int x,int y)
    {
        Cells.addCell(x,y,1,0);
    }

    void putSpot(int r, int x, int y, int v, int r_0, int r_1, int s, int p)
    {
        Spots.addSpot(r,x,y,v,r_0,r_1,s,p);
    }

    bool abrir(string archivo)
    {
        ifstream f(archivo);
        cout <<archivo<<"\n";
        string linea, entrada;
        char I;
        int x,y,n;
        int regla,origx,origy,valor,r0,r1,spin,prior;
        map<string,int> caso(
            {{"B",1},{"R",2},{"Q",3},{"E",4}}); 
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
                        int alto,largo;
                        double density;
                        f >>x>>I>>y>>I>>alto>>I>>largo>>I>>density;
                        for (int i=0;i<alto;i++)
                            for (int j=0;j<largo;j++)
                                if (density>rand()/RAND_MAX) putCell(x+i,y+j);
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
                        int nx,ny; double densidad;
                        ss >>I>>I>>nx>>I>>ny>>I>>densidad;
                        f >>regla>>I>>origx>>I>>origy>>I>>valor>>I>>r0>>I>>r1>>I>>spin>>I>>prior;
                        for (int i=0;i<nx;i++)
                            for (int j=0;j<ny;j++)
                                if (densidad>rand()/RAND_MAX) putSpot(regla,origx+i,origy+j,valor,r0,r1,spin,prior);                    
                        break;
                    default: 
                        cout <<"nope\n";   
                }
            
            }
        }    
        f.close(); 
        return true;
    }

    void doStep()
    {
        Cells.newBornCandidates();
        for (int i=0;i<Spots.quanta.size();i++)
            Spots.quanta[i].procesarCeldas(Cells);
        Cells.actualiza();
    }


};


int main(int argc, char* argv[])
{
    CellAuto MiCA;
    string f1=argv[1];
    cout << "file:" << f1 <<"\n";
    if (MiCA.abrir(f1))
    {
        cout << "Celdas:\n";
        for (auto const& pair: MiCA.Cells.living)
        {
            int x=pair.first.first;
            int y=pair.first.second;
            cout <<x<<" "<<y<<"\n";
        }
 
        cout <<"ok \n"; 
    }
    else
        cout <<"File not found \n";

    /*rules lasReglas;
    lasReglas.addRuleShort(16);
    lasReglas.addRuleShort(64);
    int* r=lasReglas.getRule(16);
    for (int i=0;i<9;i++) std::cout << r[i];
    std::cout << "\n";
    int* k=lasReglas.getRule(64);
    for (int i=0;i<9;i++) std::cout << k[i];
    std::cout << "\n";
    std::cout << "Hello World\n";
    CellSpace lasCeldas;
    lasCeldas.addCell(1,1,1,0);
    Cell miCelda;
    if (lasCeldas.getCell(1,1,miCelda))
        std::cout << miCelda.cuenta;
    else
        std::cout << "Nope\n";
    lasCeldas.incrementarCuenta(1,1);
    if (lasCeldas.getCell(1,1,miCelda))
        std::cout << miCelda.cuenta;
    else
        std::cout << "Nope\n";
    lasCeldas.incrementarCuenta(1,1);
    if (lasCeldas.getCell(1,1,miCelda))
        std::cout << miCelda.cuenta;
    else
        std::cout << "Nope\n";
*/

    return 0;
}
