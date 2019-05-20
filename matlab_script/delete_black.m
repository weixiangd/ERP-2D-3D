function [ third_data ] = delete_black( dsiURL,options )
data2 = struct('space','DO3D','x','0','y','0','w','7680','h','2160');
data2.app = struct('url','http://gdo-appsdev.dsi.ic.ac.uk:9083');
data2.app.states = struct('load',struct('url','http://gdo-appsdev.dsi.ic.ac.uk:9083/data/background/index.html?background=00000000'));
response3 = webwrite(dsiURL,data2,options);
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%Perform request at GET URL.
% third_url = 'http://gdo-appsdev.dsi.ic.ac.uk:8084/set?id=3&url=http://gdo-appsdev.dsi.ic.ac.uk:9083/data/background/index.html?background=00000000';
% third_options = weboptions('RequestMethod','auto','ContentType','auto');
% 
% %Read response.
% try 
%     third_data = webread(third_url,third_options);
% catch 
%     disp('No information found.');
% end

third_data = '';

end

