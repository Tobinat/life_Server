/*
	File: fn_vehicleStore.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Stores the vehicle in the 'Garage'
*/
private["_vehicle","_impound","_vInfo","_vInfo","_plate","_uid","_query","_sql","_unit","_fuel","_km","_ext","_extDel"];
_vehicle = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
_impound = [_this,1,false,[true]] call BIS_fnc_param;
_unit = [_this,2,ObjNull,[ObjNull]] call BIS_fnc_param;

if(isNull _vehicle OR isNull _unit) exitWith {life_impound_inuse = false; (owner _unit) publicVariableClient "life_impound_inuse";life_garage_store = false;(owner _unit) publicVariableClient "life_garage_store";}; //Bad data passed.

_vInfo = _vehicle getVariable["dbInfo",[]];
_fuel = (fuel _vehicle) * 1000;
_km = _vehicle getVariable ["vehKM",0];
_trunkData = _vehicle getVariable["Trunk",[[],0]];
_trunkData = [_trunkData] call DB_fnc_mresArray;
_ext = _vehicle getVariable ["TruckExt",0];
if(count _vInfo > 0) then
{
	_plate = _vInfo select 1;
	_uid = _vInfo select 0;
};

if(_impound) then
{
	if(count _vInfo == 0) then 
	{
		life_impound_inuse = false;
		(owner _unit) publicVariableClient "life_impound_inuse";
		if(!isNil "_vehicle" && {!isNull _vehicle}) then {
			deleteVehicle _vehicle;
			if(_ext > 0) then {
				_extDel = _vehicle getVariable "TruckExt_01";
				deleteVehicle _extDel;
			};
			if(_ext > 1) then {
				_extDel = _vehicle getVariable "TruckExt_02";
				deleteVehicle _extDel;
			};
			if(_ext > 2) then {
				_extDel = _vehicle getVariable "TruckExt_03";
				deleteVehicle _extDel;
			};
			
		};
	} 
		else
	{
		_query = format["UPDATE vehicles SET active='0', inventory='%3',posx='0',posy='0',posz='0',fuel='%4',km='%5',imbound='1',ext='%6' WHERE pid='%1' AND plate='%2'",_uid,_plate,_trunkData,_fuel,_km,_ext];
		waitUntil {!DB_Async_Active};
		_thread = [_query,1] call DB_fnc_asyncCall;
		//waitUntil {scriptDone _thread};
		if(!isNil "_vehicle" && {!isNull _vehicle}) then {
			deleteVehicle _vehicle;
			if(_ext > 0) then {
				_extDel = _vehicle getVariable "TruckExt_01";
				deleteVehicle _extDel;
			};
			if(_ext > 1) then {
				_extDel = _vehicle getVariable "TruckExt_02";
				deleteVehicle _extDel;
			};
			if(_ext > 2) then {
				_extDel = _vehicle getVariable "TruckExt_03";
				deleteVehicle _extDel;
			};
		};
		life_impound_inuse = false;
		(owner _unit) publicVariableClient "life_impound_inuse";
	};
}
	else
{
	if(count _vInfo == 0) exitWith
	{
		[[1,(localize "STR_Garage_Store_NotPersistent")],"life_fnc_broadcast",(owner _unit),false] spawn life_fnc_MP;
		life_garage_store = false;
		(owner _unit) publicVariableClient "life_garage_store";
		if(!isNil "_vehicle" && {!isNull _vehicle}) then {
			deleteVehicle _vehicle;
			if(_ext > 0) then {
				_extDel = _vehicle getVariable "TruckExt_01";
				deleteVehicle _extDel;
			};
			if(_ext > 1) then {
				_extDel = _vehicle getVariable "TruckExt_02";
				deleteVehicle _extDel;
			};
			if(_ext > 2) then {
				_extDel = _vehicle getVariable "TruckExt_03";
				deleteVehicle _extDel;
			};
		};
	};
	
	if(_uid != getPlayerUID _unit) exitWith
	{
		[[1,(localize "STR_Garage_Store_NoOwnership")],"life_fnc_broadcast",(owner _unit),false] spawn life_fnc_MP;
		life_garage_store = false;
		(owner _unit) publicVariableClient "life_garage_store";
	};
	
	_query = format["UPDATE vehicles SET active='0', inventory='%3',posx='0',posy='0',posz='0',fuel='%4',km='%5',ext='%6',imbound='0' WHERE pid='%1' AND plate='%2'",_uid,_plate,_trunkData,_fuel,_km,_ext];
	waitUntil {!DB_Async_Active};
	_thread = [_query,1] call DB_fnc_asyncCall;
	//waitUntil {scriptDone _thread};
	if(!isNil "_vehicle" && {!isNull _vehicle}) then {
		deleteVehicle _vehicle;
		if(_ext > 0) then {
			_extDel = _vehicle getVariable "TruckExt_01";
			deleteVehicle _extDel;
		};
		if(_ext > 1) then {
			_extDel = _vehicle getVariable "TruckExt_02";
			deleteVehicle _extDel;
		};
		if(_ext > 2) then {
			_extDel = _vehicle getVariable "TruckExt_03";
			deleteVehicle _extDel;
		};
	};
	life_garage_store = false;
	(owner _unit) publicVariableClient "life_garage_store";
	[[1,(localize "STR_Garage_Store_Success")],"life_fnc_broadcast",(owner _unit),false] spawn life_fnc_MP;
};