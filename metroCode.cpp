#include<iostream>
#include<vector>
using namespace std;
const int stations = 101;

void solve(vector<int> routes[], vector<bool>& vis, int currentLocation, int destination, vector<int> path){

	path.push_back(currentLocation);
	if (currentLocation == destination){
		for (int location : path)
			cout << location << ' ';
		cout << endl;
		return;
	}
	vis[currentLocation] = true;

	for (auto nextLocation : routes[currentLocation])
		if (vis[nextLocation] == false)
			solve(routes, vis, nextLocation, destination, path);


	vis[currentLocation] = false;
	path.pop_back();

}

int main(){

	int from[] = {1, 2, 3, 4, 4, 5, 6, 7, 9, 10, 11, 10, 13, 14};
	int to[] =   {2, 3, 4, 5, 9, 6, 7, 8, 10, 11, 12, 13, 14, 12};
	int n = sizeof(from) / sizeof (int);

	vector<int> routes[stations];
	for (int i = 0; i < n; i++){
		routes[from[i]].push_back(to[i]);
		routes[to[i]].push_back(from[i]);
	} 
	vector<bool> vis(stations, false);

	int source = 1;
	int destination = 12;

	vector<int> path;
	solve(routes, vis, source, destination, path);

/*    for (int i = 0; i < stations; i++){
		cout << i + 1 << " -> ";
        if (routes[i].size() > 0){
            for (int j = 0; j < routes[i].size(); j++)
                cout << routes[i][j] << ' ';
            cout << endl;
        }
    }	
*/
}
