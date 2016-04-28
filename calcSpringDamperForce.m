function [ fsd_tot_vec_i ] = calcSpringDamperForce( c, p_norm, l_s, d, p_d, v_d, idx )
%CALC_SPRINGDAMPERFORCE Summary of this function goes here
if ( c * ( p_norm - l_s ) + d * ( p_d/p_norm)' * v_d )  <0% -0.1
    c = 0;
    d = 0;d/1000;
end
   % fsd_tot_vec_i = max( ( c * ( p_norm - l_s ) + d * ( p_d/p_norm)' * v_d ), -0.1) * p_d/p_norm;
    fsd_tot_vec_i = (c * ( p_norm - l_s ) + d * ( p_d/p_norm)' * v_d ) * p_d/p_norm;

end

