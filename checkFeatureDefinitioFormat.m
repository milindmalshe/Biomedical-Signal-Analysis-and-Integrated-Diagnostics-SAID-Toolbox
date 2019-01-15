function [flag] = checkFeatureDefinitioFormat(FieldName)

% 
% checkEKGfeatureformat: Check if a structure contains correct fields
% corresponding to a "features" file from EKG signal
% It checks for fieldnames such as: Name, Value, Info.
% 
% Syntax
%     This function is not called independently, but instead is called from
%     Pattern Recognition/Clustering module
% 
% 
% Description
%     


% Milind Malshe
%     The function checks the fieldnames against a standard list of names.


% SAID Toolbox Component



StdFieldName = {'MatlabFeatureList';'MatlabFeatureList_functionNames';'MatlabFeatures_button';...
                'FortranFeatures_button';'RwaveLead_popUp_Value';'downSamplingRate_popUp';'pointsNumericalDeriv_popUp';...
                'stepSizeQRS_editBox';'baselineCorrection_button';'vectorCardio_button'};
num = size(StdFieldName,1);

flags = zeros(num,1);
for i=1:num,
  flags(i) = any(strcmp(StdFieldName(i),FieldName));
end

if all(flags(1:num)),
  flag = 1;
% elseif all(flags(1:12)),
%   flag = 1;
else
  flag = 0;
end
