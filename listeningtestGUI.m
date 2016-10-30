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

assignin('base', 'listeningGUI', hObject);

% Choose default command line output for listeningtestGUI
handles.output = hObject;

% Adding State Variables to GUI
handles.curTestCondition = evalin('base', 'subject.TestConditions{testConditionIndex}');
handles.isOver = false;
handles.yesbutton.Enable = 'off';
handles.nobutton.Enable = 'off';

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes listeningtestGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
assignin('base', 'curTestCondition', handles.curTestCondition);
handles.targetsignaltext.String = ['Alarm File: ' handles.curTestCondition.TargetFile];
handles.masklvltext.String = ['Mask Level: ', num2str(handles.curTestCondition.MaskLevel), 'dB'];
handles.graphPlotter = evalin('base', 'graphPlotter');
assignin('base', 'graphPlotter', handles.graphPlotter);


 f=figure();
 movegui(f,'west');
 handles.graphPlotter.SetFigureHandle(f);

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
currentTestCondition=handles.curTestCondition.getResponses();
handles.graphPlotter = evalin('base', 'graphPlotter');
handles.graphPlotter.PlotPoints(currentTestCondition);

% Decrement the Target Level
handles.curTestCondition.TargetLevel = handles.curTestCondition.TargetLevel - TestConfig.NumDown * TestConfig.StepSizeDB;

% Check if we've finished
if handles.curTestCondition.Finished
    fprintf('The measured threshold of audility: %d dB\n\n', handles.curTestCondition.Threshold);
    
    if evalin('base', 'testConditionIndex == length(subject.TestConditions)')
        handles.playtargetbutton.String = 'Finish Experiment';
        handles.isOver = true;
    else
        handles.playtargetbutton.String = 'Continue to Next Alarm';
    end
else
    fprintf('Next Target Level: %d dB\n\n', handles.curTestCondition.TargetLevel);
end

% Reset GUI to Play Alarm state
handles.isPlaying = false;
handles.playtargetbutton.Enable = 'on';
handles.yesbutton.Enable = 'off';
handles.nobutton.Enable = 'off';



% --- Executes on button press in nobutton.
function nobutton_Callback(hObject, eventdata, handles)
% hObject    handle to nobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Store the Subject's response
handles.curTestCondition.storeResponse(false);

% Increment the Target Level
handles.curTestCondition.TargetLevel = handles.curTestCondition.TargetLevel + TestConfig.NumUp * TestConfig.StepSizeDB;

%Plot Graph
currentTestCondition=handles.curTestCondition.getResponses();
handles.graphPlotter = evalin('base', 'graphPlotter');
handles.graphPlotter.PlotPoints(currentTestCondition);
% Check if we've finished
if handles.curTestCondition.Finished
    fprintf('The measured threshold of audility: %d dB\n\n', handles.curTestCondition.Threshold);
    
    if evalin('base', 'testConditionIndex == length(subject.TestConditions)')
        handles.playtargetbutton.String = 'Finish Experiment';
        handles.isOver = true;
    else
        handles.playtargetbutton.String = 'Continue to Next Alarm';
    end
else
    fprintf('Next Target Level: %d dB\n\n', handles.curTestCondition.TargetLevel);
end

% Reset GUI to Play Alarm state
handles.isPlaying = false;
handles.playtargetbutton.Enable = 'on';
handles.yesbutton.Enable = 'off';
handles.nobutton.Enable = 'off';


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

if handles.isOver
    finishAlarmTest(evalin('base', 'subject'));
    
elseif handles.curTestCondition.Finished
    newIndex = evalin('base', 'testConditionIndex + 1');
    assignin('base', 'testConditionIndex', newIndex);
    
    handles.curTestCondition = evalin('base', 'subject.TestConditions{testConditionIndex}');
    
    handles.targetsignaltext.String = ['Alarm File: ' handles.curTestCondition.TargetFile];
    handles.masklvltext.String = ['Mask Level: ', num2str(handles.curTestCondition.MaskLevel), 'dB'];
    
    handles.playtargetbutton.String = 'Play Alarm';

else
    % Disable all GUI elements
    handles.playtargetbutton.Enable = 'off';
    handles.yesbutton.Enable = 'off';
    handles.nobutton.Enable = 'off';
    
    % TODO: MADHUR
    % Put the signal generation code here
    % Calls PinkNoiseGenerator and sounds a test signal for the listener
    %
    % You can get the audio vector for the current alarm at....
    %   handles.curTestCondition.Target
    %
    % You can get the target (Alarm) level at....
    %   handles.curTestCondition.TargetLevel
    %
    % You can get the mask level at....
    %   handles.curTestCondition.MaskLevel
    
    PinkNoiseGenerator(handles.curTestCondition.Target,handles.curTestCondition.TargetFileFs,handles.curTestCondition.MaskLevel,handles.curTestCondition.TargetLevel)
    
    % Enable the Yes and No buttons
    handles.yesbutton.Enable = 'on';
    handles.nobutton.Enable = 'on';

end


% --- Executes on button press in panicbutton.
function panicbutton_Callback(hObject, eventdata, handles)
% hObject    handle to panicbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.isPlaying = false;
handles.playtargetbutton.Enable = 'on';
handles.yesbutton.Enable = 'off';
handles.nobutton.Enable = 'off';