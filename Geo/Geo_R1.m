%% GEO
clc;close all;
load cycloneTracks
head(cycloneTracks)
figure
latMalakas = cycloneTracks.Latitude(cycloneTracks.ID == 1012);
lonMalakas = cycloneTracks.Longitude(cycloneTracks.ID == 1012);
geoplot(latMalakas,lonMalakas,'.-')
geolimits([0 60],[100 180])
hold on
latMegi = cycloneTracks.Latitude(cycloneTracks.ID == 1013);
lonMegi = cycloneTracks.Longitude(cycloneTracks.ID == 1013);
geoplot(latMegi,lonMegi,'.-')
latChaba = cycloneTracks.Latitude(cycloneTracks.ID == 1014);
lonChaba = cycloneTracks.Longitude(cycloneTracks.ID == 1014);
geoplot(latChaba,lonChaba,'.-')
figure
latAll = cycloneTracks.Latitude;
lonAll = cycloneTracks.Longitude;
geodensityplot(latAll,lonAll)