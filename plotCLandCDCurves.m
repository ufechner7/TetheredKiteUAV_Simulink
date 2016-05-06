ALPHA_CL = [-180.0, -160.0, -90.0, -20.0, -10.0,  -5.0,  0.0, 20.0, 40.0, 90.0, 160.0, 180.0];
CL_LIST  = [   0.0,    0.5,   0.0,  0.08, 0.125,  0.15,  0.2,  1.0,  1.0,  0.0,  -0.5,   0.0];

ALPHA_CD = [-180.0, -170.0, -140.0, -90.0, -20.0, 0.0, 20.0, 90.0, 140.0, 170.0, 180.0];
CD_LIST  = [   0.5,    0.5,    0.5,   1.0,   0.2, 0.1,  0.2,  1.0,   0.5,   0.5,   0.5];

CL_spline =spline(ALPHA_CL,CL_LIST);
CD_spline =spline(ALPHA_CD,CD_LIST);

CL_alpha = ppval(CL_spline, linspace(-180,180,100));
CD_alpha = ppval(CD_spline, linspace(-180,180,100));


figure;
grid minor
hold on
plot(linspace(-180,180,100), CL_alpha, '--r','Linewidth',1.5);
hold on
plot(linspace(-180,180,100), CD_alpha, '--g','Linewidth',1.5);
xlabel('AoA [deg]')
legend('CL(\alpha)','CD(\alpha)')



alpha_test_1 = linspace(-180,-160,20);
alpha_test_2 = linspace(-160,-90,20);
alpha_test_3 = linspace(-90,-20,20);
alpha_test_4 = linspace(-20,-10,20);
alpha_test_5 = linspace(-10,-5,20);
alpha_test_6 = linspace(-5,0,20);
alpha_test_7 = linspace(0,20,20);
alpha_test_8 = linspace(20,40,20);
alpha_test_9 = linspace(40,90,20);
alpha_test_10 = linspace(90,160,20);
alpha_test_11 = linspace(160,180,20);

ALPHA_CL = [-180.0, -160.0, -90.0, -20.0, -10.0,  -5.0,  0.0, 20.0, 40.0, 90.0, 160.0, 180.0];
CL_LIST  = [   0.0,    0.5,   0.0,  0.08, 0.125,  0.15,  0.2,  1.0,  1.0,  0.0,  -0.5,   0.0];

CL_spline_coefs = CL_spline.coefs;
CD_spline_coefs = CD_spline.coefs;

%% Lift
CL_alpha_func_1 = @(aoa) (CL_spline_coefs(1,1)*(aoa+180).^3+CL_spline_coefs(1,2)*(aoa+180).^2+CL_spline_coefs (1,3)*(aoa+180) + CL_spline_coefs (1,4)) ;
CL_alpha_func_2 = @(aoa) (CL_spline_coefs(2,1)*(aoa+160).^3+CL_spline_coefs(2,2)*(aoa+160).^2+CL_spline_coefs (2,3)*(aoa+160) + CL_spline_coefs (2,4));
CL_alpha_func_3 = @(aoa) (CL_spline_coefs(3,1)*(aoa+90).^3+CL_spline_coefs (3,2)*(aoa+90).^2+CL_spline_coefs (3,3)*(aoa+90) + CL_spline_coefs (3,4));
CL_alpha_func_4 = @(aoa) (CL_spline_coefs(4,1)*(aoa+20).^3+CL_spline_coefs (4,2)*(aoa+20).^2+CL_spline_coefs (4,3)*(aoa+20) + CL_spline_coefs (4,4));
CL_alpha_func_5 = @(aoa) (CL_spline_coefs(5,1)*(aoa+10).^3+CL_spline_coefs (5,2)*(aoa+10).^2+CL_spline_coefs (5,3)*(aoa+10)+CL_spline_coefs (5,4));
CL_alpha_func_6 = @(aoa) (CL_spline_coefs(6,1)*(aoa+5).^3+CL_spline_coefs  (6,2)*(aoa+5).^2+CL_spline_coefs (6,3)*(aoa+5) + CL_spline_coefs (6,4)) ;
CL_alpha_func_7 = @(aoa) (CL_spline_coefs(7,1)*(aoa).^3+CL_spline_coefs (7,2)*(aoa).^2+CL_spline_coefs (7,3)*(aoa) + CL_spline_coefs (7,4));
CL_alpha_func_8 = @(aoa) (CL_spline_coefs(8,1)*(aoa-20).^3+CL_spline_coefs (8,2)*(aoa-20).^2+CL_spline_coefs (8,3)*(aoa-20) + CL_spline_coefs (8,4));
CL_alpha_func_9 = @(aoa) (CL_spline_coefs(9,1)*(aoa-40).^3+CL_spline_coefs (9,2)*(aoa-40).^2+CL_spline_coefs (9,3)*(aoa-40) + CL_spline_coefs (9,4));
CL_alpha_func_10 = @(aoa)(CL_spline_coefs(10,1)*(aoa-90).^3+CL_spline_coefs (10,2)*(aoa-90).^2+CL_spline_coefs (10,3)*(aoa-90)+CL_spline_coefs (10,4));
CL_alpha_func_11 = @(aoa)(CL_spline_coefs(11,1)*(aoa-160).^3+CL_spline_coefs (11,2)*(aoa-160).^2+CL_spline_coefs (11,3)*(aoa-160)+CL_spline_coefs (11,4));

