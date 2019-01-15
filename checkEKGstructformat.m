function [flag] = checkEKGstructformat(FieldName,Value)
%CHECKEKGSTRUCTFORMAT Check the fieldNames of a structure to see if it is
%            representing a valid EKG stucture.
%	
%	Syntax
%
%	  [flag] = checkEKGstructformat(fieldNames)
%
%  Description
%
%    CHECKEKGSTRUCTFORMAT is a function that checks the fieldnames
%     of structure to see if it contains the necessary fields to be a
%     valid EKG structure.  The structure can have the following
%     fieldnames:  leads i, ii, iii, v1, v2, v3, v4, v5, v6, avr, avf,
%     avl, vx, vy, vz, sampling frequency fs, gender, age.
%     
%	  CHECKEKGSTRUCTFORMAT(fieldNames) takes one function parameter,
%	    fieldNames - cell array containing the fieldnames.
%    and returns,
%      FLAG  - 2 for 15 leads, 1 for 12 leads, 0 for invalid structure
%	
%	Example
%
%	  Here is code for checking the format of a structure.
%
%       signal.i = [1 2 3];
%       ind=1:10000;
%       signal.i = sin(2*pi*ind/250);
%	    [feature,debug] = rr_interval_wav(signal);
%
%
%	Algorithm
%
%     The function checks the fieldnames against a standard list of names.
%
%	See also SAIDIMPORT.

% SAID Toolbox Component


StdFieldName = {'Age';'Gender';'Diagnosis';'i';'ii';'iii';'avl';'avr';'avf';'v1';'v2';'v3';...
                                     'v4';'v5';'v6';'vx';'vy';'vz'};


flags = zeros(18,1);
for i=1:18,
  ind1 = find(strcmp(StdFieldName(i),FieldName));
  if isempty(ind1),
    flags(i) = 0;
  else
      flags(i) = ~(strcmp('n/a',Value(ind1)) | isempty(Value{ind1})); 
  end
end

if all(flags(1:18)),
  flag = 2;
elseif all(flags(1:15)),
  flag = 1;
else
  flag = 0;
end
