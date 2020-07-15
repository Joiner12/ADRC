clear;
clc;
%% DATA
m1 = 300;
m2 = 60;
k1 = 16000;
k2 = 190000;
b1 = 1000;
%% Linearization into state space model
A = [0 1 0 0;-k1/m1 -b1/m1 k1/m1 b1/m1;0 0 0 1;k1/m2 b1/m2 (-k2-k1)/m2 -b1/m2];
B = [0;1/m1;0; -1/m2 ];
C = [1 0 0 0];
D = [0];
linsys_ss = ss(A,B,C,D);
eig(A) % to check for stability of A matrix
%% Continuous state space to discrete system
T = .1;
dissys = c2d(linsys_ss,T);
Ad = dissys.A;
Bd = dissys.B;
Cd = dissys.C;
Dd = dissys.D;
%% checking controllability and observability
Co = ctrb(A,B);
unco = length(A)-rank(Co);

if unco == 0
    disp('the system is controllable')
else
    disp('the system is not controllable')
end

Ob = obsv(A,C);
unob = length(A)-rank(Ob);

if unob == 0
    disp('the system is obsevable') 
else
    disp('the system is not observable')
end

%% Getting K through LQR method by solving Ricatti equation
Q = [250 0 0 0;0 250 0 0;0 0 350 0;0 0 0 450]; %weight matrices Q and R
R = .01;
[k0 P e] = lqr(A,B,Q,R);
K = inv(R)*B'*P

%% simulation for road profile 1 
a=1;
for t=0.01:0.05:1
if t>=0.5 && t<=0.75
r(a)=0.05*(1-cos(8*pi*t));
else
r(a)=0;
end
a=a+1;
end
 r = r';
ts1 = timeseries(r,1:20)

%% simulation for road profile 2
a1 = 1;
for t1 = 0.01:0.04:8
    if ((t1>=0.5) && (t1<=0.75)) || ((t1>=5) && (t1<=5.25))
        r1(a1) = (0.05*(1-cos(8*pi*t1)));
    elseif (t1>=3) && (t1<=3.25)
        r1(a1)= (0.025*(1-cos(8*pi*t1)));
      else
        r1(a1) = 0;  
    end
    a1 = a1+1;
end
r1 = r1';
ts2 = timeseries(r1,1:200)