var engine = argument0;
var station = argument1;
var highlight = argument2;
var column = argument3;

var cargo = station.cargo;
var ch = ds_grid_height(cargo);
var load = engine.load
var loading = true;

// if the row passed is out of bounds, escape.
if (highlight > ds_grid_height(cargo))
{loading = false;}

else
{if (highlight > 0)
 {// load this row into memory
  var type = ds_grid_get(cargo, 0, highlight);
  var destination = ds_grid_get(cargo, 1, highlight);
  var value = ds_grid_get(cargo, 2, highlight);
  var time = ds_grid_get(cargo, 3, highlight);
  var cars = ds_grid_get(cargo, 4, highlight);
  var direct = ds_grid_get(cargo, 5, highlight);}
 else
 {
  // we've already cleared a row and need to find a new one.
  var sv = 0; // search value
  var sort = 0; // 0 = same, -1 low, 1 high, 2 similar, -2 idgaf
  
  switch (column)
  {case 0: // same type
    sv = type;
    sort = 0;
    break;
   case 1: // same destination
    sv = destination;
    sort = 0;
    break;
   case 2: // high value
    sv = value;
    sort = 1;
    break;
   case 3: // low time
    sv = time;
    sort = -1;
    break;
   case 4: // whatever fits on the train?  maybe just get rid of this button
    sv = cars;
    sort = -2;
    break;
   case 5: // headed this direction
    sv = direct;
    sort = 2;
    break;
   default:
    break;}

  // does the value exist? (if it needs to?)
  if (sort < 2)
  {if (!ds_grid_value_exists(cargo, column, 0, column, ch - 1, sv))
   {loading = false;}
   else
   {highlight = ds_grid_value_y(cargo, column, 0, column, ch - 1, sv) + 1;}}
  else
  {if (sort == 2)
   {highlight = ds_grid_value_y(cargo, column, 0, column, ch - 1, max(0, ds_grid_get_max(cargo, column, 0, column, ch - 1)));
    if (highlight == 0)
    {loading = false;}}
   if (sort == 3)
   {highlight = ds_grid_value_y(cargo, column, 0, column, ch - 1, max(0, ds_grid_get_min(cargo, column, 0, column, ch - 1)));
    if (highlight == 0)
    {loading = false;}}
   if (sort == 4)
   {// i don't know what this even means, so skipping for now   
   }
   if (sort == 5)
   {maxCount = 0;
    row = 0;
    for (var a = 1; a < ch; a++)
    {var b = ds_grid_get(cargo, column, a);
     if (string_count(sv, b) > maxCount)
     {maxCount = string_count(sv, b);
      row = a;}}
    if (maxCount > 0)
    {highlight = row;}
    else
    {loading = false;}}}}
    
 while (loading)
 {if (ds_grid_height(cargo) > 1)
 {
  // check if there are any cars on this row left to load
  if (cars > 0)
  {// how much rolling stock capacity do we have?
   control.carsInUse = 0;
   with (parentEngine)
   {control.carsInUse += ds_grid_height(load);}
   if (control.carCapacity > control.carsInUse)
   {// check engine's max cargo
   if ds_grid_height(engine.load) - 1 < engine.maxCargo
   {// check control's car capacity
    var carCount = 0;
    with (parentEngine)
    {other.carCount += ds_grid_height(load) - 1;}
 
    if (carCount < control.carCapacity)
    {// add a row to load
     ds_grid_resize(load, ds_grid_width(load), ds_grid_height(load) + 1);
 
     // copy the data to load from cargo
     for (var d = 0; d < ds_grid_width(cargo); d++)
     {ds_grid_set(load, d, ds_grid_height(load) - 1, ds_grid_get(cargo, d, highlight));}
     ds_grid_set(load, 4, ds_grid_height(engine.load) - 1, noone);
 
     // subtract 1 from the number of cars of this cargo
     if (cars > 0)
     {ds_grid_set(cargo, 4, highlight, max(cars - 1, 0));
      cars--;}
     else
     {loading = false;}}
    else
    {loading = false;}}
   else
   {loading = false;}}
   else
   {loading = false;}}   
   // there are no cars left in this row, delete it.
  else
  {loading = false;
   while (ds_grid_value_exists(cargo, 4, 1, 4, ds_grid_height(cargo) - 1, 0))
   {scriptDeleteRowFromGrid(cargo, ds_grid_value_y(cargo, 4, 1, 4, ds_grid_height(cargo) - 1, 0));}
   highlight = -4;}}
  else
  {loading = false;}}}

ds_grid_sort(load, 4, true);
ds_grid_sort(cargo, 3, true);

//scriptDeleteRowFromGrid(cargo, highlight); // don't delete rows until you're done loading EVERYTHING right before sort & return
// for script looking for cars = 0, delete that row, blah blah blah
   
scriptStationPanel(station, engine);
