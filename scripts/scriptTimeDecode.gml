// argument0 = the encoded time from a cargo/load ds_grid
// a = editable shorthand for argument 0
var a = argument0;

while (string_count("&", a) > 0)
{// b = where to make the cut
 var b = string_pos("&", a);




}    

var minute;
var hour;
var day;
var year;

  
          // Deadline
  ds_grid_set(cargo, 4, a, minute + "&" + hour +  "&" + (day + 1) + "&" + year);
  // Current Time
  ds_grid_set(cargo, 5, a, minute + "&" + hour +  "&" + day + "&" + year);
  
  if !paused
{time += (delta_time * timeFactor);

while (time >= minuteLength)
{time -= minuteLength;
 minute += 5;}
while (minute >= 60)
{minute -= 60;
 hour++;}
while (hour >= 24)
{hour -= 24;
 day++;}
while (day >= 360)
{day -= 360;
 year++;}
}
