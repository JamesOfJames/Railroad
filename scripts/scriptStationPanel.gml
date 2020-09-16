//argument0 = station
//argument1 = engine

listboxCargo.items = 0;
listboxLoad.items = 0;

var station = argument0;
var engine = argument1;
panelStation.station = station;
panelStation.engine = engine;

if (station.object_index == objectLab)
{//show_debug_message("this is a lab");
 buttonLoadAvailable.uiEnabled = false;
 buttonLoadType.uiEnabled = false;
 buttonLoadDestination.uiEnabled = false;
 buttonLoadValue.uiEnabled = false;
 buttonLoadTime.uiEnabled = false;
 buttonLoadDirection.uiEnabled = false;}
else
{//show_debug_message("this is a station / mine");
 buttonLoadAvailable.uiEnabled = true;
 buttonLoadType.uiEnabled = true;
 buttonLoadDestination.uiEnabled = true;
 buttonLoadValue.uiEnabled = true;
 buttonLoadTime.uiEnabled = true;
 buttonLoadDirection.uiEnabled = true;}

var sc = station.cargo;

var cargoLastRow = ds_grid_height(sc) - 1;
var cargoCount = max(0, ds_grid_get_sum(sc, 4, 1, 4, cargoLastRow));

labelStationName.uiTextValue = station.name;
labelCargoAmount.uiTextValue = ""
listboxCargo.uiTextLabel = "Cargo - " + cargoCount + " / " + station.maxCargo;


if (station.object_index == objectCoalMine)
{labelCargoAmount.uiTextValue = string(round(station.mined)) + " mined, " + string(round(station.coal) + " left");}

if (engine != noone)
{var el = engine.load;
 var loadLastRow = ds_grid_height(el) - 1;
 labelEngineLoad.uiTextValue = engine.name + " - " + loadLastRow + " / " + engine.maxCargo;}

draw_set_font(fontArial12);

var z = 0;
for (var a = 1; a <= cargoLastRow; a++)
{var line = "";

 // availability
 line += ds_grid_get(sc, 4, a) + " cars ";

 // type
 while (string_width(line) < buttonSortType.x - listboxLoad.x)
 {line += " ";}
 line += scriptCargoType(ds_grid_get(sc, 0, a)) + " ";

 // destination 
 while (string_width(line) < buttonSortDestination.x - listboxLoad.x)
 {line += " ";}
 var b = ds_grid_get(sc, 1, a);
 if (b == all)
 {line += "Any Station";}
 else
 {line += b.name + " - " + scriptDistanceToStation(station.platform, b.platform) + "km";}
 
 // direction
 while (string_width(line) < buttonSortDirection.x - listboxLoad.x)
 {line += " ";}
 if (b != all)
 {line += scriptDirection(station, b);}

 // time
 while (string_width(line) < buttonSortTime.x - listboxLoad.x)
 {line += " ";}
 line += ds_grid_get(sc, 3, a) + " ";

 // value
 while (string_width(line) < buttonSortValue.x - listboxLoad.x)
 {line += " ";}
 line += "¤" + ds_grid_get(sc, 2, a); // or maybe £?
 
 listboxCargo.items[a - 1] = line;}
 
if (engine != noone)
{for (var a = 1; a <= loadLastRow; a++)
{var line = "";

 var count = 1;
/* for (var b = 1; b <= loadLastRow - a; b++)
 {if (ds_grid_get(el, 0, a) == ds_grid_get(el, 0, a + b))
  {if (ds_grid_get(el, 1, a) == ds_grid_get(el, 1, a + b))
   {if (ds_grid_get(el, 2, a) == ds_grid_get(el, 2, a + b))
    {if (ds_grid_get(el, 3, a) == ds_grid_get(el, 3, a + b))
     {count++;}}}}}*/ //not sure what this does?
 line += count + " cars " 

 // type
 while (string_width(line) < buttonSortType.x - listboxLoad.x)
 {line += " ";}
 line += scriptCargoType(ds_grid_get(el, 0, a)) + " ";
  
 // destination 
 while (string_width(line) < buttonSortDestination.x - listboxLoad.x)
 {line += " ";}
 var b = ds_grid_get(el, 1, a);
 if (b == all)
 {line += "Any Station";}
 else
 {line += b.name + " - " + scriptDistanceToStation(station.platform, b.platform) + "km";}
 
 // direction
 while (string_width(line) < buttonSortDirection.x - listboxLoad.x)
 {line += " ";}
 if (b != all)
 {line += scriptDirection(station, b);}
 
 // time
 while (string_width(line) < buttonSortTime.x - listboxLoad.x)
 {line += " ";}
 line += ds_grid_get(el, 3, a) + " ";
 
 // value
 while (string_width(line) < buttonSortValue.x - listboxLoad.x)
 {line += " ";}
 line += "¤" + ds_grid_get(el, 2, a); // or maybe £?
 
 listboxLoad.items[z] = line;
 z++;
 
 a += count - 1;
 }}
