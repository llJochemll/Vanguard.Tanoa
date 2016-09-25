/////////////////////////
//Script made by Jochem//
/////////////////////////
houses = [];
housesSafe = [];
housesVillages = [];
housesTowns = [];
housesCapitals = [];
housesRemote = [];

//Strategic compounds
strategic = nearestObjects [[worldSize/2,worldSize/2], ["Land_BagBunker_Small_F","Land_Cargo_House_V1_F","Land_Cargo_House_V2_F","Land_Cargo_House_V3_F","Land_BagBunker_Large_F","Land_BagBunker_Tower_F",
"Land_Cargo_HQ_V1_F","Land_Cargo_HQ_V2_F","Land_Cargo_HQ_V3_F","Land_Cargo_Patrol_V1_F","Land_Cargo_Patrol_V2_F","Land_Cargo_Patrol_V3_F","Land_Cargo_Tower_V1_F","Land_Cargo_Tower_V1_No1_F","Land_Cargo_Tower_V1_No2_F",
"Land_Cargo_Tower_V1_No3_F","Land_Cargo_Tower_V1_No4_F","Land_Cargo_Tower_V1_No5_F","Land_Cargo_Tower_V1_No6_F","Land_Cargo_Tower_V1_No7_F","Land_Cargo_Tower_V2_F","Land_Cargo_Tower_V3_F"], (worldSize*2^0.5)];

//Houses
_housesB = nearestObjects [[worldSize/2,worldSize/2], ["Land_MilOffices_V1_F","Land_nav_pier_m_F","Land_Pier_addon","Land_Pier_Box_F","Land_Pier_F","Land_Pier_small_F","Land_Pier_wall_F"], (worldSize*2^0.5)];
_housesP = ((nearestObjects [[worldSize/2,worldSize/2], ["house"], (worldSize*2^0.5)]) - strategic - _housesB);

{
    if(((nearestBuilding _x) == _x) && ((count ([_x]call BIS_fnc_buildingPositions)) > 1) && !([_x,"mrk_safeZone"]call Zen_AreInArea))then{
        _x setVehicleVarName format["house_%1",_forEachIndex];
        houses pushBack _x;
    }
} forEach _housesP;

villages = nearestLocations [[worldSize/2,worldSize/2], ["NameVillage"], (worldSize*2^0.5)];
towns = nearestLocations [[worldSize/2,worldSize/2], ["NameCity","NameLocal"], (worldSize*2^0.5)];
capitals = nearestLocations [[worldSize/2,worldSize/2], ["NameCityCapital"], (worldSize*2^0.5)];
{
    _house = _x;
    if([_x,"mrk_safeZone"]call Zen_AreInArea)then{
        housesSafe pushBack _x;
    };
} forEach houses;

{
    _house = _x;
    {
        if((getPos _x) distance2D _house < 400)then{
            housesVillages pushBack _house;
        };
    } forEach villages;

    {
        if((getPos _x) distance2D _house < 800)then{
            housesTowns pushBack _house;
        };
    } forEach towns;

    {
        if((getPos _x) distance2D _house < 1200)then{
            housesCapitals pushBack _house;
        };
    } forEach capitals;
} forEach houses - housesSafe;

housesRemote = houses - (housesVillages + housesTowns + housesCapitals + housesSafe);
