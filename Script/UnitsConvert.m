%% µ¥Î»×ª»»
%{
    Velocity:
    mpers:m/s
    mpermin:m/min
    mmperms: mm/ms
    mmperm: mm/s
    g:9.8m/s^2

    Acceleration:
    mmperms2:mm/ms^2
    mpers2:m/s^2

    Jerk:
    mmperms3:mm/ms^3
    mpers3:m/s^3


%}
classdef UnitsConvert
    % gravity to mm/s^2
    methods (Static)
        function y = gTommperms2(x,g)
            if nargin < 2
                gcalculate = 9.8;
            else
                gcalculate = g;
            end
            convertMedia = 1000*gcalculate/1e6;
            y = convertMedia*x;
        end
    end
    
    % rpm ¡ú mm/ms
    methods (Static)
        function y = rpmTommperms(r,s_pitch)
            y = r*s_pitch; % mm/min
            y = y/60/1000; % mm/ms 
        end
    end
    
    % m/min ¡ú mm/ms
    methods (Static)
        function y = mperminTommperms(x)
            y = x*1e3;% mm/min
            y = y/60/1e3; % mm/ms
        end
    end
    
end