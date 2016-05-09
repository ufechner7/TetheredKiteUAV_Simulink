function [ CL, CD ] = calcCLandCD_4pKite( aoa,CL_spline_coefs,CD_spline_coefs )


CL = 0;
CD = 0;

%% Depending on the current aoa the corresponding spline curve will be evaluated and the CL and CD will be calculated.
% For the definition of the interval please refer to plotCLandCDCurves.m
if aoa >= -180 && aoa < -160
    CL = (CL_spline_coefs(1,1)*(aoa+180).^3+CL_spline_coefs(1,2)*(aoa+180).^2+CL_spline_coefs (1,3)*(aoa+180) + CL_spline_coefs (1,4)) ;
elseif aoa >= -160 && aoa < -90
    CL =  (CL_spline_coefs(2,1)*(aoa+160).^3+CL_spline_coefs(2,2)*(aoa+160).^2+CL_spline_coefs (2,3)*(aoa+160) + CL_spline_coefs (2,4));
elseif aoa >= -90 && aoa < -20
    CL = (CL_spline_coefs(3,1)*(aoa+90).^3+CL_spline_coefs (3,2)*(aoa+90).^2+CL_spline_coefs (3,3)*(aoa+90) + CL_spline_coefs (3,4));
elseif aoa >= -20 && aoa < -10
    CL =  (CL_spline_coefs(4,1)*(aoa+20).^3+CL_spline_coefs (4,2)*(aoa+20).^2+CL_spline_coefs (4,3)*(aoa+20) + CL_spline_coefs (4,4));
elseif aoa >= -10 && aoa < -5
    CL =  (CL_spline_coefs(5,1)*(aoa+10).^3+CL_spline_coefs (5,2)*(aoa+10).^2+CL_spline_coefs (5,3)*(aoa+10)+CL_spline_coefs (5,4));
elseif aoa >= -5 && aoa < 0
    CL =  (CL_spline_coefs(6,1)*(aoa+5).^3+CL_spline_coefs  (6,2)*(aoa+5).^2+CL_spline_coefs (6,3)*(aoa+5) + CL_spline_coefs (6,4)) ;
elseif aoa >= 0 && aoa < 20
    CL = (CL_spline_coefs(7,1)*(aoa).^3+CL_spline_coefs (7,2)*(aoa).^2+CL_spline_coefs (7,3)*(aoa) + CL_spline_coefs (7,4));
elseif aoa >= 20 && aoa < 40
    CL = (CL_spline_coefs(8,1)*(aoa-20).^3+CL_spline_coefs (8,2)*(aoa-20).^2+CL_spline_coefs (8,3)*(aoa-20) + CL_spline_coefs (8,4));
elseif aoa >= 40 && aoa < 90
    CL =  (CL_spline_coefs(9,1)*(aoa-40).^3+CL_spline_coefs (9,2)*(aoa-40).^2+CL_spline_coefs (9,3)*(aoa-40) + CL_spline_coefs (9,4));
elseif aoa >= 90 && aoa < 160
    CL = (CL_spline_coefs(10,1)*(aoa-90).^3+CL_spline_coefs (10,2)*(aoa-90).^2+CL_spline_coefs (10,3)*(aoa-90)+CL_spline_coefs (10,4));
elseif aoa >= 160 && aoa < 180
    CL =  (CL_spline_coefs(11,1)*(aoa-160).^3+CL_spline_coefs (11,2)*(aoa-160).^2+CL_spline_coefs (11,3)*(aoa-160)+CL_spline_coefs (11,4));
end

if aoa >= -180 && aoa < -170
    CD = (CD_spline_coefs(1,1)*(aoa+180).^3+CD_spline_coefs (1,2)*(aoa+180).^2+CD_spline_coefs (1,3)*(aoa+180) + CD_spline_coefs (1,4)) ;
elseif aoa >= -170 && aoa < -140
    CD =  (CD_spline_coefs (2,1)*(aoa+170).^3+CD_spline_coefs (2,2)*(aoa+170).^2+CD_spline_coefs (2,3)*(aoa+170) + CD_spline_coefs (2,4));
elseif aoa >= -140 && aoa < -90
    CD = (CD_spline_coefs (3,1)*(aoa+140).^3+CD_spline_coefs (3,2)*(aoa+140).^2+CD_spline_coefs (3,3)*(aoa+140) + CD_spline_coefs (3,4));
elseif aoa >= -90 && aoa < -20
    CD = (CD_spline_coefs(4,1)*(aoa+90).^3+CD_spline_coefs (4,2)*(aoa+90).^2+CD_spline_coefs (4,3)*(aoa+90) + CD_spline_coefs (4,4)) ;
elseif aoa >= -20 && aoa < 0
    CD =  (CD_spline_coefs (5,1)*(aoa+20).^3+CD_spline_coefs (5,2)*(aoa+20).^2+CD_spline_coefs (5,3)*(aoa+20) + CD_spline_coefs (5,4));
elseif aoa >= 0 && aoa < 20
    CD =  (CD_spline_coefs (6,1)*(aoa).^3+CD_spline_coefs (6,2)*(aoa).^2+CD_spline_coefs (6,3)*(aoa) + CD_spline_coefs (6,4));
elseif aoa >= 20 && aoa < 90
    CD = (CD_spline_coefs(7,1)*(aoa-20).^3+CD_spline_coefs (7,2)*(aoa-20).^2+CD_spline_coefs (7,3)*(aoa-20) + CD_spline_coefs (7,4)) ;
elseif aoa >= 90 && aoa < 140
    CD =  (CD_spline_coefs (8,1)*(aoa-90).^3+CD_spline_coefs (8,2)*(aoa-90).^2+CD_spline_coefs (8,3)*(aoa-90) + CD_spline_coefs (8,4));
elseif aoa >= 140 && aoa < 170
    CD =  (CD_spline_coefs (9,1)*(aoa-140).^3+CD_spline_coefs (9,2)*(aoa-140).^2+CD_spline_coefs (9,3)*(aoa-140) + CD_spline_coefs (9,4));
elseif aoa >= 170 && aoa < 180
    CD = (CD_spline_coefs(10,1)*(aoa-170).^3+CD_spline_coefs (10,2)*(aoa-170).^2+CD_spline_coefs (10,3)*(aoa-170) + CD_spline_coefs (10,4)) ;
end


end

