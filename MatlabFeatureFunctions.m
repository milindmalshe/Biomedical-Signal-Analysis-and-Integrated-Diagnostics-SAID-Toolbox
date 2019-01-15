
function [MatlabFeatureList,MatlabFeatureList_functionNames] = MatlabFeatureFunctions()

MatlabFeature = {'R-R interval'     'rr_interval_wav';...
                 'Basic Features'   'basicFeatures'};
             
% 'Heart Rate'       'heart_rate_fft';...



MatlabFeatureList = MatlabFeature(:,1);
MatlabFeatureList_functionNames = MatlabFeature(:,2);