%% Drag
%ALPHA_CD = [-180.0, -170.0, -140.0, -90.0, -20.0, 0.0, 20.0, 90.0, 140.0, 170.0, 180.0];

CD_alpha_func_1 = @(aoa) (CD_spline_coefs(1,1)*(aoa+180).^3+CD_spline_coefs (1,2)*(aoa+180).^2+CD_spline_coefs (1,3)*(aoa+180) + CD_spline_coefs (1,4)) ;
CD_alpha_func_2 = @(aoa) (CD_spline_coefs (2,1)*(aoa+170).^3+CD_spline_coefs (2,2)*(aoa+170).^2+CD_spline_coefs (2,3)*(aoa+170) + CD_spline_coefs (2,4));
CD_alpha_func_3 = @(aoa) (CD_spline_coefs (3,1)*(aoa+140).^3+CD_spline_coefs (3,2)*(aoa+140).^2+CD_spline_coefs (3,3)*(aoa+140) + CD_spline_coefs (3,4));
CD_alpha_func_4 = @(aoa) (CD_spline_coefs(4,1)*(aoa+90).^3+CD_spline_coefs (4,2)*(aoa+90).^2+CD_spline_coefs (4,3)*(aoa+90) + CD_spline_coefs (4,4)) ;
CD_alpha_func_5 = @(aoa) (CD_spline_coefs (5,1)*(aoa+20).^3+CD_spline_coefs (5,2)*(aoa+20).^2+CD_spline_coefs (5,3)*(aoa+20) + CD_spline_coefs (5,4));
CD_alpha_func_6 = @(aoa) (CD_spline_coefs (6,1)*(aoa).^3+CD_spline_coefs (6,2)*(aoa).^2+CD_spline_coefs (6,3)*(aoa) + CD_spline_coefs (6,4));
CD_alpha_func_7 = @(aoa) (CD_spline_coefs(7,1)*(aoa-20).^3+CD_spline_coefs (7,2)*(aoa-20).^2+CD_spline_coefs (7,3)*(aoa-20) + CD_spline_coefs (7,4)) ;
CD_alpha_func_8 = @(aoa) (CD_spline_coefs (8,1)*(aoa-90).^3+CD_spline_coefs (8,2)*(aoa-90).^2+CD_spline_coefs (8,3)*(aoa-90) + CD_spline_coefs (8,4));
CD_alpha_func_9 = @(aoa) (CD_spline_coefs (9,1)*(aoa-140).^3+CD_spline_coefs (9,2)*(aoa-140).^2+CD_spline_coefs (9,3)*(aoa-140) + CD_spline_coefs (9,4));
CD_alpha_func_10 = @(aoa) (CD_spline_coefs(10,1)*(aoa-170).^3+CD_spline_coefs (10,2)*(aoa-170).^2+CD_spline_coefs (10,3)*(aoa-170) + CD_spline_coefs (10,4)) ;

plot(alpha_test_1, CL_alpha_func_1(alpha_test_1))
plot(alpha_test_2, CL_alpha_func_2(alpha_test_2))
plot(alpha_test_3, CL_alpha_func_3(alpha_test_3))
plot(alpha_test_4, CL_alpha_func_4(alpha_test_4))
plot(alpha_test_5, CL_alpha_func_5(alpha_test_5))
plot(alpha_test_6, CL_alpha_func_6(alpha_test_6))
plot(alpha_test_7, CL_alpha_func_7(alpha_test_7))
plot(alpha_test_8, CL_alpha_func_8(alpha_test_8))
plot(alpha_test_9, CL_alpha_func_9(alpha_test_9))
plot(alpha_test_10, CL_alpha_func_10(alpha_test_10))
plot(alpha_test_11, CL_alpha_func_11(alpha_test_11))


