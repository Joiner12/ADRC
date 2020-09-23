%% nonlinear functions 
classdef NLFunc
    %% virbration depress ver 2.0
    %{
        int32
    %}
    methods (Static)
        function CptErr = NonlinearVer2(err,DepDeg,TarHeight)
            BoundaryH = abs(TarHeight)*2;
            DepRatio = DepDeg*5;
            if (abs(err) > BoundaryH)
                CptErr = err;
            else
                DepCof = 1 + (DepRatio*(BoundaryH - abs(err))/BoundaryH);
                CptErr = (err/DepCof);
            end
        end
    end
    %% virbration depress ver 2.1
    %{
        int32
    %}
    methods (Static)
        function CptErr = NonlinearVer2_1(err,DepDeg,TarHeight)
            BoundaryH = abs(TarHeight)*2;
            DepRatio = DepDeg*5;
            if (abs(err) > BoundaryH)
                CptErr = err;
            else
                DepCof = 1 + int32(DepRatio*(BoundaryH - abs(err))/BoundaryH);
                CptErr = int32(err/DepCof);
            end
        end
    end
    
    %% virbration depress ver 3.0
    %{
        local linear & global nonlinear
        LCof:Linear Cof(0~0.5)
        k:ÒÖÕñÏµÊý(0:1:5)
    %} 
    methods(Static)
        function [y,cof] = NonlinearVer3(err,k,LCof,FollowTarget)
            LScope = LCof*FollowTarget; % linear scope
            if abs(err) <= LScope
                cof = 1;
            elseif LScope < abs(err) && abs(err) <= 1.5*FollowTarget
                by = FollowTarget*1.5 ;% boundary scope
                err_temp =  1 + k*(by - abs(err))/(by - LScope);
                cof = err_temp;
            else
                cof = 1;
            end
        %     fprintf('%0.2f\n',cof);
            y = err./cof; 
            cof = 1/cof;
        end
    end
    
    %% fal
    methods (Static)
        function [cof,xf] = fal(x,alpha,delta)
            if abs(x) < delta
                xf = x / delta^(1-alpha);
                cof = xf/x;
%                 cof = x/xf;
            else
                xf = (abs(x)^alpha) * sign(x);
                cof = xf/x;
%                 cof = x/xf;
            end
        end
    end
    
    % methods (Static)
    %     function fobj = methodName(k,h)
    %         func_cof = @(k,h,err)1+k*(2*h-err);
    %     end
    % end
    
    %% Nonlinear V3.1
    %{
        release version version
    %}
    methods(Static)
        function [outErr,nk] = NonlinearVer3_1(err,supressRatio,tarheight)
            if isequal(supressRatio,0)
                outErr = err;
                return;
            end
            nk = 1;
            nA = 200; % 0.001 mm
            nB = 1000;
            nH = tarheight;
            
            % tarheight - curheight = 0.5 - 1 = -0.5 < 0 
            if err < 0
                nk = 2*supressRatio;
            else
                % follow target height smaller than 200
                if nH <= nA
                    nk = 1;
                elseif nH < nB
                    % nk = calcRatio*supressRatio + (calcRatio*supressRatio*(nH - nA)/(nB-nA));
                    nk = supressRatio*(1+(nH-nA)/(nB-nA));
                else
                    nk = supressRatio;
                end
            end
            outErr = err/nk;
        end
    end
end