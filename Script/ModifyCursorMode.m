function output_txt = ModifyCursorMode(~,event_obj)
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).

pos = get(event_obj,'Position');
output_txt = {['X: ',num2str(pos(1),'%.2f')], ...
% 此处的pos(1)后的数字，即X轴的数据游标的显示精度位数
['Y: ',num2str(pos(2),'%.2f')]};
% 此处的pos(2)后的数字，即Y轴的数据游标的显示精度位数

% If there is a Z-coordinate in the position, display it as well
if length(pos) > 2
    output_txt{end+1} = ['Z: ',num2str(pos(3),'%.2f')];
% 此处的pos(3)后的数字，即Z轴的数据游标的显示精度位数
end