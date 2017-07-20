% main GUI of Sketch Art project
% Author: Xinxin Zhang
% Date: 12/07/2016


function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 07-Dec-2016 09:26:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;
clc;
clear global;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Load.
function Load_Callback(hObject, eventdata, handles)
% hObject    handle to Load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global X;
global Y;
global RP;
global FullPathName;

% open an image and show it on both original and result panel
[FileName,PathName] = uigetfile('*.bmp;*.tif;*.jpg;*.hdf;*.png','Select the image file');
FullPathName = [PathName,FileName];
X = imread(FullPathName);
imshow(X, 'Parent', handles.originalPanel);

RP = findobj(gcf,'Tag','resultPanel'); % resultPanel is the name of Tag
set(gcf, 'CurrentAxes', RP); % set current working panel as resultPanel
imshow(X); % show inedited image on resultPanel


% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Y;

[FileName,PathName] = uiputfile({'*.bmp';'*.tif';'*.jpg';'*.hdf';'*.png'},'Save as');
FullPathName = [PathName,FileName];
imwrite(Y,FullPathName);

% check the existence of the file and displays the result of the file selection operation.
if isequal(FileName,0) || isequal(PathName,0)
   disp('User selected Cancel')
else
   disp(['User selected ',fullfile(PathName,FileName)])
end


% --- Executes on button press in pSketch.
function pSketch_Callback(hObject, eventdata, handles)
% hObject    handle to pSketch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global cp;
global p;

if (get(hObject,'Value') == get(hObject,'Max'))
%     str = 'Yes';
    p = 1; cp = 0;
	display('Pencil Sketch Selected');
    set(handles.cpSketch,'value',0);
else
    p = 0;
	display('Not selected');
%     str = 'No';
end


% --- Executes on button press in cpSketch.
function cpSketch_Callback(hObject, eventdata, handles)
% hObject    handle to cpSketch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global cp;
global p;


if (get(hObject,'Value') == get(hObject,'Max'))
%     str = 'Yes';
    cp = 1; p = 0;
	display('Color Pencil Sketch Selected');
    set(handles.pSketch,'value',0);
else
	display('Not selected');
    cp = 0;
%     str = 'No';
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% global originalPanel;
% global resultPanel;
% global Y;
% global FullPathName;

global theta;

theta = get(hObject, 'Value');
assignin('base', 'sliderVal', theta);
set(handles.texture1, 'String', theta);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global dirNum;

currentValue = get(hObject, 'Value');
dirNum = round(currentValue);
assignin('base', 'sliderVal', dirNum);
set(handles.textWigCon, 'String', dirNum);


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end 



% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1

global w;
% set(listbox_handle, 'Value', [] );
items = get(hObject, 'String');
index_selected = get(hObject,'Value');
w = index_selected-1;
item_selected = items{index_selected};
display(item_selected);
display(index_selected);


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject,'String',{'Thin';'Moderate';'Thick'});


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global betaS;

currentValue = get(hObject, 'Value');
betaS = currentValue;
assignin('base', 'sliderVal', betaS);
set(handles.textLineLum, 'String', betaS);


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global betaI;

currentValue = get(hObject, 'Value');
betaI = currentValue;
assignin('base', 'sliderVal', betaI);
set(handles.textImgLum, 'String', betaI);

% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global RP;
global X;
global Y;
global cp;
global p;

% Controlling parameters
global theta;
global w;
global dirNum;
global betaS;
global betaI;
weightRat = 3;
ks = 1;


if cp == 1
%     set(handles.pSketch,'value',0);
    set(gcf, 'CurrentAxes', RP); % set current working panel as resultPanel
    Y = colorPencilSketch(X, ks, theta, w, dirNum, weightRat, betaS, betaI);
end

if p == 1
%     set(handles.cpSketch,'value',0);
    set(gcf, 'CurrentAxes', RP); % set current working panel as resultPanel
    Y = pencilSketch(X, ks, w, dirNum, betaS);
end
    imshow(Y);


% --- Executes on button press in clearButt.
function clearButt_Callback(hObject, eventdata, handles)
% hObject    handle to clearButt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global X;
global RP;

set(handles.pSketch,'value',0);
set(handles.cpSketch, 'value', 0);
set(handles.textImgLum, 'String', 0);
set(handles.textLineLum, 'String', 0);
set(handles.textWigCon, 'String', 6);
clc;

set(gcf, 'CurrentAxes', RP);
imshow(X);





