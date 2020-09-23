%% 振动抑制函数
%{
    error(t) = TarH(t) - CapH(t);
    inner dimension is: 1e-3 mm
%}
function [ErrL_S,ErrL_nosmooth,Maf_new] = SuppressVibration_V2(SuppressRatio, ...
                                                capL,tarL,preErr_nosmooth,Maf,varargin)
%     ErrL = tarL - capL;
ErrL = capL ;
% 偏差限幅 1e-3 mm
if (ErrL < -5000)
    ErrL = -5000;
end

calcratio = 100;
if (ErrL < 0)
    nk = calcratio*2*SuppressRatio;
else
    nA = 200; % p = 1e-3mm  = L
    nB = 1000;
    % 跟随高度小于高度下限
    if (tarL < nA)
        nk = calcratio;
    elseif (tarL < nB)
        nk = calcratio*SuppressRatio + (calcratio*SuppressRatio*(tarL - nA)/(nB-nA));
    else
        nk = calcratio*SuppressRatio;
    end
end
Err_D = calcratio* ErrL/nk;

%% Limit δerror(t)
if length(varargin) == 0
    preIn_V = 0;
else
    preIn_V = varargin{1};
end
Err_D = ShiftDenoise(preIn_V,Err_D,preErr_nosmooth);
% DeltaErrBoundary = 480; % 0.12mm/ms
% if abs(Err_D - preErr_nosmooth) > DeltaErrBoundary
%     Err_D = preErr_nosmooth + sign(Err_D - preErr_nosmooth)*DeltaErrBoundary;
% end

%% slider
maftemp = Maf;
Maf = [maftemp(2:end),Err_D];
ErrL_S = sum(Maf)/length(Maf);
Maf_new = Maf;
ErrL_nosmooth = Err_D;
end