function [ind2,rel_dis] = findNeighbors(p,ind1,number)
%FINDNEIGHBORS Find the indices of patients that are neighbors
%  of the indicated patient.
%	
%	Syntax
%
%	  [ind2,rel_dis] = findNeighbors(p,ind1,number)
%
%  Description
%
%    FINDNEIGHBORS takes as input a matrix of features for a set of patients
%     and the index of a particular patient.  It then finds the neighbors
%     of that patient.
%     
%	  findNeighbors(p,ind1,number) takes the following parameters as inputs,
%	    p      - Matrix of patient features.
%	    ind1   - Index of the patient for which we want to find the neighbors
%       number - Number of neighbors we want to find
%    and returns,
%       ind2    - Indices of neighbors, sorted with closest neighbor first
%       rel_dis - Relative distance (divided by average distance) to each 
%                  neighbor
%	
%	Example
%
%	  Here is code for plotting the roc curve for a random network.
%
%       P = [0 1 2 3 4 5 6 7 8 9 10];
%       T = [1 1 1 1 1 -1 -1 -1 -1 -1 -1];
%       net = newff(minmax(P),[5 1],{'tansig' 'tansig'});
%       [fpr,tpr] = roccurve(net,P,T);
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

ww = p';
aa = p(:,ind1);
dd = dist(ww,aa);
dd = dd/mean(dd);
[dds,ind2] = sort(dd);

for i=length(ind2):-1:1,
  if ind2(i)==ind1,
    ind2(i) = [];
    dds(i) = [];
  end
end

ind2 = ind2(1:number);
rel_dis = dds(1:number);
