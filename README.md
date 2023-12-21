Model of the battery, to simulate cooling requirements. Can probably be used for other things too.

If the battery configuration is changed, recompiling is a bit tricky.
First you use battery builder to create the pack, and create a library (or use buildBattery from the command line)
Then go into +Battery and alter the module and parallel assembly .ssc files to correct the capacity, Vo and Ro
Recompile the lib using ssc_build('+Battery') from the command line (make sure you're in the the directory containing +Battery)
Finally copy the battery block from battery.slx to your simulation
