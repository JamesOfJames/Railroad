//argument0 = object to find the nearest airlock to exit

var pointx,pointy,object,n,list,nearest;
pointx = argument0.x;
pointy = argument0.y;
n = instance_number(objectAirlock);

if n > 0
{list = ds_priority_create();
 nearest = noone;
 
// How far away is each house?
 with (objectAirlock)
 {var path = path_add();
  mp_grid_path(control.mpGrid, path, pointx, pointy, x, y, true);
  if (path_get_number(path) > 0) {ds_priority_add(list,id,path_get_length(path));}
  path_delete(path);}

// Find the nearest empty house
while (!ds_priority_empty(list))
 {nearest = ds_priority_delete_min(list);
  if (nearest.owner == noone) {break;}
  nearest = noone;}
 ds_priority_destroy(list);}
else
 {nearest = noone;}
 
// Assign the house
if (nearest != noone)
{return nearest;}
show_debug_message(nearest + " for " + argument0);
