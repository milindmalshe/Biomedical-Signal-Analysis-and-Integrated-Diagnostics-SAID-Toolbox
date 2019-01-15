

function FilterType(cmd,fType)

% 
% FilterType: Select a standard filter or a wavelet filter
% 
% Syntax
%     FilterType('init',filterType)
% 
% 
% Description
%     


% Milind Malshe




% DEFAULTS
if nargin == 0,
    cmd = '';
    FType = '';
else
    cmd = lower(cmd);
end

% FIND WINDOW IF IT EXISTS
fig = 0;

% We alow the program to see hidden handles
fig=findall(0,'type','figure','tag','FilterType');
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
        FilterType('init')
    end

    %==================================================================
    % Close the window.
    %
    % ME() or ME('')
    %==================================================================

elseif strcmp(cmd,'close') & (fig)
    delete(fig);
    
    
    
elseif strcmp(cmd,'closefiltertype') & (fig)
    if (strcmp(fType,'std_signal_processing'))
        std_signal_processing('init','','','standard');
    end
    if (strcmp(fType,'waveletSignalProcessing'))
        std_signal_processing('init','','','wavelet');
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

    H.me='FilterType';

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
        'Tag','FilterType', ...
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
        'String','Filter Method Selection', ...
        'FontSize', 10,...
        'FontWeight','bold', ...
        'Style','text', ...
        'Tag','StaticText1');

    %     H.stdFilter_button = uicontrol('Parent',fig, ...
    %         'Units',H.StdUnit, ...
    %         'Callback','std_signal_processing', ...
    %         'Enable','on', ...
    %         'ListboxTop',0, ...
    %         'Position',uipos.stdFilter_button, ...
    %         'String','Standard Filter', ...
    %         'ToolTipStr','Design a filter using "fdatool"',...
    %         'Tag','Pushbutton1');
    %
    %     H.waveletFilter_button = uicontrol('Parent',fig, ...
    %         'Units',H.StdUnit, ...
    %         'Callback','SAIDutil(''SAIDtool'',''ok'')', ...
    %         'Enable','on', ...
    %         'ListboxTop',0, ...
    %         'Position',uipos.waveletFilter_button, ...
    %         'String','Wavelet Filter', ...
    %         'ToolTipStr','Design a wavelete filter',...
    %         'Tag','Pushbutton1');
    
    
    H.stdFilter_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','FilterType(''closeFilterType'',''std_signal_processing'')', ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position',uipos.stdFilter_button, ...
        'String','Standard Filter', ...
        'ToolTipStr','Design a filter using "fdatool"',...
        'Tag','Pushbutton1');

    H.waveletFilter_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','FilterType(''closeFilterType'',''waveletSignalProcessing'')', ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position',uipos.waveletFilter_button, ...
        'String','Wavelet Filter', ...
        'ToolTipStr','Design a wavelete filter',...
        'Tag','Pushbutton1');
    
    
    
    

    H.close_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','SAIDutil(''FilterType'',''close'')', ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position',uipos.close_button, ...
        'String','Close', ...
        'ToolTipStr','Return to SAID tool',...
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

text1W = frame1W - 12*border; % figW - 6*border;
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
text1B = frame1B + frame1H - 0.8*text1H;  %*****  Actually it should be 1*text1H, but for some reason the textbox looks slightly shifeted down relative to the frame, so 0.8*text1H was used which places the frame1 aprroximately in the center of the text box because it looks good
% text1B = frame1H + button_gapH;
uipos.text1 =  [text1L, text1B, text1W, text1H];


stdFilter_buttonL = (figW/2) - button_gapW/2 - (mode_buttonW);
stdFilter_buttonB = (figH/2) - (mode_buttonH/2);
uipos.stdFilter_button = [stdFilter_buttonL, stdFilter_buttonB, mode_buttonW, mode_buttonH ];

waveletFilter_buttonL = (figW/2) + button_gapW/2;
waveletFilter_buttonB = (figH/2) - (mode_buttonH/2);
uipos.waveletFilter_button = [waveletFilter_buttonL, waveletFilter_buttonB, mode_buttonW, mode_buttonH ];

close_buttonL = (figW/2) + button_gapW/2 + mode_buttonW - action_buttonW;
% close_buttonB = (figH/2) - (mode_buttonH/2) - 2*button_gapH - action_buttonH;
close_buttonB = 2*border;
uipos.close_button = [close_buttonL, close_buttonB, action_buttonW, action_buttonH ];
