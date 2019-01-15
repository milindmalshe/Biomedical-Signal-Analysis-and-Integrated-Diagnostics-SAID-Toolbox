% % % % % ????? IN THE FINAL VERSIONJ UNDER elseif strcmp(cmd,lower('MultiLayerNetwork'))
% COMMENT select_data = load('ekg_fifthTest.mat');, WHICH IS USED TO PASS
% MORE PATIENTS TO Multilayer Network GUI

function PatternRecognition(cmd,arg1,arg2)

% 
% PatternRecognition: Classify EKG signals using self-organizing feature map and multi-layer neural networks
% 
% Syntax
%     PatternRecognition()
% 
% 
% Description
%     


% Milind Malshe





% DEFAULTS
if nargin == 0,
    cmd = '';
else
    cmd = lower(cmd);
end

% FIND WINDOW IF IT EXISTS
fig = 0;

% We alow the program to see hidden handles
fig=findall(0,'type','figure','tag','PatternRecognition');
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
        PatternRecognition('init')
    end

    %==================================================================
    % Close the window.
    %
    % ME() or ME('')
    %==================================================================

elseif strcmp(cmd,'close') & (fig)
    if exist(cat(2,tempdir,'PatternRecognitiondata.mat'))
        delete(cat(2,tempdir,'PatternRecognitiondata.mat'));
    end
    delete(fig);
    
    
elseif strcmp(cmd,lower('MultiLayerNetwork'))      
    
    data = get(H.frame1,'Userdata');
    
    select_Patients = get(H.patients_listBox,'Value');
    select_features = get(H.feature_listBox,'Value');
    

    num_select_Patients = size(select_Patients,2);
    num_select_features = size(select_features,2);
    
    
    All_Patients_Name = get(H.patients_listBox,'String');
    for i = 1:num_select_Patients
        select_Patients_Name{i,1} = All_Patients_Name{select_Patients(i)};
    end
    
    
    All_features_Name = get(H.feature_listBox,'String');
    for i = 1:num_select_features
        select_features_Name{i,1} = All_features_Name{select_features(i)};
    end
    
    
    
    
    
    
    if( (num_select_Patients <= 1) | (num_select_features <= 1))
        errordlg('Select atleast 2 features and 2 records for training','Error');
        return
    end
    
    for i = 1:num_select_Patients
        for j = 1:num_select_features
            
            select_data.p(j,i) = data.p(select_features(j),select_Patients(i));
                        
        end
        select_data.t(1,i) = data.t(select_Patients(i));
    end
    
    
    select_data.Patients_Name = select_Patients_Name;
    select_data.features_Name = select_features_Name;
    
    % % %Call "MultiLayerNetwork" and pass selected data, so that NN
    % parameters can be initialized
    MultiLayerNetwork('',select_data);

    
    
    
    
elseif strcmp(cmd,lower('FeatureMap'))
    
    data = get(H.frame1,'Userdata');
    
    select_features = get(H.feature_listBox,'Value');
    select_Patients = get(H.patients_listBox,'Value');

    num_select_Patients = size(select_Patients,2);
    num_select_features = size(select_features,2);
    
    
    if( (num_select_Patients <= 1) | (num_select_features <= 1))
        errordlg('Selecte atleast 2 features and 2 records for training','Error');
        return
    end


    for i = 1:num_select_Patients
        for j = 1:num_select_features
            
            select_data.p(j,i) = data.p(select_features(j),select_Patients(i));
                        
        end
        select_data.t(1,i) = data.t(select_Patients(i));
    end
    
   
    % % %Call "FeatureMap" and pass selected data
    FeatureMap('',select_data);
    
    
    
    
    
    
    
    
    
    
    
    
