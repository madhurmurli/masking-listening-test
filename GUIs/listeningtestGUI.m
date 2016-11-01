function varargout = listeningtestGUI(varargin)
% LISTENINGTESTGUI MATLAB code for listeningtestGUI.fig
%      LISTENINGTESTGUI, by itself, creates a new LISTENINGTESTGUI or raises the existing
%      singleton*.
%
%      H = LISTENINGTESTGUI returns the handle to a new LISTENINGTESTGUI or the handle to
%      the existing singleton*.
%
%      LISTENINGTESTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LISTENINGTESTGUI.M with the given input arguments.
%
%      LISTENINGTESTGUI('Property','Value',...) creates a new LISTENINGTESTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before listeningtestGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to listeningtestGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help listeningtestGUI

% Last Modified by GUIDE v2.5 29-Oct-2016 19:58:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @listeningtestGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @listeningtestGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before listeningtestGUI is made visible.
function listeningtestGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to listeningtestGUI (see VARARGIN)

% UIWAIT makes listeningtestGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Choose default command line output for listeningtestGUI
handles.output = hObject;

% Save a handle to this GUI in the base workspace -- debugging purposes.
assignin('base', 'listeningGUI', hObject);

% Get the handle to the current subject and save it in the gui handles
handles.Subject = evalin('base', 'subject');

% Adding State Variables to GUI
handles.curTestConditionIndex = 1;
handles.curTestCondition = handles.Subject.TestConditions{handles.curTestConditionIndex};
handles.isOver = false;
assignin('base', 'curTestCondition', handles.curTestCondition);

% Disable the subject response buttons
handles.yesbutton.Enable = 'off';
handles.nobutton.Enable = 'off';

% Fill out the text fields defining the current test condition.
handles.targetsignaltext.String = ['Alarm File: ' handles.curTestCondition.TargetFile];
handles.masklvltext.String = ['Mask Level: ', num2str(handles.curTestCondition.MaskLevel), 'dB'];

% Create a GraphPlotter object - in gui and base
handles.graphPlotter = evalin('base', 'graphPlotter');
assignin('base', 'graphPlotter', handles.graphPlotter);

f=figure();
movegui(f,'west');
handles.graphPlotter.SetFigureHandle(f);

% Create a CSVWriter object - in gui and base
handles.csvwriter = evalin('base', 'csvwriter');
assignin('base', 'csvwriter', handles.csvwriter);

% Update handles structure
guidata(hObject, handles);

% Make sure all graphical changes are made
drawnow;

% --- Outputs from this function are returned to the command line.
function varargout = listeningtestGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in yesbutton.
function yesbutton_Callback(hObject, eventdata, handles)
% hObject    handle to yesbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Modify the current Test Condition....
% Set the TargetLevel to 3dB lower than the preivous state
% Increment the 1up, 1down pivot counter

% Store the Subject's response
handles.curTestCondition.storeResponse(true);

%Plot to graph
%currentTestCondition=handles.curTestCondition.getResponses();
%handles.graphPlotter = evalin('base', 'graphPlotter');
handles.graphPlotter.PlotPoints(handles.curTestCondition.Responses);

% Decrement the Target Level
handles.curTestCondition.TargetLevel = handles.curTestCondition.TargetLevel - TestConfig.NumDown * TestConfig.StepSizeDB;

% Check if we've finished the current test condition
if handles.curTestCondition.Finished
    % Print determined threshold -- debug
    fprintf('The measured threshold of audility: %d dB\n\n', handles.curTestCondition.Threshold);
    
    % Clear the graphPlotter figure
    clf(handles.graphPlotter.FigureHandle);
    
    % Check if this was the last test condition
    if handles.curTestConditionIndex == length(handles.Subject.TestConditions)
        % Change the gui to the finished state
        handles.playtargetbutton.String = 'Finish Experiment';
        handles.isOver = true;
        
    % Otherwise change the gui to the load next condition state
    else
        handles.playtargetbutton.String = 'Continue to Next Alarm';
        
    end
    
% If we haven't finished
else
    % Print the next target level -- debug
    fprintf('Next Target Level: %d dB\n\n', handles.curTestCondition.TargetLevel);
end

% Reset GUI to Play Alarm state
handles.isPlaying = false;
handles.playtargetbutton.Enable = 'on';
handles.yesbutton.Enable = 'off';
handles.nobutton.Enable = 'off';

