
function MisclassifiedPatient(cmd,ind,Patients_Name,p,mi)

%
% MisclassifiedPatient: Display a list of misclassified patients and their
% corresponding neighbors and relative distance from neighboring data
% points (Patients)
%
% Syntax
%     MisclassifiedPatient function is not called independently but is
%     called from MultilayerNetwork window, which passes misclassification
%     matrix after training
%
%
% Description
%


% Milind Malshe




% DEFAULTS
if nargin == 0,
    cmd = '';
    ind = '';
else
    cmd = lower(cmd);
end

% FIND WINDOW IF IT EXISTS
fig = 0;

% We alow the program to see hidden handles
fig=findall(0,'type','figure','tag','MisclassifiedPatient');
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
        MisclassifiedPatient('init',ind);
    end

    %==================================================================
    % Close the window.
    %
    % ME() or ME('')
    %==================================================================

elseif strcmp(cmd,'close') & (fig)
    if exist(cat(2,tempdir,'MisclassifiedPatient.mat'))
        delete(cat(2,tempdir,'MisclassifiedPatient.mat'));
    end
    delete(fig);




    
    
    
    
elseif strcmp(cmd,lower('thresholdMiscalssPercent')) & (fig)
    misclassPerc = str2num(H.thresholdMisclassPercent_popUp_String(get(H.thresholdMisclassPercent_popUp,'Value'),:));
    misclassPerc = misclassPerc/100;
    
    
    %     select_misClassPatient = get(H.misclassPatient_listBox,'Value');
    %     [ind] = findMisclass(size(H.data.p,2),H.data.mi(select_misClassPatient),misclassPerc)
    
    [ind] = findMisclass(size(H.data.p,2),H.data.mi,misclassPerc);
    
    %     data.ind = ind;
    
    num_misClass = size(ind,2);

    
    if (num_misClass ~= 0)
        %         set(H.misclassPatient_listBox,'String',misClassPatient);
        %         data.misclassPatient = misClassPatient;
        for i = 1:num_misClass
            misClassPatient{i} = H.data.Patients_Name{ind(i)};
        end
        set(H.misclassPatient_listBox,'String',misClassPatient);


        
        % Find the five neighbors of the most misclassified healthy patient

        %%%%%MILIND ********** 11_02_07
        %%%%% if the number training data points is less than 5, then it finds
        %%%%% nearest neighbors from the entire data set which would be less than 5.

        %     num_FindNeighbors = 5;
        num_FindNeighbors = min( (size(H.data.p,2)-1), 5);

        %%%%%MALSHE ********** 11_02_07


        [ind2,rel_dis] = findNeighbors(H.data.p,H.data.ind(1),num_FindNeighbors);

        numNeighbors = size(ind2,1);

        for i = 1:numNeighbors
            neighborsDist{i} = sprintf('%s%s%s%90s','',H.data.Patients_Name{ind2(i)},...
                '', ...
                num2str(rel_dis(i)));
        end


        set(H.nearestNeighborDist_listBox,'String',neighborsDist);
        
        set(H.thresholdMisclassPercent_popUp,'Userdata',(misclassPerc*100));
    else
        warndlg('There are no misclassified patients at the selected threshold');
        
        temp = get(H.thresholdMisclassPercent_popUp,'Userdata');
        am = find((str2num(H.thresholdMisclassPercent_popUp_String) == temp));
        
        set(H.thresholdMisclassPercent_popUp,'Value',am);
%         MultiLayerNetwork();
%         MisclassrifiedPatient('close');
        return;
    end
    
    
    
    
    
    
    %======= End of updating Miscalssified Patients listBox using Threshold Misclassification Percentage =======
    
    
    
    
