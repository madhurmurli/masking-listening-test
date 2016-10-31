classdef CSVWriter < handle
    %CSVWrite- Container to store data into a CSV  .
    %
    %   This class has been created to write experimental data into a file
    %
    %
    %
    %
    
    % Madhur Murli
    
    properties (SetAccess = private)
        Name;                       % Name of the subject
        ID;                         % An ID for the subject
        FileName;
        MaskerLevel;
        IdentifiedThreshold;
        FileDestination;
    end
    
    methods
        function obj = CSVWriter(name,id)
            obj.Name = name;
            obj.ID = id;
        end
        
        function WriteToFile(obj,fname,mlevel,thresh)
            obj.FileName=fname;
            obj.MaskerLevel=mlevel;
            obj.IdentifiedThreshold=thresh;
            csvwrite('output.csv',[obj.Name obj.ID obj.MaskerLevel obj.IndentifiedThreshold]);
            
        end
    end
    
end

