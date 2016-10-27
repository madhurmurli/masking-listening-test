function varargout = calibrationGUI(varargin)
% CALIBRATIONGUI MATLAB code for calibrationGUI.fig
%      CALIBRATIONGUI, by itself, creates a new CALIBRATIONGUI or raises the existing
%      singleton*.
%
%      H = CALIBRATIONGUI returns the handle to a new CALIBRATIONGUI or the handle to
%      the existing singleton*.
%
%      CALIBRATIONGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CALIBRATIONGUI.M with the given input arguments.
%
%      CALIBRATIONGUI('Property','Value',...) creates a new CALIBRATIONGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before calibrationGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to calibrationGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help calibrationGUI

% Last Modified by GUIDE v2.5 27-Oct-2016 17:50:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @calibrationGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @calibrationGUI_OutputFcn, ...
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


% --- Executes just before calibrationGUI is made visible.
function calibrationGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to calibrationGUI (see VARARGIN)

% Choose default command line output for calibrationGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes calibrationGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = calibrationGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in playtonebutton.
function playtonebutton_Callback(hObject, eventdata, handles)
% hObject    handle to playtonebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% play the sine tone
CalibrationTone(1000,16000);

% --- Executes on button press in okbutton.
function okbutton_Callback(hObject, eventdata, handles)
% hObject    handle to okbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% when the user presses this, get the value from the entered text field and
% put it where it needs to go... TBD. 
% then open up the enroll subject window
dbspl = str2double(handles.dbedittext.String);
if isnan(dbspl) || dbspl <= 85
    return
end

% if the dbspl is valid pass it to the testconfig
TestConfig.CalibrationLevel(dbspl);
% launch enroll subj
close(gcf)
enrollsubjectGUI


function dbedittext_Callback(hObject, eventdata, handles)
% hObject    handle to dbedittext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dbedittext as text
%        str2double(get(hObject,'String')) returns contents of dbedittext as a double


% --- Executes during object creation, after setting all properties.
function dbedittext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dbedittext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
