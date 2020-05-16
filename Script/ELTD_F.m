%% H:\MatlabFiles\ADRC-GIT\Script\ELTD_F.m
%{
    函数说明:
    @funcname:ELTD_F(等效线性微分跟踪器+前馈补偿)
    1.稳态点附近进行泰勒展开，将不同非线性函数进行等效分析；
    2.得出不同非线性函数的等效线性模型,通过不同参数设置决定具体微分跟踪器形式；
    3.扩展复合微分跟踪器，利用前馈补偿原理减少相位差；


    @param:R
    @param:k1
    @param:k2
    @param:u [输入跟踪信号,前馈补偿量]
    @param:t 采样周期
    
    参数关系：
    s = tf('s');
    gs = @(R,k1,k2,s) (k1*R^2/(s^2 + k2*R*s + k1*R^2))
%}
function [sys,x0,str,ts] = ELTD_F(t,x,u,flag,k1,k2,R,ForCof)

switch flag
    
    case 0
        [sys,x0,str,ts] = mdlInitializeSizes;
        
    case 2
        sys = mdlUpdate(t,x,u,k1,k2,R,ForCof);
        
    case 3
        sys = mdlOutputs(t,x,u);
        
    case {1,4,9}
        sys = [];
        
    otherwise
        DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
        
end

% ==========================================================================

function [sys,x0,str,ts] = mdlInitializeSizes

sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 3;
sizes.NumOutputs     = 2;
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [0,0,0];
str = [];
u = [0,0];
ts  = [1e-3 0];
% end mdlInitializeSizes

% ==========================================================================
function sys = mdlUpdate(~,x,u,k1,k2,R,ForCof)
T = 5e-4;
vt = u(1);
v_f = u(2);

%{
    % 调试模式验证输入输出demux mux功能
    models = ["debug","forward","general"];

    model = models(1);
    switch model
        case "forward"

        case "general"

        case "debug"

    end
%}
% 带前馈补偿
alpha_f = ForCof;
x(1) = x(1) + T*x(2);
err_1 = x(1) - vt; % x1(k) - v(k)
% alpha_f:前馈系数
% x(2) = x(2) + T*(-k1*err_1 - k2*x(2)/R)*R^2 + R*v1;
x(2) = x(2) + T*(-k1*err_1 - k2*x(2)/R)*R^2  + alpha_f*(v_f - x(3));
x(3) = v_f;
sys = [x(1),x(2),x(3)];

% ==========================================================================
function sys = mdlOutputs(~,x,~)
sys = [x(1),x(2)];