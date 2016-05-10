function [ kite_geom_h ] = func_plot_kitegeom( P_kcu, A, B, C, D )
%FUNC_PLOT_KITEGEOM Summary of this function goes here
%   Detailed explanation goes here
k1_h = plot3([P_kcu(1),A(1)], [P_kcu(2),A(2)],[P_kcu(3),A(3)],'-k',  'Linewidth', 1);
hold on 
k2_h = plot3([P_kcu(1),C(1)], [P_kcu(2),C(2)],[P_kcu(3),C(3)],'-k',  'Linewidth', 1);
hold on 
k3_h = plot3([P_kcu(1),D(1)], [P_kcu(2),D(2)],[P_kcu(3),D(3)],'-k',  'Linewidth', 1);
hold on 
k4_h = plot3([A(1),C(1)], [A(2),C(2)],[A(3),C(3)],'-b',  'Linewidth', 3);
hold on 
k5_h = plot3([A(1),D(1)], [A(2),D(2)],[A(3),D(3)],'-b',  'Linewidth', 3);
hold on 
k6_h = plot3([A(1),B(1)], [A(2),B(2)],[A(3),B(3)],'-b',  'Linewidth', 3);
hold on 
k7_h = plot3([C(1),D(1)], [C(2),D(2)],[C(3),D(3)],'-b',  'Linewidth', 3);
hold on 
k8_h = plot3([C(1),B(1)], [C(2),B(2)],[C(3),B(3)],'-b',  'Linewidth', 3);
hold on 
k9_h = plot3([D(1),B(1)], [D(2),B(2)],[D(3),B(3)],'-b',  'Linewidth', 3);

kite_geom_h = [k1_h,k2_h,k3_h,k4_h,k5_h,k6_h,k7_h,k8_h,k9_h];
end

