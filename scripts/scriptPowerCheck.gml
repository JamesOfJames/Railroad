// This is used by the controler to count all power generated, then checks buildings to see if enough power is made to power them.

show_debug_message("power check!");

powerMade = 0;
with objectPowerPlant
{if powering {control.powerMade += powerMade;}}
powerNeed = 0;
with objectBuilding
{if !building
 {if control.powerMade - control.powerNeed >= powerNeed
  {powered = true;
   control.powerNeed += powerNeed;}}}
