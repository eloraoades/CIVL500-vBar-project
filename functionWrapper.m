

%% Part 1: Define Your Input Variables 
% this is also where you would define your search paths

timeStart = datetime(2019, 08, 1, 0,0, 0);
timeEnd = datetime(2019, 10, 17, 0, 0, 0);

NCMLurl_awac6mWaves = 'https://chldata.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/awac-6m/awac-6m.ncml';
NCMLurl_awac11mWaves = 'https://chldata.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/awac-11m/awac-11m.ncml';
NCMLurl_awac4mCurr = 'https://chldata.erdc.dren.mil/thredds/dodsC/frf/oceanography/currents/awac-4.5m/awac-4.5m.ncml';

% ^^ Remember that this url is just the NCML one within the OPeNDAP form
% (in the 'Data URL' box). 
% The associated website that you can see is the html: 
% "https://chldata.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/awac-6m/awac-6m.ncml.html"

%% Part 2: Call your function to load wave data 

% You can call the output whatever you want & run it for more than one
% url :) 
[awac6m_waves] = getData(timeStart, timeEnd, NCMLurl_awac6mWaves); 
[awac11m_waves] = getData(timeStart, timeEnd, NCMLurl_awac11mWaves); 

%% Part 3: Call your function to load current data

[awac4_curr] = getCurrents(timeStart, timeEnd, NCMLurl_awac4mCurr);

%% Part 3: Plot Bulk Wave Data 

figure()
T1 = tiledlayout(4, 1); % << 3 rows, one column

nexttile()
plot(awac6m_waves.dateTime, awac6m_waves.waterLevel); 
hold on; 
% ADD THE 11 m AWAC DATA HERE
ylabel('\eta (m)'); 
xlim([timeStart timeEnd]); ylim([-2 2]);  

nexttile()
plot(awac6m_waves.dateTime, awac6m_waves.significantWaveHeight); hold on; 
% and here 
xtickformat('MMM dd'); 
ylabel('H_s (m)'); 
xlim([timeStart timeEnd]); ylim([0 5]);

nexttile()
plot(awac6m_waves.dateTime, awac6m_waves.peakPeriod); hold on; 
% etc. 
xtickformat('MMM dd'); 
ylabel('T_p (s)'); 
xlim([timeStart timeEnd]); ylim([0 18]); 

nexttile()
plot(awac6m_waves.dateTime, awac6m_waves.wavePeakDirection); 
xtickformat('MMM dd'); 
ylabel('\Theta_p (^o)'); 
xlim([timeStart timeEnd]); ylim([0 180]); 

%% 

figure()
T2 = tiledlayout(2, 1); % << 3 rows, one column
T2.TileSpacing = 'compact'; 
T2.Padding = 'compact'; 

nexttile()
plot(awac4_curr.dateTime, awac4_curr.zAvgEast, 'b'); 
hold on; box on; 
plot(awac4_curr.dateTime, awac4_curr.zAvgNorth, 'r'); 
set(gca, 'FontName', 'cambria', 'FontSize', 16); 
legend('East Current', 'North Current', ''); 
ylabel('u (m/s)')
ylim([-1.25 1.25]); 
yline(0); 

nexttile()
plot(awac4_curr.dateTime, awac4_curr.zAvgCurrDir); 
set(gca, 'FontName', 'cambria', 'FontSize', 16);
xlabel('Time [2019]'); ylabel('u_dir (^o)')