elseif strcmp(cmd,lower('have_file'))
    signal_arch = get(H.feature_listBox,'Userdata');
        if isempty(signal_arch)   
             
            
            set(H.scatterPlot_button,'enable','on');  
            set(H.linePlot_button,'enable','on');
            
            set(H.multiLayerNet_button,'enable','on');
            set(H.featureMap_button,'enable','on');



            set(H.feature_listBox,'String',arg1.name);            
            
            set(H.feature_listBox,'Userdata',arg1.value);
            
            
            set(H.patients_listBox,'String',arg1.Patient.name,'Userdata',arg1.value);
            
            set(H.feature_listBox,'Value',[1:size(arg1.value,1)]);
            set(H.patients_listBox,'Value',[1:size(arg1.value,2)]);

        else
            % % If data already exists from previous import, then display a
            % message informing the user whether to overwrite existing data
            
            switch questdlg(...
                    {'Importing new feature data will overwrite previously imported data'
                    ' '
                    'Do you want to continue?'},...
                    'Confirm overwrite existing data','Yes','No','No');

                case 'Yes'
                    overwriteOK = 1;
                case 'No'
                    overwriteOK = 0;
            end % switch questdlg
        
            
            if(overwriteOK == 1)
                set(H.scatterPlot_button,'enable','on');
                set(H.linePlot_button,'enable','on');

                set(H.multiLayerNet_button,'enable','on');
                set(H.featureMap_button,'enable','on');

                set(H.feature_listBox,'String',arg1.name);
                set(H.feature_listBox,'Userdata',arg1.value);
                
                set(H.patients_listBox,'String',arg1.Patient.name,'Userdata',arg1.value);

                set(H.feature_listBox,'Value',[1:size(arg1.value,1)]);
                set(H.patients_listBox,'Value',[1:size(arg1.value,2)]);
            end
        end
        
        
        % % % % %***** FOLLOWING CODE GENERATES A STRUCTURE "data" WITH 2
        % FIELDS, "p" CONTAINING INPUT VECOTR TO THE NEURAL NETWORK, AND
        % "t" CONTAINING OUTPUT VECTOR TO THE NEURAL NETWORK
        % % % % %***** THE SIZE OF THE OUTPUT VECTOR WILL HAVE TO BE
        % CHANGED IF THERE ARE MORE THAN 2 CLASSES.
        data.p = arg1.value;
        for i = 1:size(arg1.diagnosis,2)
            if(strcmp(lower(arg1.diagnosis{i}),'healthy control'))
                data.t(i) = [1];
            elseif(strcmp(lower(arg1.diagnosis{i}),'myocardial infarction'))
                data.t(i) = [-1];

            end
        end

        % Hagan added the next two lines
        data.patientname = arg1.Patient.name;
        data.featurename = arg1.name;
        %
        set(H.frame1,'Userdata',data);
        
        set(H.commentText,'String','Select/ Deselect Features and Patients For Plotting and Training.  Only Selected Data Will Be Used For Training');
        
% %     ===========================


