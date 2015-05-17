/*
	Behandelt Events für die Verwaltung von dem Taxifahrerarray
	
	Author: Just-Look | Aequalitas
*/

private["_type","_tmp","_uid","_taxiposition"];

_type = [_this,0] call BIS_fnc_Param;
_uid = [_this,1] call BIS_fnc_Param;
_taxiposition = [_this,2] call BIS_fnc_Param;

diag_log format ["////////////alletaxisarray : %1 => %2",_type,_uid];

switch(_type) do {

	///Taxifahrer geht onDuty
	case 1: 
	{
		if(isNil {alleTaxifahrerOnDuty} ) exitWith { alleTaxifahrerOnDuty = [];};
		alleTaxifahrerOnDuty set [count alleTaxifahrerOnDuty,[_uid,false,_taxiposition]];
	};
	
	//////Taxifahrer geht offDuty
	case 2:
	{
		
		
			
			
		for "_i" from 0 to count alleTaxifahrerOnDuty do {
		
			diag_log format["%1 == %2  ?",alleTaxifahrerOnDuty select _i select 0 ,_uid];
			
				if(alleTaxifahrerOnDuty select _i select 0 == _uid) exitWith {
	
						alleTaxifahrerOnDuty set [_i,objNull];
						alleTaxifahrerOnDuty = alleTaxifahrerOnDuty - [objNull];
						
						diag_log "erfolgreich gelöscht////////////";
					 
				};
		
		
		};
		
	};
	
	////Taxifahrer geht besetzt
	
	case 3:
	{
		for "_i" from 0 to count alleTaxifahrerOnDuty do {
			
			if(alleTaxifahrerOnDuty select _i select 0 == _uid) exitWith {
				
				
				alleTaxifahrerOnDuty select _i set [1,true];
				
				diag_log "//////////////////// taxifahrer wird frei";
				
				};
		
		};
		
	};
	
	///Taxifahrer geht wird frei
	case 4:
	{
	
		for "_i" from 0 to count alleTaxifahrerOnDuty do {
			
			if(alleTaxifahrerOnDuty select _i select 0 == _uid) exitWith {
				
				diag_log "///////////////////////taxifahrer besetzt";
				
				alleTaxifahrerOnDuty select _i set [1,false];
				
				};
		
		};
	};
	
	case 5:
	{
		
		[[alleTaxifahrerOnDuty],"jl_fnc_setTaxisArray",_uid,false] spawn life_fnc_MP;
		diag_log format["//////////////Taxiarray wurde an %1 geschickt",_uid];
	};
};
diag_log format["alle Taxifahrer //////////////// %1",alleTaxifahrerOnDuty];
