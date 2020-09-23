%% shift denoise
%{
    parameter:
    preIn_V:Ctrl(t) mm/ms
    curErr:Error(t) mm
    preErr:Error(t-T) mm

    errDe:error after shift denoise
%}
function errDe = ShiftDenoise(preIn_V,curErr,preErr)
    UnitGain = 100;
    ErrLimit = 2*UnitGain; %% 跟随偏差(mm)
    DeltaErrLimit = 0.12*UnitGain; % 跟随偏差变化率(mm/ms)
    % 线性状态转移 Error(t+T) = Error(t) + preIn_V(△Encoder(t))
    % error(t) < -ErrLimit
    if curErr < ErrLimit*(-1)
        errDe = preErr + preIn_V;
    elseif curErr < 0
        errDe = curErr + sign(curErr - preErr)*DeltaErrLimit;
    else
        errDe = curErr;
    end
end