elseif strcmpi(cmd,'scatter') 

    data = get(H.frame1,'Userdata');
    
    select_features = get(H.feature_listBox,'Value');
    select_Patients = get(H.patients_listBox,'Value');

    num_select_Patients = size(select_Patients,2);
    num_select_features = size(select_features,2);
    
    if num_select_Patients~=0,
      names = data.patientname(select_Patients);
      p = data.p(:,select_Patients);
      scatterplot(p,names);
    end

    if num_select_features~=0,
      names = data.featurename(select_features);
      p = data.p(select_features,:);
      scatterplot(p',names);
    end
    
 elseif strcmpi(cmd,'line') 

    data = get(H.frame1,'Userdata');
    
    select_features = get(H.feature_listBox,'Value');
    select_Patients = get(H.patients_listBox,'Value');

    num_select_Patients = size(select_Patients,2);
    num_select_features = size(select_features,2);
    
    if num_select_Patients~=0,
      j = 1;
      
      p = data.p(:,select_Patients);
      
      for i=select_Patients,
        info{j}.Lead = data.patientname{i};
                
        pp{j} = p(:,j);
        info{j}.fs = 1;
        
        j = j+1;
      end

      SAIDplot(pp,[],info,'Feature Index','Feature vs Feature Index for Selected Patients');
      
%       a{i} = [c{m(i)}'];
    end

    if num_select_features~=0,
      j = 1;
      p = data.p(select_features,:);
      
      for i=select_features,
        info{j}.Lead = data.featurename{i};
                
        pp2{j} = p(j,:);
        info{j}.fs = 1;
        
        j = j+1;
      end
      
      
      SAIDplot(pp2,[],info,'Patient Index','Feature Value vs Patient Index for Selected Features');
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

    H.me='PatternRecognition';

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
        'Tag','PatternRecognition', ...
        'Resize','off', ...
        'ToolBar','none');


    H.frame1 = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ListboxTop',0, ...
        'Position',uipos.frame1, ...
        'Style','frame', ...
        'Tag','Frame4');

    H.text1 = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.text1, ...
        'String','Pattern Recognition/Clustering', ...
        'FontSize', 14,...
        'Style','text', ...
        'Tag','StaticText1');

    H.feature_listBox = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[1 1 1], ...
        'Position',uipos.feature_listBox, ...
        'Style','Listbox', ...
        'Tag','feature_listBox', ...
        'ToolTipStr','', ...
        'Max',10000000000, ...
        'Value',1);
    
    
    
    H.patients_listBox = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[1 1 1], ...
        'Position',uipos.patients_listBox, ...
        'Style','Listbox', ...
        'Tag','patients_listBox', ...
        'ToolTipStr','', ...
        'Max',10000000000, ...
        'Value',1);
    



    H.import_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','SAIDutil(''SAIDimport'',''init'','''','''',''Import Pattern Data'');', ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position',uipos.import_button, ...
        'String','Import', ...
        'ToolTipStr','Import EKG features for pattern recognition',...
        'Tag','Pushbutton1');


%     load('Features.mat');  %%%%%MILIND MALSHE
    %     H.import_button = uicontrol('Parent',fig, ...
    %         'Units',H.StdUnit, ...
    %         'Callback','', ...
    %         'Enable','on', ...
    %         'ListboxTop',0, ...
    %         'Position',uipos.import_button, ...
    %         'String','Import', ...
    %         'ToolTipStr','Import EKG features for neural network training',...
    %         'Tag','Pushbutton1');

    
    H.scatterPlot_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','PatternRecognition(''Scatter'')', ...
        'Enable','off', ...
        'ListboxTop',0, ...
        'Position',uipos.scatterPlot_button, ...
        'String','Scatter Plot', ...
        'ToolTipStr','Scatter plot',...
        'Tag','Pushbutton1');
    
    
    
    H.linePlot_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','PatternRecognition(''Line'')', ...
        'Enable','off', ...
        'ListboxTop',0, ...
        'Position',uipos.linePlot_button, ...
        'String','Line Plot', ...
        'ToolTipStr','Line plot',...
        'Tag','Pushbutton1');
    
    
    H.featureMap_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','PatternRecognition(''FeatureMap'')', ...
        'Enable','off', ...
        'ListboxTop',0, ...
        'Position',uipos.featureMap_button, ...
        'String','Feature Map', ...
        'ToolTipStr','Design a Self Organizing Feature Map',...
        'Tag','Pushbutton1');


    
    
     H.multiLayerNet_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','PatternRecognition(''MultiLayerNetwork'')', ...
        'Enable','off', ...
        'ListboxTop',0, ...
        'Position',uipos.multiLayerNet_button, ...
        'String','Multi-Layer Network', ...
        'ToolTipStr','Design a Multilayer Neural Network',...
        'Tag','Pushbutton1');

    

    
    H.PCA_checkBox = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Callback','SAIDutil(''SAIDtool'',''PCA_checkBox'')', ...
        'Enable','off', ...
        'ListboxTop',0, ...
        'Position',uipos.PCA_checkBox, ...
        'String','Principal Components', ...
        'Style','checkbox', ...
        'Tag','PCA_checkbox', ...
        'ToolTipStr','Compute Principal Components',...
        'Value',0);



    
     
    H.textFeature = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.textFeature, ...
        'String','Features', ...
        'Style','text', ...
        'Tag','StaticText1');
    
    
    
    
       
    
    H.textPatients = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.textPatients, ...
        'String','Patients', ...
        'Style','text', ...
        'Tag','StaticText1');
    
    
    
       
    H.commentFrame = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ListboxTop',0, ...
        'Position',uipos.commentFrame, ...
        'Style','frame', ...
        'Tag','commentFrame');
    
    


    H.commentText = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.commentText, ...
        'String','Import feature data to get started', ...
        'ForegroundColor',[0 0 1], ...
        'FontWeight','bold', ...
        'Style','text', ...
        'Tag','StaticText1');

    
    
    H.close_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','SAIDutil(''PatternRecognition'',''close'')', ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position',uipos.close_button, ...
        'String','Close', ...
        'ToolTipStr','Exit the pattern recognition/clustering module and return to the SAID tool',...
        'Tag','Pushbutton1');
    
    
    
    
    

    set(fig,'userdata',H);
    
        
