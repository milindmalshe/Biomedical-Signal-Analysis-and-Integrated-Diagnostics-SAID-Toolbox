
function MultiLayerNetwork(cmd,data,arg2)

% 
% MultilayerNetwork: Traing a multilayer network
% 
% Syntax
%     MultilayerNetwork function is not called independently but is called from Pattern recognition/clustering window
% 
% 
% Description
%     


% Milind Malshe







% DEFAULTS
if nargin == 0,
    cmd = '';
    data = '';
else
    cmd = lower(cmd);
end

% FIND WINDOW IF IT EXISTS
fig = 0;

% We alow the program to see hidden handles
fig=findall(0,'type','figure','tag','MultiLayerNetwork');
if (size(fig,1)==0),
    fig=0;
end

if (length(get(fig,'children')) == 0),
    fig = 0;
end

% GET WINDOW DATA IF IT EXISTS
if fig
    H = get(fig,'userdata');
end

%==================================================================
% Activate the window.
%
% ME() or ME('')
%==================================================================

if strcmp(cmd,'') | isempty(cmd)
    if fig
        figure(fig)
        set(fig,'visible','on')
    else
        MultiLayerNetwork('init',data)
    end

    %==================================================================
    % Close the window.
    %
    % ME() or ME('')
    %==================================================================

elseif strcmp(cmd,'close') & (fig)
    if exist(cat(2,tempdir,'MultiLayerNetworkdata.mat'))
        delete(cat(2,tempdir,'MultiLayerNetworkdata.mat'));
    end
    delete(fig);

    


% % % % % % MILIND

elseif strcmp(cmd,lower('train'))
    get(H.training_popUp,'Value');
    get(H.validation_popUp,'Value');
    get(H.testing_popUp,'Value');
    
    validationPercentData = H.validation_popUp_String{get(H.validation_popUp, 'Value')};
    testingPercentData = H.testing_popUp_String{get(H.testing_popUp, 'Value')};
    
    validation_PercentSymbolPositionInString = findstr(validationPercentData,'%');
    validationPercentData = validationPercentData(1:(validation_PercentSymbolPositionInString-1) );

    testing_PercentSymbolPositionInString = findstr(testingPercentData,'%');
    testingPercentData = testingPercentData(1:(testing_PercentSymbolPositionInString-1) );

    
    trainingPercentData = 100 - (str2num(validationPercentData) + str2num(testingPercentData));
    
    % % % % %FOLLOWING CODE ARRANGES THE DATA IN A FORMAT USED IN "usingMLP.m" CODE FROM Dr. Hagan
    per.tr =  trainingPercentData/100;
    per.val = str2num(validationPercentData)/100;
    per.tst = str2num(testingPercentData)/100;
    
    par.per = per;
    
    
    numLayers_cellArray = H.numLayers_popUp_String(get(H.numLayers_popUp,'value'));
    numLayers = numLayers_cellArray(1);
    numLayers = str2num(numLayers);
    
    if(numLayers == 2)

        numNeurons1 = (get(H.numNeurons_editBox_1,'String'));
        transferFcn1 = H.transferFunction_popUp_String_1{get(H.transferFunction_popUp_1,'Value')};

        numNeurons2 = (get(H.numNeurons_editBox_2,'String'));
        transferFcn2 = H.transferFunction_popUp_String_2{get(H.transferFunction_popUp_2,'Value')};
        
        %         numNeurons3 = (get(H.numNeurons_editBox_3,'String'));
        %         transferFcn3 = H.transferFunction_popUp_String_3(get(H.transferFunction_popUp_3,'Value'));
        
        
        par.netSize = [str2num(numNeurons1) str2num(numNeurons2)];
        par.tf = {transferFcn1,transferFcn2};  %%%%%?????CHECK CHECK CHECK: is it a string array of string ?????
        
    
    elseif(numLayers == 3)

        numNeurons1 = (get(H.numNeurons_editBox_1,'String'));
        transferFcn1 = H.transferFunction_popUp_String_1{get(H.transferFunction_popUp_1,'Value')};

        numNeurons2 = (get(H.numNeurons_editBox_2,'String'));
        transferFcn2 = H.transferFunction_popUp_String_2{get(H.transferFunction_popUp_2,'Value')};
        
        numNeurons3 = (get(H.numNeurons_editBox_3,'String'));
        transferFcn3 = H.transferFunction_popUp_String_3{get(H.transferFunction_popUp_3,'Value')};
        
        
        par.netSize = [str2num(numNeurons1) str2num(numNeurons2) str2num(numNeurons3)];
        par.tf = {transferFcn1,transferFcn2,transferFcn3};

    end
    
    
    par.epochs = str2num(get(H.epochs_editBox,'String'));
    
    par.trainFcn = H.trainingFunction_popUp_String(get(H.trainingFunction_popUp,'Value'));
    par.trainFcn = char(par.trainFcn);
    
    par.num_runs = str2num(get(H.numMonteCarloRuns_editBox,'String'));

    
    if(par.per.tr ~=0 )
        [net,ps,mT,perT,perc_errT,mi] = ekgMonteCarlotrain(H.data.p,H.data.t,par); % Train neural networks
        %     [net,ps,mT,perT,perc_errT,mi] = ekgMonteCarlotrain(H.data.p(1,1:5),H.data.t(1,1:5),par)


        H_netTrainOut.p = H.data.p;
        H_netTrainOut.t = H.data.t;
        H_netTrainOut.par = par;

        H_netTrainOut.net = net;
        H_netTrainOut.ps = ps;
        H_netTrainOut.mT = mT;
        H_netTrainOut.perT = perT;
        H_netTrainOut.perc_errT = perc_errT;
        H_netTrainOut.mi = mi;

        set(H.frameDisplay,'Userdata',H_netTrainOut);
    end

    set(H.inputSens_button,'Enable','On');
    set(H.misClass_button,'Enable','On');
    set(H.confusionMat_button,'Enable','On');
    set(H.ROCcurve_button,'Enable','On');
    set(H.errorHist_button,'Enable','On');
    set(H.export_button,'Enable','On');
    
    
    
       
    get(H.training_popUp,'Value');
    get(H.validation_popUp,'Value');
    get(H.testing_popUp,'Value');
    
    validationPercentData = H.validation_popUp_String{get(H.validation_popUp, 'Value')};
    testingPercentData = H.testing_popUp_String{get(H.testing_popUp, 'Value')};
    
    validation_PercentSymbolPositionInString = findstr(validationPercentData,'%');
    validationPercentData = validationPercentData(1:(validation_PercentSymbolPositionInString-1) );

    testing_PercentSymbolPositionInString = findstr(testingPercentData,'%');
    testingPercentData = testingPercentData(1:(testing_PercentSymbolPositionInString-1) );

    
    trainingPercentData = 100 - (str2num(validationPercentData) + str2num(testingPercentData));
    
    %     trainingPercentData = strcat(num2str(trainingPercentData),'%');
    
    H_netParamDataDiv.testing_popUp = str2num(testingPercentData);
    H_netParamDataDiv.validation_popUp = str2num(validationPercentData);
    H_netParamDataDiv.training_popUp = trainingPercentData;
        
    H_netParamDataDiv.net = net;
    H_netParamDataDiv.ps = ps;
    
    H_netParamDataDiv.mT = mT;
    H_netParamDataDiv.perT = perT;
    H_netParamDataDiv.perc_errT = perc_errT;
    H_netParamDataDiv.mi = mi;


    H_netParamDataDiv.trainingFunction_popUp = par.trainFcn;
    
    H_netParamDataDiv.numMonteCarloRuns_editBox = str2num(get(H.numMonteCarloRuns_editBox,'String'));
    
    
    H_netParamDataDiv.numLayers_popUp = numLayers;
    
    if(numLayers == 2)
        H_netParamDataDiv.numNeurons_editBox_1 = numNeurons1;
        H_netParamDataDiv.numNeurons_editBox_2 = numNeurons2;
        
        H_netParamDataDiv.transferFunction_popUp_1 = transferFcn1;
        H_netParamDataDiv.transferFunction_popUp_2 = transferFcn2;
        
    elseif(numLayers == 3)
        H_netParamDataDiv.numNeurons_editBox_1 = numNeurons1;
        H_netParamDataDiv.numNeurons_editBox_2 = numNeurons2;
        H_netParamDataDiv.numNeurons_editBox_3 = numNeurons3;
        
        H_netParamDataDiv.transferFunction_popUp_1 = transferFcn1;
        H_netParamDataDiv.transferFunction_popUp_2 = transferFcn2;
        H_netParamDataDiv.transferFunction_popUp_3 = transferFcn3;
    end
    
    H_netParamDataDiv.epochs_editBox = par.epochs;
    
    set(H.frameParam,'Userdata',H_netParamDataDiv);
    
    set(H.commentText,'String','Export Network Definition File For Use in Batch Mode');
    MultiLayerNetwork();
    
