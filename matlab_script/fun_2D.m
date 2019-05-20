function [ output_args ] = fun_2D( model,time_file )
%UNTITLED9 Summary of this function goes here
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
data = struct('space','DO3D','x','1920','y','1080','w','1920','h','1080');
data.app = struct('url','http://gdo-appsdev.dsi.ic.ac.uk:9082');
modelname = strcat('http://gdo-appsdev.dsi.ic.ac.uk:8081/',model,'.jpg');
data.app.states = struct('load',struct('url',modelname));
response1 = webwrite(dsiURL,data,options);

%Perform request at GET URL.
first_url = 'http://gdo-appsdev.dsi.ic.ac.uk:8084/set?id=0&url=http://gdo-appsdev.dsi.ic.ac.uk:9082/control.html?oveSectionId=0';
first_options = weboptions('RequestMethod','auto','ContentType','auto');

%Read response.
try 
    first_data = webread(first_url,first_options);
catch 
    disp('No information found.');
end

pause(1.0);

data2 = delete_black();

pause(1.0);

end

