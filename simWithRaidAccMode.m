
% Load model into memory
load_system('model_groundTethered')
% Simulate
sim('model_groundTethered')
% Postprocessing
plot_routine_3D;
 
 