% % % % %     ------end of Train
    
elseif strcmp(cmd,lower('inputSens'))
    H_netTrainOut = get(H.frameDisplay,'Userdata');

    pn = mapminmax('apply',H_netTrainOut.p,H_netTrainOut.ps);
    t = H_netTrainOut.t;
    
    sens = ekgsensitivity(H_netTrainOut.net{1},pn,t);
    figure
    stem(sens)
    xlabel('Feature Index Number');
    ylabel('Sensitivity');
    title('Input Sensitivities');
        

    
elseif strcmp(cmd,lower('confusionMat'))
    H_netTrainOut = get(H.frameDisplay,'Userdata');
    confusionMat_EKG = mean(H_netTrainOut.mT,3);
    
    perErrAvg = mean(H_netTrainOut.perc_errT);
    
    Spreadsheet_confusionMat(confusionMat_EKG,perErrAvg);
    
    
    
    
elseif strcmp(cmd,lower('errorHist'))
    H_netTrainOut = get(H.frameDisplay,'Userdata');
    
    figure
    hist(H_netTrainOut.perc_errT);
    xlabel('Percent Error');
    ylabel('Number of Cases');
    title('Error Histogram');
    

elseif strcmp(cmd,lower('ROCcurve'))
    H_netTrainOut = get(H.frameDisplay,'Userdata');
    
    pn = mapminmax('apply',H_netTrainOut.p,H_netTrainOut.ps);
    t = H_netTrainOut.t;
    
    [fpr,tpr] = roccurve(H_netTrainOut.net{1},pn,t);

elseif strcmp(cmd,lower('misClass'))
    H_netTrainOut = get(H.frameDisplay,'Userdata');
    
    [ind] = findMisclass(size(H_netTrainOut.p,2),H_netTrainOut.mi,.050);%%%%%????? 447 is the total number of patients in Dr. Hagan's data
                                                            %%%%%????? Change mi(1) to mi(i)
    if(size(ind,2)==0)
        warndlg('There are no misclassified patients');
    else
        MisclassifiedPatient('init',ind,H.data.Patients_Name,H_netTrainOut.p,H_netTrainOut.mi);
    end
% % % % ==================================================================                                                            
                                                            
                                                            
elseif strcmp(cmd,lower('importMultiLayerNetworkDefinitionFile'))
    SAIDutil('SAIDimport','init','','','Import Network Definition');
    
    
    
    
