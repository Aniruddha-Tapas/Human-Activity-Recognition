close all
clear all
clc

%% Delete the initial frames from the Frames folder
delete('Frames\*.jpg');

% Select the video file to be analyzed
[filename pathname] = uigetfile({'*.avi'},'Select A Video File'); 
%[filename pathname] = uigetfile({'*.mp4'},'Select A Video File'); 

% Using a VideoReader to display the video to be analyzed
 I = VideoReader([pathname,filename]);
 implay([pathname,filename]);
 
% v=videoinput('winvideo',1,'MJPG_1280x720');
% imwrite(v,'v1.avi');
% I = VideoReader('v1.avi');
% implay('v1.avi');

pause(7);

% Converting the video in a set of 50 frames
nFrames = I.numberofFrames;
vidHeight =  I.Height;
vidWidth =  I.Width;
mov(1:nFrames) = ...
    struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
           'colormap', []);
       WantedFrames = 50;
for k = 1:WantedFrames
    mov(k).cdata = read( I, k);
   mov(k).cdata = imresize(mov(k).cdata,[256,256]);
    imwrite(mov(k).cdata,['Frames\',num2str(k),'.jpg']);
end

% Displaying the 50 frames
for I = 1:WantedFrames
   im=imread(['Frames\',num2str(I),'.jpg']);
    figure(1),subplot(5,10,I),imshow(im);
end
clc

% Printing the processing of each frame
for i=1:WantedFrames
    disp(['Processing frame no.',num2str(i)]);
  img=imread(['Frames\',num2str(i),'.jpg']);
  
  
  %   converting n-channel image into a one channel
  %   (gray) image as gray=(r+g+b+...)/n

  rgb = double(img);
  if ndims(rgb)< 3
    f1=rgb;
  else
    f1=sum(rgb,3)/size(rgb,3);
  end
  
  % Using STIP to return features extracted from videos
  % which would later be used in testing
  [ysize,xsize]=size(f1);
  nptsmax=40;   
  kparam=0.04;  
  pointtype=1;  
  sxl2=4;       
  sxi2=2*sxl2;  
  % detect points
  [posinit,valinit]=STIP(f1,kparam,sxl2,sxi2,pointtype,nptsmax);
  % Building the testing features set
  Test_Feat(i,1:40)=valinit;
end

%% Use KNN(K nearest neighbours) To classify the videos
% Loading the TrainFeat.mat files
% that contains the training set with features derived from the KTH dataset
load('TrainFeat.mat') 
X = meas;
Y = New_Label;
Z = Test_Feat;

%% Classification

%Using an ensemble model
%ens = fitensemble(X,Y,'Subspace',300,'KNN');
%class = predict(ens,Z(1,:))

%Using a knn model to fit the training set
md1 = ClassificationKNN.fit(X,Y);
%md1 = fitcknn.fit(X,Y);

% Predicting the activities from the testing set
Type = predict(md1,Z);

%Classifying according to the labels returned by KNN classifier
if (Type == 1)
    disp('Boxing');
    helpdlg(' Boxing ');
elseif (Type == 2)
    disp('Hand Clapping');
    helpdlg('Hand Clapping');
elseif (Type == 3)
    disp('Hand Waving');
    helpdlg('Hand Waving');
elseif (Type == 4)
    disp('Jogging');
    helpdlg('Jogging');
elseif (Type == 5)
    disp('Running');
    helpdlg('Running');
elseif (Type == 6)
    disp('Walking');
    helpdlg('Walking');
else
    disp('Not able to recognize');
    helpdlg('Not able to recognize');
end
