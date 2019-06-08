# PoEAutoFlask  
Automates the use of buff style flasks for Path of Exile using an AutoHotKey script.  
  
NOTE: you MUST install AutoHotKey for this script to function!  
NOTE: this will not work properly for Life, Mana or Hybrid style flasks!  
  
Keys used and monitored:  
alt+f12 - activate/de-activate the script  
right mouse button - primary attack skills  (directions included to change this to another mouse button)
1-5 - number keys to manually use a specific flask  
\` (backtick) - use all flasks, now  
alt+c - Ctrl-Click every location in the (I)nventory screen
alt+m - Move items from Stash (12x12 or 24x24) to inventory - mouse pointer must be above first stash box to click
alt+g - Get the current screen coordinates of the mouse pointer
alt+s - Swap a skill gem with an alternate gem (in inventory or on alternate weapon group)
  
Notes on Key usage:  
To change the any of the keys, just change the line that ends with :: to the key of your choice.
For instance, if you prefer to use ctrl+f11 to activate and deactivate the script, change the line that is:  
  !F12::  
to:  
  ^F11::  
    
If you use a keyboard key, such as "q", instead of the right mouse button as your primary attack skill,
then change all occurrences of "Rbutton" to "q" (ignore the double quotes).  
  
You will need to change the duration of the each flask to match the flasks that you currently use.  The lines:  
  FlaskDurationInit[1] := 4200  
  FlaskDurationInit[2] := 4700  
  FlaskDurationInit[3] := 4800  
  FlaskDurationInit[4] := 6000  
  FlaskDurationInit[5] := 6200  
Control the duration for flasks 1 through 5.  For example, my flask 1 "Lasts 4.20 Seconds" (you see this by
letting the mouse hover over the flask and reading the info about the flask). The value listed for FlaskDurationInit
is the time, in ms, that the flask buff will last once activated.

Note, you can also put a temporary buff in the "e" or "r" action slots and automatically refresh them.  For instance,
I currently have the following setup to trigger the new Steelskin buff every 4.5 seconds:
  FlaskDurationInit["e"] := 4500
  
At anytime (after activating the script with Alt+F12 [default]), you can also use the keys 1 - 5 to use a single
flask or the \` (backtick key - left of the number 1 on a US keyboard) to use all flasks. Note that using \` to trigger
all flasks will use even those flasks that have a FlaskDurationInit of 0.  