elseif strcmp(cmd,lower('misclassPatient_listBox')) & (fig)
    
    select_misclassPatient = get(H.misclassPatient_listBox,'Value');
    
     % Find the five neighbors of the most misclassified healthy patient
     
     %%%%%MILIND ********** 11_02_07
     %%%%% if the number training data points is less than 5, then it finds
     %%%%% nearest neighbors from the entire data set which would be less than 5.

     %     num_FindNeighbors = 5;
     num_FindNeighbors = min( (size(H.data.p,2)-1), 5);

     %%%%%MALSHE ********** 11_02_07
    

    [ind2,rel_dis] = findNeighbors(H.data.p,H.data.ind(select_misclassPatient),num_FindNeighbors);
    
    numNeighbors = size(ind2,1);
    
    for i = 1:numNeighbors
       neighborsDist{i} = sprintf('%s%s%s%70s','',H.data.Patients_Name{ind2(i)},...
           '', ...
                                                    num2str(rel_dis(i)));
    end
    
    
    set(H.nearestNeighborDist_listBox,'String',neighborsDist);
    
    
    
    
    
    
elseif strcmp(cmd,lower('display_feature')) & (fig)
    fig_data = get(fig,'Userdata');
    
    features = fig_data.data.p;
    
    select_misclassPatientName = fig_data.data.misclassPatient;
    
    select_misclassPatient = select_misclassPatientName{get(H.misclassPatient_listBox,'Value')};
    
    select_misclassPatientName_NeighborName = get(H.nearestNeighborDist_listBox,'String');
    select_nearestNeighborDist = select_misclassPatientName_NeighborName{get(H.nearestNeighborDist_listBox,'Value')};

    space = strfind(select_nearestNeighborDist,' ')
    select_nearestNeighbor = select_nearestNeighborDist(1:space-1);
    %     select_features = get(H.feature_listBox,'Value');
  
    num_select_features = size(features,2);
    
    num_select_Patients = 2;
    
    selectPatients = {select_misclassPatient,select_nearestNeighbor};
    
    
    
    if num_select_Patients~=0,
              j = 1;
            for i = 1:size(selectPatients,2)
                pp{i} = fig_data.data.p(:,find(strcmp((fig_data.data.Patients_Name),(selectPatients{i}))));
                info{j}.Lead = selectPatients{i};
                info{j}.fs = 1;
                j = j+1;
            end
     
      
      SAIDplot(pp,[],info,'Feature Index Number','Features for Selected Patients');
      %       SAIDplot(p',[]);
    end
    
    
    
    
    

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

    H.me='MisclassifiedPatient';

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
        'Tag','MisclassifiedPatient', ...
        'Resize','off', ...
        'ToolBar','none');

    H.text1 = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.text1, ...
        'String','Misclassified Patients', ...
        'FontSize', 14,...
        'Style','text', ...
        'Tag','text1');




    H.frameMisclassPatient = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ListboxTop',0, ...
        'Position',uipos.frameMisclassPatient, ...
        'Style','frame', ...
        'Tag','frameMisclassPatient');






    H.frameNearestNeighborDist = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ListboxTop',0, ...
        'Position',uipos.frameNearestNeighborDist, ...
        'Style','frame', ...
        'Tag','frameNearestNeighborDist');

    
    
    
    
    
    
    H.misclassPatient_listBox = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','MisclassifiedPatient(''misclassPatient_listBox'')', ...
        'BackgroundColor',[1 1 1], ...
        'Position',uipos.misclassPatient_listBox, ...
        'Style','Listbox', ...
        'Tag','misclassPatient_listBox', ...
        'ToolTipStr','Misclassified patients: sorted in descending order, with the patient being mislassified the most number of times on top', ...
        'Max',1, ...
        'Value',1);




    H.nearestNeighborDist_listBox = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[1 1 1], ...
        'Position',uipos.nearestNeighborDist_listBox, ...
        'Style','Listbox', ...
        'Tag','nearestNeighborDist_listBox', ...
        'ToolTipStr','Patients with input features close to the selected misclassified patient', ...
        'Max',1, ...
        'Value',1);



    
    


    H.textMisclassPatient = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.textMisclassPatient, ...
        'String','Misclassified Patients', ...
        'Style','text', ...
        'Tag','textMisclassPatient');
    




    H.textNearestNeighbor = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.textNearestNeighbor, ...
        'String','Nearest Neighbors', ...
        'Style','text', ...
        'Tag','textNearestNeighbor');




    H.textDist = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.textDist, ...
        'String','Relative Distance', ...
        'Style','text', ...
        'Tag','textDist');


    
    
    

