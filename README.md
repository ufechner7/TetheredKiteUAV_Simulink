# TetheredKiteUAV_Simulink

% Usage
Just run the Simulink file model_groundTethered.m for simulation. 
The setup script setup.m will be executed automatically by Simulink. 
To visualize simulation results execute plot_routine_3D.m

% Files
calcKiteForces.m => Here the drag, lift and side force are calculated 
calcSegmentDrag.m => Here the segment drags are calculated
calcSpringDamperForce.m => Here all the spring-damper forces of the pointmasses of the tether are calculated. 
calcTransformationEB.m => Returns the transformation matrix between the bodyfixed and the groundframe. 
plot_routine_3D.m => for visualization of the simulation results 
setup.m => is executed before the simulink simulation. initialization of all relevant parameters. 
polynomial_trajectory.m => calculates a fligh path of 5th order depending on final height and flight duration.
calc4pKiteForces.m => Here the aero forces of the 4p model are calculated
plotCLandCDCurves.m = > Here the Cl and the Cd curves are determined based on a cubic spline interpolation.