elseif strcmp(cmd,lower('have_file_Import Network Definition'))
    arg1 = data;
    
    
    set(H.numMonteCarloRuns_editBox,'String',arg1.numMonteCarloRuns_editBox);

    
    argValue = (find(str2num(H.numLayers_popUp_String)==arg1.numLayers_popUp));
    numLayers = arg1.numLayers_popUp;
    set(H.numLayers_popUp,'Value',argValue);
    
    MultiLayerNetwork('check_params_numLayers');
    
    
    %Set number of neurons in each layer
    argValue = arg1.numNeurons_editBox_1;
    set(H.numNeurons_editBox_1,'String',argValue);   

    argValue = arg1.numNeurons_editBox_2;
    set(H.numNeurons_editBox_2,'String',argValue);

    if(numLayers == 3)
        argValue = arg1.numNeurons_editBox_3;
        set(H.numNeurons_editBox_3,'String',argValue);
    end
    
    
    %Set transfer function for each layer
    arg1.transferFunction_popUp_1;
    argValue = find(strcmp((H.transferFunction_popUp_String_1),arg1.transferFunction_popUp_1)==1);
    set(H.transferFunction_popUp_1,'Value',argValue);

    arg1.transferFunction_popUp_2;
    argValue = find(strcmp((H.transferFunction_popUp_String_2),arg1.transferFunction_popUp_2)==1);
    set(H.transferFunction_popUp_2,'Value',argValue);
    
    if(numLayers ==3)
        arg1.transferFunction_popUp_3;
        argValue = find(strcmp((H.transferFunction_popUp_String_3),arg1.transferFunction_popUp_3)==1);
        set(H.transferFunction_popUp_3,'Value',argValue);
    end
    
    %Set training method
    arg1.trainingFunction_popUp;
    argValue = find(strcmp((H.trainingFunction_popUp_String),arg1.trainingFunction_popUp)==1);
    set(H.trainingFunction_popUp,'Value',argValue);
    
    
    
    %Set percent data for training, validation, and testing sets
    arg1.testing_popUp;
    arg1.validation_popUp;
    arg1.training_popUp;
    
    
    testingPercentData = strcat(num2str(arg1.testing_popUp),'%');
    validationPercentData = strcat(num2str(arg1.validation_popUp),'%');
    trainingPercentData = strcat(num2str(arg1.training_popUp),'%');
    
    
    argValue = find(strcmp((H.testing_popUp_String),testingPercentData)==1);
    set(H.testing_popUp,'Value',argValue);
    
    argValue = find(strcmp((H.validation_popUp_String),validationPercentData)==1);
    set(H.validation_popUp,'Value',argValue);
    
    %     argValue = find(strcmp((H.training_popUp_String),trainingPercentData)==1);
    set(H.training_popUp,'String',trainingPercentData);
    
    
    
    % Set number of epochs (iterations) for training a neural network
    arg1.epochs_editBox;
    set(H.epochs_editBox,'String',num2str(arg1.epochs_editBox));


    set(H.inputSens_button,'Enable','On');
    set(H.misClass_button,'Enable','On');
    set(H.confusionMat_button,'Enable','On');
    set(H.ROCcurve_button,'Enable','On');
    set(H.errorHist_button,'Enable','On');
    set(H.export_button,'Enable','On');


    %     *************
    H_netTrainOut.p = H.data.p;
    H_netTrainOut.t = H.data.t;

    
    per.tr =  trainingPercentData;
    per.val = validationPercentData;
    per.tst = testingPercentData;
    
    par.per = per;
    
    H_netTrainOut.par = par;

    H_netTrainOut.net = arg1.net;
    H_netTrainOut.ps = arg1.ps;
    H_netTrainOut.mT = arg1.mT;
    H_netTrainOut.perT = arg1.perT;
    H_netTrainOut.perc_errT = arg1.perc_errT;
    H_netTrainOut.mi = arg1.mi;

    set(H.frameDisplay,'Userdata',H_netTrainOut);
% *****************


    %==============================================================
    %                        Export
    %==============================================================
elseif strcmp(cmd,lower('export'))

    arg3{1} = get(H.frameParam,'Userdata');
    arg3{2} = 'networkParam';
    %     arg4 = get(H.frameExtractParam,'Value');
    arg4 = 1;

    %     k_signal = get(H.lbh12,'Value');
    %     k_fft = get(H.lbh11,'Value');
    %     k_filtered = get(H.lbh32,'Value');
    %     k_filtered_fft = get(H.lbh31,'Value');
    if isempty(arg4)
        errordlg('You must select a network to export','Error');
        %     elseif ~isempty(k_signal) | ~isempty(k_filtered)| ~isempty(k_fft)| ~isempty(k_filtered_fft)
        %         errordlg('Only filters can be exported','Error');
    elseif length(arg4)~=1
        errordlg('You must select only one network file to be exported','Error');
    elseif length(arg4)==1
        SAIDutil('SAIDexport','init','','',arg3,arg4);
    end

    
    
    
   
    
    
    

elseif strcmp(cmd,lower('check_params_DataDiv'))
    get(H.training_popUp,'Value');
    get(H.validation_popUp,'Value');
    get(H.testing_popUp,'Value');
    
    validationPercentData = H.validation_popUp_String{get(H.validation_popUp, 'Value')};
    testingPercentData = H.testing_popUp_String{get(H.testing_popUp, 'Value')};
    
    validation_PercentSymbolPositionInString = findstr(validationPercentData,'%');
    validationPercentData = validationPercentData(1:(validation_PercentSymbolPositionInString-1) );

    testing_PercentSymbolPositionInString = findstr(testingPercentData,'%');
    testingPercentData = testingPercentData(1:(testing_PercentSymbolPositionInString-1) );

    
    trainingPercentData = 100 - (str2num(validationPercentData) + str2num(testingPercentData));
    
    trainingPercentData = strcat(num2str(trainingPercentData),'%');
    
    set(H.training_popUp,'Enable','On');
    set(H.training_popUp,'String',trainingPercentData );
    set(H.training_popUp,'ForegroundColor',[0 0 0]);
    
    
    
