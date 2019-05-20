function [ output_args ] = fun_3D( model,time_file )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here

%POST instead of DELETE
fprintf(time_file, 'First delete: %s\n',datestr(now,'mmmm dd, yyyy HH:MM:SS.FFF AM'));
newURL = 'http://gdo-appsdev.dsi.ic.ac.uk:8083/sections';
options = weboptions('MediaType','application/json');
response0 = webwrite(newURL,{},options);
pause(0.5);

dsiURL = 'http://gdo-appsdev.dsi.ic.ac.uk:9080/section';

data0 = black_screen(dsiURL,options);

%1st HTTP POST
fprintf(time_file, 'First post: %s\n',datestr(now,'mmmm dd, yyyy HH:MM:SS.FFF AM'));
data1 = struct('space','DO3D-depth','x','1920','y','1080','w','1920','h','1080');
data1.app = struct('url','http://gdo-appsdev.dsi.ic.ac.uk:9082');
modelname1 = strcat('http://gdo-appsdev.dsi.ic.ac.uk:8081/',model,'-depth','.jpg');
config1 = struct('tileSources', struct('type', 'image', 'url', string(modelname1)));
viewport1 = struct('zoom', 1, 'dimensions', struct('w', '1920', 'h', '1080'), 'bounds', struct('x', 0, 'y', 0, 'w', 1, 'h', 0.5625));
data1.app.states = struct('load',struct('config', config1, 'viewport', viewport1));
response1 = webwrite(dsiURL,data1,options);
 
%HTTP POST
fprintf(time_file, 'Second post: %s\n',datestr(now,'mmmm dd, yyyy HH:MM:SS.FFF AM'));
data2 = struct('space','DO3D','x','1920','y','1080','w','1920','h','1080');
data2.app = struct('url','http://gdo-appsdev.dsi.ic.ac.uk:9082');
modelname = strcat('http://gdo-appsdev.dsi.ic.ac.uk:8081/',model,'.jpg');
config2 = struct('tileSources', struct('type', 'image', 'url', string(modelname)));
viewport2 = struct('zoom', 1, 'dimensions', struct('w', '1920', 'h', '1080'), 'bounds', struct('x', 0, 'y', 0, 'w', 1, 'h', 0.5625));
data2.app.states = struct('load',struct('config', config2, 'viewport', viewport2));
response2 = webwrite(dsiURL,data2,options);

%Perform request at GET URL.
first_url = 'http://gdo-appsdev.dsi.ic.ac.uk:8084/set?id=0&url=http://gdo-appsdev.dsi.ic.ac.uk:9082/control.html?oveSectionId=0';
first_options = weboptions('RequestMethod','auto','ContentType','auto');

%Perform request at GET URL.
second_url = 'http://gdo-appsdev.dsi.ic.ac.uk:8084/set?id=1&url=http://gdo-appsdev.dsi.ic.ac.uk:9082/control.html?oveSectionId=1';
second_options = weboptions('RequestMethod','auto','ContentType','auto');

%Read response.
try 
    first_data = webread(first_url,first_options);
    second_data = webread(second_url,second_options);
catch 
    disp('No information found.');
end

pause(1.0);

data1 = delete_black(strcat(dsiURL, 's/0'),options);

pause(1.0);

end

