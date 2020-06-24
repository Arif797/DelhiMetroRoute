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

	string currentStation = "New Delhi";
	string destination = "Majlis Park";

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

		// Yellow Lines

		make_pair("Samaypur Badli", "Azadpur"), make_pair("Azadpur", "Civil Lines") make_pair("Civil Lines", "Kashmere Gate"), make_pair("Kashmere Gate", "New Delhi"), 
		make_pair("New Delhi", "Rajiv Chowk"), make_pair("Rajiv Chowk", "Central Secretariat"), make_pair("Central Secretariat", "INA"),
		make_pair("INA", "Hauz Khas"), make_pair("Hauz Khas", "Huda City Centre"), 


		// Blue Line

		make_pair("Dwarka Sec 21", "Dwarka Sec 8"), make_pair("Dwarka Sec 8", "Dwarka"), make_pair("Dwarka", "Janakpuri West"), 
		make_pair("Janakpuri West", "Rajouri Garden"), make_pair("Rajouri Garden", "Kirti Nagar"), 
		make_pair("Kirti Nagar", "Rajiv Chowk"), make_pair("Rajiv Chowk", "Mandi House"),
		make_pair("Mandi House", "Yamuna Bank"), make_pair("Yamuna Bank", "Mayur Vihar-1"), make_pair("Mayur Vihar-1", "Botanical Garden"),
		make_pair("Botanical Garden", "Sec 52 Noida"), make_pair("Sec 52 Noida", "Noida Electronic City"),

		// Blue Line - Vaishali Route

		make_pair("Yamuna Bank", "Karkaduma"),
		make_pair("Karkaduma", "Anand Vihar I.S.B.T."), make_pair("Anand Vihar I.S.B.T.", "Vaishali"),

		// Violet Line

		make_pair("Kashmere Gate", "Mandi House"), make_pair("Mandi House", "Central Secretariat"), make_pair("Central Secretariat", "Lajpat Nagar"),
		make_pair("Lajpat Nagar", "Kalkaji Mandir"), make_pair("Kalkaji Mandir", "Ballabgarh"),

		// Magenta Line

		make_pair("Botanical Garden", "Kalkaji Mandir"), make_pair("Kalkaji Mandir", "Hauz Khas"),
		make_pair("Hauz Khas", "Terminal 1-IGI Airport"), make_pair("Terminal 1-IGI Airport", "Janakpuri West"),


		// Airport Express Line

		make_pair("New Delhi", "Shivaji Stadium"), make_pair("Shivaji Stadium", "Dhaula Kuan"), make_pair("Dhaula Kuan", "Delhi Aerocity"),
		make_pair("Delhi Aerocity", "Airport"), make_pair("Airport", "Dwarka Sec 21"), 

		
		// Pink Line

		make_pair("Majlis Park", "Azadpur"), make_pair("Azadpur", "Netaji Subhash Place"), make_pair("Netaji Subhash Place", "Rajouri Garden"),
		make_pair("Rajouri Garden", "INA"), make_pair("INA", "Lajpat Nagar"), make_pair("Lajpat Nagar", "Hazrat Nizamuddin"), make_pair("Hazrat Nizamuddin", "Mayur Vihar-1"),
		make_pair("Mayur Vihar-1", "Anand Vihar I.S.B.T.") make_pair("Anand Vihar I.S.B.T.", "Karkaduma"), make_pair("Karkaduma", "Welcome"),
		make_pair("Welcome", "Shiv Vihar"), 
		
		// Red Line

		make_pair("Rithala", "Netaji Subhash Place"), make_pair("Netaji Subhash Place", "Inderlok"), make_pair("Inderlok", "Kashmere Gate"),
		make_pair("Kashmere Gate", "Welcome"), make_pair("Welcome", "New Bus Adda"),

		// Green Line

		make_pair("City Park", "Ashok Park Main"), make_pair("Ashok Park Main", "Inderlok"), make_pair("Ashok Park Main", "Kirti Nagar")
	};
	unordered_map<string, vector<string> > stations;
	for (auto edge : station){
		stations[edge.first].push_back(edge.second);
		stations[edge.second].push_back(edge.first);
	}

	// Adjacency list for line colors
	pair<string, string> interchange[] = {
		make_pair("YELLOW", "PINK"),
		make_pair("YELLOW", "BLUE"),
		make_pair("YELLOW", "RED"),
		make_pair("YELLOW", "VIOLET"),
		make_pair("YELLOW", "MAGENTA"),
		make_pair("YELLOW", "ORANGE"),
		make_pair("BLUE", "PINK"),
		make_pair("BLUE", "VIOLET"),
		make_pair("BLUE", "MAGENTA"),
		make_pair("BLUE", "ORANGE"),
		make_pair("PINK", "VIOLET"),
		make_pair("PINK", "RED"),
		make_pair("MAGENTA", "VIOLET"),
		make_pair("GREEN", "PINK"),
		make_pair("GREEN", "RED")
	};
	unordered_map<string, vector<string> > lines;
	for (auto color : interchange){
		lines[color.first].push_back(color.second);
		lines[color.second].push_back(color.first);
	}

	// store line color for all stations
	unordered_map<string, string> color;
	color["Rithala"] = "RED";
	color["Welcome"] = "RED";
	color["New Bus Adda"] = "RED";
	color["Inderlok"] = "GREEN";
	color["City Park"] = "GREEN";
	color["Kirti Nagar"] = "GREEN";
	color["Ashok Park Main"] = "GREEN";
	color["New Delhi"] = "ORANGE";
	color["Shivaji Stadium"] = "ORANGE";
	color["Dhaula Kuan"] = "ORANGE";
	color["Delhi Aerocity"] = "ORANGE";
	color["Airport"] = "ORANGE";
	color["Dwarka Sec 21"] = "ORANGE";
	color["Dwarka Sec 8"] = "BLUE";
	color["Dwarka"] = "BLUE";
	color["Mandi House"] = "BLUE";
	color["Yamuna Bank"] = "BLUE";
	color["Mayur Vihar-1"] = "BLUE";
	color["Sec 52 Noida"] = "BLUE";
	color["Noida Electronic City"] = "BLUE";
	color["Lakshmi Nagar"] = "BLUE";
	color["Kaushambi"] = "BLUE";
	color["Vaishali"] = "BLUE";
	color["Majlis Park"] = "PINK";
	color["Azadpur"] = "PINK";
	color["Netaji Subhash Place"] = "PINK";
	color["Rajouri Garden"] = "PINK";
	color["Lajpat Nagar"] = "PINK";
	color["Hazrat Nizamuddin"] = "PINK";
	color["Anand Vihar I.S.B.T."] = "PINK";
	color["Karkaduma"] = "PINK";
	color["Shiv Vihar"] = "PINK";
	color["Kashmere Gate"] = "VIOLET";
	color["Central Secretariat"] = "VIOLET";
	color["Kalkaji Mandir"] = "VIOLET";
	color["Ballabgarh"] = "VIOLET";
	color["Samaypur Badli"] = "YELLOW";
	color["Civil Lines"] = "YELLOW";
	color["Rajiv Chowk"] = "YELLOW";
	color["INA"] = "YELLOW";
	color["Hauz Khas"] = "YELLOW";
	color["Huda City Centre"] = "YELLOW";
	color["Janakpuri West"] = "MAGENTA";
	color["Shankar Vihar"] = "MAGENTA";
	color["Botanical Garden"] = "MAGENTA";


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