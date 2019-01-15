
function [features,dbug] = basicFeatures(EKGsignal)

%BASICFEATURES extracts age and gender from an EKG signal
%	
%	Syntax
%
%	  [feature,debug] = basicFeatures(EKGSignal,fp)
%
%  Description
%
%    BASICFEATURES is a feature extraction function that extracts age and
%    gender from an EKG signal
% 
%	  BASICFEATURES(EKGSignal,fp) takes one function parameter,
%	    EKGSIGNAL - structure containing the following fields:
%                     leads i, ii, iii, v1, v2, v3, v4, v5, v6, avr, avf,
%                       avl, vx, vy, vz
%                     info.fs - sampling frequency
%	    FP - Struct of function parameters (ignored for this function).
%    and returns,
%      FEATURE  - Structure of features, names and descriptions. The fields are
%                   feature.value(1) = age
%                   feature.value(2) = gender
%      DEBUG     - Structure of information that can be used for debugginge
%	
%	Example
%
%	  Here is code for calculating the BASICFEATURES for a EKG signal.
%       
%
%       signal.info.fs = 1000;
%       ind=1:10000;
%       signal.i = sin(2*pi*ind/250);
%	    [feature,debug] = basicFeatures(signal);
%
%
%	Algorithm
%
%     BASICFEATURES extracts age and gender from an EKG signal


% Milind Malshe







AdditionalInfoFeatures = {'Age', 'Gender'};
%         numAdditionalInfoFeatures = size(features.name,2)-numFeaturesTotal;
numAdditionalInfoFeatures = size(AdditionalInfoFeatures,2);

% Patient = EKGsignal;
% PatientName = EKGsignalName;
% PatientInfo = EKGsignal.info;


for j = 1:numAdditionalInfoFeatures
    features.name{j} = AdditionalInfoFeatures{j};
end
        
for j = 1:numAdditionalInfoFeatures
    
    value = []; % Initialize "Value" to [] or ''
    
    if strcmp(AdditionalInfoFeatures(j),'Gender')
        if strcmp(lower(EKGsignal.info.(char(AdditionalInfoFeatures(j)))),'male')
            value = 1;
        elseif strcmp(lower(EKGsignal.info.(char(AdditionalInfoFeatures(j)))),'female')
            value = -1;
        else
            display('Gender is neither male nor female')
        end
    
    else
        value = EKGsignal.info.(char(AdditionalInfoFeatures(j)));
    end
    
    features.value(j) = value;
    
end

% features.Patient.name = PatientName;
% features.Patient.info = PatientInfo;
% features.diagnosis = EKGsignal.info.Diagnosis;
% feature.diagnosis = EKGsignal.info.Diagnosis;

dbug = 1;


