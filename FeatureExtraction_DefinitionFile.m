

function [FeatureDefinition] = FeatureExtraction_DefinitionFile()

% Syntax
%   FeatureDefinition = FeatureExtraction_DefinitionFile;
%   save 'FeatureDefinition' FeatureDefinition;



% Milind Malshe


FeatureDefinition.MatlabFeatureList = {'R-R interval';'Heart Rate'};
FeatureDefinition.MatlabFeatureList_functionNames = {'rr_interval_wav';'heart_rate_fft'};

FeatureDefinition.MatlabFeatures_button = 'on';



FeatureDefinition.FortranFeatures_button = 'off';
FeatureDefinition.RwaveLead_popUp = 'i';
FeatureDefinition.downSamplingRate_popUp = 2;
FeatureDefinition.pointsNumericalDeriv_popUp = 3;
FeatureDefinition.stepSizeQRS_editBox = 4;
FeatureDefinition.baselineCorrection_button = 'off';
FeatureDefinition.vectorCardio_button = 'off';








