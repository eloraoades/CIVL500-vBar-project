function [output] = getCurrents(d1, d2, url)

time = ncread(url, 'time');
mtime = time/(3600.0*24) + datenum(1970,1,1);

if isequal(class(d1),'datetime')
    dStart = datenum(d1);
    dEnd = datenum(d2);
end

sprintf('Data record starts %s and ends %s', datestr(min(mtime)), datestr(max(mtime)))
itime = find(dStart < mtime & dEnd > mtime);

output.dateTime = datetime(mtime(itime), 'ConvertFrom', 'datenum');

output.depthBins = ncread(url,'depth');
output.blankingDistance = ncread(url,'blankDist',min(itime),length(itime)); % [m] distance between gauge & first depth bin
output.binSize = ncread(url,'cellSize',min(itime),length(itime)); % [m] bin size
output.maxCell = ncread(url,'maxCell',min(itime),length(itime)); % 
output.zAverageEast = ncread(url,'aveE',min(itime),length(itime)); % Vertically Averaged East Current [m/s]
output.zAverageNorth = ncread(url,'aveN',min(itime),length(itime)); % Vertically Averaged North Current [m/s]
output.zAvgCurrSpeed = ncread(url,'currentSpeed',min(itime),length(itime)); % Vertically Averaged Current Speed [m/s]
output.zAvgCurrDir = ncread(url,'currentDirection',min(itime),length(itime)); % [deg]

output.eastCurrBins = ncread(url,'currentEast', [1, min(itime)], [15, length(itime)]);
output.nortCurrBins = ncread(url,'currentNorth', [1, min(itime)], [15, length(itime)]);

return
