function [sensorDataStruct] = getDataALL(timeStart, timeEnd, url)
    % Get file information to determine available variables
    fileInfo = ncinfo(url);
    variableNames = {fileInfo.Variables.Name};
    
    % Initialize the output structure
    sensorDataStruct = struct();
    
    % Check if 'time' variable exists in the dataset
    if ismember('time', variableNames)
        % Read the time variable (assuming it's in epoch format)
        epoch_allTime = ncread(url, 'time'); 
        % Convert 'epoch' to 'datetime' (Matlab's time representation)
        dateTime_allTime = datetime((epoch_allTime/(3600*24) + datenum(1970,1,1)), 'ConvertFrom', 'datenum');
        
        % Find the indices within the specified time range
        index_Time = find(timeStart <= dateTime_allTime & timeEnd >= dateTime_allTime);

        if isempty(index_Time)
            error('No data found in the specified time range.');
        end
        
        % Store the time data in the output structure
        sensorDataStruct.dTime = dateTime_allTime(index_Time); 
    else
        error('Time variable not found in the dataset.');
    end

    % Loop through each variable and load data
    for i = 1:length(variableNames)
        varName = variableNames{i};
        
        % Skip the 'time' variable as it has already been handled
        if strcmp(varName, 'time')
            continue;
        end
        
        % Get the dimensions of the variable
        varInfo = ncread(url, varName);

        % If variable has the same time dimension, subset it based on time
        if size(varInfo, 1) == length(epoch_allTime) % Assuming time is the first dimension
            sensorDataStruct.(varName) = varInfo(index_Time);
        else
            % Otherwise, just load the entire variable
            sensorDataStruct.(varName) = varInfo;
        end
    end

    fprintf('Loaded %d variables from the dataset.\n', length(variableNames));
end
