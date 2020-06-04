%% H:\MatlabFiles\ADRC-GIT\Script\fal.m
%--------------fal����-----------------%
%{
    1.fal�˲���ԭ��
    ����С���棬С�������棬���������С�任��;
    sat(x,��)
    fal(x,alpha,��)
    0 < alpha < 1 ��alpha���������Զȣ�Ч�������������ƣ�
    �� �������Զ����䳤��
    
    2.�������ⲿ����ѭ������

    3. fal�˲���
   
    (1)reference��
    (2)Fal�˲�������̽��;
    (3)����H:\MatlabFiles\ADRC\Fal_Func����: y = Fal_Func(e,alpha,delta)
    (4)����:
        alpha��delta��kFal,�������ڲ�ͬ��Ƶ����ƶ��ԣ���ͬ;

    reference:
    [1]http://kzyjc.alljournals.cn/ch/reader/create_pdf.aspx?file_no=20181023&year_id=2018&quarter_id=10&falg=1
    [2]������fal�����˲��ĸĽ��Կ��ż�����ʵ�֡�.������

%}
function y = fal(e,alpha,delta)
% ������
if (alpha <= 0 || alpha >= 1)
    error('fal function parameter@:alpha error');
end

if delta <= 0
    error('fal function parameter@:delta error');
end

% ��������ѭ��
switch length(e)
    case 0
        error('fal�����޴�����������');
    case 1
        if abs(e) < delta
            temp = e/power(delta,1-alpha);
        else
            temp = power(abs(e),alpha)*sign(e);
        end
        y = temp;
        
    otherwise
        % ������������
        e_length = length(e);
        final = zeros(0);
        %     disp('"fal" function called')
        % ������Ҫ�������бȽϣ���˲���forѭ��
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