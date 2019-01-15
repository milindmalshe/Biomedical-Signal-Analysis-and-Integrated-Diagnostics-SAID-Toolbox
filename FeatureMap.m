
function FeatureMap(cmd,data)

% 
% FeatureMap: Train a self-organizing feature map
% 
% Syntax
%     FeatureMap function is not called independently but is called from Pattern recognition/clustering window
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
fig=findall(0,'type','figure','tag','FeatureMap');
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
        FeatureMap('init',data)
    end

    %==================================================================
    % Close the window.
    %
    % ME() or ME('')
    %==================================================================

elseif strcmp(cmd,'close') & (fig)
    if exist(cat(2,tempdir,'FeatureMapdata.mat'))
        delete(cat(2,tempdir,'FeatureMapdata.mat'));
    end
    delete(fig);

    
    
    
    
    % % % % % % MILIND
    
elseif strcmp(cmd,lower('Train'))
    nRows = get(H.numRows_editBox,'String');
    nCols = get(H.numColumns_editBox,'String');

    nRows = str2num(nRows);
    nCols = str2num(nCols);
    
    [r,q]=size(H.data.p);
    p_TransSOM = H.data.p';  % The SOM toolbox expects the inputs in transposed form

    % Assign names for each feature
    names = cell(r,1);
    for i=1:r,
        names{i} = num2str(i);
    end

    % Label each patient as normal 'N', or infarct 'I'.
    ndata = length(H.data.t);
    label = cell(ndata,1);
    for i=1:ndata,
        if H.data.t(1,i)==1,
            label{i} = 'N';
        else
            label{i} = 'I';
        end
    end
    
    
    %  TRAIN
    %   Create the SOM object
    sEKG = som_data_struct(p_TransSOM,'name','EKG Simple',...
        'labels',label,'comp_names',names);
    % train the SOM
    sMap = som_make(sEKG,'msize',[nRows nCols]);
    sMap = som_autolabel(sMap,sEKG,'vote');

    
    
    set(H.Umatrix_button,'Enable','On');
    set(H.UmatrixHits_button,'Enable','On');
    set(H.labeledMap_button,'Enable','On');
    set(H.componentPlane_button,'Enable','On');
    
    set(H.frame1,'Userdata',sMap);
    
    % % % % %     ------end of Train
    
    
elseif(strcmp(cmd,lower('compPlane')))
    sMap = get(H.frame1,'Userdata');
    
    figure
    som_show(sMap);
    
    
    
elseif(strcmp(cmd,lower('labeledMap')))
    %LABELED MAP
    %    Now, the map can be labelled with the labels. The best
    %    matching unit of each sample is found from the map, and the
    %    species label is given to the map unit. Function SOM_AUTOLABEL
    %    can be used to do this:
    
    sMap = get(H.frame1,'Userdata');
    
    figure
    som_show(sMap,'umat','all','empty','Labels')
    som_show_add('label',sMap,'Textsize',8,'TextColor','r','Subplot',2)
    
    
elseif(strcmp(cmd,lower('Umatrix')))
    %U-MATRIX
    %    Show the U-matrix.
    %    High values on the U-matrix mean large distance between
    %    neighboring map units, and thus indicate cluster
    %    borders. Clusters are typically uniform areas of low
    %    values. Refer to colorbar to see which colors mean high
    %    values.
    
    sMap = get(H.frame1,'Userdata');

    figure
    som_show(sMap,'umat','all')
    
    
    
