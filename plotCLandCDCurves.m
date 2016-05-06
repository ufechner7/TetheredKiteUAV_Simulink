ALPHA_CL = [-180.0, -160.0, -90.0, -20.0, -10.0,  -5.0,  0.0, 20.0, 40.0, 90.0, 160.0, 180.0];
CL_LIST  = [   0.0,    0.5,   0.0,  0.08, 0.125,  0.15,  0.2,  1.0,  1.0,  0.0,  -0.5,   0.0];

ALPHA_CD = [-180.0, -170.0, -140.0, -90.0, -20.0, 0.0, 20.0, 90.0, 140.0, 170.0, 180.0];
CD_LIST  = [   0.5,    0.5,    0.5,   1.0,   0.2, 0.1,  0.2,  1.0,   0.5,   0.5,   0.5];

CL_spline =spline(ALPHA_CL,CL_LIST);
CD_spline =spline(ALPHA_CD,CD_LIST);

CL_alpha = ppval(CL_spline, linspace(-20,100,100));
CD_alpha = ppval(CD_spline, linspace(-20,100,100));

CL_20 = ppval(CL_spline, 20);

figure;
grid minor 
hold on
plot(linspace(-20,100,100), CL_alpha);
hold on 
plot(linspace(-20,100,100), CD_alpha);
xlabel('AoA [deg]')
legend('CL(\alpha)','CD(\alpha)')