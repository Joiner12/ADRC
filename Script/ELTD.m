%% H:\MatlabFiles\ADRC-GIT\Script\ELTD.m
%{
    函数说明:
    @funcname:ELTD(等效线性微分跟踪器)
    1.稳态点附近进行泰勒展开，将不同非线性函数进行等效分析；
    2.得出不同非线性函数的等效线性模型,通过不同参数设置决定具体微分跟踪器形式；
    3.扩展复合微分跟踪器，利用前馈补偿原理减少相位差；

    @param:R
    @param:k1
    @param:k2
    @param:u 输入跟踪信号
    @param:t 采样周期
    
    参数关系：
    s = tf('s');
    gs = @(R,k1,k2,s) (k1*R^2/(s^2 + k2*R*s + k1*R^2))

    [1] 武利强, 韩京清. TD滤波器及其应用[J]. 计算技术与自动化, 2003, 22(s1):61-63.
    [2]《跟踪微分器的等效线性分析及优化》
    [3]《前向、后向差分及显隐式欧拉方程》https://blog.csdn.net/wu_nan_nan/article/details/53173302
%}
function [sys,x0,str,ts] = ELTD(t,x,u,flag,k1,k2,R)

switch flag
    
    case 0
        [sys,x0,str,ts] = mdlInitializeSizes;
        
    case 2
        sys = mdlUpdate(t,x,u,k1,k2,R);
        
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
sizes.NumDiscStates  = 2;
sizes.NumOutputs     = 2;
sizes.NumInputs      = 1;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [0,0];
str = [];
ts  = [1e-3 0];
% end mdlInitializeSizes

% ==========================================================================
function sys = mdlUpdate(~,x,u,k1,k2,R)
T = 1e-3;
vt = u;
x(1) = x(1) + T*x(2);
%离散表达式: x2(k) = x2(k-1) + R^2*(-k1*(x1(k) - v(k)) -k2*x2(k)/R)*T;
err_1 = x(1) - vt; % x1(k) - v(k)
x(2) = x(2) + T*(-k1*err_1 - k2*x(2)/R)*R^2;
sys = [x(1),x(2)];

% ==========================================================================
function sys = mdlOutputs(~,x,~)
sys = x;