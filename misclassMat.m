function [m,per,mi,perc_tot] = misclassMat(t,a)
%MISCLASSMAT Find the misclassification matrix
%
%  Syntax
%  
%    [m,per,mi,perc_tot] = misclassMat(t,a)
%
%  Description
%
%    MISCLASSMAT is a function that will compute the number of
%    misclassifications when provided with targets and network
%    outputs.  The misclassification matrix is also referred
%    to as the confusion matrix.  The matrix includes number of
%    True Positives, number of False Positives, number of True 
%    Negatives and number of False Negatives.  It will work for 
%    multiple categories.
%
%  MISCLASSMAT takes these inputs,
%      a  - Network outputs. One element in each column should equal 1,
%           and the other elements should equal -1.
%      t  - Target vectors. One element in each column should equal 1,
%           and the other elements should equal -1.
%    it returns,
%      m         - Misclassification matrix.
%      per       - Percentage of decisions in each category: False Negative,
%                  False Positive, Correct
%      mi        - Index of points that fall in each cell of the misclassification matrix.
%      perc_tot  - Total percent error
%
%	Example
%
%	  Here is code for calculating the misclassification matrix
%
%       a = [1 1 1 -1 -1 -1 1 1 1;-1 -1 -1 1 1 1 -1 -1 -1];
%       t = [1 -1 1 -1 -1 1 1 1 1;-1 1 -1 1 1 -1 -1 -1 -1];
%       [m,per,mi,perc_tot] = misclassMat(t,a);
%
%  Reference
%  http://infolab.stanford.edu/pub/gio/1990/walkerDiscovery.html

[s,q] = size(t);

m = zeros(s,s);
mi = cell(s,s);
[mx,i] = max(t);
[mx,j] = max(a);
for k = 1:length(i),
    m(i(k),j(k)) = m(i(k),j(k))+1;
    mi{i(k),j(k)} = [mi{i(k),j(k)} k];
end

per = zeros(s,3);
for i=1:s,
    tot(i) = sum(m(i,:));
    per(i,1) = 100*sum(m(i,[1:(i-1) (i+1):s]))/tot(i);
    per(i,2) = 100*sum(m([1:(i-1) (i+1):s],i))/tot(i);
    per(i,3) = 100*m(i,i)/tot(i);
end

perc_tot = 100*sum(diag(m))/sum(sum(m));
