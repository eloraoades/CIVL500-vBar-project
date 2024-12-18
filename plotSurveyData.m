filepath = cd; 
q = genpath(filePath); addpath(q); 

%% Load data & define grids 
% You can change htis fieldName to be any of the surveys (should all be in
% the same format)
fileName = "FRF_20191007_1174_DUNEX_NAVD88_LARC_CRAB_GPS_UTC_v20191023_grid_latlon.txt";

% Other sensor date names: 
%{ 
%   FRF_20190903_1168_FRF_NAVD88_LARC_GPS_UTC_v20190905_grid_latlon.txt
%   FRF_20190909_1169_FRF_NAVD88_LARC_GPS_UTC_v20190916_grid_latlon.txt
%   FRF_20190917_1170_FRF_NAVD88_CRAB_GPS_UTC_v20191029_grid_latlon.txt
%   FRF_20190923_1171_FRF_NAVD88_LARC_GPS_UTC_v20190927_grid_latlon.txt
%   FRF_20191007_1174_DUNEX_NAVD88_LARC_CRAB_GPS_UTC_v20191023_grid_latlon.txt
%   FRF_20191015_1175_DUNEX_NAVD88_LARC_GPS_UTC_v20191017_grid_latlon.txt
%   FRF_20191025_1176_DUNEX_NAVD88_LARC_GPS_UTC_v20191028_grid_latlon.txt
%}

% Extract the date portion (characters 5 to 12)
dateString = extractBetween(fileName, 5, 12);

% Convert to datetime format
surveyDatetime = datetime(dateString, 'InputFormat', 'yyyyMMdd');

% Extract data into the workspace
surveyData = readtable(fileName);

% Rename columns to desired variable names
surveyData.Properties.VariableNames = {'Longitude', 'Latitude', 'Z', 'X', 'Y'};

% Define the bounds of the incoming survey data
xMin = round(min(surveyData.X)); xMax = round(max(surveyData.X)); delX = 12; 
yMin = round(min(surveyData.Y)); yMax = round(max(surveyData.Y)); delY = 24; 

% Generate X-Y vectors with given table data
X = xMin:delX:xMax; 
Y = yMin:delY:yMax; 
[xq, yq] = meshgrid(X, Y); % grid it!

% Project depth data onto the regularly spaced grid we just created
zq = griddata(surveyData.X, surveyData.Y, surveyData.Z, xq, yq);

%% Now plot data :) 

% what y-location are we looking at for OCM? 
yOCM = 650;

figure();
pcolor(xq, yq, zq); shading interp; 
axis tight equal; 
xlabel('x (m)'); ylabel('y (m)');
title(sprintf('%s', surveyDatetime));
c = colorbar(); c.Label.String = 'h (m)';
set(gca, 'FontName', 'Times', 'FontSize', 18, 'box', 'on', 'Layer', 'top');
clim([-10 4]);
cmocean('topo', 'pivot', 0); 

% Add the pier 
hold on; 
pier = line([50 500], [515 515], 'LineWidth', 1.2, 'Color', 'k');

% and the sensors
awac45m = scatter(400, 940, 'square', 'filled', 'MarkerEdgeColor','k', 'MarkerFaceColor', [0.72,0.27,1.00], 'SizeData',50);

% ocm 
ocm1 = scatter(125, yOCM, 'o', 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceColor','w');
ocm2 = scatter(150, yOCM, 'o', 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceColor','w');
ocm3 = scatter(175, yOCM, 'o', 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceColor','w');
ocm4 = scatter(200, yOCM, 'o', 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceColor','w');
ocm5 = scatter(225, yOCM, 'o', 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceColor','w');

% Camera (argus) station
camPos = scatter(80, 565, 'pentagram', 'filled', 'MarkerEdgeColor','k', 'MarkerFaceColor','r', 'SizeData', 100);