alpha_test_1 = linspace(-180,-170,20);
alpha_test_2 = linspace(-170,-140,20);
alpha_test_3 = linspace(-140,-90,20);
alpha_test_4 = linspace(-90,-20,20);
alpha_test_5 = linspace(-20,0,20);
alpha_test_6 = linspace(0,20,20);
alpha_test_7 = linspace(20,90,20);
alpha_test_8 = linspace(90,140,20);
alpha_test_9 = linspace(140,170,20);
alpha_test_10 = linspace(170,180,20);

plot(alpha_test_1, CD_alpha_func_1(alpha_test_1))
plot(alpha_test_2, CD_alpha_func_2(alpha_test_2))
plot(alpha_test_3, CD_alpha_func_3(alpha_test_3))
plot(alpha_test_4, CD_alpha_func_4(alpha_test_4))
plot(alpha_test_5, CD_alpha_func_5(alpha_test_5))
plot(alpha_test_6, CD_alpha_func_6(alpha_test_6))
plot(alpha_test_7, CD_alpha_func_7(alpha_test_7))
plot(alpha_test_8, CD_alpha_func_8(alpha_test_8))
plot(alpha_test_9, CD_alpha_func_9(alpha_test_9))
plot(alpha_test_10, CD_alpha_func_10(alpha_test_10))


%% Test
aoa_test = -170;

% ALPHA_CL = [-180.0, -160.0, -90.0, -20.0, -10.0,  -5.0,  0.0, 20.0, 40.0, 90.0, 160.0, 180.0];
% ALPHA_CD = [-180.0, -170.0, -140.0, -90.0, -20.0, 0.0, 20.0, 90.0, 140.0, 170.0, 180.0];

if aoa_test >= -180 && aoa_test < -160
    CL_alpha_eval =  CL_alpha_func_1(aoa_test)
elseif aoa_test >= -160 && aoa_test < -90
    CL_alpha_eval =  CL_alpha_func_2(aoa_test)
elseif aoa_test >= -90 && aoa_test < -20
    CL_alpha_eval =  CL_alpha_func_3(aoa_test)
elseif aoa_test >= -20 && aoa_test < -10
    CL_alpha_eval =  CL_alpha_func_4(aoa_test)
elseif aoa_test >= -10 && aoa_test < -5
    CL_alpha_eval =  CL_alpha_func_5(aoa_test)
elseif aoa_test >= -5 && aoa_test < 0
    CL_alpha_eval =  CL_alpha_func_6(aoa_test)
elseif aoa_test >= 0 && aoa_test < 20
    CL_alpha_eval =  CL_alpha_func_7(aoa_test)
elseif aoa_test >= 20 && aoa_test < 40
    CL_alpha_eval =  CL_alpha_func_8(aoa_test)
elseif aoa_test >= 40 && aoa_test < 90
    CL_alpha_eval =  CL_alpha_func_9(aoa_test)
elseif aoa_test >= 90 && aoa_test < 160
    CL_alpha_eval =  CL_alpha_func_10(aoa_test)
elseif aoa_test >= 160 && aoa_test < 180
    CL_alpha_eval =  CL_alpha_func_11(aoa_test)
end


if aoa_test >= -180 && aoa_test < -170
    CD_alpha_eval =  CD_alpha_func_1(aoa_test)
elseif aoa_test >= -170 && aoa_test < -140
    CD_alpha_eval =  CD_alpha_func_2(aoa_test)
elseif aoa_test >= -140 && aoa_test < -90
    CD_alpha_eval =  CD_alpha_func_3(aoa_test)
elseif aoa_test >= -90 && aoa_test < -20
    CD_alpha_eval =  CD_alpha_func_4(aoa_test)
elseif aoa_test >= -20 && aoa_test < 0
    CD_alpha_eval =  CD_alpha_func_5(aoa_test)
elseif aoa_test >= 0 && aoa_test < 20
    CD_alpha_eval =  CD_alpha_func_6(aoa_test)
elseif aoa_test >= 20 && aoa_test < 90
    CD_alpha_eval =  CD_alpha_func_7(aoa_test)
elseif aoa_test >= 90 && aoa_test < 140
    CD_alpha_eval =  CD_alpha_func_8(aoa_test)
elseif aoa_test >= 140 && aoa_test < 170
    CD_alpha_eval =  CD_alpha_func_9(aoa_test)
elseif aoa_test >= 170 && aoa_test < 180
    CD_alpha_eval =  CD_alpha_func_10(aoa_test)
end


% compare with direct calculation
CL_alpha_direct = ppval(CL_spline, aoa_test)
CD_alpha_direct = ppval(CD_spline, aoa_test)
