%% motor model for simulator
classdef MotorModel
    methods (Static)
        function [cmm,dmm] = AC_MotorV1(T)
            %% motor model transfer function(first order)
            %{
                @parameter:T,Sample Period(ms)
                @parameter:C_MM,continuous transfer function
                @parameter:D_MM,discrete transfer function
            %}
            k1 = 1000;
            tao = 1000*T*1E-3;
            cmm = tf(k1,[tao,1]);
            dmm = c2d(cmm,T*(1e-3),'zoh');
        end
    end
    methods (Static)
        function P_motor = AC_MotorV2(looptype)
            %% motor model transfer function(first order)
            %{
                (J)     moment of inertia of the rotor     3.2284E-6 kg.m^2
                (b)     motor viscous friction constant    3.5077E-6 N.m.s
                (Kb)    electromotive force constant       0.0274 V/rad/sec
                (Kt)    motor torque constant              0.0274 N.m/Amp
                (R)     electric resistance                4 Ohm
                (L)     electric inductance                2.75E-6H
            reference:
            [1]http://ctms.engin.umich.edu/CTMS/index.php?example=MotorPosition&section=SystemModeling
            %}
            J = 3.2284E-6;
            b = 3.5077E-6;
            K = 0.0274;
            R = 4;
            L = 2.75E-6;
            s = tf('s');
            % P_motor = K/(s*((J*s+b)*(L*s+R)+K^2));
            switch looptype
                
                case 'speed'
                    % speed loop
                    P_motor = s*K/(s*((J*s+b)*(L*s+R)+K^2))
                    % positon loop
                    
                case 'position'
                    P_motor = K/(s*((J*s+b)*(L*s+R)+K^2))
                    % default:speed loop
                    
                otherwise
                    P_motor = K/(s*((J*s+b)*(L*s+R)+K^2))
            end
        end
    end
end