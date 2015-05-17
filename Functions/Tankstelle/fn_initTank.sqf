private["_query","_queryResult"];

_query = format["SELECT id,fuel,pos FROM tankstellen"];
waitUntil{!DB_Async_Active};
_queryResult = [_query,2,true] call DB_fnc_asyncCall;
server_tankstellen = [];
if(typeName _queryResult == "STRING") exitWith {};
{
	_new = [(_x select 2)] call DB_fnc_mresToArray;
	if(typeName _new == "STRING") then {_new = call compile format["%1", _new];};

	_tankarray = [(_x select 0),(_x select 1),_new];
	server_tankstellen set[(count server_tankstellen),_tankarray];

}foreach _queryResult;


tankstellen = server_tankstellen;
diag_log format ["::Loading Tankstelle::tankstellen::%1",tankstellen];
publicVariable "tankstellen";
diag_log format ["::Loading Tankstellen::server_tankstellen::%1",server_tankstellen];
