%% H:\MatlabFiles\ADRC-GIT\Script\fal.m
%--------------fal函数-----------------%
%{
    1.fal滤波器原理
    大误差，小增益，小误差，大增益，有利于输出小变换性;
    sat(x,δ)
    fal(x,alpha,δ)
    0 < alpha < 1 ，alpha决定非线性度，效果类似于振动抑制；
    δ 决定线性段区间长度
    
    2.兼容内外部数据循环计算

    3. fal滤波器
   
    (1)reference：
    (2)Fal滤波器性能探究;
    (3)调用H:\MatlabFiles\ADRC\Fal_Func函数: y = Fal_Func(e,alpha,delta)
    (4)结论:
        alpha，delta，kFal,参数对于不同的频率设计而言，不同;

    reference:
    [1]http://kzyjc.alljournals.cn/ch/reader/create_pdf.aspx?file_no=20181023&year_id=2018&quarter_id=10&falg=1
    [2]《基于fal函数滤波的改进自抗扰技术的实现》.吕永佳

%}
function y = fal(e,alpha,delta)
% 检查参数
if (alpha <= 0 || alpha >= 1)
    error('fal function parameter@:alpha error');
end

if delta <= 0
    error('fal function parameter@:delta error');
end

% 兼容内外循环
switch length(e)
    case 0
        error('fal函数无处理数据输入');
    case 1
        if abs(e) < delta
            temp = e/power(delta,1-alpha);
        else
            temp = power(abs(e),alpha)*sign(e);
        end
        y = temp;
        
    otherwise
        % 处理数组数据
        e_length = length(e);
        final = zeros(0);
        %     disp('"fal" function called')
        % 输入需要单独进行比较，因此采用for循环
        for i=1:1:e_length
            if abs(e(i)) <= delta
                temp = e(i)/power(delta,1-alpha);
            elseif abs(e(i)) > delta
                temp = power(abs(e(i)),alpha)*sign(e(i));
            end
            final(i) = temp;
        end
        y = final;
end
end