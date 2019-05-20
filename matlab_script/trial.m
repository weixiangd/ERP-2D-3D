time_file = fopen('time_records6.txt','w');
fprintf(time_file, 'The start time is: %s\n',datestr(now,'mmmm dd, yyyy HH:MM:SS.FFF AM'));

trial_num = 100;
time_pause = 10.0;
n = 10;
l = 10;
order = randperm(n,l);

for i = 1:9
    new_order = randperm(n,l);
    while (order(end) == new_order(1))
        new_order = randperm(n,l);
    end
    order = [order,new_order];
end

S = {'fbox1','fbox2','fbox3','fbox4','fbox5','fsphere1','fsphere2','fsphere3','fsphere4','fsphere5'};

fun_selector = randperm(6,5);
for j = 1:(trial_num/5)
    new_fun = randperm(6,5);
    while (fun_selector(end) == new_fun(1))
        new_fun = randperm(6,5);
    end
    fun_selector = [fun_selector,new_fun];
end


for m = 1:trial_num
    idx = order(m);
    model = S(idx);
    
    switch fun_selector(m)
        case 1
            disp('perform half 3d to 2d');
            fun_Half3Dto2D(model,time_file,time_pause);
            
        case 2
            disp('perform anaglyph to 2d');
            fun_Anato2D(model,time_file,time_pause);
            
        case 3
            disp('perform 3d to 2d');
            fun_3Dto2D(model,time_file,time_pause);
            
        case 4
            disp('perform 2d to half 3d');
            fun_2DtoHalf3D(model,time_file,time_pause);
            
        case 5
            disp('perform 2d to anaglyph');
            fun_2DtoAna(model,time_file,time_pause);
            
        case 6
            disp('perform 2d to 3d');
            fun_2Dto3D(model,time_file,time_pause);
            
    end
    %pause(5.0);
end

fclose(time_file);
