function  [L_Kite,D_Kite,S_Kite] = calcKiteForces(x_p_kite, x_p_belowKite,  v_a_k, C_L, rho, A, C_D, ASideRel)

e_z = x_p_belowKite - x_p_kite;
e_y = cross(v_a_k, e_z);
e_Lift = cross(v_a_k, e_y);

L_Kite =  0.5 * rho * C_L * A * (v_a_k'*v_a_k) * e_Lift/norm(e_Lift);
D_Kite = 0.5 * rho * C_D * norm(v_a_k) * v_a_k; 
S_Kite = 0.5 * rho * A * ASideRel * (v_a_k'*v_a_k) * e_y;

end