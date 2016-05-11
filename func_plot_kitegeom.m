function [ kite_geom_h ] = func_plot_kitegeom( P_kcu, A, B, C, D )
%FUNC_PLOT_KITEGEOM Summary of this function goes here
%   Detailed explanation goes here
k1_h = plot3([P_kcu(1),A(1)], [P_kcu(2),A(2)],[P_kcu(3),A(3)],'-k',  'Linewidth', 1);
hold on
k2_h = plot3([P_kcu(1),C(1)], [P_kcu(2),C(2)],[P_kcu(3),C(3)],'-k',  'Linewidth', 1);
hold on
k3_h = plot3([P_kcu(1),D(1)], [P_kcu(2),D(2)],[P_kcu(3),D(3)],'-k',  'Linewidth', 1);
hold on
k4_h = plot3([A(1),C(1)], [A(2),C(2)],[A(3),C(3)],'-k',  'Linewidth', 1);
hold on
k5_h = plot3([A(1),D(1)], [A(2),D(2)],[A(3),D(3)],'-k',  'Linewidth', 1);
hold on
k6_h = plot3([A(1),B(1)], [A(2),B(2)],[A(3),B(3)],'-k',  'Linewidth', 1);
hold on
k7_h = plot3([C(1),D(1)], [C(2),D(2)],[C(3),D(3)],'-k',  'Linewidth', 1);
hold on
k8_h = plot3([C(1),B(1)], [C(2),B(2)],[C(3),B(3)],'-k',  'Linewidth', 1);
hold on
k9_h = plot3([D(1),B(1)], [D(2),B(2)],[D(3),B(3)],'-k',  'Linewidth', 1);


% Fabric

% Calculation of unity vectors of the kite body fixed frame
x_kite_Pc = 0.5 * (C + D);
e_z_k = -(x_kite_Pc - B)/sqrt((x_kite_Pc - B)*(x_kite_Pc - B)');
e_y_k = (C - D)/sqrt((C - D)*(C - D)');
e_x_k = [ e_y_k(2)*e_z_k(3) - e_y_k(3)*e_z_k(2);
    e_y_k(3)*e_z_k(1) - e_y_k(1)*e_z_k(3);
    e_y_k(1)*e_z_k(2) - e_y_k(2)*e_z_k(1)];
Rot_Eframe = [e_x_k, e_y_k', e_z_k'];

width_kite = norm( A - x_kite_Pc ); 
height_kite = norm( B - x_kite_Pc );  
C_le = C' - Rot_Eframe * [width_kite;0;0];
C_te = C' + Rot_Eframe * [width_kite;0;0];
D_le = D' - Rot_Eframe * [width_kite;0;0];
D_te = D' + Rot_Eframe * [width_kite;0;0];
B_le = 0.5*(C_le+D_le) + Rot_Eframe * [0;0;height_kite];
B_te = 0.5*(C_te+D_te) + Rot_Eframe * [0;0;height_kite];
B_test = x_kite_Pc'  + Rot_Eframe * [0;0;height_kite];

k10_h = plot3([D_le(1),D_te(1)], [D_le(2),D_te(2)],[D_le(3),D_te(3)],'-b',  'Linewidth', 3);
k11_h = plot3([C_le(1),C_te(1)], [C_le(2),C_te(2)],[C_le(3),C_te(3)],'-b',  'Linewidth', 3);

% leading edge
spline_x_le =  [C_le(2);0.5*(C_le(2)+D_le(2)); D_le(2)];
spline_y_te = [C_le(3); B_le(3); D_le(3)];
kite_le_spline =spline(spline_x_le,spline_y_te);
kite_le = ppval(kite_le_spline, linspace(spline_x_le(1),spline_x_le(3),10));
k12_h = plot3( linspace( C_le(1), D_le(1), 10), linspace(spline_x_le(1),spline_x_le(3),10), kite_le, '-b',  'Linewidth', 3);

% trailing edge
spline_x_te =  [C_te(2);0.5*(C_te(2)+D_te(2)); D_te(2)];
spline_y_te = [C_te(3); B_te(3); D_te(3)];
kite_te_spline =spline(spline_x_te,spline_y_te);
kite_te = ppval(kite_te_spline, linspace(spline_x_te(1),spline_x_te(3),10));
k13_h = plot3( linspace( C_te(1), D_te(1), 10), linspace(spline_x_te(1),spline_x_te(3),10), kite_te, '-b',  'Linewidth', 3);

k14_h = plot3( [0.5*(C_te(1)+D_te(1)),0.5*(C_le(1)+D_le(1))], [0.5*(C_te(2)+D_te(2)),0.5*(C_le(2)+D_le(2))], [B_te(3) B_le(3)], '-b',  'Linewidth', 3);
%k15_h = plot3( [x_kite_Pc(1),B_test(1)], [x_kite_Pc(2),B_test(2)], [x_kite_Pc(3) B_test(3)], '-b',  'Linewidth', 3);

kite_geom_h = [k1_h,k2_h,k3_h,k4_h,k5_h,k6_h,k7_h,k8_h,k9_h,k10_h,k11_h,k12_h,k13_h,k14_h];

end

