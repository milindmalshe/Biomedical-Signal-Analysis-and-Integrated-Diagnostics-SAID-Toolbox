function SAIDtool(cmd)
% 
% SAIDtool
% 
% Syntax
%     SAIDtool()
% 
% 
% Description
%     SAIDtool provides the main interface from where different modules can be accessed


% Milind Malshe



if nargin == 0,
    cmd = '';
else
    cmd = lower(cmd);
end

% FIND WINDOW IF IT EXISTS
fig = 0;

% We alow the program to see hidden handles
fig=findall(0,'type','figure','tag','SAIDtool');
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
        SAIDtool('init')
    end

    %==================================================================
    % Close the window.
    %
    % ME() or ME('')
    %==================================================================

elseif strcmp(cmd,'close') & (fig)
    if exist(cat(2,tempdir,'SAIDtooldata.mat'))
        delete(cat(2,tempdir,'SAIDtooldata.mat'));
    end
    delete(fig);

    %==================================================================
    % Initialize the window.
    %
    % ME('init')
    %==================================================================

elseif strcmp(cmd,'init') & (~fig)


    window_en = 'on';
    window_dis = 'off';
    uipos = getuipos;
%     default = getdefaults;

    H.StdColor = get(0,'DefaultUicontrolBackgroundColor');
    H.StdUnit='character';
    H.PointsToPixels = 72/get(0,'ScreenPixelsPerInch');

    H.me='SAID EKG analysis tool';

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
        'Tag','SAIDtool', ...
        'Resize','off', ...
        'ToolBar','none');
   
    
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
        'String','SAID Toolbox', ...
        'FontSize', 10,...
        'FontWeight','bold', ...
        'Style','text', ...
        'Tag','StaticText1');
    
    cdata = imread('SAIDIcon.tif');
    H.icon_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Cdata',cdata, ...
        'Position',uipos.icon_button, ...
        'ToolTipStr','SAID Icon',...
        'Tag','Pushbutton1');

    H.buildDatabase_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','SAIDutil(''SAIDtool'',''ok'')', ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position',uipos.buildDatabase_button, ...
        'String','Build SAID Database', ...
        'ToolTipStr','Read files from external EKG database and convert to SAID format',...
        'Tag','Pushbutton1');
    

    H.filter_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','ModeSpecification('''',''FilterType'')', ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position',uipos.filter_button , ...
        'String','Filtering', ...
        'ToolTipStr','Filtering: Design mode / Batch Mode',...
        'Tag','Pushbutton1');
    

     H.feature_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','ModeSpecification('''',''FeatureExtraction'')', ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position', uipos.feature_button , ...
        'String','Feature Extraction', ...
        'ToolTipStr','Extract Features',...
        'Tag','Pushbutton1');
   
    

     H.patternReco_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','ModeSpecification('''',''PatternRecognition'')', ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position', uipos.patternReco_button , ...
        'String',sprintf('%s\n%s','Pattern Recognition','clustering'), ...
        'ToolTipStr','Classify the patterns',...
        'Tag','Pushbutton1');    
    


     H.visual_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','SAIDutil(''SAIDtool'',''ok'')', ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position', uipos.visual_button , ...
        'String','Visualization', ...
        'ToolTipStr','Display signal',...
        'Tag','Pushbutton1');        
    
    
     H.diagnose_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','SAIDutil(''SAIDtool'',''ok'')', ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position', uipos.diagnose_button , ...
        'String','Diagnosis', ...
        'ToolTipStr','Consult a Cardiologist to confirm the diagnosis',...
        'Tag','Pushbutton1');        

    
    

end

% % % % -------------------------------------------------------------

function uipos = getuipos

h_offset = -2;

border = 1.2;

button_gapW = 3;
button_gapH = 1;

mode_buttonW = 24;
mode_buttonH = 2.0;

text1H = 5;


figW = 2*border + button_gapW + mode_buttonW + button_gapW + mode_buttonW + button_gapW + mode_buttonW + button_gapW + 2*border;
figH = 2*border + 1*button_gapH + mode_buttonH + button_gapH + mode_buttonH + button_gapH + mode_buttonH + button_gapH + text1H + 2*border;


frame1W = figW - 2*border;
frame1H = figH - 2*border;

text1W = frame1W - 50*border; % figW - 6*border;
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
% frame1B = (figH/2) + (mode_buttonH/2) + button_gapH + mode_buttonH + 2*button_gapH
frame1B = border;

% frame1B = border + mode_buttonH + button_gapH + mode_buttonH + button_gapH + mode_buttonH + button_gapH + 1*(mode_buttonH) + border;


% frame1W = figW - (border*2);
% % frame1H = figH - border/2 - frame1B;
% frame1H = (figH/2) - (mode_buttonH/2) - button_gapH - mode_buttonH/2 - button_gapH - mode_buttonH;

% uipos.frame1 = [frame1L,frame1B,frame1W,frame1H];
uipos.frame1 = [frame1L, frame1B, frame1W, frame1H];

% text1L = 4*border;
% text1B = (figH/2) + (mode_buttonH/2) + button_gapH + mode_buttonH + 0*button_gapH;
text1L = figW/2 - text1W/2;
text1B = border/2 + frame1B + frame1H - text1H;

% text1W = figW - (border*2);
% text1H = figH - border - frame1B;
% text1W = frame1W - border;
% text1H = frame1H - border;
% uipos.text1 =  [frame1L + (border/2), frame1B + (border/2), frame1W + 2*border, frame1H + 2*border];
uipos.text1 =  [text1L, text1B, text1W, text1H];
% % % % ----------------------------------------------------

% buidDatabase_buttonL = border + mode_buttonW + button_gap;
% buidDatabase_buttonB = border + mode_buttonH + button_gap + mode_buttonH + button_gap + mode_buttonH + button_gap;

buidDatabase_buttonL = (figW/2) - (mode_buttonW/2);
% buidDatabase_buttonB = border + mode_buttonH + button_gapH + mode_buttonH + button_gapH + mode_buttonH  + mode_buttonH;
buidDatabase_buttonB = (figH/2) - (mode_buttonH/2) + button_gapH + mode_buttonH + h_offset;

uipos.buildDatabase_button = [buidDatabase_buttonL, buidDatabase_buttonB, mode_buttonW, mode_buttonH ];

uipos.icon_button = uipos.buildDatabase_button + [7 (1.5-h_offset) -14 2];
% % % % ---------------------------------------------------

filter_buttonL = (figW/2) - (mode_buttonW/2) - button_gapW - mode_buttonW;
% filter_buttonB = border + mode_buttonH + button_gapH + mode_buttonH;
filter_buttonB = (figH/2) - (mode_buttonH/2) + h_offset;

uipos.filter_button = [filter_buttonL, filter_buttonB, mode_buttonW, mode_buttonH];
% % % % ---------------------------------------------------

feature_buttonL = (figW/2) - (mode_buttonW/2);
feature_buttonB = (figH/2) - (mode_buttonH/2) + h_offset;

uipos.feature_button = [feature_buttonL, feature_buttonB, mode_buttonW, mode_buttonH];
% % % % -----------------------------------------------------

patternReco_buttonL = (figW/2) - (mode_buttonW/2) + button_gapW + mode_buttonW;
patternReco_buttonB = (figH/2) - (mode_buttonH/2) + h_offset;

uipos.patternReco_button = [patternReco_buttonL, patternReco_buttonB, mode_buttonW, mode_buttonH];
% % % % ---------------------------------------------------

visual_buttonL = (figW/2) - (button_gapW/2) - mode_buttonW;
visual_buttonB = (figH/2) - (mode_buttonH/2) - button_gapH - mode_buttonH + h_offset;

uipos.visual_button = [visual_buttonL, visual_buttonB, mode_buttonW, mode_buttonH];
% % % % -------------------------------------------------

diagnose_buttonL = (figW/2) + (button_gapW/2) ;
diagnose_buttonB = (figH/2) - (mode_buttonH/2) - button_gapH - mode_buttonH + h_offset;

uipos.diagnose_button = [diagnose_buttonL, diagnose_buttonB, mode_buttonW, mode_buttonH];

% % % % % % % % ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


% % ********

