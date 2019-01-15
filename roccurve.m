function [fpr,tpr] = roccurve(net,P,T)
%ROCCURVE Calculation and plotting of the receiver operating characteristic
%            curve.
%	
%	Syntax
%
%	  [fpr,tpr] = roccurve(net,P,T)
%
%  Description
%
%    ROCCURVE is a function which plots the ROC curve for a neural network. 
%     The fuction is supplied with a neural network object from the neural
%     network toolbox and sets of input and targets.  This function can
%     only be used for problems in which there are two classes.  There
%     should only be one output neuron.  It is expected that the output
%     neuron should have a TANSIG transfer function and that the targets
%     take on the values -1 and 1.  Although other transfer functions can
%     be used, the results may not be useful.
%     
%	  ROCCURVE(net,P,T) takes the following parameters,
%	    net - neural network object (from neural network toolbox)
%	    P - Set of input vectors.
%	    T - Set of targets (scalar).
%    and returns,
%       fpr  - Array of false positive rates
%       tpr  - Array of true positive rates
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
%     ROCCURVE calculates the receiver operating characteristic by taking the 
%     output of the supplied neural network for each of the input vectors
%     and comparing it against a threshold that is varied over the range of
%     of the output.  At each level of the threshold, the false positive
%     rate (fpr) and true positive rate (tpr) are computed using the
%     misclassification matrix.  The ROC curve is a plot of TPR vs FPR.
%
%
%	See also MISCLASSMAT.

% SAID Toolbox Component

% Check that the network only has one output (two classes)
if net.layers{end}.size ~= 1,
  warndlg({'The ROC plot is only valid for two', 'classes (one output neuron).'},'ROC Warning','modal');
  tpr = [];
  fpr = [];
  return
end

% Find the range of the output of the network.
% Since the linear transfer function has infinite
% range, set the range to be -1 to 1.
range = feval(net.layers{end}.transferFcn,'output');
llim = range(1);
if llim==-Inf, llim = -1; end
ulim = range(2);
if ulim==Inf, ulim = 1; end

% Set the threshold at 100 levels over the range
pts = 100;
step = (ulim-llim)/pts;
th = llim:step:ulim;

% Find the network response
a = sim(net,P);

% Force targets to be -1 or 1
t = hardlims(T);

% Adjust the threshold and compute TPR and FPR
for i=1:length(th),
  aT = hardlims(a-th(i));
  perc_errT = 0.5*sum(abs(t - aT))/length(t);
  aa = [aT; -aT];
  tt = [t; -t];
  [m] = misclassMat(tt,aa);
  tpr(i) = m(1,1)/sum(m(1,:));
  fpr(i) = m(2,1)/sum(m(2,:));
end

% Plot the ROC curve
figure
plot(fpr,tpr)


