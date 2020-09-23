%% 噪声模型
classdef NoiseModel
    methods (Static)
        function Noise_M = Noise_MaxPersistant(dataLen,varargin)
            if dataLen <= 0
                dataLen = 100;
            end
            %{
                持续时间不定，最大异常跳变,根据Kalman 滤波器生成
                x(k+1) = Fk * x(k) + Wk; 预测模型
                y(k)   = Hk * x(k) + Vk; 观测模型
            %}
            N = dataLen;
            
            Hk = [2];               % 观测矩阵
            Y  = zeros(N,1);        % 初始化观测变量
            V  = 20*randn(N,1);     % 构造观测噪声 Gaussian white noise
            
            for k = 1:N
                % 观测方程
                Y(k) = Hk * 10 + V(k);
            end
           Y(Y<30) = 30;
            % constant big noise
            
            for ki = 1:1:length(Y)
                if mod(ki,40)==0
                    if ki > 10
                        Y(ki-int32(rand()*20):ki) = 500;
                    end
                end
            end
            Noise_M = Y;
        end
    end
end
