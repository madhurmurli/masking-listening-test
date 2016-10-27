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

% Last Modified by GUIDE v2.5 26-Oct-2016 17:45:47

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

% Choose default command line output for listeningtestGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes listeningtestGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
handles.targetsignaltext.String = ['Alarm File: ' evalin('base', 'subject.TestConditions{testConditionIndex}.TargetFile')];
handles.masklvltext.String = ['Mask Level: ', num2str(evalin('base', 'subject.TestConditions{testConditionIndex}.MaskLevel')), 'dB'];


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

% lower the target by 5 dBfs, load a new target into the test
assignin('base', 'testConditionIndex', evalin('base', 'testConditionIndex + 1'));
try
    handles.targetsignaltext.String = ['Alarm File: ' evalin('base', 'subject.TestConditions{testConditionIndex}.TargetFile')];
    handles.masklvltext.String = ['Mask Level: ', num2str(evalin('base', 'subject.TestConditions{testConditionIndex}.MaskLevel')), 'dB'];
catch
    disp('Experiment is over mothafukkkkka');
    close(gcf);
end



% --- Executes on button press in nobutton.
function nobutton_Callback(hObject, eventdata, handles)
% hObject    handle to nobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% raise the target by 10 dBfs, load a new target into the test


% --- Executes on button press in startbutton.
function startbutton_Callback(hObject, eventdata, handles)
% hObject    handle to startbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% begin the noise and enable play target button


% --- Executes on button press in nextcondbutton.
function nextcondbutton_Callback(hObject, eventdata, handles)
% hObject    handle to nextcondbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% enabled when the 50% hearing level has been acheived thru 2-up-1-down
% when pushed, store the results somewhere for the particular subject


% --- Executes on button press in playtargetbutton.
function playtargetbutton_Callback(hObject, eventdata, handles)
% hObject    handle to playtargetbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% play the target signal
