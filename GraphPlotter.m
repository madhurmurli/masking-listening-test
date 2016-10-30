classdef GraphPlotter < handle
    %Graph Plotter - A container to plot data  .
    %
    %   This class has been created to plot a graph of the ongoing test
    %   
    %   
    %
    %   
    
    % Madhur Murli
   
    properties (SetAccess = private)
        Name;                       % Name of the subject
        ID;                         % An ID for the subject
        FigureHandle;               % Handle to the Figure on which to plot
        % Whatever other information we want....
        
        PlotPoints;             % Cell array of Plot Points
    end
    
    methods
        function obj = GraphPlotter(name, id)
            obj.Name = name;
            obj.ID = id;
        end
        function SetFigureHandle(figHandle)
            obj.FigureHandle=figHandle; 
        end
        function AddPlot(x,y,type)
            figure(obj.FigureHandle);
            if(type==1)
                plot(x,y,'b--o');
            end
            if(type==2)
                plot(x,y,'g+');
            end
            if(type==3)
                plot(x,y,'r*');
            end
        end
        
    end
    
end

