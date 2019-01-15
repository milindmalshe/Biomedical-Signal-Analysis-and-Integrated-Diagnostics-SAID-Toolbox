

function ModeSpecification(cmd,moduleType)

% 
% ModeSpecification: Choose a design mode or a batch mode
% 
% Syntax
%     ModeSpecification('init','moduleType')
% 
% 
% Description
%     


% Milind Malshe




% DEFAULTS
if nargin == 0,
    cmd = '';
    moduleType ='';
else
    cmd = lower(cmd);
end

% FIND WINDOW IF IT EXISTS
fig = 0;

% We alow the program to see hidden handles
fig=findall(0,'type','figure','tag','ModeSpecification');
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
        ModeSpecification('init',moduleType)
    end

    %==================================================================
    % Close the window.
    %
    % ME() or ME('')
    %==================================================================

elseif strcmp(cmd,'close') & (fig)
    delete(fig);


elseif strcmp(cmd,'closemodespecification') & (fig)
    if (strcmp(moduleType,'FilterType'))
        FilterType;
    end
    if (strcmp(moduleType,'FeatureExtraction'))
        FeatureExtraction;
    end
    if (strcmp(moduleType,'PatternRecognition'))
        PatternRecognition;
    end


    %     moduleType;
    delete(fig);
    
    
    
    
    
elseif strcmp(cmd,lower('closeModeSpecification_Batch')) & (fig)
    if strcmp(moduleType,'SignalProcessingBatchMode')
        BatchMode('init','','','Signal Processing Batch Mode',gcbf);
    end
    if strcmp(moduleType,'FeatureExtractionBatchMode')
       BatchMode('init','','','Feature Extraction',gcbf) 
    end
    if strcmp(moduleType,'PatternRecognitionBatchMode')
       BatchMode('init','','','Pattern Recognition',gcbf) 
    end

    
    %     moduleType;
    delete(fig);
    
    
    
    
    
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

    H.me='ModeSpecification';

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
        'Tag','ModeSpecification', ...
        'Resize','off', ...
        'ToolBar','none', ...
        'WindowStyle','Modal');


    frame1 = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ListboxTop',0, ...
        'Position',uipos.frame1, ...
        'Style','frame', ...
        'Tag','Frame4');

    text1 = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.text1, ...
        'String','Mode Specification', ...
        'FontSize', 10,...
        'FontWeight','bold', ...
        'Style','text', ...
        'Tag','StaticText1');



    %     H.designMode_button = uicontrol('Parent',fig, ...
    %         'Units',H.StdUnit, ...
    %         'Callback',moduleType, ...
    %         'Enable','on', ...
    %         'ListboxTop',0, ...
    %         'Position',uipos.designMode_button, ...
    %         'String','Design Mode', ...
    %         'ToolTipStr','Design mode: Analyze individual records',...
    %         'Tag','Pushbutton1');



    % % % % % MILIND

%=========================================================================
%  Design Mode
%=========================================================================
    if (strcmp(moduleType,'FilterType'))

        H.designMode_button = uicontrol('Parent',fig, ...
            'Units',H.StdUnit, ...
            'Callback','ModeSpecification(''closeModeSpecification'',''FilterType'')', ...
            'Enable','on', ...
            'ListboxTop',0, ...
            'Position',uipos.designMode_button, ...
            'String','Design Mode', ...
            'ToolTipStr','Design mode: Analyze individual records',...
            'Tag','Pushbutton1');
    end


    if (strcmp(moduleType,'FeatureExtraction'))

        H.designMode_button = uicontrol('Parent',fig, ...
            'Units',H.StdUnit, ...
            'Callback','ModeSpecification(''closeModeSpecification'',''FeatureExtraction'')', ...
            'Enable','on', ...
            'ListboxTop',0, ...
            'Position',uipos.designMode_button, ...
            'String','Design Mode', ...
            'ToolTipStr','Design mode: Analyze individual records',...
            'Tag','Pushbutton1');
    end


    if (strcmp(moduleType,'PatternRecognition'))

        H.designMode_button = uicontrol('Parent',fig, ...
            'Units',H.StdUnit, ...
            'Callback','ModeSpecification(''closeModeSpecification'',''PatternRecognition'')', ...
            'Enable','on', ...
            'ListboxTop',0, ...
            'Position',uipos.designMode_button, ...
            'String','Design Mode', ...
            'ToolTipStr','Design mode: Analyze individual records',...
            'Tag','Pushbutton1');
    end
