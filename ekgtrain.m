function [net] = ekgtrain(ptr,ttr,validation,testing,par)
%EKGTRAIN Train a neural network
%            
%	
%	Syntax
%
%	  [net] = ekgtrain(ptr,ttr,validation,testing,par)
%
%  Description
%
%    EKGTRAIN is a function that creates a feedforward neural network
%     and trains it with provided data.
%     
%	  EKGTRAIN(ptr,ttr,validation,testing,par) takes the following parameters,
%	    ptr         - matrix of network training inputs
%	    ttr         - matrix of network targets
%       validation  - Structure of validation vectors.
%            validation.P - matrix of validation inputs
%            validation.T - matrix of validation targets
%       testing     - Structure of test vectors.
%            testing.P - matrix of testing inputs
%            testing.T - matrix of testing targets
%       par         - Structure of parameters
%            par.netSize  - array containing number of neurons in each layer
%            par.epochs   - maximum number of training epochs
%            par.trainFcn - training function
%            par.tf       - cell array of transfer functions in each layer
%    and returns,
%       net - trained network
%	
%	Example
%
%	  Here is code for training a network with EKGTRAIN.
%
%       % Load the data
%       dataFile = 'ekg_fifthTest';
%       load(dataFile)
%       % Set the parameters
%       par.netSize = [5 1];
%       par.tf = {'tansig','tansig'};
%       par.epochs = 100;
%       par.trainFcn = 'trainscg';
%       per.tst=0.15;
%       per.val=0.15;
%       per.tr=0.7;
%       % Train the network. 
%      [ptr,ttr,validation,testing] = ekgdividedat(p,t,per);
%      [net{i}] = ekgtrain(ptr,ttr,validation,testing,par);
%
%	Algorithm
%
%     This function uses the TRAIN function from the Neural Network Toolbox.
%
%	See also EKGMONTECARLOTRAIN.

% SAID Toolbox Component



% Set various network and training parameters
netSize = par.netSize;
epochs = par.epochs;
trainFcn = par.trainFcn;
tf = par.tf;
max_fail = 40;
show = 50; %NaN;
mu = 100;
mu_dec = 0.5;

%    DEFINING THE NETWORK
%    ====================
net = newff(minmax(ptr),netSize,tf,trainFcn);
net.trainParam.show = show;    
net.trainParam.max_fail = max_fail;
net.trainParam.epochs = epochs;
net.trainParam.mu = mu;
net.trainParam.mu_dec = mu_dec;

%    TRAINING THE NETWORK
%    ====================
[net,tr]=train(net,ptr,ttr,[],[],validation,testing);
