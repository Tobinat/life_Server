/*
	File: fn_updateVehicleOwner.sqf
	Author: Mindsaver
	
	Description:
	Updates the vehicle owner
*/
private["_vid","_vpid","_pid","_query","_sql","_vehicle","_nearVehicles","_name","_side","_tickTime","_dir"];

_pid = [_this,0,"",[""]] call BIS_fnc_param;

{

	_vpid = _vpid select 0;
	diag_log format ["::Vehicle Found::_vpid: %1 | _pid: %2", _vpid,_pid];
	if( _vpid == _pid) then{
	diag_log format ["Vehicle Found: %1", vehicleArray];
	//Update Client
	}

}forEach vehicleArray;

