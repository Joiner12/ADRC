%% H:\MatlabFiles\ADRC-GIT\Script\ControlObj.m
%{
    系统模型(i)
    From input "u1" to output "y1":
        16.75 (+/- 0.2556) s - 0.2331 (+/- 1.816)
    --------------------------------------------------
    s^2 + 0.3274 (+/- 0.1804) s + 0.06028 (+/- 0.3627)
    
    控制对象输入 (-2^-15 ~ 2^15) digital
    控制对象输出 1P - 0.001mm
%}

clc;
T = 1e-3; % 系统采样周期
s = tf('s');
tf_ob = (16.75)/(s + 0.5);
if true
    sys = ss(tf_ob) % 传递函数
    [num,den] = tfdata(c2d(tf_ob,T*2,'zoh'),'v')    % 离散方式采用零阶保持器——zoh(zero order hold)
else
    % transfer function to space state
    [A,B,C,D] = tf2ss([0 0 16.7],[1 0.5 0]) % 状态空间表达式
end
