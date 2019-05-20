function [ data ] = black_screen( dsiURL,options )
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here
data2 = struct('space','DO3D','x','0','y','0','w','7680','h','2160');
data2.app = struct('url','http://gdo-appsdev.dsi.ic.ac.uk:9083');
data2.app.states = struct('load',struct('url','http://gdo-appsdev.dsi.ic.ac.uk:9083/data/background/index.html?background=000000ff'));
response3 = webwrite(dsiURL,data2,options);

%black_url = 'http://gdo-appsdev.dsi.ic.ac.uk:8084/set?id=3&url=http%3A%2F%2Fgdo-appsdev.dsi.ic.ac.uk%3A9083%2Fcontrol.html%3Furl%3Dhttp%253A%252F%252Fgdo-appsdev.dsi.ic.ac.uk%253A9083%252Fdata%252Fbackground%252Findex.html%253Fbackground%253D000000ff%26%26oveSectionId%3D3';
%black_options = weboptions('RequestMethod','auto','ContentType','auto');

%Read response.
%try 
%    data = webread(black_url,black_options);
% 
% catch 
%     disp('No information found.');
% end

data = '';

end

