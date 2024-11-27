function [longshore_current,crossshore_current] = rotateCurrentComponents(N_component, E_component, beach_angle_deg)
% Beach orientation angle is in degrees oriented West of North

% Calculate the rotated current components
longshore_current = N_component.* cosd(beach_angle_deg) + E_component.* sind(beach_angle_deg);
crossshore_current = -N_component.* sind(beach_angle_deg) + E_component.* cosd(beach_angle_deg);

end