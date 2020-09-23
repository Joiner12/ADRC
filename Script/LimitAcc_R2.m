%% limit Jerk
clc;
a = 1.2;                % 10 m/s^2
a = a*10*1e3/1e6;       % mm/ms^2
vmax = 30;              % m/min
vmax = vmax*1e3/60/1e3; % mm/ms 
Jcof = 1e-1;            
J = a*Jcof;             % mm/s^3

t = linspace(0,1000,1000+1);    % ms
s = zeros(1,length(t));
t_Stage1 = t(t<a/J);
t_Stage2 = t(t >= a/J & t <= vmax/a-a/J);
tn = [t_Stage1,t_Stage2];
s1 = 1/6*J.*t_Stage1.^3;
s2 = 1/2*a.*(t_Stage2 - a/J).^2 + ...
    (a^2/2/J).*(t_Stage2 - a/J) + ...
    a^3/6/J^2;
sn = 1/2*a.*(tn).^2;
try
    close('s-model')
catch
end
figure('name','s-model')
subplot(211)
plot(tn,[s1,s2])
hold on 
plot(tn,sn)
xlabel('time(ms)')
ylabel('position(mm)')
grid on 
subplot(212)
errorbar(tn,[s1,s2],sn-[s1,s2])
xlabel('time(ms)')
ylabel('position(mm)')
grid on 
