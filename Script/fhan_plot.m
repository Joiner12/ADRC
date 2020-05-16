%% fhan º¯Êý
%{
    explore fhan function
    __date__:2020-5-15
%}
clc;
fprintf('fhan function explore\n');
try
    close('fhan');
catch
    
end
c = 0.2;
h = 0.004;
r = 0.4;
[X,Y] = meshgrid(-1:0.05:1);
Z = zeros(0);
% Z = fhan( X, Y, 1, 0.1 );
for i = 1:length(X)
    for j = 1:length(Y)
        Z(i,j) = fhan( X(i,j), c*Y(i,j), r, 200*0.004);
    end
end
figure('name','fhan');
surf(X,Y,Z);
xlabel('x1');
ylabel('x2');
title('fhan function explore')

%% fhan function
function [ y ] = fhan( x1, x2, r, h )
d = r * h^2;
a0 = h * x2;
y = x1 + a0;
a1 = sqrt( d * (d + 8*abs(y)) );
a2 = a0 + sign(y)*(a1 - d)/2;
sy = (sign(y + d) - sign(y - d))/2;
a = (a0 + y - a2)*sy + a2;
sa = (sign(a + d) - sign(a - d))/2;
y = -r*(a/d - sign(a))*sa - r*sign(a);
end