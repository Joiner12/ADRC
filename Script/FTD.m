%% H:\MatlabFiles\ADRC-GIT\Script\FTD.m
%{
    函数说明:
    @funcname:ELTD(等效线性微分跟踪器)
    1.稳态点附近进行泰勒展开，将不同非线性函数进行等效分析；
    2.得出不同非线性函数的等效线性模型,通过不同参数设置决定具体微分跟踪器形式；
    3.扩展复合微分跟踪器，利用前馈补偿原理减少相位差；

    @param:r,加速因子
    @param:h，步长
    @param:h0，滤波因子
    @param:u 输入跟踪信号
    @param:t 采样周期
    
    参数关系：
    s = tf('s');
    gs = @(R,k1,k2,s) (k1*R^2/(s^2 + k2*R*s + k1*R^2))

%}
function [sys,x0,str,ts] = FTD(t,x,u,flag,h,h0,r)

switch flag
    
    case 0
        [sys,x0,str,ts] = mdlInitializeSizes;
        
    case 2
        sys = mdlUpdate(t,x,u,h,h0,r);
        
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
    x0  = [0,0]; %[tracker,differential]
    str = [];
    ts  = [1e-3 0];
    % end mdlInitializeSizes

% ==========================================================================
function sys = mdlUpdate(~,x,u,h,h0,r)
    %{
        离散表达式：
        x1(k+1) = x1(k) + h*x2(k)
        x2(k+1) = x2(k) + h*fhan
    %}
    %------------------------%
    % fhan 函数计算
    d = r*h0^2;
    a0 = h0*x(2);
    y = (x(1)- u) + a0;
    a1 = sqrt(d*(d+8*abs(y)));
    a2 = a0 + sign(y)*(a1-d)/2;
    % fsg_yd = (sign(y+d)-sign(y-d))/2
    fsg_yd = (sign(y+d) - sign(y-d))/2;
    a = (a0+y)*fsg_yd + a2*(1-fsg_yd);
    % fsg_ad = (sign(a+d)-sign(a-d))/2
    fsg_ad = (sign(a+d) - sign(a-d))/2;
    if ~isequal(d,0)
        fhan = -1*r*(a/d)*fsg_ad - r*sign(a)*(1-fsg_ad);
    else
        fhan = 0;
        warning('zero divide in fhan function');
    end
    %------------------------%
    % 系统状态更新
    x(1) = x(1) + h*x(2);
    x(2) = x(2) + h*fhan;
    sys = [x(1),x(2)];

% ==========================================================================
function sys = mdlOutputs(~,x,~)
    sys = x;