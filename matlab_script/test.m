time_file = fopen('time_records7.txt','w');
fprintf(time_file, 'The start time is: %s\n',datestr(now,'mmmm dd, yyyy HH:MM:SS.FFF AM'));
time_pause=5.0;
S = {'fbox1','fbox2','fbox3','fbox4','fbox5','fsphere1','fsphere2','fsphere3','fsphere4','fsphere5'};
model = S(2);
for i = 1:5
    fun_3Dto2D_wx(model,time_file,time_pause);
end
fclose(time_file);
