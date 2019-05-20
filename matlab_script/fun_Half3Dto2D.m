function [ output_args ] = fun_Half3Dto2D( model,time_file,time_pause )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

%POST instead of DELETE
fprintf(time_file, 'First delete: %s\n',datestr(now,'mmmm dd, yyyy HH:MM:SS.FFF AM'));
newURL = 'http://gdo-appsdev.dsi.ic.ac.uk:8083/sections';
options = weboptions('MediaType','application/json');
response0 = webwrite(newURL,{},options);
pause(0.5);

dsiURL = 'http://gdo-appsdev.dsi.ic.ac.uk:9080/section';

data0 = black_screen(dsiURL,options);

%1st HTTP POST: 3D image
fprintf(time_file, 'First post: %s\n',datestr(now,'mmmm dd, yyyy HH:MM:SS.FFF AM'));
data1 = struct('space','DO3D-depth','x','1920','y','1080','w','1920','h','1080');
data1.app = struct('url','http://gdo-appsdev.dsi.ic.ac.uk:9082');
modelname1 = strcat('http://gdo-appsdev.dsi.ic.ac.uk:8081/',model,'-depth','.jpg');
config1 = struct('tileSources', struct('type', 'image', 'url', string(modelname1)));
viewport1 = struct('zoom', 1, 'dimensions', struct('w', '1920', 'h', '1080'), 'bounds', struct('x', 0, 'y', 0, 'w', 1, 'h', 0.5625));
data1.app.states = struct('load',struct('config', config1, 'viewport', viewport1));
response2 = webwrite(dsiURL,data1,options);

 
%2nd HTTP POST: 3D depth
fprintf(time_file, 'Second post: %s\n',datestr(now,'mmmm dd, yyyy HH:MM:SS.FFF AM'));
data2 = struct('space','DO3D','x','1920','y','1080','w','1920','h','1080');
data2.app = struct('url','http://gdo-appsdev.dsi.ic.ac.uk:9082');
modelname = strcat('http://gdo-appsdev.dsi.ic.ac.uk:8081/',model,'.jpg');
disp(modelname);
config2 = struct('tileSources', struct('type', 'image', 'url', string(modelname)));
viewport2 = struct('zoom', 1, 'dimensions', struct('w', '1920', 'h', '1080'), 'bounds', struct('x', 0, 'y', 0, 'w', 1, 'h', 0.5625));
data2.app.states = struct('load',struct('config', config2, 'viewport', viewport2));
response1 = webwrite(dsiURL,data2,options);


%3rd HTTP POST half 3D = add mask 8b8b8b8f ATM
fprintf(time_file, 'Third post (add half mask): %s\n',datestr(now,'mmmm dd, yyyy HH:MM:SS.FFF AM'));
data3 = struct('space','DO3D-depth','x','0','y','0','w','7680','h','2160');
data3.app = struct('url','http://gdo-appsdev.dsi.ic.ac.uk:9083');
data3.app.states = struct('load',struct('url','http://gdo-appsdev.dsi.ic.ac.uk:9083/data/background/index.html?background=8b8b8b8f'));
response3 = webwrite(dsiURL,data3,options);

%Perform request at GET URL.
first_url = 'http://gdo-appsdev.dsi.ic.ac.uk:8084/set?id=1&url=http://gdo-appsdev.dsi.ic.ac.uk:9082/control.html?oveSectionId=1';
first_options = weboptions('RequestMethod','auto','ContentType','auto');

%Perform request at GET URL.
second_url = 'http://gdo-appsdev.dsi.ic.ac.uk:8084/set?id=0&url=http://gdo-appsdev.dsi.ic.ac.uk:9082/control.html?oveSectionId=0';
second_options = weboptions('RequestMethod','auto','ContentType','auto');

%Perform request at GET URL.
third_url = 'http://gdo-appsdev.dsi.ic.ac.uk:8084/set?id=2&url=http://gdo-appsdev.dsi.ic.ac.uk:9083/data/background/index.html?background=8b8b8b8f';
third_options = weboptions('RequestMethod','auto','ContentType','auto');

%Read response.
try 
    first_data = webread(first_url,first_options);
    second_data = webread(second_url,second_options);
    third_data = webread(third_url,third_options);
catch 
    disp('No information found.');
end

pause(time_pause);

data4 = delete_black(strcat(dsiURL, 's/0'),options);

pause(time_pause);

data5 = black_screen(dsiURL,options);
 
%4rd HTTP POST = add opaque mask
fprintf(time_file, 'Fourth post (add opaque mask): %s\n',datestr(now,'mmmm dd, yyyy HH:MM:SS.FFF AM'));
data6 = struct('space','DO3D-depth','x','0','y','0','w','7680','h','2160');
data6.app = struct('url','http://gdo-appsdev.dsi.ic.ac.uk:9083');
data6.app.states = struct('load',struct('url','http://gdo-appsdev.dsi.ic.ac.uk:9083/data/background/index.html?background=8b8b8bff'));
response4 = webwrite(dsiURL,data6,options);

%Perform request at GET URL.
fourth_url = 'http://gdo-appsdev.dsi.ic.ac.uk:8084/set?id=2&url=http://gdo-appsdev.dsi.ic.ac.uk:9083/data/background/index.html?background=8b8b8bff';
fourth_options = weboptions('RequestMethod','auto','ContentType','auto');

%Read response.
try 
    fourth_data = webread(fourth_url,fourth_options);
catch 
    disp('No information found.');
end

pause(time_pause);

data7 = delete_black(strcat(dsiURL, 's/0'),options);

pause(time_pause);

end

