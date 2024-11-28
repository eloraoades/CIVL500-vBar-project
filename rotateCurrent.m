
E4 = awac4_curr.zAverageEast;
N4 = awac4_curr.zAverageNorth; 
C4 = sqrt((E4.^2)+(N4.^2));

E11 = awac11_curr.zAverageEast;
N11 = awac11_curr.zAverageNorth; 
C11 = sqrt((E11.^2)+(N11.^2));

%E=uE+vE
%N=uN+vN

u4 = E4.*cosd(19) + (-N4.*sind(19));
v4 = E4.*sind(19) + N4.*cosd(19);
w4 = sqrt((u4.^2)+(v4.^2));

u11 = E11.*cosd(19) + (-N11.*sind(19));
v11 = E11.*sind(19) + N11.*cosd(19);
w11 = sqrt((u11.^2)+(v11.^2));

figure()
T2 = tiledlayout(2, 1); % << 2 rows, one column
T2.TileSpacing = 'compact'; 
T2.Padding = 'compact'; 

nexttile()
plot(awac4_curr.dateTime, u4, 'b'); 
hold on; box on; 
plot(awac4_curr.dateTime, v4, 'r'); 
hold on; box on;
plot(awac4_curr.dateTime, w4, 'k');
set(gca, 'FontName', 'cambria', 'FontSize', 16); 
yline(0); 
legend('Crossshore Current', 'Longshore Current','Total Current'); 
ylabel('u (m/s) @4m')
ylim([-1.25 1.25]);

nexttile()
plot(awac11_curr.dateTime, u11, 'b'); 
hold on; box on; 
plot(awac11_curr.dateTime, v11, 'r'); 
hold on; box on;
plot(awac4_curr.dateTime, w4, 'k');
set(gca, 'FontName', 'cambria', 'FontSize', 16); 
yline(0);
legend('Crossshore Current', 'Longshore Current', 'Total Current'); 
ylabel('u (m/s) @ 11m')
ylim([-1.25 1.25]); 


