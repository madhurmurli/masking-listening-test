classdef Subject < handle
    %SUBJECT - A container to hold data pertaining to a subject.
    %
    %   This class contains the basic information of the subject as well as
    %   the subject's results. The results are stored in the entries of the
    %   TestConditions cell array.
    %
    %   See also TestCondition
    
    % Evan Shenkman
   
    properties (SetAccess = private)
        Name;                       % Name of the subject
        ID;                         % An arbitrary ID for the subject
        
        % Whatever other information we want....
        
        TestConditions;             % Cell array of TestCondition objects
    end
    
    methods (Static)
        function obj = Subject(name, id, tc)
            obj.Name = name;
            obj.ID = id;
            
            obj.TestConditions = tc;
        end
        
    end
    
end

