%% H:\MatlabFiles\ADRC-GIT\Script\FTD.m
%{
    ����˵��:
    @funcname:ELTD(��Ч����΢�ָ�����)
    1.��̬�㸽������̩��չ��������ͬ�����Ժ������е�Ч������
    2.�ó���ͬ�����Ժ����ĵ�Ч����ģ��,ͨ����ͬ�������þ�������΢�ָ�������ʽ��
    3.��չ����΢�ָ�����������ǰ������ԭ�������λ�

    @param:r,��������
    @param:h������
    @param:h0���˲�����
    @param:u ��������ź�
    @param:t ��������
    
    ������ϵ��
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
        ��ɢ���ʽ��
        x1(k+1) = x1(k) + h*x2(k)
        x2(k+1) = x2(k) + h*fhan
    %}
    %------------------------%
    % fhan ��������
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
    % ϵͳ״̬����
    x(1) = x(1) + h*x(2);
    x(2) = x(2) + h*fhan;
    sys = [x(1),x(2)];

% ==========================================================================
function sys = mdlOutputs(~,x,~)
    sys = x;