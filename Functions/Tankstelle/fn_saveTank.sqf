

private["_tindex","_tankfuel","_tankarray","_pos"];
_tindex = [_this,0,0,[0]] call BIS_fnc_param;
_tankid = [_this,1,0,[0]] call BIS_fnc_param;
_tankfuel = [_this,2,0,[0]] call BIS_fnc_param;


_query = format["UPDATE tankstellen SET fuel='%2' WHERE id='%1'",_tankid,_tankfuel];
waitUntil {!DB_Async_Active};
[_query,1] call DB_fnc_asyncCall;

_pos = server_tankstellen select _tindex;
_pos = _pos select 2;

_tankarray = [_tankid,_tankfuel,_pos];

server_tankstellen set [_tindex,_tankarray];

diag_log format ["::saving Tankstelle::server_tankstellen::%1",server_tankstellen];

tankstellen = server_tankstellen;

publicVariable "tankstellen";
