%% fal function explore
%{
    __date__:2020-5-15
%}
clc;
fprintf('fal funciton explore\n');
try
    close('fal-plot');
catch
end
x = -1:0.01:1;
y = zeros(0);
lineLable = cell(0);
cnt = 0;
figure('name','fal-plot')
for alpha = 0.0:0.5:2.5
    for i = 1:length(x)
        y(i) = fal(x(i), alpha, 0.2 );
    end
    plot(x,y,'LineWidth',alpha*0.2 + 0.5);
    lineLable{cnt+1} = strcat('alpha=',num2str(alpha));
    cnt = cnt + 1;
    hold on
end

plot(x,x)
legend(lineLable)
grid on

%% fal for virbration depress
clc;
fprintf('fal funciton explore\n');
try
    close('fal-plot');
catch
end
x = -1:0.01:1;
y_fal = zeros(0);
y_sqrt = zeros(0);
alpha = 2;
for i = 1:length(x)
        y_fal(i) = fal(x(i), alpha, 0.5);
        y_sqrt(i) = sqrt(x(i));
end
figure('name','fal-plot')
plot(x,y_fal,'LineWidth',alpha*0.2 + 0.5);
hold on 
plot(x,y_sqrt)
%% fal
function [ y ] = fal( x, alpha, delta )
if abs(x) < delta
    cof = delta^(-1 + alpha);
    y = x * cof;
else
    y = (abs(x)^alpha) * sign(x);
end
end
%{
if abs(e(i)) <= delta
    temp = e(i)/power(delta,1-alpha);
elseif abs(e(i)) > delta
    temp = power(abs(e(i)),alpha)*sign(e(i));
end
%}