% Make sure the GUI updates itself
guidata(handles.figure1, handles);
drawnow


% --- Executes on button press in nobutton.
function nobutton_Callback(hObject, eventdata, handles)
% hObject    handle to nobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Store the Subject's response
handles.curTestCondition.storeResponse(false);

%Plot Graph
%currentTestCondition=handles.curTestCondition.getResponses();
%handles.graphPlotter = evalin('base', 'graphPlotter');
handles.graphPlotter.PlotPoints(handles.curTestCondition.Responses);

% Increment the Target Level
handles.curTestCondition.TargetLevel = handles.curTestCondition.TargetLevel + TestConfig.NumUp * TestConfig.StepSizeDB;

% Check if we've finished
if handles.curTestCondition.Finished
    % Print determined threshold -- debug
    fprintf('The measured threshold of audility: %d dB\n\n', handles.curTestCondition.Threshold);
       clf(handles.graphPlotter.FigureHandle);

    % Check if this was the last test condition
    if handles.curTestConditionIndex == length(handles.Subject.TestConditions)
        % Change the gui to the finished state
        handles.playtargetbutton.String = 'Finish Experiment';
        handles.isOver = true;
        
    % Otherwise change the gui to the load next condition state
    else
        handles.playtargetbutton.String = 'Continue to Next Alarm';
        
    end
    
% If we haven't finished
else
    % Print the next target level -- debug
    fprintf('Next Target Level: %d dB\n\n', handles.curTestCondition.TargetLevel);
end

% Reset GUI to Play Alarm state
handles.isPlaying = false;
handles.playtargetbutton.Enable = 'on';
handles.yesbutton.Enable = 'off';
handles.nobutton.Enable = 'off';

% Make sure the GUI updates itself
guidata(handles.figure1, handles);
drawnow


% --- Executes on button press in playtargetbutton.
function playtargetbutton_Callback(hObject, eventdata, handles)
% hObject    handle to playtargetbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
% Check if the Test Condition pivot counter exceeds 6 or 8
%       if it does...
%           move to the next TestCondition
%
%       if it does not...
%           generate the signal...

% TODO - put this entire function in this switch statement
% switch handles.State
%     case 'Testing'
%         disp('Testing state');
%         
%     case 'NextAlarm'
%         disp('Next Alarm state');
%         
%     case 'Finished'
%         disp('Finished state');
%         
%     otherwise
%         disp('Unknown state');
%     
% end

% Check if the whole experiment is over
if handles.isOver
    finishAlarmTest(handles.Subject);
    
% Check if the current test condition is over
elseif handles.curTestCondition.Finished 
    % Move on to the next test condition
    handles.curTestConditionIndex = handles.curTestConditionIndex + 1;
    handles.curTestCondition = handles.Subject.TestConditions{handles.curTestConditionIndex};
    
    % Update the text fields to the next test condition
    handles.targetsignaltext.String = ['Alarm File: ' handles.curTestCondition.TargetFile];
    handles.masklvltext.String = ['Mask Level: ', num2str(handles.curTestCondition.MaskLevel), 'dB'];
    
    % Set the GUI to the Play Alarm State
    handles.playtargetbutton.String = 'Play Alarm';
    handles.playtargetbutton.Enable = 'on';
    handles.yesbutton.Enable = 'off';
    handles.nobutton.Enable = 'off';

% Neither the experiment or test condition is over
else
    % Disable all GUI elements
    handles.playtargetbutton.Enable = 'off';
    handles.yesbutton.Enable = 'off';
    handles.nobutton.Enable = 'off';
    drawnow;
 
    % Generate Noise+Signal
    PinkNoiseGenerator(handles.curTestCondition.Target,handles.curTestCondition.TargetFileFs,handles.curTestCondition.MaskLevel,handles.curTestCondition.TargetLevel)
    
    % Enable the Yes and No buttons
    handles.yesbutton.Enable = 'on';
    handles.nobutton.Enable = 'on';

end

guidata(handles.figure1, handles);
drawnow;


% --- Executes on button press in panicbutton.
function panicbutton_Callback(hObject, eventdata, handles)
% hObject    handle to panicbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.isPlaying = false;
handles.playtargetbutton.Enable = 'on';
handles.yesbutton.Enable = 'off';
handles.nobutton.Enable = 'off';

% Make sure the GUI updates itself
guidata(handles.figure1, handles);
drawnow