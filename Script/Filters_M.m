%% filters
classdef Filters_M
    methods (Static)
        function Kalman_example()
            % x(k+1) = Fk * x(k) + Wk; 预测模型
            % y(k)   = Hk * x(k) + Vk; 观测模型
            
            N = 365;
            
            Fk = [1];               % 状态转移矩阵
            X  = zeros(N,1);        % 初始化状态变量
            W  = 12*randn(N,1);     % 构造过程噪声 Gaussian white noise
            X(1) = 100;             % 初始状态
            
            for k = 2:N
                % 状态方程
                X(k) = Fk * X(k-1) + W(k-1);
            end
            
            Hk = [2];               % 观测矩阵
            Y  = zeros(N,1);        % 初始化观测变量
            V  = 20*randn(N,1);     % 构造观测噪声 Gaussian white noise
            
            for k = 1:N
                % 观测方程
                Y(k) = Hk * X(k) + V(k);
            end
            % constant big noise
            
            if true
                for ki = 1:1:length(Y)
                    if mod(ki,20)==0
                        if ki > 10
                            Y(ki-int32(rand()*10):ki) = 500;
                        end
                    end
                end
            end
            Q  = cov(W);            % 过程噪声协方差；
            R  = cov(V);            % 观测噪声协方差；
            
            Xupdate = zeros(N,1);
            Xupdate(1) = Y(1);      % 初始化第一个，也就是观测到的第一个
            Pupdate(1) = 0;
            for k = 2:N
                % 五大核心方程
                Xpredict(k) = Fk * Xupdate(k-1);
                Ppredict(k) = Fk * Pupdate(k-1) * Fk' + Q;
                K = Ppredict(k) * Hk * (Hk * Ppredict(k) * Hk' + R).^-1;
                Xupdate(k) = (1 - K * Hk) * Xpredict(k) + K * Y(k);
                Pupdate(k) = (1 - K * Hk) * Ppredict(k);
            end
            
            tcf('kalman filter example')
            figure('name','kalman filter example');
            plot(1:N,X,'B','linewidth',2);hold on;
            plot(1:N,Y,'K','linewidth',2);hold on;
            plot(1:N,Xupdate,'R','linewidth',2);hold on;
            plot(1:N,abs(Xupdate-X),'m','linewidth',2);hold off;
            legend('真值','观测值','滤波值','误差')
        end
    end
end