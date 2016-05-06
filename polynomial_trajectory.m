%% Trajectory in x-direction 

syms t x0 x1 x2 x3 x4 x5

xref = x5 * t^5 + x4 * t^4 + x3 * t^3 + x2 * t^2 + x1 * t + x0;
xref_dot = diff(xref,t);
xref_dotdot = diff(xref_dot,t);

Fx = [subs( xref, t, 0) == 0;
    subs( xref_dot, t, 0) == 0;
    subs( xref_dot, t, Tx) == 0;
    subs( xref_dotdot, t, 0) == 0;
    subs( xref_dotdot, t, Tx) == 0;
    subs( xref, t, Tx) == xT];

solutions_x = solve(Fx);

x0num = double( solutions_x.x0 );
x1num =  double( solutions_x.x1 ); 
x2num =  double( solutions_x.x2 );
x3num =  double( solutions_x.x3 );
x4num =  double( solutions_x.x4 );
x5num =  double( solutions_x.x5 );

%% Trajectory in y-direction 

syms t y0 y1 y2 y3 y4 y5

yref = y5 * t^5 + y4 * t^4 + y3 * t^3 + y2 * t^2 + y1 * t + y0;
yref_dot = diff(yref,t);
yref_dotdot = diff(yref_dot,t);

Fy = [subs( yref, t, 0) == 0;
    subs( yref_dot, t, 0) == 0;
    subs( yref_dot, t, Ty) == 0;
    subs( yref_dotdot, t, 0) == 0;
    subs( yref_dotdot, t, Ty) == 0;
    subs( yref, t, Ty) == yT];

solutions_y = solve(Fy);

y0num = double( solutions_y.y0 );
y1num =  double( solutions_y.y1 ); 
y2num =  double( solutions_y.y2 );
y3num =  double( solutions_y.y3 );
y4num =  double( solutions_y.y4 );
y5num =  double( solutions_y.y5 );

%% Trajectory in z-direction 

syms t z0 z1 z2 z3 z4 z5
zref = z5 * t^5 + z4 * t^4 + z3 * t^3 + z2 * t^2 + z1 * t + z0;
zref_dot = diff(zref,t);
zref_dotdot = diff(zref_dot,t);

Fz = [subs( zref, t, 0) == l_t;
    subs( zref_dot, t, 0) == 0;
    subs( zref_dot, t, Tz) == 0;
    subs( zref_dotdot, t, 0) == 0;
    subs( zref_dotdot, t, Tz) == 0;
    subs( zref, t, Tz) == zT];

solutions_z = solve(Fz);

z0num = double( solutions_z.z0 );
z1num =  double( solutions_z.z1 ); 
z2num =  double( solutions_z.z2 );
z3num =  double( solutions_z.z3 );
z4num =  double( solutions_z.z4 );
z5num =  double( solutions_z.z5 );
