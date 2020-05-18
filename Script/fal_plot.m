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
for alpha = 0:1:10
    for i = 1:length(x)
        y(i) = fal(x(i), alpha, 0.1 );
    end
    plot(x,y,'LineWidth',alpha*0.2 + 0.5);
    lineLable{alpha+1} = strcat('alpha=',num2str(alpha+1));
    hold on
end
plot(x,x)
legend(lineLable)
grid on

%% fal
function [ y ] = fal( x, alpha, delta )
if abs(x) < delta
    y = x / delta^(1-alpha);
else
    y = (abs(x)^alpha) * sign(x);
end
end


