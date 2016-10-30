function varargout = enrollsubjectGUI(varargin)
% ENROLLSUBJECTGUI MATLAB code for enrollsubjectGUI.fig
%      ENROLLSUBJECTGUI, by itself, creates a new ENROLLSUBJECTGUI or raises the existing
%      singleton*.
%
%      H = ENROLLSUBJECTGUI returns the handle to a new ENROLLSUBJECTGUI or the handle to
%      the existing singleton*.
%
%      ENROLLSUBJECTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENROLLSUBJECTGUI.M with the given input arguments.
%
%      ENROLLSUBJECTGUI('Property','Value',...) creates a new ENROLLSUBJECTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before enrollsubjectGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to enrollsubjectGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help enrollsubjectGUI

% Last Modified by GUIDE v2.5 27-Oct-2016 14:55:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @enrollsubjectGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @enrollsubjectGUI_OutputFcn, ...
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


% --- Executes just before enrollsubjectGUI is made visible.
function enrollsubjectGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to enrollsubjectGUI (see VARARGIN)

assignin('base', 'enrollGUI', hObject);

% Choose default command line output for enrollsubjectGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes enrollsubjectGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = enrollsubjectGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function subjnameedit_Callback(hObject, eventdata, handles)
% hObject    handle to subjnameedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of subjnameedit as text
%        str2double(get(hObject,'String')) returns contents of subjnameedit as a double



% --- Executes during object creation, after setting all properties.
function subjnameedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to subjnameedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function subjidnumedit_Callback(hObject, eventdata, handles)
% hObject    handle to subjidnumedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of subjidnumedit as text
%        str2double(get(hObject,'String')) returns contents of subjidnumedit as a double


% --- Executes during object creation, after setting all properties.
function subjidnumedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to subjidnumedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in begintestbutton.
function begintestbutton_Callback(hObject, eventdata, handles)
% hObject    handle to begintestbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Disable the Continue button
handles.begintestbutton.Enable = 'off';

if isnan(str2double(handles.subjidnumedit.String))
    handles.begintestbutton.Enable = 'on';
    
else
    testConditions = generateTestConditions();
    subject = Subject(handles.subjnameedit.String, handles.subjidnumedit.String, testConditions);
    graphPlotter=GraphPlotter(handles.subjnameedit.String,handles.subjidnumedit.String);
    assignin('base', 'subject', subject);
    assignin('base', 'testConditionIndex', 1);
    assignin('base','graphPlotter',graphPlotter);
    
    handles.begintestbutton.Enable = 'on';
    close(gcf)
    listeningtestGUI
end
