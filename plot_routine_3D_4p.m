close all

sim_len = length( p_is.Data );
T = sim_len * dt;

% Drone
x_is = p_is.Data(:,1);
y_is = p_is.Data(:,2);
z_is = p_is.Data(:,3);

% Reference Drone
x_ref = p_ref.Data(1,:);
y_ref = p_ref.Data(2,:);
z_ref = p_ref.Data(3,:);

%% --- TETHER --
x_vec =  x_save.Data;
y_vec =  y_save.Data;
z_vec =  z_save.Data;
% number of data points
numb = length(x_vec);

t_vec = 0: sample_log : T_sim;

% Thrust
F_T_b_norm_1 = F_T_b.Data(:,1);% / max( F_T_b.Data(:,1) );
F_T_b_norm_2 = F_T_b.Data(:,2);% / max( F_T_b.Data(:,2) );
F_T_b_norm_3 = F_T_b.Data(:,3);% / max( F_T_b.Data(:,3) );
F_T_b_norm_vec = [F_T_b_norm_1, F_T_b_norm_2, F_T_b_norm_3];

lever_arm_toCG = 2;

% Payload
pos_pl_vec = pos_pl_save;

% Trajectory
f_H = figure(1);
set(f_H, 'Position', [0 0 1120 840])
grid on
hold on
xlabel('x [m]')
ylabel('y [m]')
zlabel('z [m]')

axis([ min( min( x_vec ) ) max( max(x_vec))  min(min(y_vec)) max(max(y_vec))  max(min(min(z_vec)),0) max(max(z_vec))  ])

hold on

view([45,10])
quadcopterh = [];
axis equal
plot3( x_ref, y_ref, z_ref,'color', '0.7500    0.7500  0', 'Linewidth', 1.5, 'Linestyle', '--' )
hold on drawArrow( p_CG_is, F_T_trafo )
drawArrow = @(a,b) quiver3( a(1),a(2),a(3),...
    b(1), b(2), b(3), '-r', 'Linewidth', 1.5 ) ;
drawArrow([15,15,0], v_w_vec)
%%----------------- Set up the movie.
movie_flag = 1;
if movie_flag
    writerObj = VideoWriter('flight.avi'); % Name it.
    writerObj.FrameRate = 60; % How many frames per second.
    open(writerObj);
end
%-----------------

