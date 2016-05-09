%% Defines the parameters of the 4p - kite model as defined in "Dynamic Model of a Pumping Kite Power System"

% Masses
nose_mass_fraction = 0.47;
m_A = nose_mass_fraction * m_kite;
m_B = 0.4 * (1-nose_mass_fraction)*m_kite;
m_C = 0.3 * (1-nose_mass_fraction)*m_kite;
m_D = 0.3 * (1-nose_mass_fraction)*m_kite;

% Geometry
h_kite = 2.23; % Distance between Pc and B
h_bridle = 4.9; % Distance between Pc and P_kcu
w_k = 5.77;% Distance between C and D
d_n_r = 0.2;% relative nose distance. in combinatino with nose_mass_fraction it can be used to tune the rot. inertia + CG
w_rel = 0.9; % reflects the fact that the aerodynamic steering forces do not act on the tips of the kite but further inwards

% Aerodynamics
alpha_s_0 = 10 * pi/180;
alpha_0 = 10 * pi/180;
alpha_s_max = 20 * pi/180; % max. angle of attack caused by the steering line difference
K_d_s = 1.5; % describes the influence of the depower angle on the steering sensitivity
K = 1 - ASideRel;

% Cl and Cd for the kite
ALPHA_CL = [-180.0, -160.0, -90.0, -20.0, -10.0,  -5.0,  0.0, 20.0, 40.0, 90.0, 160.0, 180.0];
CL_LIST  = [   0.0,    0.5,   0.0,  0.08, 0.125,  0.15,  0.2,  1.0,  1.0,  0.0,  -0.5,   0.0];

ALPHA_CD = [-180.0, -170.0, -140.0, -90.0, -20.0, 0.0, 20.0, 90.0, 140.0, 170.0, 180.0];
CD_LIST  = [   0.5,    0.5,    0.5,   1.0,   0.2, 0.1,  0.2,  1.0,   0.5,   0.5,   0.5];

% Cubic spline interpolation
CL_spline =spline(ALPHA_CL,CL_LIST);
CD_spline =spline(ALPHA_CD,CD_LIST);
CL_spline_coefs = CL_spline.coefs;
CD_spline_coefs = CD_spline.coefs;

alpha_d_max = 31 * pi/180; % max. depower angle
u_d_0 = 0.213; % depower ofset
u_max = 0.47;

% Initial position kite particles
P_kcu = p_init( 3*(n-2)-2:3*(n-2)  );
Pc_init = P_kcu + [0;0;1]*h_bridle;
A_init = Pc_init + d_n_r * w_k * w_rel * [-1;0;0];
B_init = Pc_init + h_kite * [0;0;1;];
C_init = Pc_init + 0.5 * w_k * w_rel * [0;1;0];
D_init = Pc_init - 0.5 * w_k * w_rel * [0;1;0];

% Length dridlelines
ls_AC = norm( A_init -  C_init);
ls_AB = norm( A_init -  B_init);
ls_AKcu = norm( A_init -  P_kcu);
ls_AD = norm( A_init -  D_init);
ls_CB = norm( C_init -  B_init);
ls_CD = norm( C_init -  D_init);
ls_CKcu = norm( C_init -  P_kcu);
ls_DKcu = norm( D_init -  P_kcu);
ls_DB = norm( D_init -  B_init);


%% Plot kite geometry
if 0
    close all
    figure;
    axis equal
    grid minor
    hold on
    plot3(P_kcu(1),P_kcu(2),P_kcu(3),'*k', 'Markersize', 5, 'Linewidth', 2)
    hold on
    plot3(Pc_init(1),Pc_init(2),Pc_init(3),'*k', 'Markersize', 5, 'Linewidth', 2)
    hold on
    plot3(A_init(1),A_init(2),A_init(3),'*k', 'Markersize', 5, 'Linewidth', 2)
    hold on
    plot3(B_init(1),B_init(2),B_init(3),'*k', 'Markersize', 5, 'Linewidth', 2)
    hold on
    plot3(C_init(1),C_init(2),C_init(3),'*k', 'Markersize', 5, 'Linewidth', 2)
    hold on
    plot3(D_init(1),D_init(2),D_init(3),'*k', 'Markersize', 5, 'Linewidth', 2)
    
    % connections
    plot3([P_kcu(1),A_init(1)], [P_kcu(2),A_init(2)],[P_kcu(3),A_init(3)],'-k',  'Linewidth', 1.5)
    plot3([P_kcu(1),C_init(1)], [P_kcu(2),C_init(2)],[P_kcu(3),C_init(3)],'-k',  'Linewidth', 1.5)
    plot3([P_kcu(1),D_init(1)], [P_kcu(2),D_init(2)],[P_kcu(3),D_init(3)],'-k',  'Linewidth', 1.5)
    plot3([A_init(1),C_init(1)], [A_init(2),C_init(2)],[A_init(3),C_init(3)],'-k',  'Linewidth', 1.5)
    plot3([A_init(1),D_init(1)], [A_init(2),D_init(2)],[A_init(3),D_init(3)],'-k',  'Linewidth', 1.5)
    plot3([A_init(1),B_init(1)], [A_init(2),B_init(2)],[A_init(3),B_init(3)],'-k',  'Linewidth', 1.5)
    plot3([C_init(1),D_init(1)], [C_init(2),D_init(2)],[C_init(3),D_init(3)],'-k',  'Linewidth', 1.5)
    plot3([C_init(1),B_init(1)], [C_init(2),B_init(2)],[C_init(3),B_init(3)],'-k',  'Linewidth', 1.5)
    plot3([D_init(1),B_init(1)], [D_init(2),B_init(2)],[D_init(3),B_init(3)],'-k',  'Linewidth', 1.5)
end