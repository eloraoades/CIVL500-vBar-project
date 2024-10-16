

%% Part 1: Define Your Input Variables 
% this is also where you would define your search paths

timeStart = datetime(2017, 10, 1, 0,0, 0);
timeEnd = datetime(2017, 10, 31, 0, 0, 0);

NCMLurl_awac6m = 'https://chldata.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/awac-6m/awac-6m.ncml';

NCMLurl_awac11m = 'https://chldata.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/awac-11m/awac-11m.ncml';


% ^^ Remember that this url is just the NCML one within the OPeNDAP form
% (in the 'Data URL' box). 
% The associated website that you can see is the html: 
% "https://chldata.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/awac-6m/awac-6m.ncml.html"

%% Part 2: Call your Function 

% You can call the output whatever you want & run it for more than one
% url :) 
[awac6m_waves] = getData(timeStart, timeEnd, NCMLurl_awac6m); 

[awac11m_waves] = getData(timeStart, timeEnd, NCMLurl_awac11m); 

%% Part 3: Plot the Data ! 

figure()
T3 = tiledlayout(4, 1); % << 3 rows, one column

nexttile()
plot(awac6m_waves.dateTime, awac6m_waves.waterLevel); 
% ADD THE 11 m AWAC DATA HERE
hold on; 
ylabel('\eta (m)'); 
xlim([timeStart timeEnd]); ylim([-2 2]);  

nexttile()
plot(awac6m_waves.dateTime, awac6m_waves.significantWaveHeight); 
% and here 
ylabel('H_s (m)'); 
xlim([timeStart timeEnd]); ylim([0 4]);

nexttile()
plot(awac6m_waves.dateTime, awac6m_waves.peakPeriod); 
% etc. 
ylabel('T_p (s)'); 
xlim([timeStart timeEnd]); ylim([0 15]); 

nexttile()
plot(awac6m_waves.dateTime, awac6m_waves.wavePeakDirection); 
% :) 
ylabel('\Theta (^o)'); 
xlim([timeStart timeEnd]); ylim([0 180]); 



