%% H:\MatlabFiles\ADRC-GIT\Script\fal_s.m
%{
     refer to fal.m
%}
function [sys,x0,str,ts] = fal_s(t,x,u,flag,alpha_,delta_)

switch flag
    
    case 0
        [sys,x0,str,ts] = mdlInitializeSizes;
        
    case 2
        sys = mdlUpdate(t,x,u,flag,alpha_,delta_);
        
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
    sizes.NumDiscStates  = 1;
    sizes.NumOutputs     = 1;
    sizes.NumInputs      = 1;
    %{
        直接馈通
        如果输出函数mdlOutputs
        或者对于变采样时间的mdlGetTimeOfNextVarHit是输入u的函数，
        则模块具有直接馈通的特性sizes.DirFeedthrough=1;否则为0。
    %}
    sizes.DirFeedthrough = 0;
    sizes.NumSampleTimes = 1;
    sys = simsizes(sizes);
    str = [];
    ts  = [1e-3 0];
    x0=0;
    % end mdlInitializeSizes

% ==========================================================================
function sys = mdlUpdate(~,~,u,~,alpha_,delta_)
    e = u;
    if abs(e) < delta_
        temp = e/power(delta_,1-alpha_);
    else
        temp = power(abs(e),alpha_)*sign(e);
    end
    x = temp;
    sys = x;
% ==========================================================================
function sys = mdlOutputs(~,x)
    sys = x;

% ==========================================================================
function sys = mdlTerminate(~,~,~)
    sys = [];
    fprintf("typeter is hard\n")