elseif(strcmp(cmd,lower('UmatrixHits')))
    %U-MATRIX WITH HITS
    
    sMap = get(H.frame1,'Userdata');
    
    
    % %----****
    [r,q]=size(H.data.p);
    p_TransSOM = H.data.p';  % The SOM toolbox expects the inputs in transposed form

    % Assign names for each feature
    names = cell(r,1);
    for i=1:r,
        names{i} = num2str(i);
    end

    % Label each patient as normal 'N', or infarct 'I'.
    ndata = length(H.data.t);
    label = cell(ndata,1);
    for i=1:ndata,
        if H.data.t(1,i)==1,
            label{i} = 'N';
        else
            label{i} = 'I';
        end
    end
    
    
    %  TRAIN
    %   Create the SOM object
    sEKG = som_data_struct(p_TransSOM,'name','EKG Simple',...
        'labels',label,'comp_names',names);
    % %----****
    
    h_healthy = find(H.data.t == 1);
    h_mi = find(H.data.t == -1);
    
    h1 = som_hits(sMap,sEKG.data(h_healthy,:));
    h2 = som_hits(sMap,sEKG.data(h_mi,:));

    figure
    som_show(sMap,'umat','all')
    som_show_add('hit',[h1, h2],'MarkerColor',[0 1 0; 1 0 0])
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

    H.me='FeatureMap';

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
        'Tag','FeatureMap', ...
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
        'String','Feature Map', ...
        'FontSize', 14,...
        'Style','text', ...
        'Tag','StaticText1');
    
    
    
     H.textDisplay = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.textDisplay, ...
        'String','Display', ...
        'Style','text', ...
        'Tag','StaticText1');
    
    
        H.Umatrix_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','FeatureMap(''Umatrix'')', ...
        'Enable','off', ...
        'ListboxTop',0, ...
        'Position',uipos.Umatrix_button, ...
        'String','U-Matrix', ...
        'ToolTipStr','Display U-matrix',...
        'Tag','Umatrix_button');
    
    
    
        H.UmatrixHits_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','FeatureMap(''UmatrixHits'')', ...
        'Enable','off', ...
        'ListboxTop',0, ...
        'Position',uipos.UmatrixHits_button, ...
        'String','U-Matrix with Hits', ...
        'ToolTipStr','Display U-matrix with hits',...
        'Tag','UmatrixHits_button');
    
    
    
        H.labeledMap_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','FeatureMap(''labeledMap'')', ...
        'Enable','off', ...
        'ListboxTop',0, ...
        'Position',uipos.labeledMap_button, ...
        'String','Labeled Map', ...
        'ToolTipStr','Display labeled map',...
        'Tag','labeledMap_button');
    

    
        H.componentPlane_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','FeatureMap(''compPlane'')', ...
        'Enable','off', ...
        'ListboxTop',0, ...
        'Position',uipos.componentPlane_button, ...
        'String','Component Plane', ...
        'ToolTipStr','Display component plane',...
        'Tag','componentPlane_button');
    
    
    
    
        H.train_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','FeatureMap(''Train'')', ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position',uipos.train_button, ...
        'String','Train', ...
        'ToolTipStr','Train feature map',...
        'Tag','train_button');
    
    
    
    
    H.textNumColumns = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.textNumColumns, ...
        'String','Number of columns', ...
        'HorizontalAlignment','Right', ...
        'Style','text', ...
        'Tag','textNumColumns');


    H.numColumns_editBox = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.numColumns_editBox, ...
        'String', '10', ...
        'Style','edit', ...
        'Callback','', ...
        'ToolTipStr','',...
        'Tag','numColumns_editBox');

    
    
    
    
    H.textNumRows = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.textNumRows, ...
        'String','Number of rows', ...
        'HorizontalAlignment','Right', ...
        'Style','text', ...
        'Tag','textNumRows');


    H.numRows_editBox = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.numRows_editBox, ...
        'String','10', ...
        'Style','edit', ...
        'Callback','', ...
        'ToolTipStr','',...
        'Tag','numRows_editBox');

    
    
    
        H.close_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','FeatureMap(''Close'')', ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position',uipos.close_button, ...
        'String','Close', ...
        'ToolTipStr','Exit feature map window and return to ''Pattern Recognition/Clustering'' module',...
        'Tag','close_button');




    H.data = data;  %%%%%MILIND MALSHE
%     H.p = data.p;
%     H.t = data.t;
    set(fig,'userdata',H);

    
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
listBoxH = 25;

textListBoxW = 15;
textListBoxH = 2;


textRadioButtonNameW = 25;
textRadioButtonW = 10;
textRadioButtonH = 1.4;


editBoxW = 10;
editBoxH = 1.6;

