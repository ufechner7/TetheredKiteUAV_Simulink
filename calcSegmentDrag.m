function [ d_segment ] = calcSegmentDrag( p_d, v_a_p, rho_air, CD_tether,d_tether )
%CALCSEGMENTDRAG Summary of this function goes here
%   Detailed explanation goes here
dp_parallel = p_d - p_d .* v_a_p .* v_a_p / (v_a_p' * v_a_p) ; % projection of segment direction perpedicular to v_a direction
A_eff = norm(dp_parallel) * d_tether; % projected tether area perpendicular to v_a
d_segment = 0.5 * rho_air * CD_tether * v_a_p * norm(v_a_p) * A_eff; % particle drag
end


