% Transformation between Bodyfixed-Frame and Ground 
function [T_BE, T_EB] = calcTransformationEB( eta ) 

phi = eta(1); 
theta = eta(2); 
psi = eta(3); 

T_psi = [cos(psi), sin(psi), 0; 
         -sin(psi), cos(psi), 0; 
         0, 0, 1];

T_theta = [cos(theta), 0, -sin(theta); 
        0, 1, 0; 
        sin(theta), 0, cos(theta)]; 

T_phi = [1, 0, 0; 
         0, cos(phi), sin(phi); 
         0, -sin(phi), cos(phi)];
     
T_BE = T_phi * T_theta * T_psi;
T_EB = T_BE'; 

