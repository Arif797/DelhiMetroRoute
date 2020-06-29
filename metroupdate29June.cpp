#include<unordered_map>
#include<unordered_set>
#include<iostream>
#include<vector>
#include<queue>
#include<set>
using namespace std;

bool isEqual(string& A, string& B){
	
	if (A.size() != B.size())
		return false;
	for (int i = 0; i < A.size(); i++)
		if (A[i] != B[i])
			return false;
	return true;
}

bool isSameColor(unordered_multimap<string, string>& color, 
	string requiredColor, 
	string destination){
	// loop over all the color present in destination node
	auto itr = color.equal_range(destination);
	for (auto j = itr.first; j != itr.second; j++)
		if (isEqual(j -> second, requiredColor))
			return true;
	return false;
}

string getNextStationColor(unordered_multimap<string, string>& color, 
	string currentStation, 
	string nextStation){

	auto itr = color.equal_range(currentStation);
	for (auto j = itr.first; j != itr.second; j++)
		if (isSameColor(color, j -> second, nextStation))
			return j -> second;

		return "";
}

void getIntermediateLines(vector<vector<string> >& totalColorPaths,
	vector<string> colorPath, string currentLine, string destination, 
	unordered_map<string, vector<string> >& lines, 
	unordered_map<string, bool>& visitedLines,
	unordered_multimap<string, string>& color){

	colorPath.push_back(currentLine);

	if (isSameColor(color, currentLine, destination)){
		totalColorPaths.push_back(colorPath);
		return;
	}	

	visitedLines[currentLine] = true;
	for (auto line : lines[currentLine])
		if (!visitedLines[line])
			getIntermediateLines(totalColorPaths, colorPath, line, destination, lines, visitedLines, color);
	visitedLines[currentLine] = false;
}

void getIntermediateStations(vector<vector<string> >& totalStationPaths, 
	vector<string> stationPath, 
	string currentStation, 
	string& destination, 
	unordered_map<string, vector<string> >& stations, 
	unordered_map<string, bool>& visitedStation, 
	unordered_multimap<string, string>& color, 
	queue<string>& q, 
	string& currentLine){

	stationPath.push_back(currentStation);

	if (isEqual(currentStation, destination)){
		totalStationPaths.push_back(stationPath);
		return;
	}

	visitedStation[currentStation] = true;
	for (auto nextStation : stations[currentStation]){
		if (!visitedStation[nextStation]){

			// stay on the same color line
			if (isSameColor(color, currentLine, nextStation))
				
				getIntermediateStations(totalStationPaths, stationPath, nextStation, destination, stations, visitedStation, color, q, currentLine);

			// switch to next color line only if q.front == color of next station
			else if (!q.empty() && isSameColor(color, q.front(), nextStation)){
				
				currentLine = q.front();
				q.pop();
				getIntermediateStations(totalStationPaths, stationPath, nextStation, destination, stations, visitedStation, color, q, currentLine);
			}
		}
	}
	visitedStation[currentStation] = false;
}