elseif strcmp(cmd, lower('check_params_numLayers') )

    numLayers_cellArray = H.numLayers_popUp_String(get(H.numLayers_popUp,'value'));
    numLayers = numLayers_cellArray(1);
    
    numLayers = str2num(numLayers);
    
    dataTEMP = get(fig,'userdata');
    data.t = dataTEMP.data.t;
    
    if(numLayers == 2)
        set(H.transferFunction_popUp_3,'Visible','Off');
        set(H.numNeurons_editBox_3,'Visible','Off');
        
        set(H.numNeurons_editBox_2,'String',size(data.t,1));
        set(H.numNeurons_editBox_2,'Enable','Off');
    end
    
    if(numLayers == 3)
        set(H.transferFunction_popUp_3,'Visible','On');
        set(H.numNeurons_editBox_3,'Visible','On');
        
        set(H.numNeurons_editBox_2,'Enable','On');
        set(H.numNeurons_editBox_2,'ToolTipStr','');
        
        set(H.numNeurons_editBox_3,'String',size(data.t,1));
        set(H.numNeurons_editBox_3,'Enable','Off');
        %         set(H.numNeurons_editBox_2,'String',20);
    end
    
% % % % % % MALSHE
    


    %==================================================================
    % Initialize the window.
    %
    % ME('init')
    %==================================================================

