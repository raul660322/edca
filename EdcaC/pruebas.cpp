#include <cmath>
#include <bits/stdc++.h>
#include <windows.h>
#include <commdlg.h>

using namespace std;
void pasarVector(vector<int>& elVector)
{
    vector<int> nuevo;
    nuevo=elVector;  
    cout << "\n";
    cout <<nuevo[0];          
}

pair<int,int> cov(int p, int r)
{
    if (p<r)
    {
        return make_pair(-r,p);
    } 
    else if (p<2*r)
    {
        return make_pair(-2*r+p,r);
    }
    else if (p<3*r)
    {
        return make_pair(-2*r+p,r);
    }
    else if (p<4*r)
    {
        return make_pair(r,4*r-p);        
    }
    else if (p<5*r)
    {
        return make_pair(r,4*r-p);        
    }
    else if (p<6*r)
    {
        return make_pair(6*r-p,-r);     
    }
    else if (p<7*r)
    {
        return make_pair(6*r-p,-r);        
    }
    else 
    {
        return make_pair(-r,p-8*r);        
    }
}

int main(int argc, char* argv[])
{
    int angle;
    char ch;
    int a,b,c,p;
    double d;
    unsigned int res;
    string cadena;
    angle=-370;
    res=angle%360;
    /*std::cout << (angle+360*10)%360;*/
    /*std::cout << res <<"\n"; 
    std::cout << "Teclee la cadena:";
    std::cin >> a >> ch >> b >> ch >> c >> ch >> d >> ch >> cadena >> ch >> p;
    std::cout << a << b << c << d << cadena << p <<"\n";
    std::cout << "Teclee la cadena:";
    std::cin >> cadena;
    stringstream ss(cadena);
    ss >> a >> ch >> b >> ch >> d;
    std::cout << a << " " << b << " " << d <<"\n";
    std::cout << "Teclee la cadena:";
    std::cin >> a >> ch  >> cadena >> ch >> b;
    std::cout << a << " " << cadena << " " << b << "\n";


    vector<vector<int>> cols{{},{},{}};
    cols[0].push_back(1);
    cols[1].push_back(2);
    cols[2].push_back(3);
    cout <<cols[0][0] <<" "<<cols[1][0]<<" "<<cols[2][0];
    vector<int> nuevo=cols[0];
    cout << "\n";
    cout <<nuevo[0];
    pasarVector(cols[2]);
    for (int i=0;i<16;i++)
    {
        cout << cov(i,2).first<<" "<<cov(i,2).second <<"\n";
    }*/
        time_t sec;
        time(&sec); // Take the number of seconds and
        cout << (unsigned)sec;
    return 0;
} 