function output_txt = ModifyCursorMode(~,event_obj)
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).

pos = get(event_obj,'Position');
output_txt = {['X: ',num2str(pos(1),'%.2f')], ...
% �˴���pos(1)������֣���X��������α����ʾ����λ��
['Y: ',num2str(pos(2),'%.2f')]};
% �˴���pos(2)������֣���Y��������α����ʾ����λ��

% If there is a Z-coordinate in the position, display it as well
if length(pos) > 2
    output_txt{end+1} = ['Z: ',num2str(pos(3),'%.2f')];
% �˴���pos(3)������֣���Z��������α����ʾ����λ��
end