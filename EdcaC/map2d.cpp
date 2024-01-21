#include <bits/stdc++.h>

using namespace std;

struct HASH{ 
  size_t operator()(const pair<int,int>&x)const{
    return ((int64_t)x.first) ^ (((long long)x.second) << 32);
  }
};

unordered_map<pair<int, int>, int, HASH> m;

int main() {
  auto T = clock();
  for (int i = 0; i < 1000000; i++)
    m[make_pair(1, i)] = i;
  cout << double(clock()-T)/CLOCKS_PER_SEC << '\n';
}

