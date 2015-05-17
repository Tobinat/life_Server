/*
	File: fn_jerryRefuel.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Refuels the vehicle if the player has a fuel can.
*/
private["_vehicle","_displayName","_upp","_ui","_progress","_pgText","_cP","_previousState","_ext"];
_vehicle = cursorTarget;
diag_log format["::fn_truckStorageExtension Ausgeführt::"];
life_interrupted = false;
if(isNull _vehicle) exitWith {hint "Du musst auf das Fahrzeug schauen um es zu erweitern!"};
if(!(_vehicle isKindOF "LandVehicle")) exitWith {};
if(!((typeOf _vehicle == "B_Truck_01_transport_F") || (typeOf _vehicle == "O_Truck_03_transport_F") || (typeOf _vehicle == "C_Van_01_transport_F") || (typeOf _vehicle == "C_Offroad_01_F") || (typeOf _vehicle == "O_Truck_02_transport_F"))) exitWith {hint "Dieses Fahrzeug kann nicht erweitert werden!"};
if(player distance _vehicle > 7.5) exitWith {hint "Du musst näher am Auto stehen!"};

if(!([false,"truckstorageextension",1] call life_fnc_handleInv)) exitWith {};
life_action_inUse = true;
_displayName = getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");

_upp = format["Erweitere Fahrzeug: %1",_displayName];
//Setup our progress bar.
disableSerialization;
5 cutRsc ["life_progress","PLAIN"];
_ui = uiNameSpace getVariable "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
_progress progressSetPosition 0.01;
_cP = 0.01;

while{true} do
{
	if(animationState player != "AinvPknlMstpSnonWnonDnon_medic_1") then {
		[[player,"AinvPknlMstpSnonWnonDnon_medic_1"],"life_fnc_animSync",true,false] spawn life_fnc_MP;
		player playMoveNow "AinvPknlMstpSnonWnonDnon_medic_1";
	};
	sleep 0.2;
	if(isNull _ui) then {
		5 cutRsc ["life_progress","PLAIN"];
		_ui = uiNamespace getVariable "life_progress";
		_progressBar = _ui displayCtrl 38201;
		_titleText = _ui displayCtrl 38202;
	};
	_cP = _cP + 0.01;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
	if(_cP >= 1) exitWith {};
	if(!alive player) exitWith {};
	if(life_interrupted) exitWith {};
};
life_action_inUse = false;
5 cutText ["","PLAIN"];
player playActionNow "stop";
if(!alive player) exitWith {};
if(life_interrupted) exitWith {life_interrupted = false; titleText["Action cancelled","PLAIN"];};


switch (true) do
{
	case (_vehicle isKindOF "LandVehicle"):
	{
		switch(typeOf _vehicle) do{
		
			case "B_Truck_01_transport_F": 
			{ 
				_ext = _vehicle getVariable ["TruckExt",0];
				if(_ext == 0) then {
					_cargo = "Land_CargoBox_V1_F" createVehicle position _vehicle;
					_cargo attachTo [_vehicle, [0,-0.2,0.2]]; 
					_vehicle setVariable ["TruckExt",1,true];
					_vehicle setVariable ["TruckExt_01",_cargo,true];
				};
				if(_ext == 1) then {
					_cargo = "Land_CargoBox_V1_F" createVehicle position _vehicle;
					_cargo attachTo [_vehicle, [0,-1.8,0.2]]; 
					_vehicle setVariable ["TruckExt",2,true];
					_vehicle setVariable ["TruckExt_02",_cargo,true];
				};
				if(_ext == 2) then {
					_cargo = "Land_CargoBox_V1_F" createVehicle position _vehicle;
					_cargo attachTo [_vehicle, [0,-3.4,0.2]]; 
					_vehicle setVariable ["TruckExt",3,true];
					_vehicle setVariable ["TruckExt_03",_cargo,true];
				};
					
			};
			case "O_Truck_03_transport_F": {
				_ext = _vehicle getVariable ["TruckExt",0];
				if(_ext == 0) then {
					_cargo = "Land_CargoBox_V1_F" createVehicle position _vehicle;
					_cargo attachTo [_vehicle, [0,-0.8,0.2]]; 
					_vehicle setVariable ["TruckExt",1,true];
					_vehicle setVariable ["TruckExt_01",_cargo,true];
				};
				if(_ext == 1) then {
					_cargo = "Land_CargoBox_V1_F" createVehicle position _vehicle;
					_cargo attachTo [_vehicle, [0,-2.4,0.2]]; 
					_vehicle setVariable ["TruckExt",2,true];
					_vehicle setVariable ["TruckExt_02",_cargo,true];
				};
				if(_ext == 2) then {
					_cargo = "Land_CargoBox_V1_F" createVehicle position _vehicle;
					_cargo attachTo [_vehicle, [0,-4,0.2]]; 
					_vehicle setVariable ["TruckExt",3,true];
					_vehicle setVariable ["TruckExt_03",_cargo,true];
				};
			};
			case "C_Offroad_01_F": {
				_ext = _vehicle getVariable ["TruckExt",0];
				if(_ext == 0) then {
					_cargo = "Land_CargoBox_V1_F" createVehicle position _vehicle;
					_cargo attachTo [_vehicle, [0,-1.8,0.2]]; 
					_vehicle setVariable ["TruckExt",1,true];
					_vehicle setVariable ["TruckExt_01",_cargo,true];
				};
			};
			case "C_Van_01_transport_F": {
				_ext = _vehicle getVariable ["TruckExt",0];
				if(_ext == 0) then {
					_cargo = "Land_CargoBox_V1_F" createVehicle position _vehicle;
					_cargo attachTo [_vehicle, [0,-1.8,0.2]]; 
					_vehicle setVariable ["TruckExt",1,true];
					_vehicle setVariable ["TruckExt_01",_cargo,true];
				};
			};
			case "O_Truck_02_transport_F": {
			_ext = _vehicle getVariable ["TruckExt",0];
				if(_ext == 0) then {
					_cargo = "Land_CargoBox_V1_F" createVehicle position _vehicle;
					_cargo attachTo [_vehicle, [0,0.4,0.2]]; 
					_vehicle setVariable ["TruckExt",1,true];
					_vehicle setVariable ["TruckExt_01",_cargo,true];
				};
				if(_ext == 1) then {
					_cargo = "Land_CargoBox_V1_F" createVehicle position _vehicle;
					_cargo attachTo [_vehicle, [0,-1.2,0.2]]; 
					_vehicle setVariable ["TruckExt",2,true];
					_vehicle setVariable ["TruckExt_02",_cargo,true];
				};
				if(_ext == 2) then {
					_cargo = "Land_CargoBox_V1_F" createVehicle position _vehicle;
					_cargo attachTo [_vehicle, [0,-2.8,0.2]]; 
					_vehicle setVariable ["TruckExt",3,true];
					_vehicle setVariable ["TruckExt_03",_cargo,true];
				};
			};
		};

	};
	
};
titleText[format["Du hast %1 erweitert",_displayName],"PLAIN"];