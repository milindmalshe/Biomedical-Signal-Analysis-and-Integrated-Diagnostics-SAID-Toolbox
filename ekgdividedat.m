function [ptr,ttr,validation,testing] = ekgdividedat(p,t,per)
%EKGDIVIDEDAT Divide data into training/validation/testing
%	
%	Syntax
%
%	  [ptr,ttr,validation,testing] = ekgdividedat(p,t,per)
%
%  Description
%
%    EKGDIVIDEDAT randomly divides a set of data into training, validation 
%     and testing segments, based on a set of provided percentages.
%     
%	  EKGDIVIDEDAT(p,t,per) takes the following parameters,
%	    p   - Set of input vectors.
%	    t   - Set of targets.
%       per - structure containing testing, validation and training
%             percentages
%           per.tst - testing percentage
%           per.val - validation percentage
%           per.tr  - training percentage
%    and returns,
%       ptr        - Set of training input vectors
%       ttr        - Set of training targets
%       validation - structure of validation inputs and targets
%           validation.P - Set of validation input vectors
%           validation.T - Set of validation targets
%       testing    - structure of testing inputs and targets
%           testing.P    - Set of testing input vectors
%           testing.T    - Set of testing targets
%	
%	Example
%
%	  Here is code for dividing data.
%
%       per.tst=0.15;
%       per.val=0.15;
%       per.tr=0.7;
%       P = [0 1 2 3 4 5 6 7 8 9 10];
%       T = [1 1 1 1 1 -1 -1 -1 -1 -1 -1];
%       [ptr,ttr,validation,testing] = ekgdividedat(P,T,per);
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

% Divide the data up into training, validation and test sets.

[r,q] = size(p);
q1 = fix(q*per.tst);
q2 = q1 + fix(q*per.val);
qrand = randperm(q);
iitst = qrand(1:q1);
iival = qrand((q1+1):q2);
iitrn = qrand((q2+1):end);


validation.P = p(:,iival);
validation.T = t(:,iival);
testing.P = p(:,iitst);
testing.T = t(:,iitst);
ptr = p(:,iitrn);
ttr = t(:,iitrn);

