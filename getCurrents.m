function [output] = getCurrents(d1, d2, urlEnd)

srvloc = 'https://chldata.erdc.dren.mil/thredds/dodsC/';
url = strcat(srvloc, urlEnd);

time = ncread(url, 'time');
mtime = time/(3600.0*24) + datenum(1970,1,1);

if isequal(class(d1),'datetime')
    dStart = datenum(d1);
    dEnd = datenum(d2);
end

sprintf('Data record starts %s and ends %s', datestr(min(mtime)), datestr(max(mtime)))
itime = find(dStart < mtime & dEnd > mtime);

output.tNum = mtime(itime);
output.dTime = datetime(mtime(itime), 'ConvertFrom', 'datenum');

output.d = ncread(url,'depth');
output.blankDist = ncread(url,'blankDist',min(itime),length(itime)); % [m] distance from gauge
output.cellSize = ncread(url,'cellSize',min(itime),length(itime)); % [m] bin size
output.maxCell = ncread(url,'maxCell',min(itime),length(itime));
output.avgTime = ncread(url,'aveTime',min(itime),length(itime));
output.meanPressure = ncread(url,'meanPressure',min(itime),length(itime)); % [dbar]
output.avgE = ncread(url,'aveE',min(itime),length(itime)); % [m/s]
output.avgN = ncread(url,'aveN',min(itime),length(itime)); % Vertically Averaged Northward Sea Water Current [m/s]
output.avgCurrSpeed = ncread(url,'currentSpeed',min(itime),length(itime)); % Vertically Averaged Current Speed [m/s]
output.avgCurrDir = ncread(url,'currentDirection',min(itime),length(itime)); % [deg]

output.currE = ncread(url,'currentEast', [1, min(itime)], [15, length(itime)]);
output.currN = ncread(url,'currentNorth', [1, min(itime)], [15, length(itime)]);
output.currUp = ncread(url, 'currentUp', [1, min(itime)], [15, length(itime)]);
output.meanAmp = ncread(url, 'meanAmplitude', [1, min(itime)], [15, length(itime)]);
return
