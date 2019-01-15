function [net,ps,mT,perT,perc_errT,mi] = ekgMonteCarlotrain(p,t,par)
%EKGTRAIN Train multiple neural networks in Monte Carlo fashion, and
%         compute associated statistics.
%            
%	
%	Syntax
%
%	  [net] = ekgMonteCarlotrain(num_runs,p,t,par)
%
%  Description
%
%    EKGMONTECARLOTRAIN is a function that creates multiple feedforward 
%      neural networks and trains them with provided data.  Each network is
%      trained with a different division of the data into
%      training/testing/validation sets, and with different intial weights.
%      The statistics associated with the networks are calculated.
%     
%	  ekgMonteCarlotrain(p,t,par) takes the following parameters,
%	    p         - matrix of network inputs
%	    t         - matrix of network targets
%       par       - Structure of parameters
%            par.num_runs  - number of Monte Carlo runs to excecute
%            par.netSize   - array containing number of neurons in each layer
%            par.epochs    - maximum number of training epochs
%            par.trainFcn  - training function
%            par.tf        - cell array of transfer functions in each layer
%            par.per       - structure containing testing, validation and training
%                             percentages
%               par.per.tst - testing percentage
%               par.per.val - validation percentage
%               par.per.tr  - training percentage
%    and returns,
%       net - trained network
%	
%	Example
%
%	  Here is code for training 5 networks with EKGMONTECARLOTRAIN.
%
%       % Load the data
%       dataFile = 'ekg_fifthTest';
%       load(dataFile)
%       % Set the parameters
%       per.tst=0.15;
%       per.val=0.15;
%       per.tr=0.7;
%       par.per = per;
%       par.netSize = [5 1];
%       par.tf = {'tansig','tansig'};
%       par.epochs = 100;
%       par.trainFcn = 'trainscg';
%       par.num_runs = 5;
%       % Train the networks. 
%       [net,ps,mT,perT,perc_errT,mi] = ekgMonteCarlotrain(p,t,par);
%
%	Algorithm
%
%     This function uses the TRAIN function from the Neural Network Toolbox.
%
%	See also EKGTRAIN.

%

num_runs = par.num_runs;

% Normalize the data
[p,ps] = mapminmax(p);
[r1,q1] = size(p);
maxt = max(max(t));
mint = min(min(t));
if (mint==-1) && (maxt==1),
  t = 0.9*t;
end

mT = zeros(2,2,num_runs);
perT = zeros(2,3,num_runs);
perc_errT = zeros(1,num_runs);
mi = cell(1,num_runs);
net = cell(1,num_runs);

for i = 1:num_runs,
    [ptr,ttr,validation,testing] = ekgdividedat(p,t,par.per);
    [net{i}] = ekgtrain(ptr,ttr,validation,testing,par);

%    [mT(:,:,i),perT(:,:,i),perc_errT(i),mi{i}] = crossValEKG(dataFile,ind1,ind2,inds);

    % Compute percent error on test set and misclassification matrix
    anT = sim(net{i},testing.P);
    aT = hardlims(anT);
    tT = hardlims(testing.T);
    perc_errT(i) = 100*0.5*sum(abs(tT - aT))/length(tT);
    aa = [aT; -aT];
    tt = [tT; -tT];
    [mT(:,:,i),perT(:,:,i)] = misclassMat(tt,aa);

    % Find out which patients were misclassified
    a = sim(net{i},p);
    a = hardlims(a);
    t = hardlims(t);
    aa1 = [a; -a];
    tt1 = [t; -t];
    [m,per,mi{i}] = misclassMat(tt1,aa1);
end

