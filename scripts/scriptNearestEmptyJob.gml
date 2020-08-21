//argument0 = object to find the nearest habitat for

var pointx,pointy,object,n,list,nearest;
pointx = argument0.x;
pointy = argument0.y;
n = instance_number(objectGreenhouse) + instance_number(objectPowerPlant) + instance_number(objectLaboratory);

if n > 0
{list = ds_priority_create();
 nearest = noone;
 
// How far away is each jobsite?
 with (objectGreenhouse)
 {var path = path_add();
  mp_grid_path(control.mpGrid, path, pointx, pointy, x, y, true);
  if (path_get_number(path) > 0) {ds_priority_add(list,id,path_get_length(path));}
  path_delete(path);}
 with (objectPowerPlant)
 {var path = path_add();
  mp_grid_path(control.mpGrid, path, pointx, pointy, x, y, true);
  if (path_get_number(path) > 0) {ds_priority_add(list,id,path_get_length(path));}
  path_delete(path);}
 with (objectLaboratory)
 {var path = path_add();
  mp_grid_path(control.mpGrid, path, pointx, pointy, x, y, true);
  if (path_get_number(path) > 0) {ds_priority_add(list,id,path_get_length(path));}
  path_delete(path);}
// Find the nearest empty house
while (!ds_priority_empty(list))
 {nearest = ds_priority_delete_min(list);
  if (nearest.worker == noone) {break;}
  nearest = noone;}
 ds_priority_destroy(list);}
else
 {nearest = noone;}
 
// Assign the house
if (nearest != noone)
{nearest.worker = argument0;
 argument0.work = nearest;}
show_debug_message(nearest + " hires " + argument0);


