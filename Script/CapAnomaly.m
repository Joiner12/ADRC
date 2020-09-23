classdef CapAnomaly
    %% 出边检测参数
    
    %% 踏空检测参数
    properties (SetAccess = private)
        nMissPanelToleranceP = 2; %mm 
    end
    %% 电容异常检测参数
    properties (SetAccess = private)
        capSaltusHasFollowed = false;
        hasFollowed = false;
        followed = false;
        preEncoder = 0;
        preErr = 0;
        capSaltusCnt = 0;
        capSaltus = false;
        bWarmMissPanel = false;
    end
    %% 检测出边
    %{
        
    %}
    methods (Static)
        
        function bRet = CheckForOutPanelEdge(obj,varargin)
            if followerr < -0.3
                ResetCheck();
                return;
            end
            bRet = false;
        end
    end
    
    %% 踏空检测
    %{
        
    %}
    methods (Static)
        function bRet = CheckForMissPanel(obj,encoder,caph,varargin)
            if ~obj.bHasFollowed && ~obj.bWarmMissPanel
                bRet = false;
                obj.preEncoder = encoder;
                return;
            end
            if caph == max_caph
                obj.encoder = encoder;
            end
            if encoder - obj.encoder > nMissPanelToleranceP
                bRet = true;
            end
        end
    end
    
    %% 电容突变
    %{
    %}
    methods(Static)
        function bRet = CheckCapSaltus(obj,varargin)
            if ~obj.capSaltusHasFollowed
                obj.capSaltusCnt = 0;
                if ~obj.followed
                    return;
                else
                    obj.capSaltusHasFollowed = true;
                end
            end
            if err < -0.6 %mm
                obj.capSaltusCnt = obj.capSaltusCnt + 1;
            else
                obj.capSaltusCnt = obj.capSaltusCnt - 1;
            end
            if obj.capSaltusCnt < 0
                obj.capSaltusCnt = 0;
            end
            if obj.capSaltusCnt > 8 % 持续时间
                obj.capSaltus = true;
            else
                obj.capSaltus = false;
            end
            bRet = false;
        end
    end
end

function ResetCheck()
    cprintf('reset check\n');
end