#include<unordered_map>
#include<iostream>
#include<vector>
#include<queue>
#include<map>
using namespace std;

bool isEqual(const string& A, const string& B){
	
	if (A.size() != B.size())
		return false;
	for (int i = 0; i < A.size(); i++)
		if (A[i] != B[i])
			return false;
	return true;
}

void getIntermediateLines(vector<vector<string> >& totalColorPaths, vector<string> colorPath, string currentLine, string& destinationLine,  unordered_map<string, vector<string> >& lines, unordered_map<string, bool>& visitedLines){

	colorPath.push_back(currentLine);

	if (isEqual(currentLine, destinationLine)){
		totalColorPaths.push_back(colorPath);
		// for (auto i : colorPath)		cout << i << ' ';	cout << endl;
		return ;
	}
	visitedLines[currentLine] = true;
	for (auto line : lines[currentLine])
		if (!visitedLines[line])
			getIntermediateLines(totalColorPaths, colorPath, line, destinationLine, lines, visitedLines);
	visitedLines[currentLine] = false;
}

void getIntermediateStations(vector<vector<string> >& totalStationPaths, vector<string> stationPath, string currentStation, string& destination, unordered_map<string, vector<string> >& stations, unordered_map<string, bool>& visitedStation, unordered_map<string, string>& color, queue<string>& q, string& prevColor){

	stationPath.push_back(currentStation);
	if (isEqual(currentStation, destination)){

		totalStationPaths.push_back(stationPath);
		// for (auto station : stationPath)cout << station << ' ';	cout << endl;
		return ;
	}

	visitedStation[currentStation] = true;

	for (auto station : stations[currentStation]){

		if (!visitedStation[station]){

			// switch when q.front() == color of next station
			if (!q.empty() && isEqual(q.front(), color[station])){
				prevColor = q.front();
				q.pop();
				getIntermediateStations(totalStationPaths, stationPath, station, destination, stations, visitedStation, color, q, prevColor);
			}
			
			// if queue is empty then dont move on same line
			else if (isEqual(prevColor, color[station]))
				getIntermediateStations(totalStationPaths, stationPath, station, destination, stations, visitedStation, color, q, prevColor);

			// else cout << currentStation << " -> " << station << endl;
		}
	}

	visitedStation[currentStation] = false;
}

void getRoutes(unordered_map<string, vector<string> >& stations, unordered_map<string, vector<string> >& lines, unordered_map<string, string>& color){

	string currentStation = "E";
	string destination = "I";

	string currentLine = color[currentStation];
	string destinationLine = color[destination];

		
	vector<vector<string> > totalColorPaths;
	vector<string> colorPath;
	
	unordered_map<string, bool> visitedLines;
	for (auto line : lines)		visitedLines[line.first] = false;	
	
	getIntermediateLines(totalColorPaths, colorPath, currentLine, destinationLine, lines, visitedLines);


	vector<vector<string> > totalStationPaths;
	for (auto colorPath : totalColorPaths){

		queue<string> q;
		for (int i = 1; i < colorPath.size(); i++)
			q.push(colorPath[i]);

		string prevColor = colorPath[0];
		vector<string> stationPath;
		unordered_map<string, bool> visitedStation;
		for (auto station : stations)	visitedStation[station.first] = false;	

		getIntermediateStations(totalStationPaths, stationPath, currentStation, destination, stations, visitedStation, color, q, prevColor);
	}

	for (auto route : totalStationPaths){
		for (auto station : route)
			cout << station << ' ' << color[station] << endl ;
		cout << endl;
	}
}

int main(){

	// Adjacency list for stations
	pair<string, string> station[] = {
		make_pair("A", "B"), make_pair("B", "C"), make_pair("C", "D"), 
		make_pair("D", "E"), make_pair("C", "O"), make_pair("O", "P"), 
		make_pair("C", "F"), make_pair("F", "G"), make_pair("G", "H"), 
		make_pair("G", "J"), make_pair("J", "K"), make_pair("J", "L"), 
		make_pair("L", "N"), make_pair("L", "M"), make_pair("H", "I")
	};
	unordered_map<string, vector<string> > stations;
	for (auto edge : station){
		stations[edge.first].push_back(edge.second);
		stations[edge.second].push_back(edge.first);
	}

	// Adjacency list for line colors
	pair<string, string> interchange[] = {
		make_pair("RED", "YELLOW"), 
		make_pair("YELLOW", "BLUE"), 
		make_pair("BLUE", "GREEN")
	};
	unordered_map<string, vector<string> > lines;
	for (auto color : interchange){
		lines[color.first].push_back(color.second);
		lines[color.second].push_back(color.first);
	}

	// store line color for all stations
	unordered_map<string, string> color;
	color["A"] = "RED";
	color["B"] = "RED";
	color["C"] = "RED";
	color["D"] = "RED";
	color["E"] = "RED";
	color["F"] = "YELLOW";
	color["G"] = "YELLOW";
	color["H"] = "BLUE";
	color["I"] = "BLUE";
	color["J"] = "BLUE";
	color["K"] = "BLUE";
	color["L"] = "GREEN";
	color["M"] = "GREEN";
	color["N"] = "GREEN";
	color["O"] = "YELLOW";
	color["P"] = "YELLOW";


	getRoutes(stations, lines, color);

/*
	// lines adjacency list
	for (auto i : stations){
		cout << i.first << " -> ";
		for (auto j : i.second)
			cout << j << " |";
		cout << endl; 
	}

*/
	return 0;
}