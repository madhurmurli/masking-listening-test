function r = writeToCSV(name,id,filename,maskerlevel,threshold)
    %writeToCSV- writes passed parameters to CSV file
      fid=fopen('testresults.csv','at');
      fprintf(fid,'%s,%s,%s,%f,%f\n',name,id,filename,maskerlevel,threshold);
     fclose(fid);   
     r=1;
      
end