classdef Response < handle
    %RESPONSE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Level;
        Detected;
    end
    
    methods (Static)
        function obj = Response(l, d)
            if ~isnumeric(l) || ~isscalar(l) || ~islogical(d)
                error('Incorrect parameters to create a Respose object.');
            end
            
            obj.Level = l;
            obj.Detected = d;
        end
    end
    
end

