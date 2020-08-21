/// Goals
var b = argument0;
var path = path_add();
var g = b.goal;
var grid = b.grid;

// List of paths between airlocks to get to goal
var pathList = ds_list_create();

// Is there a goal?
if g != noone
{var a, gx, gy;
 gx = g.x;
 gy = g.y;
 
 // What is at the goal?
 //If it has been occupied or the position being checked is out of the grids bounds then the function will return -1 otherwise it will return 0. 
 if !mp_grid_get_cell(control.mpGrid, gx * grid , gy * grid)
 {// Goal is indoors
  // Can you get there without going outside?
  path = mp_grid_path(id, path, b.x, b.y, gx, gy, true) // The function returns either true (it succeeded in finding a path) or false (it failed) 
  if path 
  {// I can get there staying inside this building
  }
  else
  {// Gonna have to go outside
  
  }
 
 
 /*
 
 
 
 // Gonna have to go outside
  var validAirlocks = array_create(0);
 
  with (objectAirlock)
  {var path = path_add();
   var b = other.b;
   var gx = x;
   var gy = y;
   /*var z = mp_grid_path(control.mpGrid, path, b.x, b.y, gx, gy, true);
   if z
   {other.validAirlocks[array_length_1d(other.validAirlocks)] = z;}
  */
  show_debug_message(validAirlocks);}
 }
 else
 {// Goal is indoors Can stay within this building?
  if mp_grid_path(control.mpGrid, path, x, y, gx, gy, true)
  {show_debug_message("i can get there indoors");}
 }
 
 
 
 
 
 {var validAirlocks = array_create(0);
 
  with (objectAirlock)
  {var path = path_add();
   var b = other.b;
   var gx = x;
   var gy = y;
   var z = mp_grid_path(control.mpGrid, path, x, y, gx, gy, true);
   if z
   {other.validAirlocks[array_length_1d(other.validAirlocks)] = z;}
  
  show_debug_message(validAirlocks);
 }
 }
 
 
 
 
 
 
 //if mp_grid_path(control.mpSurface, path, x, y, gx, gy, true)
 //{show_debug_message("i can get there outdoors");}  


/*
























if g != noone
{var a, gx, gy;
 gx = g.x;
 gy = g.y;
 a = point_distance(x, y, gx, gy);
 
 if a > grid // if it's too far
 {// Move Toward Goal
//  direction = point_direction(x, y, gx, gy);
//  speed = moveSpeed;
  path = path_add();
  if mp_grid_path(control.mpGrid, path, x, y, gx, gy, true)
   {path_start(path, moveSpeed, path_action_stop, true);}     
  }
 else // it's close
 {speed = 0;
  if goal.building
  {// Build
   goal.buildCurrent += building; // add my building skill to it's buildCurrent total
   buildXP++;}
  
  }}
else
{
path_delete(path);

// Find a house and a job
if (house == noone) {scriptNearestEmptyHouse(id)}
if (work == noone) {scriptNearestEmptyJob(id)}


// Mining
mining = irandom(2) + irandom(2) + 1;
mineXP = 0;
}
/*
building = irandom(2) + irandom(2) + 1;
buildXP = 0;

buildNeeded = 1000;
buildCurrent = 0;
building = true;
