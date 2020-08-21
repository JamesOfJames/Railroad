//argument0 = this platform
//argument1 = destination platform

// need to fix this to measure from platform to platform
/*
var engine = argument0;
var station = argument1;
station = station.platform;
engine = engine.platform;
var grid = control.grid;

var path = path_add();
mp_grid_path(control.mpGrid, path, engine.x, engine.y, station.x, station.y, false);
var dist = path_get_length(path);
path_delete(path);

dist = floor(dist / grid);
*/

dist = 5;
return dist;
