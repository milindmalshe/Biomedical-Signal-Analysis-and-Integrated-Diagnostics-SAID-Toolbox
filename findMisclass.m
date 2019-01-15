function [ind]=findMisclass(q,mi,frac)
%FINDMISCLASS Find the index of patients that have been misclassified more
%  than a certain fraction of the time.
%	
%	Syntax
%
%	  [ind21,ind12]=findMisclass(q,mi,frac)
%
%  Description
%
%    FINDMISCLASS takes as input a cell array containing indices of patients
%     that fall in each cell of the misclassification matrix. The cell array
%     is created by EKGMONTECARLOTRAIN by running a number of Monte Carlo
%     trials.  The function then finds those patients that were
%     misclassified most often.     
%     
%	  FINDMISCLASS(q,mi,frac) takes the following parameters as inputs,
%	    q    - Number of patients.
%	    mi   - Cell array.  Each cell contains a cell array of indices of points
%	           that fall in each compartment of the misclassification
%	           matrix. This cell array is created by EKGMONTECARLOTRAIN.
%              The number of cells corresponds to the number of Monte Carlo
%              trials that were run.
%       frac - the function will return the indices of all patients who
%              were misclassified more than this fraction of the trials.
%    and returns,
%       ind12 - Index of sick patients who were misclassified as healthy
%               more than frac ratio of the trials
%       ind21 - Index of healthy patients who were misclassified as sick
%               more than frac ratio of the trials
%	
%	Example
%
%	  Here is code for finding misclassified patients.
%
%       a = [1 1 1 -1 -1 -1 1 1 1;-1 -1 -1 1 1 1 -1 -1 -1];
%       t = [1 -1 1 -1 -1 1 1 1 1;-1 1 -1 1 1 -1 -1 -1 -1];
%       [m,per,mi,perc_tot] = misclassMat(t,a);
%       mi1{1} = mi;
%       frac = 0.5;
%       q = 9;
%       [ind21,ind12]=findMisclass(q,mi1,frac);
%
%
%	Algorithm
%
%     EKGDIVIDEDAT randomly divides data into testing, validation and 
%     training sets.  It uses the RANDPERM function to randomly order 
%     the original data set.
%
%	See also EKGMONTECARLOTRAIN.

% SAID Toolbox Component


[n,m] = size(mi);
summ21=[];
summ12=[];
for i=1:m,
  summ21 = [summ21 mi{1,i}{2,1}];
  summ12 = [summ12 mi{1,i}{1,2}];
end

n21 = hist(summ21,[1:q]);
n12 = hist(summ12,[1:q]);

n = n21 + n12;

% [n21b,n21ix] = sort(n21,'descend');
% [n12b,n12ix] = sort(n12,'descend');

[nb,nix] = sort(n,'descend');

ind = find(nb>(m*frac));
ind = nix(ind);

% ind12 = find(n12b>(m*frac));
% ind12 = n12ix(ind12);