%     H.dist_listBox = uicontrol('Parent',fig, ...
%         'Units',H.StdUnit, ...
%         'BackgroundColor',[1 1 1], ...
%         'Position',uipos.dist_listBox, ...
%         'Style','Listbox', ...
%         'Tag','dist_listBox', ...
%         'ToolTipStr','', ...
%         'Max',1, ...
%         'Value',1);


    
    
    
    
    
    
    
    
        H.textThresholdMisclassPercent_popUp = uicontrol('Parent',fig, ...
            'Units',H.StdUnit, ...
            'BackgroundColor',[0.8 0.8 0.8], ...
            'Enable',window_en, ...
            'ListboxTop',0, ...
            'Position',uipos.textThresholdMisclassPercent_popUp, ...
            'String','Threshold Misclassification Percentage', ...
            'Style','text', ...
            'Tag','textThresholdMisclassPercent_popUp');



        



        H.thresholdMisclassPercent_popUp_String = [' 5';'10';'20';'30';'40';'50';'60';'70';'80';'90'];
        H.thresholdMisclassPercent_popUp = uicontrol('Parent',fig, ...
            'Units',H.StdUnit, ...
            'Callback','MisclassifiedPatient(''thresholdMiscalssPercent'')', ...
            'BackgroundColor',[1 1 1], ...
            'Enable',window_en, ...
            'ListboxTop',0, ...
            'Position',uipos.thresholdMisclassPercent_popUp, ...
            'Max',1, ...
            'String',H.thresholdMisclassPercent_popUp_String, ...
            'Style','popupmenu', ...
            'ToolTipStr','Set a threshold percentage for misclassified patients', ...
            'Tag','thresholdMisclassPercent_popUp', ...
            'Value',1, ...
            'Userdata',5);
        
        
        
        
        
    
    %     H.textDisplay = uicontrol('Parent',fig, ...
    %         'Units',H.StdUnit, ...
    %         'BackgroundColor',[0.8 0.8 0.8], ...
    %         'Enable',window_en, ...
    %         'ListboxTop',0, ...
    %         'Position',uipos.textDisplay, ...
    %         'String','Display/Analysis', ...
    %         'Style','text', ...
    %         'Tag','textDisplay');
    %
    %
    %
    %
    %     H.inputSens_button = uicontrol('Parent',fig, ...
    %         'Units',H.StdUnit, ...
    %         'Callback','SAIDutil(''MultiLayerNetwork'',''inputSens'')', ...
    %         'Enable','off', ...
    %         'ListboxTop',0, ...
    %         'Position',uipos.inputSens_button, ...
    %         'String','Input Sensitivity', ...
    %         'ToolTipStr','Display the sesitivity of the target for each  of the input variable',...
    %         'Tag','close_button');
    %


    
    





