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

void getIntermediateStations(vector<vector<string> >& totalStationPaths, vector<string> stationPath, string currentStation, string& destination, unordered_map<string, vector<string> >& stations, unordered_map<string, bool>& visitedStation, unordered_multimap<string, string>& color, queue<string>& q, string& prevColor){

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
			else{
                for (auto nextStation : stations[station])
                    if (color[nextStation] == prevColor && !visitedStation[nextStation]){
                        stationPath.push_back(station);
                        getIntermediateStations(totalStationPaths, stationPath, nextStation, destination, stations, visitedStation, color, q, prevColor);
                    }
                }
		}
	}

	visitedStation[currentStation] = false;
}

void getRoutes(unordered_map<string, vector<string> >& stations, unordered_map<string, vector<string> >& lines, unordered_multimap<string, string>& color){

	string currentStation = "Dwarka";
	string destination = "New Delhi";

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

		make_pair("Samaypur Badli", "Azadpur"), make_pair("Azadpur", "Civil Lines"), make_pair("Civil Lines", "Kashmere Gate"), make_pair("Kashmere Gate", "Chandni Chowk"), 
		make_pair("Chandni Chowk", "New Delhi"), make_pair("New Delhi", "Rajiv Chowk"), make_pair("Rajiv Chowk", "Central Secretariat"), make_pair("Central Secretariat", "INA"),
		make_pair("INA", "Hauz Khas"), make_pair("Hauz Khas", "Huda City Centre"), 


		// Blue Line

		make_pair("Dwarka Sec 21", "Dwarka Sec 8"),
		make_pair("Dwarka Sec 8", "Dwarka Sec 9"), 
		make_pair("Dwarka Sec 9", "Dwarka Sec 10"),
		make_pair("Dwarka Sec 10", "Dwarka Sec 11"), 
		make_pair("Dwarka Sec 11", "Dwarka Sec 12"), 
		make_pair("Dwarka Sec 12", "Dwarka Sec 13"),
		make_pair("Dwarka Sec 13", "Dwarka Sec 14"), 
		make_pair("Dwarka Sec 14", "Dwarka"), 
		make_pair("Dwarka", "Dwarka Mor"), 
		make_pair("Dwarka Mor", "Nawada"), 
		make_pair("Nawada", "Uttam Nagar (W)"), 
		make_pair("Uttam Nagar (W)", "Uttam Nagar (E)"), 
		make_pair("Uttam Nagar (E)", "Janakpuri West"),
		make_pair("Janakpuri West", "Janakpuri East"),
		make_pair("Janakpuri East", "Tilak Nagar"),
		make_pair("Tilak Nagar", "Subhash Nagar"),
		make_pair("Subhash Nagar", "Tagore Garden"),
		make_pair("Tagore Garden", "Rajouri Garden"),
		make_pair("Rajouri Garden", "Ramesh Nagar"),
		make_pair("Ramesh Nagar", "Moti Nagar"),
		make_pair("Moti Nagar", "Kirti Nagar"),
		make_pair("Kirti Nagar", "Shadipur"),
		make_pair("Shadipur", "Patel Nagar"),
		make_pair("Patel Nagar", "Rajendra Place"),
		make_pair("Rajendra Place", "Karol Bagh"),
		make_pair("Karol Bagh", "Jhandewalan"),
		make_pair("Jhandewalan", "RK Ashram Marg"),
		make_pair("RK Ashram Marg", "Rajiv Chowk"),
		make_pair("Rajiv Chowk", "Barakhamba Road"),
		make_pair("Barakhamba Road", "Mandi House"),
		make_pair("Mandi House", "Supreme Court"),
		make_pair("Supreme Court", "Indraprastha"),
		make_pair("Indraprastha", "Yamuna Bank"), 
		make_pair("Yamuna Bank", "Akshardham"),
		make_pair("Akshardham", "Mayur Vihar-1"), 
		make_pair("Mayur Vihar-1", "Mayur Vihar Ext"),
		make_pair("Mayur Vihar Ext", "New Ashok Nagar"),
		make_pair("New Ashok Nagar", "Noida Sec 15"),
		make_pair("Noida Sec 15", "Noida Sec 16"),
		make_pair("Noida Sec 16", "Noida Sec 18"),
		make_pair("Noida Sec 18", "Botanical Garden"),
		make_pair("Botanical Garden", "Golf Course"),
		make_pair("Golf Course", "Noida City Centre"),
		make_pair("Sec 34 Noida", "Sec 52 Noida"),
		make_pair("Sec 52 Noida", "Sec 61 Noida"),
		make_pair("Sec 61 Noida", "Sec 59 Noida"),
		make_pair("Sec 59 Noida", "Sec 62 Noida"),
		make_pair("Sec 62 Noida", "Noida Electronic City"),
		
		
		


		// Blue Line - Vaishali Route

		make_pair("Yamuna Bank", "Laxmi Nagar"),
		make_pair("Karkaduma", "Anand Vihar I.S.B.T."), 
		make_pair("Anand Vihar I.S.B.T.", "Vaishali"),

		// Violet Line

		make_pair("Kashmere Gate", "Lal Quila"),
		make_pair("Lal Quila", "Jama Masjid"),
		make_pair("Jama Masjid", "Delhi Gate"),
		make_pair("Delhi Gate", "I.T.O."),
		make_pair("I.T.O.", "Mandi House"),
		make_pair("Mandi House", "Janpath"),
		make_pair("Janpath", "Central Secretariat"),
		make_pair("Central Secretariat", "Khan Market"),
		make_pair("Khan Market", "JLN Stadium"),
		make_pair("JLN Stadium", "Jangpura"),
		make_pair("Jangpura", "Lajpat Nagar"),
		make_pair("Lajpat Nagar", "Kalkaji Mandir"),
		make_pair("Kalkaji Mandir", "Ballabgarh"),

		// Magenta Line

		make_pair("Botanical Garden", "Kalkaji Mandir"), make_pair("Kalkaji Mandir", "Hauz Khas"),
		make_pair("Hauz Khas", "Terminal 1-IGI Airport"), make_pair("Terminal 1-IGI Airport", "Janakpuri West"),


		// Airport Express Line

		make_pair("New Delhi", "Shivaji Stadium"), make_pair("Shivaji Stadium", "Dhaula Kuan"), make_pair("Dhaula Kuan", "Delhi Aerocity"),
		make_pair("Delhi Aerocity", "Airport"), make_pair("Airport", "Dwarka Sec 21"), 

		
		// Pink Line

		make_pair("Majlis Park", "Azadpur"), make_pair("Azadpur", "Netaji Subhash Place"), make_pair("Netaji Subhash Place", "Rajouri Garden"),
		make_pair("Rajouri Garden", "INA"), make_pair("INA", "Lajpat Nagar"), make_pair("Lajpat Nagar", "Hazrat Nizamuddin"), make_pair("Hazrat Nizamuddin", "Mayur Vihar-1"),
		make_pair("Mayur Vihar-1", "Anand Vihar I.S.B.T."), make_pair("Anand Vihar I.S.B.T.", "Karkaduma"), make_pair("Karkaduma", "Welcome"),
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
	unordered_multimap<string, string> color;
	color.insert(make_pair("Rithala", "RED"));
	color.insert(make_pair("Welcome", "RED"));
	color.insert(make_pair("New Bus Adda", "RED"));


	color.insert(make_pair("Inderlok", "GREEN"));
	color.insert(make_pair("City Park", "GREEN"));
	color.insert(make_pair("Kirti Nagar", "GREEN"));
	color.insert(make_pair("Ashok Park Main", "GREEN"));

	
	color.insert(make_pair("New Delhi", "ORANGE"));
	color.insert(make_pair("Shivaji Stadium", "ORANGE"));
	color.insert(make_pair("Dhaula Kuan", "ORANGE"));
	color.insert(make_pair("Delhi Aerocity", "ORANGE"));
	color.insert(make_pair("Airport", "ORANGE"));
	color.insert(make_pair("Dwarka Sec 21", "ORANGE"));

	
	color.insert(make_pair("Dwarka Sec 21", "BLUE"));
	color.insert(make_pair("Dwarka Sec 8", "BLUE"));
	color.insert(make_pair("Dwarka Sec 9", "BLUE"));
	color.insert(make_pair("Dwarka Sec 10", "BLUE"));
	color.insert(make_pair("Dwarka Sec 11", "BLUE"));
	color.insert(make_pair("Dwarka Sec 12", "BLUE"));
	color.insert(make_pair("Dwarka Sec 13", "BLUE"));
	color.insert(make_pair("Dwarka Sec 14", "BLUE"));
	color.insert(make_pair("Dwarka", "BLUE"));
	color.insert(make_pair("Dwarka Mor", "BLUE"));
	color.insert(make_pair("Nawada", "BLUE"));
	color.insert(make_pair("Uttam Nagar (W)", "BLUE"));
	color.insert(make_pair("Uttam Nagar (E)", "BLUE"));
	color.insert(make_pair("Janakpuri East", "BLUE"));
	color.insert(make_pair("Tilak Nagar", "BLUE"));
	color.insert(make_pair("Subhash Nagar", "BLUE"));
	color.insert(make_pair("Tagore Garden", "BLUE"));
	color.insert(make_pair("Ramesh Nagar", "BLUE"));
	color.insert(make_pair("Moti Nagar", "BLUE"));
	color.insert(make_pair("Shadipur", "BLUE"));
	color.insert(make_pair("Patel Nagar", "BLUE"));
	color.insert(make_pair("Rajendra Place", "BLUE"));
	color.insert(make_pair("Karol Bagh", "BLUE"));
	color.insert(make_pair("Jhandewalan", "BLUE"));
	color.insert(make_pair("RK Ashram Marg", "BLUE"));
	color.insert(make_pair("Barakhamba Road", "BLUE"));
	color.insert(make_pair("Mandi House", "BLUE"));
	color.insert(make_pair("Supreme Court", "BLUE"));
	color.insert(make_pair("Indraprastha", "BLUE"));
	color.insert(make_pair("Yamuna Bank", "BLUE"));
	color.insert(make_pair("Akshardham", "BLUE"));
	color.insert(make_pair("Mayur Vihar-1", "BLUE"));
	color.insert(make_pair("Mayur Vihar Ext", "BLUE"));
	color.insert(make_pair("New Ashok Nagar", "BLUE"));
	color.insert(make_pair("Noida Sec 15", "BLUE"));
	color.insert(make_pair("Noida Sec 16", "BLUE"));
	color.insert(make_pair("Noida Sec 18", "BLUE"));
	color.insert(make_pair("Golf Course", "BLUE"));
	color.insert(make_pair("Noida City Centre", "BLUE"));
	color.insert(make_pair("Sec 34 Noida", "BLUE"));
	color.insert(make_pair("Sec 52 Noida", "BLUE"));
	color.insert(make_pair("Sec 61 Noida", "BLUE"));
	color.insert(make_pair("Sec 59 Noida", "BLUE"));
	color.insert(make_pair("Sec 62 Noida", "BLUE"));
	color.insert(make_pair("Noida Electronic City", "BLUE"));

	color.insert(make_pair("Laxmi Nagar Nagar", "BLUE"));
	color.insert(make_pair("Nirman Vihar", "BLUE"));
	color.insert(make_pair("Preet Vihar", "BLUE"));
	color.insert(make_pair("Kaushambi", "BLUE"));
	color.insert(make_pair("Vaishali", "BLUE"));

	
	color.insert(make_pair("Majlis Park", "PINK"));
	color.insert(make_pair("Azadpur", "PINK"));
	color.insert(make_pair("Netaji Subhash Place", "PINK"));
	color.insert(make_pair("Rajouri Garden", "PINK"));
	color.insert(make_pair("Lajpat Nagar", "PINK"));
	color.insert(make_pair("Hazrat Nizamuddin", "PINK"));
	color.insert(make_pair("Anand Vihar I.S.B.T.", "PINK"));
	color.insert(make_pair("Karkaduma", "PINK"));
	color.insert(make_pair("Shiv Vihar", "PINK"));
	

	color.insert(make_pair("Kashmere Gate", "VIOLET"));
	color.insert(make_pair("Central Secretariat", "VIOLET"));
	color.insert(make_pair("Kalkaji Mandir", "VIOLET"));
	color.insert(make_pair("Ballabgarh", "VIOLET"));

	
	color.insert(make_pair("Samaypur Badli", "YELLOW"));
	color.insert(make_pair("Civil Lines", "YELLOW"));
	color.insert(make_pair("Chandni Chowk", "YELLOW"));
	color.insert(make_pair("Rajiv Chowk", "YELLOW"));
	color.insert(make_pair("INA", "YELLOW"));
	color.insert(make_pair("Hauz Khas", "YELLOW"));
	color.insert(make_pair("Huda City Centre", "YELLOW"));


	color.insert(make_pair("Janakpuri West", "MAGENTA"));
	color.insert(make_pair("Shankar Vihar", "MAGENTA"));
	color.insert(make_pair("Botanical Garden", "MAGENTA"));


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