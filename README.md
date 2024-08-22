Model of the tractive system, to simulate cooling requirements. Can probably be used for other things too.

Car parameters can be changed by editing the files in /data.

The Simulink model performs a lap simulation using OpenLap, then pipes the result of that (i.e. a 50hz torque, rpm, and speed signal) into a series of functions to calculate the energy lost due to inefficiency of the motor+inverter. By considering all this loss to go to heat, the model uses an implementation of the E-NTU Method (Compact Heat Exchangers, Kays & London) to determine the coolant temp with a given radiator geometry. The model also considers accumulator heating, using an ohmic heating model with the cell's internal resistance. Combining that with the total heat capacity of the accumulator, we can determine the temperature rise through endurance. Since the internal geometry of the battery is complex, we consider it a lumped heat capacity system (this assumption is not valid, since it doesn't pass the Biot number test) and model the effect of natural convection (i.e. the car being stationary) and forced convection (i.e. the car moving at the speed given by the lap sim). That should give an qualitative indication of how pack temp will drop in reality, but the values cannot be trusted.

If you're working on the cooling system in future, I'd suggest you try and expand on this model.
- Validating the E-NTU implementation by controlled experimental test of a radiator (start with the airflow estimation)
- Alternatively try to get it to work with GT-Suite, since that's more reliable (so I've been told)
- Measure the properties of the cells, rather than trusting the datasheet
- Consider internal resistance of the entire pack, such as bus bars
- Implement a proper thermal network for the cells, to replace the lumped capacity model
- Model how much heat a given ammount of airflow through the cells would actually remove
