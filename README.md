# TetheredKiteUAV_Simulink

% Usage
Just run the Simulink files. The setup scripts will be called automatically. 
At the moment two different Simulink models exists. One for the pointmass-kite and one for the 4p - kite. In the futur both models 
will be merged such that the user can decide which model he/she wants to run. 
For postprocessing and visualization the plot_routine_3D_4p/1p.m have to be executed after runtime.

The Simulink file for the 1p model is:
model_tmp_1p.m 
The corresponding setup file is setup_tmp_1p.m and the plot routine will be called with plot_routine_3D_1p.m
For the 4p kite model the files are are denoted with *_4p.m

% Files
calcKiteForces.m => Here the drag, lift and side force are calculated 
calcSegmentDrag.m => Here the segment drags are calculated
calcSpringDamperForce.m => Here all the spring-damper forces of the pointmasses of the tether are calculated. 
calcTransformationEB.m => Returns the transformation matrix between the bodyfixed and the groundframe.  
polynomial_trajectory.m => calculates a fligh path of 5th order depending on final height and flight duration.
calc4pKiteForces.m => Here the aero forces of the 4p model are calculated
plotCLandCDCurves.m = > Here the Cl and the Cd curves are determined based on a cubic spline interpolation.
calcCLandCD_4pKite.m => Here the current Cl and Cd value with respect to the angle of attack are calculated. 
func_plot_kitegeom.m => called from the plot routine. Plots the 4p kite model geometry and bridle lines
calcSpringDamperForce_Bridle.m => calculates the bridle line forces.