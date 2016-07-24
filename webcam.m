v=videoinput('winvideo',1,'MJPG_1280x720');
% preview(v)
% 
% %%%
% >> imaqhwinfo
% 
% ans =
% 
%     InstalledAdaptors: {'dcam'  'linuxvideo'}
%         MATLABVersion: '7.12 (R2011a)'
%           ToolboxName: 'Image Acquisition Toolbox'
%        ToolboxVersion: '4.1 (R2011a)'
% 
% >> imaqhwinfo('linuxvideo')
% 
% ans =
% 
%        AdaptorDllName: '/usr/local/MATLAB/R2011a/toolbox/imaq/imaqadaptors/glnx86/mwlinuxvideoimaq.so'
%     AdaptorDllVersion: '4.1 (R2011a)'
%           AdaptorName: 'linuxvideo'
%             DeviceIDs: {[1]  [2]}
%            DeviceInfo: [1x2 struct]
% 
% >> imaqhwinfo('linuxvideo',1)
% 
% ans =
% 
%           DefaultFormat: 'RGB3_320x240'
%     DeviceFileSupported: 0
%              DeviceName: 'Hercules Dualpix HD Microphone'
%                DeviceID: 1
%       ObjectConstructor: 'videoinput('linuxvideo', 1)'
%        SupportedFormats: {1x20 cell}
% 
% >> vid = videoinput('linuxvideo', 1, 'RGB3_320x240');
% >> preview(vid)%%%