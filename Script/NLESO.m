%% H:\MatlabFiles\ADRC-GIT\Script\NLESO.m
%{
    ADRC-ESO;
    二阶段系统(second-order)扩张状态观测器(三阶观测器);
    @ parameters:[alpha01,alpha02,beta01,beta02,beta03,b0]
    alpha:fal函数非线性度参数
    beta:eso各阶估计器系数
    b0:等效增益
%}
function [sys,x0,str,ts] = NLESO(t,x,u,flag,alpha_,delta_,beta01,beta02,beta03,b0)

switch flag
    
    case 0
        [sys,x0,str,ts] = mdlInitializeSizes;
        
    case 2
        sys = mdlUpdate(t,x,u,flag,alpha_,delta_,beta01,beta02,beta03,b0);
        
    case 3
        sys = mdlOutputs(t,x);
        
    case {1,4,}
        sys = [];
        
    case 9
        sys = mdlTerminate(t,x,u);
        
    otherwise
        DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
        
end

% ==========================================================================

function [sys,x0,str,ts] = mdlInitializeSizes
    sizes = simsizes;
    sizes.NumContStates  = 0;
    sizes.NumDiscStates  = 3;
    sizes.NumOutputs     = 3;
    sizes.NumInputs      = 2;
    %{
        直接馈通
        如果输出函数mdlOutputs
        或者对于变采样时间的mdlGetTimeOfNextVarHit是输入u的函数，
        则模块具有直接馈通的特性sizes.DirFeedthrough=1;否则为0。
    %}
    sizes.DirFeedthrough = 0;
    sizes.NumSampleTimes = 1;
    sys = simsizes(sizes);
    x0  = [0,0,0];
    u = [0,0];% u=[input,output]
    str = [];
    ts  = [1e-3 0];
    % end mdlInitializeSizes

% ==========================================================================
% 三阶扩张状态观测器
% ==========================================================================
function sys = mdlUpdate(~,~,u,~,alpha_,delta_,beta01,beta02,beta03,b0)
    h = 1e-3; % 步长
    x = zeros(1,3);
    % e(k) = y(k) - x_1(k)
    ek = u(2) - x(1);
    %{
        x_1(k) = x_1(k-1) + T*beta01*fal(e,alpha1,delta1)
        alpha1,delta1需要单独调试
    %}
    x_1 = x(1) + h*fal(ek,alpha_,delta_)*beta01;
    %{
        x_2(k) = x_2(k-1) + T*beta01*fal(e,alpha2,delta2) + b0*u;
    %}
    x_2 = x(2) + h*fal(ek,alpha_,delta_)*beta02 + b0*u(1);
    %{
        x_3(k) = x_3(k-1) + T*beta01*fal(e,alpha3,delta3);
    %}
    x_3 = x(3) + h*fal(ek,alpha_,delta_)*beta03;
    x(1) = x_1;
    x(2) = x_2;
    x(3) = x_3;
    sys = x;
% ==========================================================================
function sys = mdlOutputs(~,x)
    sys = x;

% ==========================================================================
function sys = mdlTerminate(~,~,~)
    sys = [];
