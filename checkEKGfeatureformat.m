function [flag] = checkEKGfeatureformat(FieldName)

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



StdFieldName = {'name';'value';'Patient';'feature'};

numFieldname = size(StdFieldName,1);

flags = zeros(numFieldname,1);
for i=1:numFieldname,
  flags(i) = any(strcmp(StdFieldName(i),FieldName));
end

if all(flags(1:numFieldname)),
  flag = 1;
% elseif all(flags(1:12)),
%   flag = 1;
else
  flag = 0;
end
