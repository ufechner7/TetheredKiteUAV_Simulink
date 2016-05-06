close all
clear all
clc

%%% Setup the Simulink simulation. The script will be executed
%%% automatically. Please just run the Simulink model
%%% model_groundTethered.slx

% Load busses
load('drone_states_bus.mat');

% Trajectory generator
t0 = 1; 
t1 = 3; 

T_ro_init = 0;
T_sim = 20;
T_launch = 40;
dt = 0.002;
sample_log = 0.01;
l_t = 10; % initial tether length

Tx = 10;
xT = 5;
Ty = 10;
yT = 10;
Tz = 10;
zT = 50;

polynomial_trajectory; % calculate a trajectory


Ixx = 0.018; 
Iyy = 0.018;
Izz = 0.009;
J = diag([Ixx, Iyy, Izz]); 
Jinv = J \ eye(3); 

m_uav = 3; 

g = 9.81; 

%% Stuff related to the tether aerodynamics (Model Uwe)
d_tether = 0.004; % meters
CD_tether = 0.96;
v_w_vec = [1;1;1]; %m/s
% number of masses 
n = 10;
c0 =  614000; % stiffness
d0 = 473; % damping
rho_t = 0.013; % mass density tetherr kg/m
g_vec = [0;0;9.81]; % gravity
rho_air = 1.225; % air density
l_t = 10; % initial tether length
l_s0 = l_t/n; % segment length
m_p = l_s0 * rho_t; % particle weight at initial segment length

%% Kite Aerodynamics
A_Kite = 7;
ASideRel = 0*0.3;
C_L_Kite = 0.1;
C_D_Kite = 0.05;
% --- Payload 
m_kite = 7;
m_ges = m_kite + m_uav ;

% Load the 4p kite model 
setup_KiteModel_4points;


%% ================================ Controller Section ================================

%% Reference model rotational dynamics
A_ref = zeros(6); 
A_ref(1:3, 4:6) = eye(3); 
omega_ref = 100; 
damp_ref = 2*1; 
A_ref(4:6, 1:3) = -omega_ref^2 * eye(3); 
A_ref(4:6, 4:6) = -2*damp_ref * omega_ref * eye(3);  
B_ref = zeros(6,3); 
B_ref(4:6, :) = omega_ref^2*eye(3); 

% Baseline controller gains (Error Dynamics Attitude)
k_e_eta = omega_ref^2;
k_e_eta_dot = 2*damp_ref * omega_ref; 
k_e_eta_I = 1;

%% Reference Model Translational Dynamics
A_t_ref = zeros(6); 
A_t_ref(1:3, 4:6 ) = eye(3); 
A_t_ref_cl = A_t_ref;

omega_0_trans = 0.8;
zeta_0_trans = 1;
A_t_ref_cl(4:6,1:3) = -omega_0_trans^2*eye(3);
A_t_ref_cl(4:6,4:6) = -2*omega_0_trans*zeta_0_trans*eye(3);
B_t_ref_cl(4:6, :) = omega_0_trans^2*eye(3);

% Error controller translational dynamics
K_x_t = omega_0_trans^2*eye(3);
%K_v_t =4* 2*omega_0_trans*zeta_0_trans*eye(3); 
K_v_t = 2*omega_0_trans*zeta_0_trans*eye(3); 
K_i_t = 10*eye(3);

% Initializations
p_init = zeros(3*n,1);
p_init(3:3:3*n) = linspace(l_s0,l_t,n)'; % inital position of the tether segments
x_drone_init = p_init(3*n-2:3*n); % inital postion of the drone
omega_init = zeros(3,1); % initial rates of the drone
eta_init = zeros(3,1); % initial attitude of the drone

T_detach = 30;

% Adaptive augmentation for translational dynamics
A_M_aug = [zeros(3), eye(3);
       -K_x_t, -K_v_t];
Bc = [zeros(3,3); K_x_t ];
Bpbl = [zeros(3); eye(3)]; % Bpbl * Kr =  Bc

Q = blkdiag( diag([0.2,0.2,0.2,2,2,2 ]));
%P_tref = lyap(A_t_ref_cl', Q);
P_tref = lyap(A_M_aug', Q);

% Learning rates
Gamma_ad = 100;100; % MRAC, constant dist
Gamma_pred = 100; % Predictor, constant dist

Gamma_ad_x = 0*eye(6); % Not necessary
Gamma_pred_x =0* eye(6);

%A_prd = 1000 * A_t_ref_cl; % Predictor Dynamics
%P_prd = 1000 * P_tref;

A_prd = 1000 * A_M_aug; % Predictor Dynamics
P_prd = 1000 * P_tref; %lyap(A_prd', 100 * Q);

%P_prd = 10 * P_tref;

%% Robustness modifications
% Deadzone treshhold
e_0 = 0.01;
% Smoothed deadzone
delta_dead = 0.5;
% Projection 
Theta_max = 60; % maximum allowable bound for the jth column 
%Theta_max = 6; % maximum allowable bound for the jth column 

epsilon = 0.6; % projection tolerance


%% Actuator
% Armlength
R = 0.3;
km = 1e-6; % arbitrary

C_A = [0, -R, 0, R;
    R, 0, -R, 0;
    -km, km, -km, km;
    1, 1, 1, 1];

C_A_inv = C_A \eye(4) ;


% Actuator limits (max. thrust per propeller)
Thrust_Max = 80; % N  

% State space form Actuator (first order lag)
A_act = -100*eye(4);
B_act = 100*eye(4);



