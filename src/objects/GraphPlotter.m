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
            
            obj.FigureHandle = figure();
            movegui(obj.FigureHandle,'west');
        end
        
        function setFigureHandle(obj,figHandle)
            obj.FigureHandle=figHandle;
        end
        
        function PlotPoints(obj, responses)
            % Bring the Plot Figure to the foreground
            figure(obj.FigureHandle);
            
            ylabel('SPL (dB)');
            title(['Audibility Threshold ' obj.Name '-' obj.ID ]);
            
            % Resize the X-axis as responses come in
            varXaxis = length(responses);
            if varXaxis < 10
                varXaxis = 10;
            else
                varXaxis = 5 * floor(varXaxis/5) + 5;
            end
            
            for i = 1:size(responses, 2)
                if responses{i}.Detected
                     plot(i, responses{i}.Level, 'g+', 'MarkerSize', 18);
                     
                else
                     plot(i,responses{i}.Level,'r*', 'MarkerSize', 18);

                end
                
                hold on;
            end
            
            axis([0 varXaxis 30 100]);
        end
    end
    
end

