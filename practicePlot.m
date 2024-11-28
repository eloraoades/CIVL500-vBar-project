% Specify the file path
filename = 'C:\\Users\\kattr\\OneDrive - Queen''s University\\Queen''s\\Thesis\\FRF_20190903_1168_FRF_NAVD88_LARC_GPS_UTC_v20210823.csv'; % Replace 'your_file.csv' with your actual file name

% Read the CSV file
data = readtable(filename);

% Extract latitude and longitude from the 4th and 5th columns
latitude = data{:, 4};
longitude = data{:, 5};

% Plot the coordinates
geoplot(latitude, longitude, 'ro');
title('Latitude and Longitude Plot');
xlabel('Longitude');
ylabel('Latitude');