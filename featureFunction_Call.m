
% function [features] = featureFunction_Call(Patient,PatientName,PatientInfo,MatlabFeatureList_functionNames,call_extractFeatureList_functionsNames)

function [features] = featureFunction_Call(EKGsignal,EKGsignalName,MatlabFeatureList_functionNames,call_extractFeatureList_functionsNames)
% 
% 
% featureFunction_Call: Extract features using Matlab codes
% Syntax
%   function is not called independently but is called from 

% Milind Malshe



features = struct('name',{},'value',{});

numFeatureFile = length(call_extractFeatureList_functionsNames);


Patient = EKGsignal;
PatientName = EKGsignalName;
PatientInfo = EKGsignal.info;

for j=1:numFeatureFile
    call_function = char(MatlabFeatureList_functionNames(call_extractFeatureList_functionsNames(j)));
    %                 [feature_name_value,dbug] = SAIDutil(call_function,Patient1);
    [feature_name_value,dbug] = SAIDutil(call_function,Patient);

    i = 1;
    
    if(i == 1)
        numFeatures_currentFeatureFile(j) = length(feature_name_value.value);


        for k = 1:numFeatures_currentFeatureFile(j)
            %            count_features = count_features + 1;
            %
            %            features.name(count_features) = feature_name_value.name(k);
            %            features.value(count_features) = feature_name_value.value(k);
            if(isempty(features))
                % features(i,1).name = feature_name_value.name(k);
                features(1,1).name = feature_name_value.name(k);  %%% Use features(1,1) instead of features(i,1), since for all patients, the feature names are all the same
                features(i,1).value = feature_name_value.value(k);
            else
                % features.name(i,end+1) = feature_name_value.name(k);
                features.name(1,end+1) = feature_name_value.name(k);  %%% Use features(1,end+1) instead of features(i,end+1), since for all patients, the feature names are all the same
                features.value(i,end+1) = feature_name_value.value(k);
            end

        end %% end k

    else
        for k = 1:numFeatures_currentFeatureFile(j)
            if( j == 1)
                % features.name(i,k) = feature_name_value.name(k);
                features.name(1,k) = feature_name_value.name(k);  %%% Use features(1,k) instead of features(i,k), since for all patients, the feature names are all the same
                features.value(i,k) = feature_name_value.value(k);
            else
                % features.name(i,(numFeatures_currentFeatureFile(j-1) + k)) = feature_name_value.name(k);
                features.name(1,(numFeatures_currentFeatureFile(j-1) + k)) = feature_name_value.name(k);
                features.value(i, (numFeatures_currentFeatureFile(j-1) + k)) = feature_name_value.value(k);
            end
        end
    end %% end if(i == 1)
end

% features.Patient.name = char(PatientName);
% features.Patient.info = PatientInfo;
% features.diagnosis = EKGsignal.info.Diagnosis;