for step = 1 : 10 : sim_len
    
    hold on
    p_CG_is = [x_is(step), y_is(step), z_is(step)];
    
    [T_BE, T_EB] = calcTransformationEB( eta.Data(step,:) );
    F_t_norm = [0;0; norm(F_T_b_norm_vec(step,:))];
    
    F_T_trafo = T_BE  * F_t_norm;
    
    % Position rotors
    p1 = p_CG_is' + T_BE * [0,-lever_arm_toCG,0]';
    p2 = p_CG_is' + T_BE * [0,lever_arm_toCG,0]';
    p3 = p_CG_is' + T_BE * [-lever_arm_toCG,0,0]';
    p4 = p_CG_is' + T_BE * [lever_arm_toCG,0,0]';
    
    % Thrust vector
    drawArrow = @(p_CG_is,F_T_b_norm) quiver3( p_CG_is(1),p_CG_is(2),p_CG_is(3),...
        F_T_b_norm(1), F_T_b_norm(2), F_T_b_norm(3), '-r', 'Linewidth', 2 ) ;
    %thrusth = drawArrow( p_CG_is, F_T_trafo );
    
    delete(quadcopterh)
    
    % Lever arms
    leverh1 = plot3([p1(1) p2(1)], [p1(2) p2(2)], [p1(3) p2(3)],'k','Linewidth', 2 );
    leverh2 = plot3([p3(1) p4(1)], [p3(2) p4(2)], [p3(3) p4(3)],'k','Linewidth', 2 );
    
    cgh = plot3(p_CG_is(1),p_CG_is(2),p_CG_is(3) ,'.','MarkerEdgeColor','[ 0    0.4470    0.7410]','MarkerFaceColor', '[0.9290    0.6940    0.1250]','MarkerSize', 6);
    
    refh = plot3(x_ref(step),y_ref(step),z_ref(step) ,'+','MarkerEdgeColor','[  0    0.5000         0]','MarkerFaceColor', '[0.9290    0.6940    0.1250]','MarkerSize', 10, 'Linewidth', 1.5);
    
    %---- Payload ----
    [ kite_geom_h ] = func_plot_kitegeom( [x_save.Data(step,n_t_p),y_save.Data(step,n_t_p),z_save.Data(step,n_t_p)],...
        [pos_kite.Data(step,1),pos_kite.Data(step,2),pos_kite.Data(step,3)],...
        [pos_kite.Data(step,4),pos_kite.Data(step,5),pos_kite.Data(step,6)],...
        [pos_kite.Data(step,7),pos_kite.Data(step,8),pos_kite.Data(step,9)],...
        [pos_kite.Data(step,10),pos_kite.Data(step,11),pos_kite.Data(step,12)] );
    
    p_kite_uav_h_1 = plot3( [pos_kite.Data(step,4) p_kite_uav.Data(step,1)],...
        [pos_kite.Data(step,5), p_kite_uav.Data(step,2)],...
        [pos_kite.Data(step,6), p_kite_uav.Data(step,3)], 'k');
    
    p_kite_uav_h_2 = plot3( [p_kite_uav.Data(step,1), p_CG_is(1) ],...
        [p_kite_uav.Data(step,2), p_CG_is(2)],...
        [p_kite_uav.Data(step,3), p_CG_is(3)], 'k');
    
    p_kite_uav_h_3 =  plot3( p_kite_uav.Data(step,1),...
        p_kite_uav.Data(step,2),...
        p_kite_uav.Data(step,3), 'o', 'MarkerEdgeColor', 'k','MarkerFaceColor','k' ,'Markersize', 3);
    
    p_kite_uav_h = [p_kite_uav_h_1, p_kite_uav_h_2, p_kite_uav_h_3];
    
    %---- TETHER ----
    if t_vec(step) < T_launch
        tether_h = plot3( [0, x_vec(step, :)],[0, y_vec(step, :)],[0, z_vec(step, :)], 'k');
        tether_h_lmpd = plot3( x_vec(step, :),y_vec(step, :),z_vec(step, :), 'o', 'MarkerEdgeColor', 'k','MarkerFaceColor','k' ,'Markersize', 3);
        quadcopterh = [leverh1, leverh2, refh,tether_h, tether_h_lmpd, kite_geom_h, p_kite_uav_h ];
    else
        tether_h = plot3( [0, x_vec(step, 1:n-2)],[0, y_vec(step, 1:n-2)],[0, z_vec(step, 1:n-2)], 'k');
        tether_h_lmpd = plot3( x_vec(step, 1:n-2),y_vec(step, 1:n-2),z_vec(step, 1:n-2), 'o', 'MarkerEdgeColor', 'k','MarkerFaceColor','k' ,'Markersize', 3);
        
        tether_h_to_Drone_h = plot3( x_vec(step, n-1:n),y_vec(step, n-1:n),z_vec(step, n-1:n), 'k');
        tether_h_to_Drone_lmpd = plot3( x_vec(step, n-1:n),y_vec(step,  n-1:n),z_vec(step,  n-1:n), 'o', 'MarkerEdgeColor', 'k','MarkerFaceColor','k' ,'Markersize', 3);
        quadcopterh = [leverh1, leverh2, refh,tether_h, tether_h_lmpd,...
            tether_h_to_Drone_h,tether_h_to_Drone_lmpd, p_kite_uav_h  ];
    end
    
    
    if movie_flag
        frame = getframe(gcf); % 'gcf' can handle if you zoom in to take a movie.
        writeVideo(writerObj, frame);
    end
    drawnow
    pause(0.01)
end
%%

if movie_flag
    close(writerObj); % Saves the movie.
end

% Position over time
figure;
grid on
hold on
plot( t_vec,x_is, 'Markersize', 3 )
plot( t_vec,x_ref, 'Markersize', 3 )
xlabel('Time [s]')
ylabel('x position [m]')

figure;
grid on
hold on
plot( t_vec,y_is, 'Markersize', 3 )
plot( t_vec,y_ref, 'Markersize', 3 )
xlabel('Time [s]')
ylabel('y position [m]')

