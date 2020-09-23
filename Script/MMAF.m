%% Medium Moving Average Filter(MAF)
%{
    5、中位值平均滤波法（又称防脉冲干扰平均滤波法）
    A、方法：
    相当于“中位值滤波法”+“算术平均滤波法”
    连续采样N个数据，去掉一个最大值和一个最小值
    然后计算N-2个数据的算术平均值
    N值的选取：3~14
    B、优点：
    融合了两种滤波法的优点
    对于偶然出现的脉冲性干扰，可消除由于脉冲干扰所引起的采样值偏差
    C、缺点：
    测量速度较慢，和算术平均滤波法一样
    比较浪费RAM
%}
clc;close all;
global ValueStored;
global Scope;

OptCnt = 0;
outValues = zeros(0);
inValues = zeros(0);
outValues_1 = zeros(0);
%{
    信号
%}
if false
    inValues = 10.*ones(1,101) + (rand(1,101)-0.5);
    inValuesTemp = inValues;
    inValuesTemp(abs(inValuesTemp-10)>0.4) = 20;
    %     plot(inValuesTemp)
    %     hold on
    %     plot(inValues)
end

while(true)
    OptCnt = OptCnt+1;
    
    if isequal(OptCnt,1)
        CapHeight = 0;
        MAF_INIT(10,CapHeight);
        inValue = 10;
    else
        inValue =  sin(0.005*(OptCnt-1)) ;
        if abs(inValue-1) < 0.0003/100
            inValue = 3;
        end
%         inValue = (1+rand)*inValue;
        inValues(OptCnt-1) = inValue;
        [val_1,val_2] = MediumMAF(inValue);
        outValues(OptCnt-1) = val_1;
        outValues_1(OptCnt-1) = val_2;
    end
    
    if OptCnt > 1000
        break;
    end
end
if true

    close all
    subplot(211)
    plot(inValues)
    hold on
    plot(outValues,'LineWidth',2)
    hold on 
    plot(outValues_1,'LineWidth',2,'LineStyle','-.')
    legend('in','scope-1','scope')
    subplot(212)
    plot(outValues - outValues_1)
end


function MAF_INIT(Scope_i,initValue)
global ValueStored;
global Scope;
Scope = Scope_i;
ValueStored = initValue.*ones(1,Scope_i);
end

function [val_out1,val_out2] = MediumMAF(val_in)
global ValueStored;
global Scope;

StackTemp = [ValueStored(2:end),val_in];
ValueStored = StackTemp;
indexMax = find(StackTemp==max(StackTemp),1);
aTemp = sum(StackTemp) - StackTemp(indexMax);
val_out1 = aTemp/(Scope-1);
val_out2 = sum(ValueStored)/Scope;
end
