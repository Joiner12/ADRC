%% Controller Simulator
%{
    仿真验证现有控制器在电容跳变为最大值的情况下最大抑制周期;
%}
clc;
% load('VirdepData.mat');
OriginErrs = Line_M2(16666:16895);
OriginErrs = OriginErrs'; % 0.01mm
OriginErrs = 10.*OriginErrs; % 0.001 mm
CVirErrs =  Line_M5(16666:16895);
CVirErrs = 10.*CVirErrs;
MVirErrs = zeros(0);
PreErr = 0;
err_nosmooth = Line_M5(16666);
Maf_1 = Line_M5(16666-3:16666);
% main loop
for loopCnt = 1:1:length(OriginErrs)
    OErr = OriginErrs(loopCnt);
    if loopCnt == 1
        PreErr = CVirErrs(1);
        err_s = OErr;
    else
        % function [ErrL_S,ErrL_nosmooth,Maf_new] = SuppressVibration_V2(SuppressRatio, ...
        %   capL,tarL,preErr_nosmooth,Maf)
        [err_s,err_nosmooth,Maf_1] = SuppressVibration_V2(1,OErr,30,err_s,Maf_1);
        PreErr = err_nosmooth;
    end
    MVirErrs(loopCnt) = err_s;
end

tcf('er-1');figure('name','er-1');
plot(OriginErrs.*1e-3)
hold on
plot(MVirErrs.*(1e-3)-0.13)
hold on 
plot(CVirErrs.*1e-3)
hold on 
plot(-0.3*ones(1,length(CVirErrs)))

legend('ori','m','c','errline')