%     H.commentFrame = uicontrol('Parent',fig, ...
%         'Units',H.StdUnit, ...
%         'BackgroundColor',[0.8 0.8 0.8], ...
%         'ListboxTop',0, ...
%         'Position',uipos.commentFrame, ...
%         'Style','frame', ...
%         'Tag','commentFrame');
% 
% 
% 
%     H.commentTextString = 'Set neural network training parameters';
%     H.commentText = uicontrol('Parent',fig, ...
%         'Units',H.StdUnit, ...
%         'BackgroundColor',[0.8 0.8 0.8], ...
%         'Enable',window_en, ...
%         'ListboxTop',0, ...
%         'Position',uipos.commentText, ...
%         'String',H.commentTextString, ...
%         'FontWeight','bold', ...
%         'ForegroundColor',[0 0 1], ...
%         'Style','text', ...
%         'Tag','StaticText1');

    
    

    H.close_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','MisclassifiedPatient(''Close'')', ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position',uipos.close_button, ...
        'String','Close', ...
        'ToolTipStr','Exit Misclassified Patients window and return to Multilayer Network',...
        'Tag','close_button');
    



    H.display_EKGsignal_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','', ...
        'Enable','off', ...
        'ListboxTop',0, ...
        'Position',uipos.display_EKGsignal_button, ...
        'String','Display EKG signal', ...
        'ToolTipStr','Display EKG signal',...
        'Tag','display_EKGsignal_button');

    
    
    
    
    
    H.display_feature_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','MisclassifiedPatient(''display_feature'')', ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position',uipos.display_feature_button, ...
        'String','Display features', ...
        'ToolTipStr','Display features: Select 1 misclassified patient and 1 patient from its nearest neighbors with input features close to it',...
        'Tag','display_feature_button');
    
    
    
    
    
    data.ind = ind;
    data.Patients_Name = Patients_Name;
    data.p = p;
    data.mi = mi;
    
    
    
    num_misClass = size(data.ind,2);
    for i = 1:num_misClass
       misClassPatient{i} = data.Patients_Name{data.ind(i)}; 
    end
    
    if (num_misClass ~= 0)
        set(H.misclassPatient_listBox,'String',misClassPatient);
        data.misclassPatient = misClassPatient;
    else
        warndlg('There are no misclassified patients');
        MultiLayerNetwork();
        MisclassifiedPatient('close');
        return;
    end
    
    
    
    
    
    % Find the five neighbors of the most misclassified healthy patient

    %%%%%MILIND ********** 11_02_07
    %%%%% if the number training data points is less than 5, then it finds
    %%%%% nearest neighbors from the entire data set which would be less than 5.

    %     num_FindNeighbors = 5;
    num_FindNeighbors = min( (size(data.p,2)-1), 5);
    
    %%%%%MALSHE ********** 11_02_07
    
    [ind2,rel_dis] = findNeighbors(data.p,data.ind(1),num_FindNeighbors);
    
    numNeighbors = size(ind2,1);
    
    for i = 1:numNeighbors
       neighborsDist{i} = sprintf('%s%s%s%70s','',data.Patients_Name{ind2(i)},...
           '', ...
                                                    num2str(rel_dis(i)));
    end
    
    
    set(H.nearestNeighborDist_listBox,'String',neighborsDist);
    
    H.data = data;  %%%%%MILIND MALSHE
    
    set(fig,'userdata',H);
    
end

% %=========== End of MisclassifiedPatient =============





function uipos = getuipos

border = 1.2;

button_gapW = 3;
button_gapH = 1;

mode_buttonW = 22;
mode_buttonH = 1.6;

action_buttonW = 18;
action_buttonH = 1.6;

textRadioButtonNameW = 45;
textRadioButtonW = 10;
textRadioButtonH = 1.4;

textListBoxW = 22;
textListBoxH = 1.2;

listBoxW = 55;
listBoxH = 25;


popUpMenuW = 14;
popUpMenuH = 1;

commentTextH = 2.0;

text1H = 2;

% gapBetween2Frames = button_gapW/2;


figW = 2*border + listBoxW + 2*border + border + listBoxW + 0.5*listBoxW + 2*border ; 
figH = 2*border + mode_buttonH + 2*border + action_buttonH + listBoxH + textListBoxH + 2*border + popUpMenuH + 1*border + text1H + 2*border;



sunits = get(0, 'Units');
set (0, 'Units', 'character');
ssinchar = get(0, 'ScreenSize');
set (0, 'Units', sunits);


figL = (ssinchar(3) - figW) / 2;
figB = (ssinchar(4) - figH) / 2;

uipos.fig = [figL, figB, figW, figH];





text1W = figW - 20*border;
text1L = figW/2 - text1W/2;
text1B = figH - 2*border - text1H + 1* commentTextH/2;
uipos.text1 = [text1L, text1B, text1W, text1H];



frameMisclassPatientL = border;
frameMisclassPatientB = 1*border + mode_buttonH  + action_buttonH + 2*border;
frameMisclassPatientW = listBoxW + 2*border;
frameMisclassPatientH = listBoxH + 2*border;
uipos.frameMisclassPatient = [frameMisclassPatientL,frameMisclassPatientB,frameMisclassPatientW,frameMisclassPatientH];



frameNearestNeighborDistL = frameMisclassPatientL + frameMisclassPatientW + border;
frameNearestNeighborDistB = frameMisclassPatientB;
frameNearestNeighborDistW = 1.5*listBoxW + 2*border;
frameNearestNeighborDistH = listBoxH + 2*border;
uipos.frameNearestNeighborDist = [frameNearestNeighborDistL,frameNearestNeighborDistB,frameNearestNeighborDistW,frameNearestNeighborDistH];







