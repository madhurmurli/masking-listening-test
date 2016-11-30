clear all; close all;
out=textread('testresults.csv', '%s', 'whitespace',',');
audio_files=dir('alarms/*.wav');
total_alarms=size(audio_files,1);
file_list=strings(total_alarms);
total_iterations=size(out,1)/5;
data_table=cell2table(cell(0,5),'VariableNames',{'UserId','FileName','MaskerLevel','Threshold','Difference'});
anova_table=cell2table(cell(0,3),'VariableNames',{'FileName','meas1','meas2'});
anova2_table=cell2table(cell(0,2),'VariableNames',{'FileName','TML'});
tablecounter=0;
for j=1:total_alarms
    file_name= audio_files(j,1).name;
    file_string=string(file_name);
   % figure();
    x=zeros(3,4);
    y=zeros(3,4);  
    counter1=1;
    counter2=1;
    counter3=1;
    for i=1:total_iterations
        cur_ind=i-1;
        mlevel=str2double(out{cur_ind*5+4});
        threshold=str2double(out{cur_ind*5+5});
        alarm=out{cur_ind*5+3};
        user_id=str2num(out{cur_ind*5+2});
        tml=threshold/mlevel;
    
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
            
            temp=table(user_id,file_string,mlevel,threshold,mlevel-threshold);
            temp.Properties.VariableNames={'UserId','FileName','MaskerLevel','Threshold','Difference'};
             temp2=table(file_string,mlevel,mlevel-threshold);
            temp2.Properties.VariableNames={'FileName','meas1','meas2'};
            temp3=table(file_string,tml);
            temp3.Properties.VariableNames={'FileName','TML'};
            data_table=[data_table ;temp];
            anova_table=[anova_table; temp2];
            anova2_table=[anova2_table;temp3];
            
        end
        
    end
    y=y-x;
  %  plot(x(1,1:4),y(1,1:4),'xb');
   % hold on;
   % plot(x(2,1:4),y(2,1:4),'og');
   % hold on;
  %  plot(x(3,1:4),y(3,1:4),'.r');
  % legend('Madhur','Evan','Sanket');
   % axis([min(min(x))-5 max(max(x))+5 min(min(y))-5 max(max(y))+5]);
   %  xlabel('Mask Level (dB SPL)');
   % ylabel('Deviation (dB)');
   % title(file_name);
        
end
%%
% %Anova stuff
% Meas=dataset([1 2]','VarNames',{'Measurements'});
% rm= fitrm(anova_table,'meas1-meas2~FileName','WithinDesign',Meas);
% ranovatbl = ranova(rm)
%%
%ANova2
s=table2array(anova2_table(:,2));
[p,tbl]=anova2(s,2);

