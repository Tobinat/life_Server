/*
	File: fn_wantedAdd.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Adds or appends a unit to the wanted list.
*/
private["_uid","_type","_index","_data","_crimes","_val","_customBounty","_name"];
_uid = [_this,0,"",[""]] call BIS_fnc_param;
_name = [_this,1,"",[""]] call BIS_fnc_param;
_type = [_this,2,"",[""]] call BIS_fnc_param;
_customBounty = [_this,3,-1,[0]] call BIS_fnc_param;
if(_uid == "" OR _type == "" OR _name == "") exitWith {}; 


switch(_type) do
{
	case "187V": {_type = ["Fahrlaessige Toetung",6500]};
	case "187": {_type = ["Totschlag",15000]};
	case "901": {_type = ["JVA ausbruch",7500]};
	case "261": {_type = ["Raub",5000]}; //What type of sick bastard would add this?
	case "261A": {_type = ["versuchter Raub",3000]};
	case "215": {_type = ["versuchter Autodiebstahl",2000]};
	case "213": {_type = ["Verwenden illegaler Sprengstoff",10000]};
	case "211": {_type = ["Diebstahl",1000]};
	case "212": {_type = ["ATM Aufgebrochen",20000]};
	case "207": {_type = ["Entfuehrung",3500]};
	case "207A": {_type = ["versuchte Entfuehrung",2000]};
	case "211A": {_type = ["Tankstellenraub",20000]};
	case "487": {_type = ["Autodiebstahl",10000]};
	case "488": {_type = ["versuchter Autodiebstahl",2000]};
	case "480": {_type = ["Hit and run",1300]};
	case "481": {_type = ["Drogenherstellung",1000]};
	case "482": {_type = ["Intent to distribute",5000]};
	case "483": {_type = ["Drug Trafficking",9500]};
	case "459": {_type = ["Burglary",6500]};
	case "907": {_type = ["FEAR Führeschein",50000]};
	case "919": {_type = ["Organ Handel",20000]};
	case "390": {_type = ["Public Intoxication",15000]};
	
	
	case "1": {_type = ["Fahren ohne Führerschein",3000]};
    case "2": {_type = ["Fahren ohne Licht Nachts",500]};
    case "3": {_type = ["Fahren auf der falschen Straßenseite",2000]};
    case "4": {_type = ["Unfallverursacher",2500]};
    case "5": {_type = ["Fahrerflucht nach Unfall",5000]};
    case "6": {_type = ["Behinderung des Verkehrs",1000]};
    case "7": {_type = ["Vorsätzliches Überfahren von Spielern",10000]};
    case "8": {_type = ["Falschparken",1000]};
    case "9": {_type = ["Behinderung des Fahrzeugspawns",2000]};
    case "10": {_type = ["Offroad (übers Feld fahren)",2000]};
    case "11": {_type = ["Führen eines Illegalen Fahrzeugs",35000]};
    case "12": {_type = ["Lärmbelästigung durch unnötiges Hupen",1000]};
    case "13": {_type = ["Kein Sanikasten beim führen eines Fahrzeuges",250]};
    case "14": {_type = ["Kein Werkzeugkasten beim führen eines Fahrzeuges",250]};
    case "15": {_type = ["Innerorts über 50km/h",750]};
    case "16": {_type = ["Innerorts über 60km/h",1500]};
    case "17": {_type = ["Innerorts über 85km/h",5000]};
    case "18": {_type = ["Innerorts über 110km/h",10000]};
    case "19": {_type = ["Außerorts über 130km/h+",10000]};
    case "20": {_type = ["Schweben über bewohntem Gebiet unter 150m",5000]};
    case "21": {_type = ["Landen in bewohntem Gebiet innerhalb 500 Meter der Grenze",10000]};
    case "22": {_type = ["Landen auf Straßen",15000]};
    case "23": {_type = ["Landen in gesperrten gebieten z.B.: Polizeistationen, Bank",30000]};
    case "24": {_type = ["Heli-Rettung / Sicherung vor der Polizei",5000]};
    case "25": {_type = ["Fliegen ohne Beleuchtung Kollisionsleuchten",5000]};
    case "26": {_type = ["Fliegen ohne Lizenz",7500]};
    case "27": {_type = ["Lockpicking versuchter Fahrzeugdiebstahl",2000]};
    case "28": {_type = ["Lockpicking + Fahrzeugdiebstahl",10000]};
    case "29": {_type = ["Unbeabsichtigte Fahrzeugbeschädigung mit Fahrzeug",5000]};
    case "30": {_type = ["Versuchter Raubüberfall",2500]};
    case "31": {_type = ["Raubüberfall",7500]};
    case "32": {_type = ["Mord",15000]};
    case "33": {_type = ["Ausbruch aus dem Gefängnis",7500]};
    case "34": {_type = ["Beihilfe beim Gefängisausbruch",10000]};
    case "35": {_type = ["Misslungener Banküberfall",50000]};
    case "36": {_type = ["Geglückter Banküberfall",90000]};
    case "37": {_type = ["Drogenschmuggel/-handel",50000]};
    case "38": {_type = ["Drogenschmuggel/ -handel bei Info durch Dealer/ Wanted Liste",25000]};
    case "39": {_type = ["Schmuggel mit verbotenen Tieren Schildkröten",50000]};
    case "40": {_type = ["Nutzung von Illegalen Substanzen",25000]};
	case "41": {_type = ["versuchte Entführung",10000]};
	case "42": {_type = ["Enführung",50000]};
	case "43": {_type = ["Flüchtig",2500]};
	case "44": {_type = ["Betrugsabsichten",15000]};
	case "45": {_type = ["Störung der Öffentlichen Ordnung",5000]};
	case "46": {_type = ["Betreten von Sperrzonen z.B. Polizeistation",10000]};
	case "47": {_type = ["Missbrauch des Notruf Systems",100000]};
	case "48": {_type = ["Behinderung der Polizei einmaliger Verstoß",2500]};
	case "49": {_type = ["Behinderung der Polizei mehrfach",5000]};
	case "50": {_type = ["Beleidigung gegenüber der Polizei einmaliger Verstoß",5000]};
	case "51": {_type = ["Beleidigung gegenüber der Polizei mehrfach",7500]};
	case "52": {_type = ["Befreien festgesetzter Personen einmaliger Verstoß",25000]};
	case "53": {_type = ["Befreien festgesetzter Personen mehrfach",25000]};
	case "54": {_type = ["Inspizierung der Ausrüstung und Fahrzeuge von Beamten",5000]};
	case "55": {_type = ["Beamtenbeschuss",15000]};
	case "56": {_type = ["Töten eines Beamten",50000]};
	case "57": {_type = ["Waffe sichtbar tragen gezogen Innerorts",7500]};
	case "58": {_type = ["Waffe abfeuern Innerorts",15000]};
	case "59": {_type = ["Verursachter Personenschaden mit einer Waffe",20000]};
	case "60": {_type = ["Besitz einer Waffe ohne Lizenz",20000]};
	case "61": {_type = ["Verursachter Personenschaden / Tötung mit einer illegalen Waffe",50000]};
	
    
	
	
	
	
	
	default {_type = [];};

	
	
	
	
	
	
	
};

if(count _type == 0) exitWith {}; 

if(_customBounty != -1) then {_type set[1,_customBounty];};

_index = [_uid,life_wanted_list] call fnc_index;

if(_index != -1) then
{
_data = life_wanted_list select _index;
_crimes = _data select 2;
_crimes set[count _crimes,(_type select 0)];
_val = _data select 3;
life_wanted_list set[_index,[_name,_uid,_crimes,(_type select 1) + _val]];
}
else
{
life_wanted_list set[count life_wanted_list,[_name,_uid,[(_type select 0)],(_type select 1)]];
};

diag_log format["WANTED_LIST = %1", life_wanted_list];
_gesuchter = [life_wanted_list] call DB_fnc_mresArray;
_query = format["UPDATE wanted set list = '%1'", _gesuchter];
waitUntil {sleep (random 0.3); !DB_Async_Active};
_queryResult = [_query,1] call DB_fnc_asyncCall;