void getRoutes(unordered_map<string, vector<string> >& stations,
	unordered_map<string, vector<string> >& lines, 
	unordered_multimap<string, string>& color, 
	string& currentStation, 
	string& destination){
	
	// mark all lines unvisited
	unordered_map<string, bool> visitedLines;
	for (auto line : lines)		
		visitedLines[line.first] = false;	

	vector<vector<string> > totalColorPaths;
	vector<string> colorPath;

	auto junction = color.equal_range(currentStation);
	for (auto currentLine = junction.first; currentLine != junction.second; currentLine++){
		visitedLines[currentLine -> second] = true;
		getIntermediateLines(totalColorPaths, colorPath, currentLine -> second, destination, lines, visitedLines, color);
		visitedLines[currentLine -> second] = false;
	}

	// for (auto colorPath : totalColorPaths){
	// 	for (auto color : colorPath)
	// 		cout << color << ' ';
	// 	cout << endl;
	// }

	vector<vector<string> > totalStationPaths;
	for (auto colorPath : totalColorPaths){

		queue<string> q;
		for (int i = 1; i < colorPath.size(); i++)
			q.push(colorPath[i]);

		string currentLine = colorPath[0];
		vector<string> stationPath;

		unordered_map<string, bool> visitedStation;
		for (auto station : stations)	visitedStation[station.first] = false;	

		getIntermediateStations(totalStationPaths, stationPath, currentStation, destination, stations, visitedStation, color, q, currentLine);
	}

	// remove all duplicate paths (put in set)
	set<vector<string> > uniquePaths;
	for (auto route : totalStationPaths)
		uniquePaths.insert(route);


	// sort by no of stations (put again in vector)
	vector<pair<int, vector<string> > > allUniquePaths;
	for (auto route : uniquePaths)
		allUniquePaths.push_back(make_pair(route.size(), route));
	sort(allUniquePaths.begin(), allUniquePaths.end());




	for (int i = 0; i < allUniquePaths.size(); i++){

		cout << "Route " << i + 1 << " -----------------------> " << endl;
		string currentLineColor ("");

		for (int j = 0; j < allUniquePaths[i].first; j++){

			string currentStation = allUniquePaths[i].second[j];

			if (isSameColor(color, currentLineColor, currentStation)){
				// do nothing
			}
			else if (j + 1 == allUniquePaths[i].first)
				currentLineColor = color.find(currentStation) -> second;
			
			else{
				string nextStation = allUniquePaths[i].second[j + 1];

				string currentColor = getNextStationColor(color, currentStation, nextStation);

				if (currentColor.size() > 0)
					currentLineColor = currentColor;
				else
					currentLineColor = color.find(nextStation) -> second ;
				// cout << "change to " << currentLineColor << endl;
			}
			cout << currentStation << " -> " << currentLineColor << endl;
		}
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
	color.insert(make_pair("Kirti Nagar", "BLUE"));
	color.insert(make_pair("Ashok Park Main", "GREEN"));

	
	color.insert(make_pair("New Delhi", "ORANGE"));
	color.insert(make_pair("New Delhi", "YELLOW"));
	color.insert(make_pair("Shivaji Stadium", "ORANGE"));
	color.insert(make_pair("Dhaula Kuan", "ORANGE"));
	color.insert(make_pair("Delhi Aerocity", "ORANGE"));
	color.insert(make_pair("Airport", "ORANGE"));
	color.insert(make_pair("Dwarka Sec 21", "BLUE"));
	color.insert(make_pair("Dwarka Sec 21", "ORANGE"));

	
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
	color.insert(make_pair("Sec Noida 34", "BLUE"));
	color.insert(make_pair("Sec Noida 52", "BLUE"));
	color.insert(make_pair("Sec Noida 61", "BLUE"));
	color.insert(make_pair("Sec Noida 59", "BLUE"));
	color.insert(make_pair("Sec Noida 62", "BLUE"));
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
	color.insert(make_pair("Rajouri Garden", "BLUE"));
	color.insert(make_pair("Lajpat Nagar", "PINK"));
	color.insert(make_pair("Hazrat Nizamuddin", "PINK"));
	color.insert(make_pair("Anand Vihar I.S.B.T.", "PINK"));
	color.insert(make_pair("Karkaduma", "PINK"));
	color.insert(make_pair("Shiv Vihar", "PINK"));
	

	color.insert(make_pair("Kashmere Gate", "VIOLET"));
	color.insert(make_pair("Central Secretariat", "VIOLET"));
	color.insert(make_pair("Central Secretariat", "YELLOW"));
	color.insert(make_pair("Kalkaji Mandir", "VIOLET"));
	color.insert(make_pair("Ballabgarh", "VIOLET"));

	
	color.insert(make_pair("Samaypur Badli", "YELLOW"));
	color.insert(make_pair("Civil Lines", "YELLOW"));
	color.insert(make_pair("Chandni Chowk", "YELLOW"));
	color.insert(make_pair("Rajiv Chowk", "YELLOW"));
	color.insert(make_pair("Rajiv Chowk", "BLUE"));
	color.insert(make_pair("INA", "YELLOW"));
	color.insert(make_pair("Hauz Khas", "YELLOW"));
	color.insert(make_pair("Huda City Centre", "YELLOW"));
	

	color.insert(make_pair("Janakpuri West", "MAGENTA"));
	color.insert(make_pair("Janakpuri West", "BLUE"));
	color.insert(make_pair("Shankar Vihar", "MAGENTA"));
	color.insert(make_pair("Botanical Garden", "MAGENTA"));



	string currentStation = "Rajiv Chowk";
	string destination = "Kashmere Gate";

	getRoutes(stations, lines, color, currentStation, destination);

	// // lines adjacency list
	// for (auto i : stations){
	// 	cout << i.first << " -> ";
	// 	for (auto j : i.second)
	// 		cout << j << " |";
	// 	cout << endl; 
	// }

	return 0;
}