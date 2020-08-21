var here = argument0;
var there = argument1;

var dir = point_direction(here.x, here.y, there.x, there.y);

var a;
for (a = 0; a < 8; a++)
{if (dir < 22.5 + (45 * a)) {break;}}

str = "";
switch (a)
{case 0:
  str = "E";
  break;
 case 1:
  str = "NE";
  break;
 case 2:
  str = "N";
  break;
 case 3:
  str = "NW";
  break;
 case 4:
  str = "W";
  break;
 case 5:
  str = "SW";
  break;
 case 6:
  str = "S";
  break;
 case 7:
  str = "SE";
  break;
 default:
  str = "E";
 break;}

return str;
