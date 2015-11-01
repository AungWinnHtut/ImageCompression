function varargout = SegmentationGui(varargin)
% SEGMENTATIONGUI MATLAB code for SegmentationGui.fig
%      SEGMENTATIONGUI, by itself, creates a new SEGMENTATIONGUI or raises the existing
%      singleton*.
%
%      H = SEGMENTATIONGUI returns the handle to a new SEGMENTATIONGUI or the handle to
%      the existing singleton*.
%
%      SEGMENTATIONGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEGMENTATIONGUI.M with the given input arguments.
%
%      SEGMENTATIONGUI('Property','Value',...) creates a new SEGMENTATIONGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SegmentationGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SegmentationGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SegmentationGui

% Last Modified by GUIDE v2.5 01-Nov-2015 11:28:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SegmentationGui_OpeningFcn, ...
                   'gui_OutputFcn',  @SegmentationGui_OutputFcn, ...
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


% --- Executes just before SegmentationGui is made visible.
function SegmentationGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SegmentationGui (see VARARGIN)

% Choose default command line output for SegmentationGui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SegmentationGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SegmentationGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnSelect.
function btnSelect_Callback(hObject, eventdata, handles)
% hObject    handle to btnSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc

[f p]=uigetfile('*.jpg');
%axes(handles.figOriginal);

axes(handles.figIteration);

I = imread([p f]);  %-- load the image
I=rgb2gray(I); 
imshow(I,'Parent',handles.figOriginal); title('Input Image');
%I = imresize(I,.5);  
[x y II rect]=imcrop(I);
rect=round(rect);
m = zeros(size(I,1),size(I,2)); %-- create initial mask
m(rect(2):rect(2)+rect(4)-1,rect(1):rect(1)+rect(3)-1)=ones;  
%axes(h);



imshow(m,'Parent',handles.figInitialMask); title('Initial mask');
%imshow(I,'Parent',handles.figOne); title('Input Image');

seg = region_seg(I, m, 100); %-- Run segmentation

imshow(seg,'Parent',handles.figFinalSegmentation);
%imshow(seg,'Parent',handles.figOriginal); title('Input Image');
[r c] = size(I);
newimag1 = uint8(zeros(r,c));
newimag2 = uint8(zeros(r,c));
for ii=1:r
    for jj = 1:c
        if seg(ii,jj) == 1
            newimag1(ii,jj) = I(ii,jj);
            newimag2(ii,jj) = 255;
        else
            newimag1(ii,jj) = 0;
            newimag2(ii,jj) = I(ii,jj);
        end
    end
end
imshow(newimag1,'Parent',handles.figSegmentedROI);
imshow(newimag2,'Parent',handles.figOtherThanROI);
%f1=handles.figOriginal;
%saveas(f1,'tmp.fig');
%f2=hgload('tmp.fig');
%delete('tmp.fig');
%imshow(f2,'Parent',handles.figIteration);


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mnuHelp_Callback(hObject, eventdata, handles)
% hObject    handle to mnuHelp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mnuExit_Callback(hObject, eventdata, handles)
% hObject    handle to mnuExit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;
