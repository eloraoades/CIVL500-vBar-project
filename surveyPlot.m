filePath = cd; 
q = genpath(filePath); addpath(q);

%% Load data & define grids
% You can change this fieldName to be any of the surveys (should all be in
% the same format)
fileName = "FRF_20190903_1168_FRF_NAVD88_LARC_GPS_UTC_v20190905_grid_latlon.txt";

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
awac45m = scatter(400, 940, 'square', 'filled', 'MarkerEdgeColor','k', 'MarkerFaceColor', [1.00,1.00,0.00], 'SizeData',50);

% ocm 
ocm1 = scatter(125, yOCM, 'o', 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceColor','w');
ocm2 = scatter(150, yOCM, 'o', 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceColor','w');
ocm3 = scatter(175, yOCM, 'o', 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceColor','w');
ocm4 = scatter(200, yOCM, 'o', 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceColor','w');
ocm5 = scatter(225, yOCM, 'o', 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceColor','w');

% Camera (argus) station
camPos = scatter(80, 565, 'pentagram', 'filled', 'MarkerEdgeColor','k', 'MarkerFaceColor','r', 'SizeData', 100);