figure;
grid on
hold on
plot( t_vec,z_is, 'Markersize', 3 )
plot( t_vec,z_ref, 'Markersize', 3 )
xlabel('Time [s]')
ylabel('z position [m]')


%
% %% Error
% figure(2)
% grid on
% hold on
% plot( F_T_b.Data )
figure;
%% Attitude
subplot(311)
grid on
hold on
plot( t_vec,180/pi*eta.Data(:,1) )
xlabel('Time [s]')
ylabel('\Phi [deg]')

subplot(312)
grid on
hold on
plot( t_vec,180/pi*eta.Data(:,2) )
xlabel('Time [s]')
ylabel('\Theta [deg]')

subplot(313)
grid on
hold on
plot( t_vec,180/pi*eta.Data(:,3) )
xlabel('Time [s]')
ylabel('\Psi [deg]')

%% estimated disturbance
figure;
subplot(311)
grid on
hold on
plot( t_vec,disturbance_estimation_x.Data(:,1) )
plot( t_vec,disturbance_estimation_x.Data(:,2) )
xlabel('Time [s]')
ylabel('d_x [N]')

subplot(312)
grid on
hold on
plot( t_vec,disturbance_estimation_y.Data(:,1) )
plot( t_vec,disturbance_estimation_y.Data(:,2) )
xlabel('Time [s]')
ylabel('d_y [N]')

subplot(313)
grid on
hold on
plot( t_vec,disturbance_estimation_z.Data(:,1) )
plot( t_vec,disturbance_estimation_z.Data(:,2) )
xlabel('Time [s]')
ylabel('d_z [N]')
legend('True value','Estimated')

figure;
grid on
hold on
plot( t_vec,safety_barrier.Data(:,1), 'color', '[ 0    0.4470    0.7410]', 'Linewidth', 2 );
hold on
plot([0 40],[0.5 0.5], '--r', 'Linewidth', 2 );
xlabel('Time [s]')
ylabel('Difference CG Drone and Tetherlength [m]')

figure;
grid on
hold on
plot( t_vec,V_save, 'color', '[ 0    0.4470    0.7410]', 'Linewidth', 2 );
hold on
xlabel('Time [s]')
ylabel('V [-]')

%% robustness mod analysis
figure;
set(gca,'fontsize',18)
grid on
hold on
plot( t_vec,e_pref_mu.Data(:,1), 'color', '[ 0    0.4470    0.7410]', 'Linewidth', 2 );
hold on
plot( t_vec,e_pref_mu.Data(:,2), 'color', '[  0.8500    0.3250    0.0980]', 'Linewidth', 2 );
plot( [0 T_sim],[delta_dead*e_0 delta_dead*e_0], 'color', '[ 0.4660    0.6740    0.1880]', 'Linewidth', 2, 'Linestyle', '--' );
hold on
plot( [0 T_sim],[e_0 e_0], 'color', '[ 0.4660    0.6740    0.1880]', 'Linewidth', 2, 'Linestyle', '--' );
hold on
xlabel('Time [s]')
legend('e_{ref}', '\mu_{dead}','deadzone' )

figure;
set(gca,'fontsize',18)
grid on
hold on
plot( t_vec,e_ref_mu.Data(:,1), 'color', '[ 0    0.4470    0.7410]', 'Linewidth', 2 );
hold on
plot( t_vec,e_ref_mu.Data(:,2), 'color', '[  0.8500    0.3250    0.0980]', 'Linewidth', 2 );
hold on
plot( [0 T_sim],[delta_dead*e_0 delta_dead*e_0], 'color', '[ 0.4660    0.6740    0.1880]', 'Linewidth', 2, 'Linestyle', '--' );
hold on
plot( [0 T_sim],[e_0 e_0], 'color', '[ 0.4660    0.6740    0.1880]', 'Linewidth', 2, 'Linestyle', '--' );
hold on
xlabel('Time [s]')
legend('e_{ref}', '\mu_{dead}','deadzone' )

