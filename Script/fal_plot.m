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
for i = 1:length(x)
    y(i) = fal(x(i), 2, 0.1 );
end
plot(x,y);
hold on
plot(x,x)
grid on

%% fal
function [ y ] = fal( x, alpha, delta )
if abs(x) < delta
    y = x / delta^(1-alpha);
else
    y = (abs(x)^alpha) * sign(x);
end
end


