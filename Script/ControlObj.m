%% H:\MatlabFiles\ADRC-GIT\Script\ControlObj.m
%{
    ϵͳģ��(i)
    From input "u1" to output "y1":
        16.75 (+/- 0.2556) s - 0.2331 (+/- 1.816)
    --------------------------------------------------
    s^2 + 0.3274 (+/- 0.1804) s + 0.06028 (+/- 0.3627)
    
    ���ƶ������� (-2^-15 ~ 2^15) digital
    ���ƶ������ 1P - 0.001mm
%}

clc;
T = 1e-3; % ϵͳ��������
s = tf('s');
tf_ob = (16.75)/(s + 0.5);
if true
    sys = ss(tf_ob) % ���ݺ���
    [num,den] = tfdata(c2d(tf_ob,T*2,'zoh'),'v')    % ��ɢ��ʽ������ױ���������zoh(zero order hold)
else
    % transfer function to space state
    [A,B,C,D] = tf2ss([0 0 16.7],[1 0.5 0]) % ״̬�ռ���ʽ
end