end
% % % % ----------------------------


function uipos = getuipos

border = 1.2;

button_gapW = 3;
button_gapH = 1;

mode_buttonW = 22;
mode_buttonH = 1.6;

action_buttonW = 18;
action_buttonH = 1.6;

listBoxW = 55;
listBoxH = 25;

textListBoxH = 1;
textListBoxW = 20;


checkBoxW = 28;
checkBoxH = 2;


commentTextH = 2.0;

text1H = 3;



figW = 2*border + listBoxW + 2*button_gapW + mode_buttonW + 2*button_gapW + listBoxW + 2*border;
% figH = 2*border + 1*button_gapH + mode_buttonH + 1*button_gapH + 1*button_gapH + text1H + 2*border;
figH = 2*border + 1*button_gapH + mode_buttonH + 2*button_gapH + listBoxH + 0*button_gapH + text1H + commentTextH + 2*border;

frame1W = figW - 2*border;
% frame1H = figH - 2*border  - 3*border - commentTextH;
frame1H = 1*button_gapH + listBoxH + 1*button_gapH;
% frame1H = figH - 2*border - text1H;

text1W = frame1W - 60*border; % figW - 6*border;
% text1H = frame1H - 1*border;

commentTextW = figW - 8*border;

% figW = 200;
% figH = 50;

sunits = get(0, 'Units');
set (0, 'Units', 'character');
ssinchar = get(0, 'ScreenSize');
set (0, 'Units', sunits);


figL = (ssinchar(3) - figW) / 2;
figB = (ssinchar(4) - figH) / 2;


uipos.fig = [figL,figB,figW,figH];


frame1L = border;
frame1B = border + 1*button_gapH + mode_buttonH + button_gapH + button_gapH + commentTextH ;
uipos.frame1 = [frame1L, frame1B, frame1W, frame1H];

% text1L = 4*border;
% text1B = (figH/2) + button_gapH + 0*button_gapH;

% text1L = (frame1L + frame1W)/2 - text1W/2;
text1L = figW/2 - text1W/2;
% text1B = frame1B + frame1H - 0.8*text1H;  %*****  Actually it should be 1*text1H, but for some reason the textbox looks slightly shifeted down relative to the frame, so 0.8*text1H was used which places the frame1 aprroximately in the center of the text box because it looks good
text1B = figH - 1*border - text1H + 0* commentTextH/2;

% text1B = frame1H + button_gapH;
uipos.text1 =  [text1L, text1B, text1W, text1H];


% feature_listBoxL = (figW/2) - button_gapW/2 - (mode_buttonW);
% feature_listBoxB = (figH/2) - (mode_buttonH/2);
feature_listBoxL = 2*border;
feature_listBoxB = 2*border + 1*button_gapH + mode_buttonH + 2*button_gapH + commentTextH ;
uipos.feature_listBox = [feature_listBoxL, feature_listBoxB, listBoxW, listBoxH ];