%% Projection operator
figure;
set(gca,'fontsize',14)
grid on
hold on
theta_f = linspace(-Theta_max, Theta_max, 1000);
theta_f_b = linspace(-Theta_max*epsilon, Theta_max*epsilon, 1000);
f = ( ( (1+epsilon)*(theta_f).^2 - (Theta_max).^2 ) ./ (epsilon*(Theta_max).^2) );
plot(theta_f, f,'color', '[ 0    0.4470    0.7410]', 'Linewidth', 2 );
hold on
plot([Theta_max/sqrt(1+epsilon) Theta_max/sqrt(1+epsilon)], [-1.5 1], 'color', '[  0.8500    0.3250    0.0980]', 'Linewidth', 2, 'Linestyle', '--')
plot([-Theta_max/sqrt(1+epsilon) -Theta_max/sqrt(1+epsilon)], [-1.5 1],'color', '[  0.8500    0.3250    0.0980]', 'Linewidth', 2, 'Linestyle', '--')
hold on
plot([Theta_max Theta_max], [-1.5 1], 'color', '[  0.8500    0.3250    0.0980]', 'Linewidth', 2, 'Linestyle', '--')
plot([-Theta_max -Theta_max], [-1.5 1],'color', '[  0.8500    0.3250    0.0980]', 'Linewidth', 2, 'Linestyle', '--')
hold on
plot( disturbance_estimation_z.Data(:,2),max(proj_flat.Data(:,2).*proj_flat.Data(:,1),  0),...
    '*','MarkerEdgeColor','[   0.4660    0.6740    0.1880]','MarkerSize', 5, 'Linewidth', 0.1);

xlabel('dz_{est}')
ylabel('f(dz_{est})')


%% Hedging

% ---- Propeller thrusts ----
figure;
subplot(221)
grid on
hold on
plot(t_vec, prop_thrust_cmd.Data(:,1),'color', '[ 0    0.4470    0.7410]', 'Linewidth', 1.5 );
hold on
plot(t_vec, prop_thrust_real.Data(:,1),'color', '[   0.4660    0.6740    0.1880]', 'Linewidth', 1.5 );
hold on
plot( [0 T_sim],[Thrust_Max Thrust_Max], 'color', '[  0.8500    0.3250    0.0980]', 'Linewidth', 2, 'Linestyle', '--' );
hold on
plot( [0 T_sim],[-Thrust_Max -Thrust_Max], 'color', '[  0.8500    0.3250    0.0980]', 'Linewidth', 2, 'Linestyle', '--' );
ylabel('F_1')

subplot(222)
grid on
hold on
plot(t_vec, prop_thrust_cmd.Data(:,2),'color', '[ 0    0.4470    0.7410]', 'Linewidth', 1.5 );
hold on
plot(t_vec, prop_thrust_real.Data(:,2),'color', '[   0.4660    0.6740    0.1880]', 'Linewidth', 1.5 );
hold on
plot( [0 T_sim],[Thrust_Max Thrust_Max], 'color', '[  0.8500    0.3250    0.0980]', 'Linewidth', 2, 'Linestyle', '--' );
hold on
plot( [0 T_sim],[-Thrust_Max -Thrust_Max], 'color', '[  0.8500    0.3250    0.0980]', 'Linewidth', 2, 'Linestyle', '--' );
ylabel('F_2')

subplot(223)
grid on
hold on
plot(t_vec, prop_thrust_cmd.Data(:,3),'color', '[ 0    0.4470    0.7410]', 'Linewidth', 1.5 );
hold on
plot(t_vec, prop_thrust_real.Data(:,3),'color', '[   0.4660    0.6740    0.1880]', 'Linewidth', 1.5 );
hold on
plot( [0 T_sim],[Thrust_Max Thrust_Max], 'color', '[  0.8500    0.3250    0.0980]', 'Linewidth', 2, 'Linestyle', '--' );
hold on
plot( [0 T_sim],[-Thrust_Max -Thrust_Max], 'color', '[  0.8500    0.3250    0.0980]', 'Linewidth', 2, 'Linestyle', '--' );
ylabel('F_3')

subplot(224)
grid on
hold on
plot(t_vec, prop_thrust_cmd.Data(:,4),'color', '[ 0    0.4470    0.7410]', 'Linewidth', 1.5 );
hold on
plot(t_vec, prop_thrust_real.Data(:,4),'color', '[   0.4660    0.6740    0.1880]', 'Linewidth', 1.5 );
hold on
plot( [0 T_sim],[Thrust_Max Thrust_Max], 'color', '[  0.8500    0.3250    0.0980]', 'Linewidth', 2, 'Linestyle', '--' );
hold on
plot( [0 T_sim],[-Thrust_Max -Thrust_Max], 'color', '[  0.8500    0.3250    0.0980]', 'Linewidth', 2, 'Linestyle', '--' );
ylabel('F_4')

