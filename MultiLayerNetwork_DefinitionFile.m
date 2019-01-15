
function [MultiLayerNetworkDefinition] = MultiLayerNetwork_DefinitionFile();

% Syntax
%   MultiLayerNetworkDefinition = MultiLayerNetwork_DefinitionFile;
%   save 'MultiLayerNetworkDefinition' MultiLayerNetworkDefinition;



% Milind Malshe




% MultiLayerNetworkDefinition.numLayers = 3;
% 
% if (MultiLayerNetworkDefinition.numLayers == 2)
%     MultiLayerNetworkDefinition.numNeurons_editBox_1 = 25;
%     MultiLayerNetworkDefinition.numNeurons_editBox_2 = 1;
%     
%     MultiLayerNetworkDefinition.transferFunction_popUp_1 = 'logsig';
%     MultiLayerNetworkDefinition.transferFunction_popUp_2 = 'logsig';
%     
% elseif (MultiLayerNetworkDefinition.numLayers == 3)
%     MultiLayerNetworkDefinition.numNeurons_editBox_1 = 25;
%     MultiLayerNetworkDefinition.numNeurons_editBox_2 = 15;
%     MultiLayerNetworkDefinition.numNeurons_editBox_3 = 1;
%     
%     MultiLayerNetworkDefinition.transferFunction_popUp_1 = 'logsig';
%     MultiLayerNetworkDefinition.transferFunction_popUp_2 = 'logsig';
%     MultiLayerNetworkDefinition.transferFunction_popUp_3 = 'logsig';
% end
% 
% 
% MultiLayerNetworkDefinition.trainingFunction_popUp = 'traingd';



load('net_5MonteCarlo_25_15_1_logsig_logsig_logsig');

MultiLayerNetworkDefinition.net = net;
MultiLayerNetworkDefinition.numMonteCarloRuns_editBox = size(net,2);

MultiLayerNetworkDefinition.numLayers_popUp = size(net{1}.layers,1); % NOTE: YOU ARE CHECKING ONLY net{1},
                                                                % SO, ALL NETWORKS IN A MONTECARLO RUN SHOULD HAVE THE SAME NUMBER OF lAYERS AND NEURONS


if (MultiLayerNetworkDefinition.numLayers_popUp == 2)
    MultiLayerNetworkDefinition.numNeurons_editBox_1 = net{1}.layers{1}.dimensions;
    MultiLayerNetworkDefinition.numNeurons_editBox_2 = net{1}.layers{2}.dimensions;
    
    MultiLayerNetworkDefinition.transferFunction_popUp_1 = net{1}.layers{1}.transferFcn;
    MultiLayerNetworkDefinition.transferFunction_popUp_2 = net{1}.layers{2}.transferFcn;
    
elseif (MultiLayerNetworkDefinition.numLayers_popUp == 3)
    MultiLayerNetworkDefinition.numNeurons_editBox_1 = net{1}.layers{1}.dimensions;
    MultiLayerNetworkDefinition.numNeurons_editBox_2 = net{1}.layers{2}.dimensions;
    MultiLayerNetworkDefinition.numNeurons_editBox_3 = net{1}.layers{3}.dimensions;
    
    MultiLayerNetworkDefinition.transferFunction_popUp_1 = net{1}.layers{1}.transferFcn;
    MultiLayerNetworkDefinition.transferFunction_popUp_2 = net{1}.layers{2}.transferFcn;
    MultiLayerNetworkDefinition.transferFunction_popUp_3 = net{1}.layers{3}.transferFcn;
end

MultiLayerNetworkDefinition.trainingFunction_popUp = net{1}.trainFcn;
MultiLayerNetworkDefinition.epochs_editBox = net{1}.trainParam.epochs;



MultiLayerNetworkDefinition.testing_popUp = 25;
MultiLayerNetworkDefinition.validation_popUp = 25;
MultiLayerNetworkDefinition.training_popUp = 100 - (MultiLayerNetworkDefinition.testing_popUp + MultiLayerNetworkDefinition.validation_popUp);