checkBoxW = 28;
checkBoxH = 2;


commentTextH = 2.0;

text1H = 3;



figW = 2*border + mode_buttonW + button_gapW + mode_buttonW + 2*border;
figH = 2*border + action_buttonH + 2*button_gapH + border + mode_buttonH + button_gapH + mode_buttonH + border + button_gapH + ...
        button_gapH + editBoxH + button_gapH + editBoxH + button_gapH + text1H + 2*border;

    
sunits = get(0, 'Units');
set (0, 'Units', 'character');
ssinchar = get(0, 'ScreenSize');
set (0, 'Units', sunits);


figL = (ssinchar(3) - figW) / 2;
figB = (ssinchar(4) - figH) / 2;


uipos.fig = [figL,figB,figW,figH];

frame1L = 1*border;
frame1B = 2*border + action_buttonH + 1*button_gapH; 

frame1W = figW - 2*border;
frame1H = 0*button_gapH + border + mode_buttonH + button_gapH + mode_buttonH + border ;
uipos.frame1 = [frame1L, frame1B, frame1W, frame1H];


text1W = frame1W - 10*border; 
text1L = figW/2 - text1W/2;
text1B = figH - 1*border - text1H + 0* commentTextH/2;
uipos.text1 =  [text1L, text1B, text1W, text1H];



textDisplayL = frame1L + frame1W/2  - textListBoxW/2;
textDisplayB = frame1B + frame1H - textListBoxH/2;
uipos.textDisplay = [textDisplayL, textDisplayB, textListBoxW, textListBoxH];


Umatrix_buttonL = frame1L + border;
Umatrix_buttonB = frame1B + border + mode_buttonH + button_gapH;
uipos.Umatrix_button = [Umatrix_buttonL, Umatrix_buttonB, mode_buttonW, mode_buttonH];


UmatrixHits_buttonL = Umatrix_buttonL + mode_buttonW + button_gapW;
UmatrixHits_buttonB = Umatrix_buttonB;
uipos.UmatrixHits_button = [UmatrixHits_buttonL, UmatrixHits_buttonB, mode_buttonW, mode_buttonH];



labeledMap_buttonL = frame1L + border;
labeledMap_buttonB = frame1B + border;
uipos.labeledMap_button = [labeledMap_buttonL, labeledMap_buttonB, mode_buttonW, mode_buttonH];


componentPlane_buttonL = labeledMap_buttonL + mode_buttonW + button_gapW;
componentPlane_buttonB = labeledMap_buttonB;
uipos.componentPlane_button = [componentPlane_buttonL, componentPlane_buttonB, mode_buttonW, mode_buttonH];



train_buttonL = figW/2 - mode_buttonW/2;
train_buttonB = frame1B + frame1H + button_gapH + border;
uipos.train_button = [train_buttonL, train_buttonB, mode_buttonW, mode_buttonH];



textNumColumnsL = frame1L + border;
textNumColumnsB = train_buttonB + mode_buttonH + button_gapH + 0*border;
uipos.textNumColumns = [textNumColumnsL, textNumColumnsB, textRadioButtonNameW, textRadioButtonH];

numColumns_editBoxL = textNumColumnsL + textRadioButtonNameW + 2*border;
numColumns_editBoxB = textNumColumnsB;
uipos.numColumns_editBox = [numColumns_editBoxL, numColumns_editBoxB, editBoxW, editBoxH];



textNumRowsL = frame1L + border;
textNumRowsB = textNumColumnsB + button_gapH + button_gapH;
uipos.textNumRows = [textNumRowsL, textNumRowsB, textRadioButtonNameW, textRadioButtonH];

numRows_editBoxL = textNumRowsL + textRadioButtonNameW + 2*border;
numRows_editBoxB = textNumRowsB;
uipos.numRows_editBox = [numRows_editBoxL, numRows_editBoxB, editBoxW, editBoxH];






close_buttonL = figW - 2*border - action_buttonW;
close_buttonB = 1* border + 0* button_gapH ;
uipos.close_button = [close_buttonL, close_buttonB, action_buttonW, action_buttonH ];