legend('F_{CMD}','F','F_{max}','F_{min}')

%% ---- Resulting moments and total thrust (considering rotational direction) ----
%    o1
% o4-x--o2
%    o3
% (script FSD, quadcopter experiment)

LMNT_cmd = C_A * [prop_thrust_cmd.Data(:,1), prop_thrust_cmd.Data(:,2), prop_thrust_cmd.Data(:,3), prop_thrust_cmd.Data(:,4)]';
LMNT_real = C_A * [prop_thrust_real.Data(:,1), prop_thrust_real.Data(:,2), prop_thrust_real.Data(:,3), prop_thrust_real.Data(:,4)]';

figure;
subplot(221)
grid on
hold on
plot(t_vec, LMNT_cmd(1,:),'color', '[ 0    0.4470    0.7410]', 'Linewidth', 1.5 );
hold on
plot(t_vec, LMNT_real(1,:), 'Linewidth', 1.5 );
hold on
ylabel('L [Nm]')

subplot(222)
grid on
hold on
plot(t_vec,LMNT_cmd(2,:),'color', '[ 0    0.4470    0.7410]', 'Linewidth', 1.5 );
hold on
plot(t_vec, LMNT_real(2,:), 'Linewidth', 1.5 );
hold on
ylabel('M [Nm]')

subplot(223)
grid on
hold on
plot(t_vec, LMNT_cmd(3,:),'color', '[ 0    0.4470    0.7410]', 'Linewidth', 1.5 );
hold on
plot(t_vec, LMNT_real(3,:), 'Linewidth', 1.5 );
hold on
ylabel('N [Nm]')

subplot(224)
grid on
hold on
plot(t_vec, LMNT_cmd(4,:),'color', '[ 0    0.4470    0.7410]', 'Linewidth', 1.5 );
hold on
plot(t_vec, LMNT_real(4,:), 'Linewidth', 1.5 );
hold on
ylabel('T [N]')

legend('CMD','REAL')


%% -- Compare reference model with slowed down reference model
% Rotatory dynamics
figure;
subplot(311)
grid on
hold on
plot(t_vec, original_rot_ref.Data(:,1), 'Linewidth', 1.5 );
hold on
plot(t_vec, slowed_rot_ref.Data(:,1), 'Linewidth', 1.5 );
ylabel('nu_{x,trans}')

subplot(312)
grid on
hold on
plot(t_vec, original_rot_ref.Data(:,2), 'Linewidth', 1.5 );
hold on
plot(t_vec, slowed_rot_ref.Data(:,2), 'Linewidth', 1.5 );
ylabel('nu_{y,trans}')

subplot(313)
grid on
hold on
plot(t_vec, original_rot_ref.Data(:,3), 'Linewidth', 1.5 );
hold on
plot(t_vec, slowed_rot_ref.Data(:,3), 'Linewidth', 1.5 );
ylabel('nu_{z,trans}')
legend('CMD','REAL')

% Translational dynamics
figure;
subplot(311)
grid on
hold on
plot(t_vec, original_trans_ref.Data(:,1), 'Linewidth', 1.5 );
hold on
plot(t_vec, slowed_trans_ref.Data(1,:), 'Linewidth', 1.5 );
ylabel('nu_{x,rot}')

subplot(312)
grid on
hold on
plot(t_vec, original_trans_ref.Data(:,2), 'Linewidth', 1.5 );
hold on
plot(t_vec, slowed_trans_ref.Data(2,:), 'Linewidth', 1.5 );
ylabel('nu_{y,rot}')

subplot(313)
grid on
hold on
plot(t_vec, original_trans_ref.Data(:,3), 'Linewidth', 1.5 );
hold on
plot(t_vec, slowed_trans_ref.Data(3,:), 'Linewidth', 1.5 );
ylabel('nu_{z,rot}')
legend('CMD','REAL')