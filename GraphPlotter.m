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
        
        PlotPointsX;             % Cell array of Plot Points
        PlotPointsY;
        PlotPointsType;
    end
    
    methods
        function obj = GraphPlotter(name, id)
            obj.Name = name;
            obj.ID = id;
        end
        function SetFigureHandle(obj,figHandle)
            obj.FigureHandle=figHandle;
        end
        function AddPlot2(obj,x,y,type)
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
        function PlotPoints(obj,responses)
            figure(obj.FigureHandle);
            
            for i=1:size(responses,2)
                lev=responses{i}.Level;
                typ=responses{i}.Detected;
                if(typ==1)
                     plot(i,lev,'g+');
                end
                if(typ==0)
                     plot(i,lev,'r*');

                end
              hold on;
                ylabel('SPL (dB)');
                title(['Audibility Threshold ' obj.Name '-' obj.ID ]);
            end
              axis([0 10 30 100]);
        end
    end
    
end

