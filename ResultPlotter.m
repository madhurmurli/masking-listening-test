clear all; close all;
out=textread('testresults.csv', '%s', 'whitespace',',');
audio_files=dir('alarms/*.wav');
total_alarms=size(audio_files,1);
file_list=strings(total_alarms);
total_iterations=size(out,1)/5;

for j=1:total_alarms
    file_name= audio_files(j,1).name;
    figure();
    x=zeros(3,4);
    y=zeros(3,4);  
    counter1=1;
    counter2=1;
    counter3=1;
    for i=1:total_iterations-1
        mlevel=str2double(out{i*5+4});
        threshold=str2double(out{i*5+5});
        alarm=out{i*5+3};
        user_id=str2num(out{i*5+2});
        
        if(strcmp(alarm,file_name))
            if(user_id==1)
                x(user_id,counter1)=mlevel;
                y(user_id,counter1)=threshold;
                counter1=counter1+1;
            elseif(user_id==2)
                x(user_id,counter2)=mlevel;
                y(user_id,counter2)=threshold;
                counter2=counter2+1;
            elseif(user_id==3)
                x(user_id,counter3)=mlevel;
                y(user_id,counter3)=mlevel;
                counter3=counter3+1;
            end
            
            
        end
        
    end
    y=y-x;
    plot(x(1,1:4),y(1,1:4),'xb');
    hold on;
    plot(x(2,1:4),y(2,1:4),'og');
    hold on;
    plot(x(3,1:4),y(3,1:4),'.r');
    legend('Madhur','Evan','Sanket');
    axis([min(min(x))-5 max(max(x))+5 -20 20]);
     xlabel('Mask Level (dB SPL)');
    ylabel('Deviation (dB)');
    title(file_name);
    
    
end