patients_listBoxL = 2*border + listBoxW + 2*button_gapW + mode_buttonW + 2*button_gapW;
patients_listBoxB = 2*border + 1*button_gapH + mode_buttonH + 2*button_gapH + commentTextH ;
uipos.patients_listBox = [patients_listBoxL, patients_listBoxB, listBoxW, listBoxH];





import_buttonL = 2*border + listBoxW + 2*button_gapW;
import_buttonB = feature_listBoxB + listBoxH/2 + 2*button_gapH + 2*mode_buttonH + commentTextH ;
uipos.import_button = [import_buttonL, import_buttonB, mode_buttonW, mode_buttonH ];


scatterPlot_buttonL = 2*border + listBoxW + 2*button_gapW;
scatterPlot_buttonB = feature_listBoxB + listBoxH/2 - 1*button_gapH - 1*mode_buttonH + commentTextH ;
uipos.scatterPlot_button = [scatterPlot_buttonL, scatterPlot_buttonB, mode_buttonW, mode_buttonH ];



linePlot_buttonL = 2*border + listBoxW + 2*button_gapW;
linePlot_buttonB = feature_listBoxB + listBoxH/2 - 1*button_gapH - button_gapH - 2*mode_buttonH + commentTextH ;
uipos.linePlot_button = [linePlot_buttonL, linePlot_buttonB, mode_buttonW, mode_buttonH ];



featureMap_buttonL = figW/2 - button_gapW/2 - mode_buttonW;
featureMap_buttonB = 2*border + 1*button_gapH + commentTextH ;
uipos.featureMap_button = [featureMap_buttonL, featureMap_buttonB, mode_buttonW, mode_buttonH ];


multiLayerNet_buttonL = figW/2 + button_gapW/2;
multiLayerNet_buttonB = 2*border + 1*button_gapH + commentTextH ;
uipos.multiLayerNet_button = [multiLayerNet_buttonL, multiLayerNet_buttonB, mode_buttonW, mode_buttonH ];




PCA_checkBoxL = figW/2  - button_gapW/2 - mode_buttonW/2;
PCA_checkBoxB = 2*border + 1*button_gapH  + mode_buttonH + 2*button_gapH + commentTextH ;
uipos.PCA_checkBox = [PCA_checkBoxL, PCA_checkBoxB, checkBoxW, checkBoxH ];




% textListBoxW = 20;
% textListBoxH = 1;
textFeatureL = feature_listBoxL + listBoxW/2 - textListBoxW/2;
textFeatureB = frame1B + frame1H - textListBoxH/2;
uipos.textFeature = [textFeatureL, textFeatureB, textListBoxW, textListBoxH];



% textListBoxW = 20;
% textListBoxH = 1;
textPatientsL = patients_listBoxL + listBoxW/2 - textListBoxW/2;
textPatientsB = frame1B + frame1H - textListBoxH/2;
uipos.textPatients = [textPatientsL, textPatientsB, textListBoxW, textListBoxH];


% close_buttonL = (figW/2) + button_gapW/2 + mode_buttonW - action_buttonW;
% close_buttonB = (figH/2) - (mode_buttonH/2) - 2*button_gapH - action_buttonH;
close_buttonL = figW - 2*border - action_buttonW;
close_buttonB = 2*border + 1*button_gapH + commentTextH ;
uipos.close_button = [close_buttonL, close_buttonB, action_buttonW, action_buttonH ];



commentTextL = 3*border;
commentTextB = border + border/2;
uipos.commentText = [commentTextL, commentTextB, commentTextW, commentTextH];


commentFrameL = border;
commentFrameB = border;
commentFrameW = frame1W;
commentFrameH = commentTextH + commentTextH/2;
uipos.commentFrame = [commentFrameL, commentFrameB, commentFrameW, commentFrameH]; 