%=========================================================================
%  Batch Mode
%=========================================================================
if (strcmp(moduleType,'FilterType'))
%     'Callback','BatchMode(''init'','''','''',''Signal Processing Batch Mode'',gcbf)', ...
    H.batchMode_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','ModeSpecification(''closeModeSpecification_Batch'',''SignalProcessingBatchMode'')', ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position',uipos.batchMode_button, ...
        'String','Batch Mode', ...
        'ToolTipStr','Batch mode: Analyze all records',...
        'Tag','Pushbutton1');
 end
  

if (strcmp(moduleType,'FeatureExtraction'))
%     'Callback','BatchMode(''init'','''','''',''Feature Extraction'',gcbf)', ...
    H.batchMode_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','ModeSpecification(''closeModeSpecification_Batch'',''FeatureExtractionBatchMode'')', ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position',uipos.batchMode_button, ...
        'String','Batch Mode', ...
        'ToolTipStr','Batch mode: Analyze all records',...
        'Tag','Pushbutton1');
 end
 
 if (strcmp(moduleType,'PatternRecognition'))
%     'Callback','BatchMode(''init'','''','''',''Pattern Recognition'',gcbf)', ...
     H.batchMode_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','ModeSpecification(''closeModeSpecification_Batch'',''PatternRecognitionBatchMode'')', ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position',uipos.batchMode_button, ...
        'String','Batch Mode', ...
        'ToolTipStr','Batch mode: Analyze all records',...
        'Tag','Pushbutton1');
 end
 
 
 
 
 
 
    H.close_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','SAIDutil(''ModeSpecification'',''close'')', ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position',uipos.close_button, ...
        'String','Close', ...
        'ToolTipStr','Return to SAID Toolbox',...
        'Tag','Pushbutton1');

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


text1H = 3;


figW = 2*border + button_gapW + mode_buttonW + button_gapW + mode_buttonW + button_gapW + 2*border;
% figH = 2*border + 1*button_gapH + mode_buttonH + 1*button_gapH + 1*button_gapH + text1H + 2*border;
figH = 2*border + 1*button_gapH + mode_buttonH + 1*button_gapH + mode_buttonH + 1*button_gapH + text1H + 2*border;

frame1W = figW - 2*border;
frame1H = figH - 2*border;
% frame1H = figH - 2*border - text1H;

text1W = frame1W - 15*border; % figW - 6*border;
% text1H = frame1H - 1*border;


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
frame1B = border;
uipos.frame1 = [frame1L, frame1B, frame1W, frame1H];

% text1L = 4*border;
% text1B = (figH/2) + button_gapH + 0*button_gapH;

% text1L = (frame1L + frame1W)/2 - text1W/2;
text1L = figW/2 - text1W/2;
text1B = frame1B + frame1H - 0.8*text1H;   %*****  Actually it should be 1*text1H, but for some reason the textbox looks slightly shifeted down relative to the frame, so 0.8*text1H was used which places the frame1 aprroximately in the center of the text box because it looks good
% text1B = frame1H + button_gapH;
uipos.text1 =  [text1L, text1B, text1W, text1H];


designMode_buttonL = (figW/2) - button_gapW/2 - (mode_buttonW);
designMode_buttonB = (figH/2) - (mode_buttonH/2);
uipos.designMode_button = [designMode_buttonL, designMode_buttonB, mode_buttonW, mode_buttonH ];

batchMode_buttonL = (figW/2) + button_gapW/2;
batchMode_buttonB = (figH/2) - (mode_buttonH/2);
uipos.batchMode_button = [batchMode_buttonL, batchMode_buttonB, mode_buttonW, mode_buttonH ];

close_buttonL = (figW/2) + button_gapW/2 + mode_buttonW - action_buttonW;
% close_buttonB = (figH/2) - (mode_buttonH/2) - 2*button_gapH - action_buttonH;
close_buttonB = 2*border;
uipos.close_button = [close_buttonL, close_buttonB, action_buttonW, action_buttonH ];
