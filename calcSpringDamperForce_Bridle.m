function [ fsd_tot_vec_i ] = calcSpringDamperForce_Bridle( c, p_norm, l_s, d, p_d, v_d, idx )
%CALC_SPRINGDAMPERFORCE Summary of this function goes here

fsd_tot_vec_i = (c * ( p_norm - l_s ) + d * ( p_d/p_norm)' * v_d ) * p_d/p_norm;


