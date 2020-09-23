%% H:\MatlabFiles\ADRC-GIT\Script\LESO.m
%{
    ����˵��(second order state observer)��
    1.����״̬�۲�����ϵͳ��Ϊ����������,һ��״̬������״̬��ϵͳ���ٶȣ�
    2.�������Ź۲���
    3.�۲�����������1����2��
    4.�����򻯣����ù۲�������(rad/s)

    ��1 = 2*��0����2 = 1*��0^2,��0�ǹ۲�������
    @Funcname:���Ź۲���
    @param:beta1,�۲���ϵ��
    @param:beta2,�۲���ϵ��
    
    reference:
    [1] ����ADRC�������� https://blog.csdn.net/handsome_for_kill/article/details/88398467
    [2] �Ͷ���, Фά��. �����Կ��ſ������Ĳ�����[J]. �Զ����Ǳ�, 2007, 28(5).
    [3] H:\MatlabFiles\ADRC\Scripts\SystemModel_R1.m
    [4] Active disturbance rejection control:some recent experimental and industrial case studies
    [5] Linear inverted pendulum control based on improved ADRC
    [6] Analysis and Design of a Time-Varying Extended State Observer for a Class of
        Nonlinear Systems with Unknown Dynamics Using Spectral Lyapunov Function
    [7] �����Կ��ſ��Ʋ�������³���Եĸ��켣����
%}
function [sys,x0,str,ts] = LESO(t,x,u,flag,omega_o)

switch flag
    
    case 0
        [sys,x0,str,ts] = mdlInitializeSizes;
        
    case 2
        sys = mdlUpdate(t,x,u,omega_o);
        
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
% u(1) = y(k),u(2) = ctrl_u
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [0,0];
str = [];
ts  = [1e-3 0];
% end mdlInitializeSizes


% ==========================================================================
%{
    % ������������״̬�۲���
    ��������:x = [z1(k),z2(k)];
    ��������:u = [y(k),u(k)];
    �������:x = [z1(k+1),z2(k+1)];
    ������������ά
%}
function sys = mdlUpdate(~,x,u,omega_o)
T = 1e-3;
h = T;
e = u(2) - x(1);
% z = [z1(k),z2(k)];
z = zeros(1,2);
% set paramters
beta1 = 2*omega_o;
beta2 = omega_o*omega_o;
z(1) = x(1) + h*(x(2) + beta1*e + u(1));
z(2) = x(2) + h*beta2*e;

x(1) = z(1);
x(2) = z(2);

sys(1) = x(1);
sys(2) = x(2);

%============================================================================
function sys = mdlOutputs(~,x,~)
sys(1) = x(1);
sys(2) = x(2);