elseif (strcmp(cmd,'init') & (~fig))

    window_en = 'on';
    window_dis = 'off';
    uipos = getuipos;
    %     default = getdefaults;

    H.StdColor = get(0,'DefaultUicontrolBackgroundColor');
    H.StdUnit='character';
    H.PointsToPixels = 72/get(0,'ScreenPixelsPerInch');

    H.me='MultiLayerNetwork';

    fig = figure('Units',H.StdUnit, ...
        'Color',[0.8 0.8 0.8], ...
        'IntegerHandle',  'off',...
        'Interruptible','off', ...
        'BusyAction','cancel', ...
        'HandleVis','Callback', ...
        'MenuBar','none', ...
        'Name',H.me, ...
        'Numbertitle','off', ...
        'Units', H.StdUnit, ...
        'PaperUnits','points', ...
        'Position',uipos.fig, ...
        'Tag','MultiLayerNetwork', ...
        'Resize','off', ...
        'ToolBar','none', ...
        'WindowStyle','Modal');

    H.text1 = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.text1, ...
        'String','Multi-Layer Network', ...
        'FontSize', 14,...
        'Style','text', ...
        'Tag','text1');
    
    
    

    H.frameDisplay = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ListboxTop',0, ...
        'Position',uipos.frameDisplay, ...
        'Style','frame', ...
        'Tag','frameDisplay');

    
    
    
    H.textDisplay = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.textDisplay, ...
        'String','Display/Analysis', ...
        'Style','text', ...
        'Tag','textDisplay');
    
    
    
    
    H.inputSens_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','SAIDutil(''MultiLayerNetwork'',''inputSens'')', ...
        'Enable','off', ...
        'ListboxTop',0, ...
        'Position',uipos.inputSens_button, ...
        'String','Input Sensitivity', ...
        'ToolTipStr','Display the sesitivity of the target for each  of the input variable',...
        'Tag','close_button');
    
    
    
    
    H.misClass_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','MultiLayerNetwork(''misClass'')', ...
        'Enable','off', ...
        'ListboxTop',0, ...
        'Position',uipos.misClass_button, ...
        'String','Misclassified Patients', ...
        'ToolTipStr','Display the list of mis-classified patients',...
        'Tag','misClass_button');
    
    
    
    
    
    
    H.confusionMat_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','MultiLayerNetwork(''confusionMat'')', ...
        'Enable','off', ...
        'ListboxTop',0, ...
        'Position',uipos.confusionMat_button, ...
        'String','Confusion Matrix', ...
        'ToolTipStr','Display the confusion matrix',...
        'Tag','confusionMat_button');
    
    
    
    
    
    H.ROCcurve_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','SAIDutil(''MultiLayerNetwork'',''ROCcurve'')', ...
        'Enable','off', ...
        'ListboxTop',0, ...
        'Position',uipos.ROCcurve_button, ...
        'String','ROC curve', ...
        'ToolTipStr','Display the Receiver-Operator Characteristics (ROC) curve',...
        'Tag','ROCcurve_button');

    
    
    
    
    H.errorHist_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','MultiLayerNetwork(''errorHist'')', ...
        'Enable','off', ...
        'ListboxTop',0, ...
        'Position',uipos.errorHist_button, ...
        'String','Error Histogram', ...
        'ToolTipStr','Display the error histogram',...
        'Tag','errorHist_button');
    
    
    
    


    H.frameParam = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ListboxTop',0, ...
        'Position',uipos.frameParam, ...
        'Style','frame', ...
        'Tag','frameParam');

    
    
    
    
    
    H.textParam = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.textParam, ...
        'String','Network Parameters', ...
        'Style','text', ...
        'Tag','textParam');
    
    
    
    
    
    
    
    
    H.train_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','MultiLayerNetwork(''train'')', ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position',uipos.train_button, ...
        'String','Train', ...
        'ToolTipStr','Train the neural network',...
        'Tag','train_button');
    
    
    
    
    
    
    H.import_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','MultiLayerNetwork(''importMultiLayerNetworkDefinitionFile'')', ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position',uipos.import_button, ...
        'String','Import', ...
        'ToolTipStr','Import the definition file for parameters to train the neural network',...
        'Tag','import_button');
    
    
    
    
    

    H.textTrainingFunction_popUp = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.textTrainingFunction_popUp, ...
        'String','Training Functions', ...
        'Style','text', ...
        'Tag','textTrainingFunction_popUp');

    
    
    
    
    
    
    H.trainingFunction_popUp_String = {'trainlm'; 'trainbr'; 'trainbfg'; 'trainscg'; 'traingd'; 'traingda'; 'traingdm'; 'traingdx'; 'trainrp'};
    H.trainingFunction_popUp = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[1 1 1], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.trainingFunction_popUp, ...
        'Max',5, ...
        'String',H.trainingFunction_popUp_String, ...
        'Style','popupmenu', ...
        'Tag','trainingFunction_popUp', ...
        'Value',4);

    
    
    
    
    
    H.textTransferFunction_popUp = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.textTransferFunction_popUp, ...
        'String','Transfer Functions', ...
        'Style','text', ...
        'Tag','textTransferFunction_popUp');

    
    
    
    
    
    
    H.transferFunction_popUp_String_1 = {'tansig'; 'logsig'; 'purelin'; 'hardlim'};
    H.transferFunction_popUp_1 = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[1 1 1], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.transferFunction_popUp_1, ...
        'Max',5, ...
        'String',H.transferFunction_popUp_String_1, ...
        'Style','popupmenu', ...
        'Tag','transferFunction_popUp_1', ...
        'Value',1);
    

    H.transferFunction_popUp_String_2 = {'tansig'; 'logsig'; 'purelin'; 'hardlim'};
    H.transferFunction_popUp_2 = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[1 1 1], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.transferFunction_popUp_2, ...
        'Max',5, ...
        'String',H.transferFunction_popUp_String_2, ...
        'Style','popupmenu', ...
        'Tag','transferFunction_popUp_2', ...
        'Value',1);

    
    H.transferFunction_popUp_String_3 = {'tansig'; 'logsig'; 'purelin'; 'hardlim'};
    H.transferFunction_popUp_3 = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[1 1 1], ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position',uipos.transferFunction_popUp_3, ...
        'Max',5, ...
        'String',H.transferFunction_popUp_String_3, ...
        'Style','popupmenu', ...
        'Tag','transferFunction_popUp_3', ...
        'Value',1, ...
        'Visible', 'off');

    
    
    
    
    
       H.textNumNeurons = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.textNumNeurons, ...
        'String','Number of Neurons', ...
        'Style','text', ...
        'Tag','textNumNeurons');

    
       H.numNeurons_editBox_1 = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[1 1 1], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.numNeurons_editBox_1, ...
        'String','20', ...
        'Style','edit', ...
        'Callback','', ...
        'ToolTipStr','',...
        'Tag','numNeurons_editBox_1');
    
    

    numNeurons_outputLayer = size(data.t,1);
    H.numNeurons_editBox_2 = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[1 1 1], ...
        'Enable','Off', ...
        'ListboxTop',0, ...
        'Position',uipos.numNeurons_editBox_2, ...
        'String',numNeurons_outputLayer, ...
        'Style','edit', ...
        'Callback','', ...
        'ToolTipStr','Number of neurons in the output layer is determined by the dimension of the target values',...
        'Tag','numNeurons_editBox_2');
    


    numNeurons_outputLayer = size(data.t,1);
    H.numNeurons_editBox_3 = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[1 1 1], ...
        'Enable','Off', ...
        'ListboxTop',0, ...
        'Position',uipos.numNeurons_editBox_3, ...	    
        'String',numNeurons_outputLayer, ...
        'Style','edit', ...
        'Callback','', ...
        'ToolTipStr','Number of neurons in the output layer is determined by the dimension of the target values',...
        'Tag','numNeurons_editBox_3', ...
        'Visible','off');
   
    
    


    H.textNumLayers_popUp = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...        
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.textNumLayers_popUp, ...
        'String','Number of Layers', ...
        'Style','text', ...
        'Tag','textNumLayers_popUp');

    
    
    
    
    
    
    H.numLayers_popUp_String = ['2';'3'];
    H.numLayers_popUp = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback',['MultiLayerNetwork(''check_params_numLayers'','''')'], ...
        'BackgroundColor',[1 1 1], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.numLayers_popUp, ...
        'Max',5, ...
        'String',H.numLayers_popUp_String, ...
        'Style','popupmenu', ...
        'Tag','numLayers_popUp', ...
        'Value',1);

    
    
    
    
    
    
    
    
        H.frameDataDiv = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ListboxTop',0, ...
        'Position',uipos.frameDataDiv, ...
        'Style','frame', ...
        'Tag','frameDataDiv');

    
    
    
    
       H.textDataDiv = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.textDataDiv, ...
        'String','Data Division', ...
        'Style','text', ...
        'Tag','textDataDiv');
    
    
    
    
    
    
    
    
    H.textNumMonteCarloRuns = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.textNumMonteCarloRuns, ...
        'String','Monte Carlo Runs', ...
        'Style','text', ...
        'Tag','textNumMonteCarloRuns');


    H.numMonteCarloRuns_editBox = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[1 1 1], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.numMonteCarloRuns_editBox, ...
        'String','10', ...
        'Style','edit', ...
        'Callback','', ...
        'ToolTipStr','',...
        'Tag','numMonteCarloRuns_editBox');

    
    

    
    H.textEpochs = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.textEpochs, ...
        'String','Epochs', ...
        'HorizontalAlignment','Center', ...
        'Style','text', ...
        'Tag','textEpochs');


    H.epochs_editBox = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[1 1 1], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.epochs_editBox, ...
        'String','100', ...
        'Style','edit', ...
        'Callback','', ...
        'ToolTipStr','',...
        'Tag','epochs_editBox');






    H.textTesting = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.textTesting, ...
        'String','Testing', ...
        'Style','text', ...
        'Tag','textTesting');






%     H.testing_popUp_String = {'0%','5%','10%','15%','20%','25%','30%','35%','40%','45%','50%'};
    H.testing_popUp_String = {'0%','5%','10%','15%','20%','25%','30%','35%','40%','45%'};
    H.testing_popUp = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback',['MultiLayerNetwork(''check_params_DataDiv'',''testingPercentData'')'], ...
        'BackgroundColor',[1 1 1], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.testing_popUp, ...
        'Max',5, ...
        'String',H.testing_popUp_String, ...
        'Style','popupmenu', ...
        'ToolTipStr','Specify the percent data to be used for testing',...
        'Tag','testing_popUp', ...
        'Value',4);



    
    
    
        H.textValidation = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.textValidation, ...
        'String','Validation', ...
        'Style','text', ...
        'Tag','textValidation');






%     H.validation_popUp_String = {'0%','5%','10%','15%','20%','25%','30%','35%','40%','45%','50%'};
    H.validation_popUp_String = {'0%','5%','10%','15%','20%','25%','30%','35%','40%','45%'};
    H.validation_popUp = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback',['MultiLayerNetwork(''check_params_DataDiv'',''validationPercentData'')'], ...
        'BackgroundColor',[1 1 1], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.validation_popUp, ...
        'Max',5, ...
        'String',H.validation_popUp_String, ...
        'Style','popupmenu', ...
        'ToolTipStr','Specify the percent data to be used for validation',...
        'Tag','validation_popUp', ...
        'Value',4);

    
    
        H.textTraining = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.textTraining, ...
        'String','Training', ...
        'Style','text', ...
        'Tag','textTraining');




    

    H.training_popUp_String = {'5%','10%','15%','20%','25%','30%','35%','40%','45%','50%','55%','60%','65%','70%','75%','80%','85%','90%','95%','100%'};
    H.training_popUp_String_initialize = '70%';
    H.training_popUp = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback',['MultiLayerNetwork(''check_params_DataDiv'',''trainingPercentData'')'], ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable','on', ...
        'ForegroundColor',[0 0 0], ...
        'ListboxTop',0, ...
        'Position',uipos.training_popUp, ...
        'String',H.training_popUp_String_initialize, ...
        'Style','Edit', ...
        'ToolTipStr','Percent data for training is set based on the percent data specified for validation and testing',...
        'Tag','training_popUp');


%     ['SAIDutil(''testGUI'',''check_params_DataDiv'',''Hidden_layer_size'', ''', get(H.Hidden_layer_text, 'String'),''');']
    
    




    H.commentFrame = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ListboxTop',0, ...
        'Position',uipos.commentFrame, ...
        'Style','frame', ...
        'Tag','commentFrame');



    H.commentTextString = 'Set Neural Network Training Parameters';
    H.commentText = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.commentText, ...
        'String',H.commentTextString, ...
        'FontWeight','bold', ...
        'ForegroundColor',[0 0 1], ...
        'Style','text', ...
        'Tag','StaticText1');

    
    

    H.close_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','MultiLayerNetwork(''Close'')', ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position',uipos.close_button, ...
        'String','Close', ...
        'ToolTipStr','Exit multilayer network window and return to ''Pattern Recognition/Clustering'' module',...
        'Tag','close_button');
    



    H.export_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','MultiLayerNetwork(''export'')', ...
        'Enable','off', ...
        'ListboxTop',0, ...
        'Position',uipos.export_button, ...
        'String','Export', ...
        'ToolTipStr','Export neural network definition file',...
        'Tag','export_button');
    
    
    
    H.data = data;  %%%%%MILIND MALSHE
%     H.p = data.p;
%     H.t = data.t;
    set(fig,'userdata',H);
    
end









function paramok = checkparam(param2check, handles, paramlabel, checkforinf)

paramok = true; %set to true initially
paramH = getfield(handles, param2check);
paramval = str2num(get(paramH, 'String'));

try
    % Common Checks for all params
    message = 'Illegal value assigned to parameter';

    if ~sanitycheckparam(paramval, checkforinf)
        error(message);
    end
    
catch
    message = sprintf('Illegal value assigned to ''%s'' parameter', paramlabel);
    errordlg(message,'Plant Identification Warning','modal');
    paramok = false;
end













function uipos = getuipos

border = 1.2;

button_gapW = 3;
button_gapH = 1;

mode_buttonW = 22;
mode_buttonH = 1.6;

action_buttonW = 18;
action_buttonH = 1.6;

listBoxW = 55;
listBoxH = 20;
inputSignal_listBoxH = 20;
MatlabFeatures_listBoxH = 10;


textListBoxW = 22;
textListBoxH = 1.2;

textRadioButtonNameW = 25;
textRadioButtonW = 10;
textRadioButtonH = 1.4;



editBoxW = 10;
editBoxH = 1.6;


checkBoxW = 28;
checkBoxH = 2;

popUpMenuW = 14;
popUpMenuH = 1;

commentTextH = 2.0;

text1H = 2;

gapBetween2Frames = 2*button_gapW;


    
% figW = 2*border + textRadioButtonNameW + button_gapW + popMenuW;
figW = 2*border + mode_buttonW + button_gapW + mode_buttonW + button_gapW + mode_buttonW + border + 2*border + ...
        border + textRadioButtonNameW + border + editBoxW + 2*border;
    
figH = 2*border +  mode_buttonH + button_gapH + border + mode_buttonH + button_gapH + mode_buttonH + border + textListBoxH + ...
        border + mode_buttonH + button_gapH + editBoxH + button_gapH + editBoxH + button_gapH + editBoxH + button_gapH + editBoxH + button_gapH + ...
        textListBoxH + border + text1H + 2*border;
    

sunits = get(0, 'Units');
set (0, 'Units', 'character');
ssinchar = get(0, 'ScreenSize');
set (0, 'Units', sunits);


figL = (ssinchar(3) - figW) / 2;
figB = (ssinchar(4) - figH) / 2;

uipos.fig = [figL, figB, figW, figH];


text1W = figW - 60*border;
text1L = figW/2 - text1W/2;
text1B = figH - 2*border - text1H + 1* commentTextH/2;

uipos.text1 = [text1L, text1B, text1W, text1H];
    
    

frameDisplayL = border;
frameDisplayB = 2*border +  mode_buttonH + button_gapH ;
% frameDisplayW = figW - 2*border;
% frameDisplayH = figH - 2*border - text1H;
frameDisplayW = 2*border + mode_buttonW + button_gapW + mode_buttonW + button_gapW + mode_buttonW + border ;
% frameDisplayH = border + mode_buttonH + button_gapH + mode_buttonH + border + textListBoxH ;
frameDisplayH = border + mode_buttonH + button_gapH + mode_buttonH + border;

uipos.frameDisplay = [frameDisplayL, frameDisplayB, frameDisplayW, frameDisplayH];


textDisplayL = border + frameDisplayW/2 - textListBoxW/2;
textDisplayB = frameDisplayB + frameDisplayH - textListBoxH/2;
uipos.textDisplay = [textDisplayL, textDisplayB, textListBoxW, textListBoxH];

    
inputSens_buttonL = frameDisplayL + border + frameDisplayW/2 - button_gapW/2 - mode_buttonW;
inputSens_buttonB = frameDisplayB + border;
uipos.inputSens_button = [inputSens_buttonL, inputSens_buttonB, mode_buttonW, mode_buttonH];
    
    
misClass_buttonL = inputSens_buttonL + mode_buttonW + button_gapW;
misClass_buttonB = inputSens_buttonB;
uipos.misClass_button = [misClass_buttonL, misClass_buttonB, mode_buttonW, mode_buttonH];
    


confusionMat_buttonL = frameDisplayL + border;
% confusionMat_buttonB = frameDisplayB + frameDisplayH - border - mode_buttonH;
confusionMat_buttonB = inputSens_buttonB + mode_buttonH + button_gapH;
uipos.confusionMat_button = [confusionMat_buttonL, confusionMat_buttonB, mode_buttonW, mode_buttonH];



ROCcurve_buttonL = confusionMat_buttonL + mode_buttonW + button_gapW;
ROCcurve_buttonB = confusionMat_buttonB;
uipos.ROCcurve_button = [ROCcurve_buttonL, ROCcurve_buttonB, mode_buttonW, mode_buttonH];



errorHist_buttonL = ROCcurve_buttonL + mode_buttonW + button_gapW;
errorHist_buttonB = confusionMat_buttonB;
uipos.errorHist_button = [errorHist_buttonL, errorHist_buttonB, mode_buttonW, mode_buttonH];




frameParamL = frameDisplayL;
frameParamB = frameDisplayB + frameDisplayH + button_gapH + border;
frameParamW = frameDisplayW;
frameParamH = border + mode_buttonH + button_gapH + editBoxH + button_gapH + editBoxH + button_gapH + editBoxH + button_gapH + editBoxH + 2*button_gapH ;
uipos.frameParam = [frameParamL, frameParamB, frameParamW, frameParamH];



textParamL = border + frameParamW/2 - textListBoxW/2;
textParamB = frameParamB + frameParamH - textListBoxH/2;
uipos.textParam = [textParamL, textParamB, textListBoxW, textListBoxH];




train_buttonL = frameParamL + frameParamW/2 - button_gapW/2 - mode_buttonW;
train_buttonB = frameParamB + border;
uipos.train_button = [train_buttonL, train_buttonB, mode_buttonW, mode_buttonH];



import_buttonL = train_buttonL + mode_buttonW + button_gapW;
import_buttonB = train_buttonB;
uipos.import_button = [import_buttonL, import_buttonB, mode_buttonW, mode_buttonH];


textTrainingFunction_popUpL = frameParamL + border;
textTrainingFunction_popUpB = train_buttonB + mode_buttonH + button_gapH;
uipos.textTrainingFunction_popUp = [textTrainingFunction_popUpL, textTrainingFunction_popUpB, textRadioButtonNameW, textRadioButtonH];



trainingFunction_popUpL = textTrainingFunction_popUpL + textRadioButtonNameW + 0*border;
trainingFunction_popUpB = textTrainingFunction_popUpB + popUpMenuH;
uipos.trainingFunction_popUp = [trainingFunction_popUpL, trainingFunction_popUpB, popUpMenuW, popUpMenuH];





textTransferFunction_popUpL = frameParamL + border;
textTransferFunction_popUpB = trainingFunction_popUpB + popUpMenuH + button_gapH;
uipos.textTransferFunction_popUp = [textTransferFunction_popUpL, textTransferFunction_popUpB, textRadioButtonNameW, textRadioButtonH];



transferFunction_popUp_1L = textTransferFunction_popUpL + textRadioButtonNameW + 0*border;
transferFunction_popUp_1B = textTransferFunction_popUpB + popUpMenuH;
uipos.transferFunction_popUp_1 = [transferFunction_popUp_1L, transferFunction_popUp_1B, popUpMenuW, popUpMenuH];


transferFunction_popUp_2L = transferFunction_popUp_1L + popUpMenuW + 2*border;
transferFunction_popUp_2B = transferFunction_popUp_1B;
uipos.transferFunction_popUp_2 = [transferFunction_popUp_2L, transferFunction_popUp_2B, popUpMenuW, popUpMenuH];



transferFunction_popUp_3L = transferFunction_popUp_2L + popUpMenuW + 2*border;
transferFunction_popUp_3B = transferFunction_popUp_1B;
uipos.transferFunction_popUp_3 = [transferFunction_popUp_3L, transferFunction_popUp_3B, popUpMenuW, popUpMenuH];




textNumNeuronsL = frameParamL + border;
textNumNeuronsB = transferFunction_popUp_1B + popUpMenuH + button_gapH;
uipos.textNumNeurons = [textNumNeuronsL, textNumNeuronsB, textRadioButtonNameW, textRadioButtonH];



numNeurons_editBox_1L = textNumNeuronsL + textRadioButtonNameW + 0*border;
numNeurons_editBox_1B = textNumNeuronsB;
uipos.numNeurons_editBox_1 = [numNeurons_editBox_1L, numNeurons_editBox_1B, editBoxW, editBoxH];



% numNeurons_editBox_2L = numNeurons_editBox_1L + editBoxW + button_gapW;
numNeurons_editBox_2L = transferFunction_popUp_2L;
numNeurons_editBox_2B = textNumNeuronsB;
uipos.numNeurons_editBox_2 = [numNeurons_editBox_2L, numNeurons_editBox_2B, editBoxW, editBoxH];




% numNeurons_editBox_3L = numNeurons_editBox_2L + editBoxW + button_gapW;
numNeurons_editBox_3L = transferFunction_popUp_3L;
numNeurons_editBox_3B = textNumNeuronsB;
uipos.numNeurons_editBox_3 = [numNeurons_editBox_3L, numNeurons_editBox_3B, editBoxW, editBoxH];





textNumLayers_popUpL = frameParamL + border;
textNumLayers_popUpB = numNeurons_editBox_1B + editBoxH + button_gapH;
uipos.textNumLayers_popUp = [textNumLayers_popUpL, textNumLayers_popUpB, textRadioButtonNameW, textRadioButtonH];



numLayers_popUpL = textNumLayers_popUpL + textRadioButtonNameW + 0*border;
numLayers_popUpB = textNumLayers_popUpB + popUpMenuH;
uipos.numLayers_popUp = [numLayers_popUpL, numLayers_popUpB, popUpMenuW/2, popUpMenuH];






frameDataDivL = frameParamL + frameParamW + border;
frameDataDivB = frameParamB;
frameDataDivW = figW - border - frameParamL - frameParamW - border;
frameDataDivH = frameParamH;
uipos.frameDataDiv = [frameDataDivL, frameDataDivB, frameDataDivW, frameDataDivH];




textDataDivL = frameDataDivL + frameDataDivW/2  - (0.7 * textListBoxW/2);
textDataDivB = frameDataDivB + frameDataDivH - textListBoxH/2;
uipos.textDataDiv = [textDataDivL, textDataDivB, (0.7*textListBoxW), textListBoxH];



textNumMonteCarloRunsL = frameDataDivL + border;
textNumMonteCarloRunsB = frameDataDivB + border;
uipos.textNumMonteCarloRuns = [textNumMonteCarloRunsL, textNumMonteCarloRunsB, textRadioButtonNameW, 1.*textRadioButtonH];


numMonteCarloRuns_editBoxL = textNumMonteCarloRunsL + textRadioButtonNameW + 0*border;
numMonteCarloRuns_editBoxB = textNumMonteCarloRunsB + 0.*textRadioButtonH;
uipos.numMonteCarloRuns_editBox = [numMonteCarloRuns_editBoxL, numMonteCarloRuns_editBoxB, editBoxW, editBoxH];


textEpochsL = frameDataDivL + border;
textEpochsB = textNumMonteCarloRunsB + editBoxH + button_gapH;
uipos.textEpochs = [textEpochsL, textEpochsB, textRadioButtonNameW, 1.*textRadioButtonH];


epochs_editBoxL = textEpochsL + textRadioButtonNameW + 0*border;
epochs_editBoxB = textEpochsB + 0*editBoxH;
uipos.epochs_editBox = [epochs_editBoxL, epochs_editBoxB, editBoxW, editBoxH];



textTestingL = frameDataDivL + border;
textTestingB = epochs_editBoxB + editBoxH + button_gapH;
uipos.textTesting = [textTestingL, textTestingB,  textRadioButtonNameW, 1*textRadioButtonH];


testing_popUpL = textTestingL + textRadioButtonNameW + 0*border;
% testing_popUpB = textTestingB + 0.*textRadioButtonH;
testing_popUpB = textTestingB + popUpMenuH;
uipos.testing_popUp = [testing_popUpL, testing_popUpB, editBoxW, popUpMenuH];




textValidationL = frameDataDivL + border;
textValidationB = textTestingB + popUpMenuH + button_gapH;
uipos.textValidation = [textValidationL, textValidationB,  textRadioButtonNameW, 1*textRadioButtonH];


validation_popUpL = textValidationL + textRadioButtonNameW + 0*border;
validation_popUpB = textValidationB + popUpMenuH;
uipos.validation_popUp = [validation_popUpL, validation_popUpB, editBoxW, popUpMenuH];



textTrainingL = frameDataDivL + border;
textTrainingB = textValidationB+ editBoxH + button_gapH;
uipos.textTraining = [textTrainingL, textTrainingB,  textRadioButtonNameW, 1*textRadioButtonH];


training_popUpL = textTrainingL + textRadioButtonNameW + 0*border;
training_popUpB = textTrainingB + popUpMenuH/4;
uipos.training_popUp = [training_popUpL, training_popUpB, editBoxW, editBoxH];





close_buttonL = figW - 2*border - action_buttonW;
close_buttonB = border;
uipos.close_button = [close_buttonL, close_buttonB, action_buttonW, action_buttonH ];




export_buttonL = close_buttonL - button_gapW - action_buttonW;
export_buttonB = close_buttonB;
uipos.export_button = [export_buttonL, export_buttonB, action_buttonW, action_buttonH ];




commentFrameL = border;
commentFrameB = 0.8* border;
commentFrameW = export_buttonL - border - button_gapW;
commentFrameH = 2;
uipos.commentFrame = [commentFrameL, commentFrameB, commentFrameW, commentFrameH];


commentTextL = commentFrameL + border;
commentTextB = commentFrameB + 0.2* border;
commentTextW = commentFrameW - 4* border;
commentTextH = 0.8* commentFrameH;
uipos.commentText = [commentTextL, commentTextB, commentTextW, commentTextH];

