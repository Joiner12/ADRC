%% markov chains
clc;clear;
%'eeee, MMMM d, yyyy h:mm a'
fprintf('UTC+8:%s\n',datetime('now','TimeZone','local','format',' MM/d/yyyy h:mm'));
% markov chains model
tmp = [.90 .0750 .025;.15 .8 .05;.25 .25 .5];
xt = [0.3 0.3 0.4];
stateName = ["bull","bear","stagnant"];
mcStock = dtmc(tmp,'StateNames',stateName);
xtStore = cell(0);
for i=1:1:50
    xt = xt*tmp;
    xtStore{i} = xt;
end
xtStore = cell2mat(xtStore');
%% figure
try 
    close('mc-stock','markov-1');
catch
    
end
figure('name','mc-stock')
sp1 = subplot(2,2,1);
imagesc(tmp);
colormap(jet);
colorbar;
sp1.XLim = [1 3];
sp1.YLim = [1 3];
axis square

sp2 = subplot(2,2,2);
graphplot(mcStock,'ColorEdges',true,'ColorNodes',true)
% sp2.Box = 'off';
subplot(2,2,[3 4])
plot3(xtStore(:,1),xtStore(:,2),xtStore(:,3),'Marker','.')
grid on