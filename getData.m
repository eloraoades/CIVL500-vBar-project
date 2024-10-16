function [sensorDataStruct] = getData(timeStart, timeEnd, url)
    % Get file information to determine available variables
    fileInfo = ncinfo(url);
    variableNames = {fileInfo.Variables.Name};
    
    % Check if 'time' variable exists in the dataset
    if ismember('time', variableNames)
        % Read the time variable (assuming it's in epoch format)
        epoch_allTime = ncread(url, 'time'); % epoch is the format 
        % Convert 'epoch' to 'datetime' (Matlab's time representation)
        dateTime_allTime = datetime((epoch_allTime/(3600*24) + datenum(1970,1,1)), 'ConvertFrom', 'datenum');
    else
        error('Time variable not found in the dataset.');
    end
    
    % Print start and end of data record
    fprintf('Data record starts %s and ends %s\n', datestr(min(dateTime_allTime)), datestr(max(dateTime_allTime)));

    % Find the indices within the specified time range
    index_Time = find(timeStart <= dateTime_allTime & timeEnd >= dateTime_allTime);

    if isempty(index_Time)
        error('No data found in the specified time range.'); 
    end

    % Create the output structure and assign time data
    sensorDataStruct.dateTime = dateTime_allTime(index_Time); 

    % Check and read 'waveFrequency' if it exists
    if ismember('waveFrequency', variableNames)
        sensorDataStruct.waveFrequency = ncread(url, 'waveFrequency');
    else
        warning('waveFrequency variable not found in the dataset.');
    end
    
    % Check and read 'waveHs' (wave height) if it exists
    if ismember('waveHs', variableNames)
        sensorDataStruct.significantWaveHeight = ncread(url, 'waveHs', min(index_Time), length(index_Time));
    else
        warning('waveHs variable not found in the dataset.');
    end
    
    % Check and read 'waveTp' (peak period) if it exists
    if ismember('waveTp', variableNames)
        sensorDataStruct.peakPeriod = ncread(url, 'waveTp', min(index_Time), length(index_Time));
    else
        warning('waveTp variable not found in the dataset.');
    end
   
    % Check and read 'eta' (water level) if it exists
    if ismember('waterLevel', variableNames)
        sensorDataStruct.waterLevel = ncread(url, 'waterLevel', min(index_Time), length(index_Time)); 
    else
        warning('water level is not found in the dataset,'); 
    end 

    % Check and read 'wave peak direction at the peak frequency' (incoming wave direction) if it exists
    if ismember('wavePeakDirectionPeakFrequency', variableNames)
        sensorDataStruct.wavePeakDirection = ncread(url, 'wavePeakDirectionPeakFrequency', min(index_Time), length(index_Time)); 
    else
        warning('wavePeakDirectionPeakFrequency is not found in the dataset,'); 
    end 

    % Check and read 'waveEnergyDensity' (the 1D frequency-energy spectrum) if it exists
    if ismember('waveEnergyDensity', variableNames)
        sensorDataStruct.waveEnergyDensity = permute(ncread(url, 'waveEnergyDensity',[1,min(index_Time)],[inf,length(index_Time)]),[2, 1]); % arraging with hours in first value
    else
        warning('waveEnergyDensity variable not found in the dataset.');
    end
end
