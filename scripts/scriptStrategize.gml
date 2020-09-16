// cycle through all the guarded objects and determine if a team should attack, defend, etc.

var t0 = control.team0;
var t1 = control.team1;

// Default values for guarded points
for (var b = 0; b < instance_number(parentGuarded); b++)
{var p = instance_find(parentGuarded, b);
 var po = p.owner;
 var pt = p.object_index;
 var px = p.x;
 var py = p.y;
 var pg = p.guards;
 var pv = 0;
 
 // mines worth level (min 1) x3, stations worth level (min 1) x2, guard posts worth level (min 1) 
 var basePriority = 200;
 if (pt == objectGuardPost) {pv = 1;}
 if (pt == objectStation)   {pv = 2;}
 if (pt == objectCoalMine)  {pv = 3;}
 
 ds_priority_change_priority(t0, p, pv * basePriority);
 ds_priority_change_priority(t1, p, pv * basePriority);

 // Add wartrains as temporary guards
 for (var m = 0; m < instance_number(objectWartrain); m++)
 {n = instance_find(objectWartrain, m);
  if (n.closest == p)
  {ds_list_add(p.guards, n);}}
 var pgs = ds_list_size(pg);   
  
 // Check what each guard is doing
 for (var a = 0; a < pgs; a++)
 {var m = ds_list_find_value(pg, a);
  //  var mo = m.owner;
  var mt = m.object_index;
  //  var md = m.goal;
  //  var mt = m.target;

  // combat units priority = attack * HP * range?
  var mH = max(1, m.HP);
  var mA = max(1, m.damage / (m.ROF / room_speed));
  var mR = max(1, m.maxRange / control.grid);
  var value = mH * mA * mR;
 
  var t0p = ds_priority_find_priority(t0, p);
  var t1p = ds_priority_find_priority(t1, p);
//  show_debug_message(object_get_name(m.object_index) + "#" + m + " - " + floor(100 * power(value, 1/3)) + ", " + t0p);
  
  if (po == 0)
  {ds_priority_change_priority(t0, p, t0p - floor(100 * power(value, 1/3)));}
  if (po == 1)
  {ds_priority_change_priority(t1, p, t1p - floor(100 * power(value, 1/3)));}}

 // Remove wartrains as temporary guards
 for (var m = 0; m < instance_number(objectWartrain); m++)
 {n = instance_find(objectWartrain, m);
  if (n.closest == p)
  {var z = ds_list_find_index(pg, n);
   ds_list_delete(pg, z);}}
}

// Make temporary copies of our work to this point.
var T0 = ds_priority_create();
var T1 = ds_priority_create();
for (var b = 0; b < instance_number(parentGuarded); b++)
{var p = instance_find(parentGuarded, b);
 ds_priority_add(T0, p, ds_priority_find_priority(t0, p));
 ds_priority_add(T1, p, ds_priority_find_priority(t1, p));}

// Compare other points
for (var b = 0; b < instance_number(parentGuarded); b++)
{var p = instance_find(parentGuarded, b);
 var po = p.owner;
 var pt = p.object_index;
 var px = p.x;
 var py = p.y;
 var pg = p.guards;
 var pgs = ds_list_size(pg);
 var pv = 0;

// if (po != noone)
 {// Check other points
  for (var c = 1; c <= instance_number(parentGuarded); c++)
  {var d = scriptInstance_nth_nearest(px, py, parentGuarded, c);

   // if this is me, next
   if (d == p)
   {continue;}
   else
   {var dO = d.owner;
    // if this is our point
    if (dO == po)
    {if (po == 0)
     {var pp = ds_priority_find_priority(t0, p);
      var T0d = ds_priority_find_priority(T0, d) / c;
//      show_debug_message(p + " - was " + pp + ", friend " + d + "'s " + ds_priority_find_priority(T0, d) + " per " + c + " = " + (pp + round(T0d)));
      ds_priority_change_priority(t0, p, pp + round(T0d));}
     if (po == 1)
     {var pp = ds_priority_find_priority(t1, p);
      var T1d = ds_priority_find_priority(T1, d) / c;
//      show_debug_message(p + " - was " + pp + ", friend " + d + "'s " + ds_priority_find_priority(T1, d) + " per " + c + " = " + (pp + round(T1d)));
      ds_priority_change_priority(t1, p, pp + round(T1d));}}
    else
    {// if this is the enemy's point
     {if (po == 0)
      {var pp = ds_priority_find_priority(t0, p);
       var T1d = ds_priority_find_priority(T1, d) / c;
//      show_debug_message(p + " - was " + pp + ", enemy " + d + "'s " + ds_priority_find_priority(T1, d) + " per " + c + " = " + (pp - round(T1d)));
       ds_priority_change_priority(t0, p, pp - round(T1d));

       // METAAAAAAA
       var dx = d.x;
       var dy = d.y;
       var q;
       for (q = 1; q <= instance_number(parentGuarded); q++)
       {var r = scriptInstance_nth_nearest(dx, dy, parentGuarded, q);
        // if this isn't the original instance, next
        if (p == r)
        {break;}}

       // how much does the thing that i'm affecting affect me?
       pp = ds_priority_find_priority(t1, p);
       var T0d = ds_priority_find_priority(T0, d) / q;
//       show_debug_message(p + " - was " + pp + ", now " + (pp - round(T0d)));
       ds_priority_change_priority(t1, p, pp - round(T0d));}
         
     if (po == 1)
     {var pp = ds_priority_find_priority(t1, p);
      var T0d = ds_priority_find_priority(T0, d) / c;
//      show_debug_message(p + " - was " + pp + ", enemy " + d + "'s " + ds_priority_find_priority(T0, d) + " per " + c + " = " + (pp - round(T0d)));
      ds_priority_change_priority(t1, p, pp - round(T0d));

       // METAAAAAAA
       var dx = d.x;
       var dy = d.y;
       var q;
       for (q = 1; q <= instance_number(parentGuarded); q++)
       {var r = scriptInstance_nth_nearest(dx, dy, parentGuarded, q);
        // if this isn't the original instance, next
        if (p == r)
        {break;}}

       // how much does the thing that i'm affecting affect me?
       pp = ds_priority_find_priority(t0, p);
       var T1d = ds_priority_find_priority(T1, d) / q;
//       show_debug_message(p + " - was " + pp + ", now " + (pp - round(T1d)));
       ds_priority_change_priority(t0, p, pp - round(T1d));}
     
     // This point is neutral  
     if (po < 0)
{var pp = ds_priority_find_priority(t0, p);
 var T0d = ds_priority_find_priority(T0, d) / c;
 ds_priority_change_priority(t0, p, pp - round(T0d));
 var pp = ds_priority_find_priority(t1, p);
 var T1d = ds_priority_find_priority(T1, d) / c;
 ds_priority_change_priority(t1, p, pp - round(T1d));}}}}

   if (c == instance_number(parentGuarded))
   {show_debug_message(p + ", " + po + " - " + ds_priority_find_priority(t0, p) + " & " + ds_priority_find_priority(t1, p));}
   }}
   
 
 // Okay so we've accounted for the nearby points.
 
}
    
ds_priority_destroy(T0);
ds_priority_destroy(T1);
