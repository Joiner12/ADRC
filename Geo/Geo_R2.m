%% Geo handle
clc;
webmap_R1()

%% gep plot 
function GeoExplore_R1()
    clc;
    fprintf('geo explore\n');
    try
        close('Geo-figure1');
    catch
    end
    f = figure('Name','Geo-figure1');
    g_axes = geoaxes(f,'basemap','bluegreen');
    geoplot(g_axes,[30.97691,30.99163],[104.70539,104.80753],'g-*')
    text(30.97691,104.70539,'fds')
end


%% web map
function webmap_R1()
try
    wmclose;
catch
end
fprintf('web map function start...\n');
    webmap('World Street Map')
    S = shaperead('tsunamis', 'UseGeoCoords', true);
    p = geopoint(S);
    attribspec = makeattribspec(p);
%     p=[30.97691,104.70539];
    wmmarker(p, 'Description', attribspec,... 
	           'OverlayName', 'Tsunami Events')
%     wmmarker(30.97691,104.70539)
end