misclassPatient_listBoxL = frameMisclassPatientL + border;
misclassPatient_listBoxB = frameMisclassPatientB + border/2;
uipos.misclassPatient_listBox = [misclassPatient_listBoxL,misclassPatient_listBoxB,listBoxW,(listBoxH+border)];




nearestNeighborDist_listBoxL = frameNearestNeighborDistL + border;
nearestNeighborDist_listBoxB = frameNearestNeighborDistB + border/2;
nearestNeighborDist_listBoxW = 1.5*listBoxW;
nearestNeighborDist_listBoxH = listBoxH + border;
uipos.nearestNeighborDist_listBox = [nearestNeighborDist_listBoxL,nearestNeighborDist_listBoxB,nearestNeighborDist_listBoxW,nearestNeighborDist_listBoxH];



% dist_listBoxL = nearestNeighbor_listBoxL + listBoxW;
% dist_listBoxB = nearestNeighbor_listBoxB;
% uipos.dist_listBox = [dist_listBoxL,dist_listBoxB,listBoxW,(listBoxH+border)];





textMisclassPatientL = misclassPatient_listBoxL + listBoxW/2 - textListBoxW/2;
textMisclassPatientB = frameMisclassPatientB + frameMisclassPatientH - textListBoxH/2;
uipos.textMisclassPatient = [textMisclassPatientL, textMisclassPatientB, textListBoxW, textListBoxH];


textNearestNeighborL = nearestNeighborDist_listBoxL + listBoxW/2 - textListBoxW;
textNearestNeighborB = frameNearestNeighborDistB + frameNearestNeighborDistH - textListBoxH/2;
uipos.textNearestNeighbor = [textNearestNeighborL,textNearestNeighborB,textListBoxW, textListBoxH];


textDistL = nearestNeighborDist_listBoxL + listBoxW ;
textDistB = frameNearestNeighborDistB + frameNearestNeighborDistH - textListBoxH/2;
uipos.textDist = [textDistL,textDistB,textListBoxW, textListBoxH];



textThresholdMisclassPercent_popUpL = 40*border;
textThresholdMisclassPercent_popUpB = frameMisclassPatientB + frameMisclassPatientH + 2*border;
uipos.textThresholdMisclassPercent_popUp = [textThresholdMisclassPercent_popUpL,textThresholdMisclassPercent_popUpB,textRadioButtonNameW, textRadioButtonH];




thresholdMisclassPercent_popUpL = textThresholdMisclassPercent_popUpL + textRadioButtonNameW;
thresholdMisclassPercent_popUpB = textThresholdMisclassPercent_popUpB + popUpMenuH;
uipos.thresholdMisclassPercent_popUp = [thresholdMisclassPercent_popUpL,thresholdMisclassPercent_popUpB,popUpMenuW, popUpMenuH];



close_buttonL = figW - 2*border - action_buttonW;
close_buttonB = border;
uipos.close_button = [close_buttonL, close_buttonB, action_buttonW, action_buttonH ];




display_EKGsignal_buttonL = figW/2 - button_gapW/2 - mode_buttonW;
display_EKGsignal_buttonB = close_buttonB + action_buttonH + border;
uipos.display_EKGsignal_button = [display_EKGsignal_buttonL, display_EKGsignal_buttonB, mode_buttonW, mode_buttonH ];



display_feature_buttonL = figW/2 + button_gapW;
display_feature_buttonB = display_EKGsignal_buttonB;
uipos.display_feature_button = [display_feature_buttonL, display_feature_buttonB, mode_buttonW, mode_buttonH ];












commentFrameL = border;
commentFrameB = 0.8* border;
commentFrameW = display_EKGsignal_buttonL - border - button_gapW;
commentFrameH = 2;
uipos.commentFrame = [commentFrameL, commentFrameB, commentFrameW, commentFrameH];


commentTextL = commentFrameL + border;
commentTextB = commentFrameB + 0.2* border;
commentTextW = commentFrameW - 4* border;
commentTextH = 0.8* commentFrameH;
uipos.commentText = [commentTextL, commentTextB, commentTextW, commentTextH];











