function std_signal_processing(cmd,arg1,arg2,arg3)
% std_signal_processing generates the GUI for standard signal
% processing modules of SAID toolbox.
%
%       Syntax
%
%	  std_signal_processing(cmd,arg1,arg2,arg3)
%
%       Description
%




%
% SAID Toolbox Component

clc

% DEFAULTS
if nargin == 0, cmd = ''; else cmd = lower(cmd); end

% FIND WINDOW IF IT EXISTS
fig = 0;

% We alow the program to see hidden handles
fig=findall(0,'type','figure','tag','std_signal_processing');
if (size(fig,1)==0), fig=0; end

if (length(get(fig,'children')) == 0), fig = 0; end

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
        std_signal_processing('init')
    end
    %
    %==================================================================
    % Close the window.
    %
    % ME() or ME('')
    %==================================================================

elseif strcmp(cmd,'close') & (fig)
    if exist(cat(2,tempdir,'std_signal_processingdata.mat'))
        delete(cat(2,tempdir,'std_signal_processingdata.mat'));
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
    %default = getdefaults;

    H.StdColor = get(0,'DefaultUicontrolBackgroundColor');
    H.StdUnit='character';
    H.PointsToPixels = 72/get(0,'ScreenPixelsPerInch');

    %start%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if ~exist('arg3')
        H.me = 'Standard Signal Processing Design Mode';
        H.mode = 'standard';
    elseif strcmp(arg3,'standard')
        H.me = 'Standard Signal Processing Design Mode';
        H.mode = 'standard';
    elseif strcmp(arg3,'wavelet')
        H.me = 'Wavelet Signal Processing Design Mode';
        H.mode = 'wavelet';
    end
    %end%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    labelw = 32;
    labelh = 1.5;

    uipos = getuipos;

    fig = figure('Units',H.StdUnit, ...
        'Color',[0.8 0.8 0.8], ...
        'IntegerHandle','off',...
        'Interruptible','off', ...
        'BusyAction','cancel', ...
        'HandleVis','Callback', ...
        'MenuBar','none', ...
        'Name',H.me, ...
        'Numbertitle','off', ...
        'Units', H.StdUnit, ...
        'PaperUnits','points', ...
        'Position',uipos.fig, ...
        'Tag','std_signal_processing', ...
        'Resize','off', ...
        'ToolBar','none');

    H.frame1 = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ListboxTop',0, ...
        'Position',uipos.frame1, ...
        'Style','frame', ...
        'Tag','Frame1');

    H.h11 = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.h11, ...
        'String','Input Signal', ...
        'Style','text', ...
        'Tag','StaticText11');

    H.h12 = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.h12, ...
        'String','Fourier Transform', ...
        'Style','text', ...
        'Tag','StaticText12');


    H.h31 = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.h31, ...
        'String','Filtered Signal', ...
        'Style','text', ...
        'Tag','StaticText31');

    H.h32 = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.h32, ...
        'String','Fourier Transform', ...
        'Style','text', ...
        'Tag','StaticText32');

    H.frame2 = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ListboxTop',0, ...
        'Position',uipos.frame2, ...
        'Style','frame', ...
        'Tag','Frame2');

    H.h2 = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.h2, ...
        'String','Filters', ...
        'Style','text', ...
        'Tag','StaticText2');

    H.frame4 = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ListboxTop',0, ...
        'Position',uipos.frame4, ...
        'Style','frame', ...
        'Tag','Frame4');

    H.error_messages= uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'FontWeight','bold', ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 1], ...
        'ListboxTop',0, ...
        'Position',uipos.error_messages, ...
        'String','Import Data to Get Started',...
        'Style','text', ...
        'ToolTipStr','Feedback line with important messages for the user.',...
        'Tag','StaticText1');

    H.Title_std_signal_processing = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'FontSize',14, ...
        'ListboxTop',0, ...
        'Position',uipos.Title_std_signal_processing, ...
        'String',H.me, ...
        'Style','text', ...
        'Tag','Standard Signal Processing');

    H.lbh11 = uicontrol('Parent',fig,...
        'BackgroundColor','white',...
        'Style','Listbox',...
        'Min',0,...
        'Max',1000, ...
        'Units',H.StdUnit, ...
        'Value',[],...
        'Position',uipos.lb11,...
        'Tag','Listbox Fourier Transform1');

    H.lbh12 = uicontrol('Parent',fig,...
        'BackgroundColor','white',...
        'Min',0,...
        'Max',1000, ...
        'Style','Listbox',...
        'Units',H.StdUnit, ...
        'Value',[],...
        'Position',uipos.lb12,...
        'Tag','Listbox Input Signal');

    H.lbh31 = uicontrol('Parent',fig,...
        'Style','Listbox',...
        'BackgroundColor','white',...
        'Min',0,...
        'Max',1000, ...
        'Units',H.StdUnit, ...
        'Value',[],...
        'Position',uipos.lb31,...
        'Tag','Listbox Fourier Transform3');

    H.lbh32 = uicontrol('Parent',fig,...
        'BackgroundColor','white',...
        'Min',0,...
        'Max',1000, ...
        'Style','Listbox',...
        'Units',H.StdUnit, ...
        'Value',[],...
        'Position',uipos.lb32,...
        'Tag','Listbox Filtered Signal');

    H.lbh2 = uicontrol('Parent',fig,...
        'BackgroundColor','white',...
        'Min',0,...
        'Max',1000, ...
        'Style','Listbox',...
        'Value',[],...
        'Userdata',[],...
        'Units',H.StdUnit, ...
        'Position',uipos.lb2,...
        'Tag','Filters');

    H.Import_but1 = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','SAIDutil(''SAIDimport'',''init'','''','''',''Import Data'');',...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position',uipos.Import_but1, ...
        'String','Import', ...
        'ToolTipStr','Import Signal',...
        'Tag','Import_but1');

    H.FFT_but1 = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','std_signal_processing(''fft1'',''lbh12'',''lbh11'')', ...
        'Enable','off', ...
        'ListboxTop',0, ...
        'Position',uipos.FFT_but1, ...
        'String','FFT', ...
        'ToolTipStr','Fast Fourier Transform',...
        'Tag','FFT_but1');

    H.FFT_but3 = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','std_signal_processing(''fft3'',''lbh32'',''lbh31'')', ...
        'Enable','off', ...
        'ListboxTop',0, ...
        'Position',uipos.FFT_but3, ...
        'String','FFT', ...
        'ToolTipStr','Fast Fourier Transform',...
        'Tag','FFT_but3');

    H.Statistics_but = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','SAIDutil(''std_signal_processing'',''plot'')', ...
        'Enable','off', ...
        'ListboxTop',0, ...
        'Position',uipos.Statistics_but, ...
        'String','Statistics', ...
        'ToolTipStr','Statistics',...
        'Tag','Statistics_but');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if strcmp(H.mode,'standard')
        H.Import_but2 = uicontrol('Parent',fig, ...
            'Units',H.StdUnit, ...
            'Callback','SAIDutil(''SAIDimport'',''init'','''','''',''Import Filter'')', ...
            'Enable','on', ...
            'ListboxTop',0, ...
            'Position',uipos.Import_but2, ...
            'String','Import', ...
            'ToolTipStr','Import Filter(s)',...
            'Tag','Import_but2');
    else
        H.Import_but2 = uicontrol('Parent',fig, ...
            'Units',H.StdUnit, ...
            'Callback','SAIDutil(''SAIDimport'',''init'','''','''',''Import Wavelet Filter'')', ...
            'Enable','on', ...
            'ListboxTop',0, ...
            'Position',uipos.Import_but2, ...
            'String','Import', ...
            'ToolTipStr','Import Filter(s)',...
            'Tag','Import_but2');
    end
   
    H.Design_filter_but = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','std_signal_processing(''Design_filter'')', ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position',uipos.Design_filter_but, ...
        'String','Design Filter', ...
        'ToolTipStr','Design Filter(s)',...
        'Tag','Design_filter_but');

    H.Apply_filter_but = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','std_signal_processing(''apply_filter'')', ...
        'Enable','off', ...
        'ListboxTop',0, ...
        'Position',uipos.Apply_filter_but, ...
        'String','Apply Filter', ...
        'ToolTipStr','Apply Filter(s)',...
        'Tag','Apply_filter_but');

    H.Display_but = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','SAIDutil(''std_signal_processing'',''display'')', ...
        'Enable','off', ...
        'ListboxTop',0, ...
        'Position',uipos.Display_but, ...
        'String','Display', ...
        'ToolTipStr','Display',...
        'Tag','Dispaly_but');

    H.Delete_but = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','SAIDutil(''std_signal_processing'',''delete'')', ...
        'Enable','off', ...
        'ListboxTop',0, ...
        'Position',uipos.Delete_but, ...
        'String','Delete', ...
        'ToolTipStr','Delete',...
        'Tag','Delete_but');

    H.Export_but = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','SAIDutil(''std_signal_processing'',''export'')', ...
        'Enable','off', ...
        'ListboxTop',0, ...
        'Position',uipos.Export_but, ...
        'String','Export', ...
        'ToolTipStr','Export Filter',...
        'Tag','Export_but');

%          ...
    H.Close_but = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','SAIDutil(''std_signal_processing'',''Close'',gcbf)', ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position',uipos.Close_but, ...
        'String','Close', ...
        'ToolTipStr','Close',...
        'Tag','Close_but');

    %==============================================
    % Menue Bar,We create the menus for the block.
    % =============================================
%     H.Handles.Menus.File.Top= uimenu('Parent',fig, ...
%         'Label','File');
% 
%     H.Handles.Menus.File.Import_Signal = uimenu('Parent',...
%         H.Handles.Menus.File.Top,...
%         'Label','Import Signal...',...
%         'Accelerator','I',...
%         'Callback','SAIDutil(''SAIDimport'',''init'','''','''',''Import Data'');',...
%         'Enable',window_en, ...
%         'Tag','Import Signal');
% 
%     H.Handles.Menus.File.Import_Filter = uimenu('Parent',H.Handles.Menus.File.Top, ...
%         'Label','Import Filter...', ...
%         'Accelerator','E', ...
%         'Callback','SAIDutil(''SAIDimport'',''init'','''','''',''Import Filter'')', ...
%         'Enable',window_en, ...
%         'Tag','Import Filter');
% 
%     H.Handles.Menus.File.Save_Exit = uimenu('Parent',...
%         H.Handles.Menus.File.Top,...
%         'Label','Save and Exit',...
%         'Enable','on', ...
%         'Accelerator','A',...
%         'Callback','SAIDutil(''std_signal_processing'',''ok'');',...
%         'Tag','Save and Exit');
% 
%     H.Handles.Menus.File.Close = uimenu('Parent',H.Handles.Menus.File.Top, ...
%         'Callback','SAIDutil(''std_signal_processing'',''close'',gcbf);', ...
%         'Separator','on', ...
%         'Label','Exit without saving', ...
%         'Accelerator','X', ...
%         'Tag','Exit without saving');
%     H.Handles.Menus.Help.Top = uimenu('Parent',fig, ...
%         'Label','Help');
%     H.Handles.Menus.Help.Main = uimenu('Parent',H.Handles.Menus.Help.Top, ...
%         'Label','SAID toolbox Help', ...
%         'Callback','SAIDutil(''SAIDimporthelp'',''main'');',...
%         'Accelerator','H');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    H.filterno = 1;
    %end%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    set(fig,'Userdata',H);
    set(0,'RecursionLimit',100)
    set(fig,'Userdata',H);
    %=============================================================
    %                        have_file
    %============================================================
elseif strcmp(cmd,'have_file')
    signal_arch = get(H.frame1,'Userdata');
    if isempty(signal_arch)

        set(H.FFT_but1,'enable','on');
        set(H.Display_but,'enable','on');
        set(H.Delete_but,'enable','on');
        set(H.error_messages,'string',sprintf('Import Filter to Filter Signal.'));
        arg1 = ChangeFieldName(arg1,arg2);
        signal_obj = arg1;
        signal_name = arg2;
        signal_arch{1} = signal_obj;
        signal_arch{2} = signal_name;
        P = ComStruct(signal_arch);
        set(H.lbh12,'String',fieldnames(P),'Userdata',P);
        set(H.frame1,'Userdata',signal_arch);

    else
        % To check whether the selected signal is already exist or not
        k = length(signal_arch);
        for i = 2 : 2 : k
            signal_name = signal_arch{i};
            if strmatch(arg2,signal_name,'exact')
                errordlg('Selected patient already exists. Select another patient','Error');
                return
            end
        end
        arg1 = ChangeFieldName(arg1,arg2);
        signal_arch{end+1} = arg1;
        signal_arch{end+1} = arg2;
        P = ComStruct(signal_arch);
        set(H.frame1,'Userdata',signal_arch);
        set(H.lbh12,'String',fieldnames(P),'Userdata',P);
        set(H.error_messages,'string',sprintf('Import Filter to Filter Data.'));
    end
    %===============================================================
    %                      Apply Filter
    %===============================================================
elseif  strcmp(cmd,'apply_filter')
    k_signal = get(H.lbh12,'Value');
    k_filter = get(H.lbh2,'Value');
    k_filtered = get(H.lbh32,'Value');
    P = get(H.lbh12,'Userdata');
    P_filtered = get(H.lbh32,'Userdata');

    filter_arch = get(H.lbh2,'Userdata');
    signal_arch = get(H.frame1,'Userdata');
    signal_filtered_arch = get(H.frame4,'Userdata');

    if ~isempty(k_filtered)
        errordlg('You must deselect the selceted filtered signal before applying filter','modal');
        return

    elseif isempty(k_signal) | isempty(k_filter)
        errordlg('You must select leasd(s) and filter before applying filter','Modal');
        return
    elseif length(k_filter) ~=1
        errordlg('You must select only one filter','Error');
        return
    end
    % When signal_filtered_arch is empty
    if isempty(signal_filtered_arch)
        %--->
        clear arg1
        for i = 1:length(signal_arch)
            if mod(i,2)==1
                arg1{i} = signal_arch{i};
                LeadName = fieldnames(arg1{i});
                suff = filter_arch{2*k_filter};
                suff = strcat('_','filt_',suff);
                LeadName_filtered = strcat(LeadName,suff);
                LeadName_filtered = cellstr(LeadName_filtered);
                c = struct2cell(arg1{i});
                %*****************Problem  23-Oct-2007 12:18:29
%                 signal_filtered_arch{i}=[];
                %*****************Problem
                for j = 1:length(LeadName)
                    signal_filtered_arch{i}.(char(LeadName_filtered(j)))=c{j};

                end
            else
                signal_filtered_arch{i} = signal_arch{i};
            end
        end

        LeadName = fieldnames(P);
        suff = filter_arch{2*k_filter};
        suff = strcat('_','filt_',suff);
        LeadName_filtered = strcat(LeadName,suff);
        LeadName_filtered = cellstr(LeadName_filtered);


        % Updating P_filtered for the first time
        for i =1:length(k_signal)
            if strcmp(H.mode,'standard')
                P_filtered.(char(LeadName_filtered(k_signal(i))))=filter(filter_arch{2*k_filter-1},P.(char(LeadName(k_signal(i)))));
            else
                P_filtered.(char(LeadName_filtered(k_signal(i))))=SAIDwfilter(filter_arch{2*k_filter-1},P.(char(LeadName(k_signal(i)))));
            end
         
        end
        % Updating signal_filtered_arch for the first time

        [signal_filtered_arch] = Arch_Update(signal_filtered_arch,P_filtered);

    else
        % Updating P_filtered when P_filtered is not empty
        LeadName = fieldnames(P);
        suff = filter_arch{2*k_filter};
        suff = strcat('_','filt_',suff);
        LeadName_filtered = strcat(LeadName,suff);
        LeadName_filtered = cellstr(LeadName_filtered);
        for  i =1:length(k_signal)
            if isempty(strmatch(LeadName_filtered(k_signal(i)),fieldnames(P_filtered),'exact'))
                %start%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                if strcmp(H.mode,'standard')
                    P_filtered.(char(LeadName_filtered(k_signal(i))))=filter(filter_arch{2*k_filter-1},P.(char(LeadName(k_signal(i)))));
                else
                    P_filtered.(char(LeadName_filtered(k_signal(i))))=SAIDwfilter(filter_arch{2*k_filter-1},P.(char(LeadName(k_signal(i)))));
                end
                %end%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            else  % To check whether the selected signal is already exist or not
                errordlg('One of the selected leads already exists. Select new leads','Error');
                return
            end
        end

        % Updating signal_filtered_arch when signal_filtered_arch is
        % not empty
        %--->
        clear arg1
        %--->
        for i = 1:length(signal_arch)
            if mod(i,2)==1
                arg1{i} = signal_arch{i};
                LeadName = fieldnames(arg1{i});
                suff = filter_arch{2*k_filter};
                suff = strcat('_','filt_',suff);
                LeadName_filtered = strcat(LeadName,suff);
                LeadName_filtered = cellstr(LeadName_filtered);
                c = struct2cell(arg1{i});
                %%%%%%%%%%%%%%%%%%%RJ%%%%%
                %signal_filtered_arch{i}=[];
                %%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                for j = 1:length(LeadName)
                    
%                     signal_filtered_arch{i}.(char(LeadName_filtered(j)))=c{j};
                    
                    %++++
                    if ~isstruct(c{j})
                        signal_filtered_arch{i}.(char(LeadName_filtered(j)))=c{j};
                    else 
                        signal_filtered_arch{i}.(char(LeadName_filtered(j)))=c{j};
                         signal_filtered_arch{i} = rmfield(signal_filtered_arch{i},LeadName_filtered(end));
                         signal_filtered_arch{i}.(char(LeadName_filtered(end)))=c{j};
                    end
%                     k = find(strcmp(LeadName_filtered(end),fieldnames(signal_filtered_arch{i})));
                    
%                     if k
%                         if ~Done
%                             signal_filtered_arch{i} = rmfield(signal_filtered_arch{i},LeadName_filtered(end));
%                             signal_filtered_arch{i}.(char(LeadName_filtered(end)))=c{end};
%                            
                    
%                         end
%                     end
                    %++++
                end
            else
                signal_filtered_arch{i} = signal_arch{i};
            end
        end
        %++++++
%         aa = signal_filtered_arch;
%         
%         for i = 1:length(signal_arch)
%             if mod(i,2)==1
%                 n = length(fieldnames(aa{i}));
%                 for j = 1: n
%                     if ~isempty(strmatch(LeadName_filtered(end),fieldnames(aa{i}),'exact'))
%                         k = find(strcmp(LeadName_filtered(end),aa{i}));
%                         aa{i} = rmfield(aa{i},LeadName_filtered(end));
%                         aa{i}.(char(LeadName_filtered(end)))=c{end};
% 
%                     end
%                 end
%             else
%                         aa{i} =  signal_arch{i};
%             end
%         end
        %++++++
        [signal_filtered_arch] = Arch_Update(signal_filtered_arch,P_filtered);
    end

    set(H.frame4,'Userdata',signal_filtered_arch);
    set(H.lbh32,'String',fieldnames(P_filtered),'Userdata',P_filtered,'Value',[]);
    set(H.FFT_but3,'enable','on');
    set(H.Statistics_but,'enable','on');
    set(H.error_messages,'string',sprintf('You Can Now Export Filter.'));
    %==============================================================
    %                        fft of raw signal
    %=============================================================
elseif strcmp(cmd,'fft1')
    k_signal = get(H.lbh12,'Value');
    P = get(H.lbh12,'Userdata');
    P_fft = get(H.lbh11,'Userdata');
    signal_arch = get(H.frame1,'Userdata');
    signal_fft_arch = get(H.h12,'Userdata');

    if isempty(k_signal)
        errordlg('You must select at least one lead','Error');
    
    else
        clear arg1
        if isempty(signal_fft_arch)
            for i = 1:length(signal_arch)
                if mod(i,2)==1
                    arg1{i} = signal_arch{i};
                    LeadName = fieldnames(arg1{i});
                    suff = '_F';
                    LeadName_f = strcat(LeadName,suff);
                    LeadName_f = cellstr(LeadName_f);
                    c = struct2cell(arg1{i});
                    for j = 1:length(LeadName)
                        if ~isstruct(c{j})
                            signal_fft_arch{i}.(char(LeadName_f(j)))=fft(c{j});
                        else
                            signal_fft_arch{i}.(char(LeadName_f(j)))=c{j};
                        end
                    end
                else
                    signal_fft_arch{i} = signal_arch{i};
                end
            end


            % Updtaing P_fft for the first time
            LeadName = fieldnames(P);
            suff = '_F';
            LeadName_f = strcat(LeadName,suff);
            LeadName_f = cellstr(LeadName_f);
            for i =1:length(k_signal)
                P_fft.(char(LeadName_f(k_signal(i)))) = fft(P.(char(LeadName(k_signal(i)))));
            end
            [signal_fft_arch] = Arch_Update(signal_fft_arch,P_fft);


        else
            % Updating P_fft when signal_fft_arch is not empty
            LeadName = fieldnames(P);
            suff = '_F';
            LeadName_f = strcat(LeadName,suff);
            LeadName_f = cellstr(LeadName_f);
            for  i =1:length(k_signal)
                if isempty(strmatch(LeadName_f(k_signal(i)),fieldnames(P_fft),'exact'))
                    P_fft.(char(LeadName_f(k_signal(i)))) = fft(P.(char(LeadName(k_signal(i)))));
                else
                    errordlg('One of the selected leads already exists. Select new leads','Error');
                    return
                end
            end
            % Updating signal_fft_arch when signal_fft_arch is
            % not empty
            clear signal_fft_arch
            %---->
            clear arg1
            %---->
            for i = 1:length(signal_arch)
                if mod(i,2)==1
                    arg1{i} = signal_arch{i};
                    LeadName = fieldnames(arg1{i});
                    suff = '_F';
                    LeadName_f = strcat(LeadName,suff);
                    LeadName_f = cellstr(LeadName_f);
                    c = struct2cell(arg1{i});
                    for j = 1:length(LeadName)
                        if ~isstruct(c{j})
                            signal_fft_arch{i}.(char(LeadName_f(j)))=fft(c{j});
                        else
                            signal_fft_arch{i}.(char(LeadName_f(j)))=c{j};
                        end
                    end
                else
                    signal_fft_arch{i} = signal_arch{i};
                end
            end
            [signal_fft_arch] = Arch_Update(signal_fft_arch,P_fft);
        end

    set(H.lbh11,'String',fieldnames(P_fft),'Userdata',P_fft);
    set(H.h12,'Userdata',signal_fft_arch);
    end
    %==============================================================
    %                      fft of filtered signal
    %=============================================================
elseif strcmp(cmd,'fft3')

    k_filtered = get(H.lbh32,'Value');
    P_filtered = get(H.lbh32,'Userdata');
    P_filtered_fft = get(H.lbh31,'Userdata');
    signal_filtered_arch = get(H.frame4,'Userdata');
    signal_filtered_fft_arch = get(H.h32,'Userdata');

    if isempty(k_filtered)
        errordlg('You must select at least one lead','Error');
    

    else
        clear arg1
        if isempty(signal_filtered_fft_arch)
            for i = 1:length(signal_filtered_arch)
                if mod(i,2)==1
                    arg1{i} = signal_filtered_arch{i};
                    LeadName = fieldnames(arg1{i});
                    suff = '_F';
                    LeadName_f = strcat(LeadName,suff);
                    LeadName_f = cellstr(LeadName_f);
                    c = struct2cell(arg1{i});
                    for j = 1:length(LeadName)
                        if ~isstruct(c{j})
                            signal_filtered_fft_arch{i}.(char(LeadName_f(j)))=fft(c{j});
                        else
                            signal_filtered_fft_arch{i}.(char(LeadName_f(j)))=c{j};
                        end
                    end
                else
                    signal_filtered_fft_arch{i} = signal_filtered_arch{i};
                end
            end


            % Updtaing P_fft for the first time
            LeadName = fieldnames(P_filtered);
            suff = '_F';
            LeadName_f = strcat(LeadName,suff);
            LeadName_f = cellstr(LeadName_f);
            for i =1:length(k_filtered)
                P_filtered_fft.(char(LeadName_f(k_filtered(i)))) = fft(P_filtered.(char(LeadName(k_filtered(i)))));
            end
            [signal_filtered_fft_arch] = Arch_Update(signal_filtered_fft_arch,P_filtered_fft);


        else
            % Updating P_fft when signal_fft_arch is not empty
            LeadName = fieldnames(P_filtered);
            suff = '_F';
            LeadName_f = strcat(LeadName,suff);
            LeadName_f = cellstr(LeadName_f);
            for  i =1:length(k_filtered)
                if isempty(strmatch(LeadName_f(k_filtered(i)),fieldnames(P_filtered_fft),'exact'))
                    P_filtered_fft.(char(LeadName_f(k_filtered(i)))) = fft(P_filtered.(char(LeadName(k_filtered(i)))));
                else
                    errordlg('One of the selected leads already exists. Select new leads','Error');
                    return
                end
            end
            % Updating signal_fft_arch when signal_fft_arch is
            % not empty

            clear signal_filtered_fft_arch
            %---->
            clear arg1
            %---->
            for i = 1:length(signal_filtered_arch)
                if mod(i,2)==1
                    arg1{i} = signal_filtered_arch{i};
                    LeadName = fieldnames(arg1{i});
                    suff = '_F';
                    LeadName_f = strcat(LeadName,suff);
                    LeadName_f = cellstr(LeadName_f);
                    c = struct2cell(arg1{i});
                    for j = 1:length(LeadName)
                        if ~isstruct(c{j})
                            signal_filtered_fft_arch{i}.(char(LeadName_f(j)))=fft(c{j});
                        else
                            signal_filtered_fft_arch{i}.(char(LeadName_f(j)))=c{j};
                        end
                    end
                else
                    signal_filtered_fft_arch{i} = signal_filtered_arch{i};
                end
            end
            [signal_filtered_fft_arch] = Arch_Update(signal_filtered_fft_arch,P_filtered_fft);
        end
    
    set(H.lbh31,'String',fieldnames(P_filtered_fft),'Userdata',P_filtered_fft);
    set(H.h32,'Userdata',signal_filtered_fft_arch);
    end
    %===============================================================
    %                      import_filter
    %===============================================================
elseif strcmp(cmd,'import_filter')
    filter_arch = get(H.lbh2,'Userdata');
    % To check whether the selected signal is already exist or not
    if ~isempty(filter_arch)
        k = size(filter_arch); k = k(2);
        for i = 2 : 2 : k
            filter_name = filter_arch{i};
            
            if isempty(arg2)
               return
            end
            
            if strmatch(arg2,filter_name,'exact')
                errordlg('Selected filter already exists. Select another filter','Error');
                return
            end
        end
    end
    if isempty(filter_arch)

        set(H.Apply_filter_but,'enable','on');
        set(H.Export_but,'enable','on');
        set(H.Delete_but,'enable','on');

        if ~isempty(arg2)
            filter_obj = arg1;
            filter_name = arg2;
            filter_arch{1} = filter_obj;
            filter_arch{2} = char(filter_name);
            set(H.lbh2,'String',filter_name,'Userdata',filter_arch,'Value',[]);
            set(H.error_messages,'string',sprintf('Apply Filter to Obtain Filtered Signal.'));

        else
            
        set(H.lbh2,'String',[],'Userdata',[],'Value',[]);
        set(H.error_messages,'string',sprintf('Apply Filter to Obtain Filtered Signal.'));
        end

    else
        if ~isempty(arg2)
            filter_arch{end+1} = arg1;
            filter_arch{end+1} = char(arg2);
            for i=2:2:length(filter_arch)
                filter_name_f{i/2}=filter_arch{i};
            end
            set(H.lbh2,'String',filter_name_f,'Userdata',filter_arch,'Value',[]);
     
        end
    end
    %===============================================================
===============================================================
    std_signal_processing('');
    %===============================================================
    %                      Design Filter
    %===============================================================
elseif strcmp(cmd,'design_filter')
    %start%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if strcmp(H.mode,'standard')
        fdatool;
    else
       

        k_signal = get(H.lbh12,'Value');
        signal_arch = get(H.frame1,'Userdata');
        if isempty(k_signal)
            errordlg('You must select leasd(s) before designing filter','Modal');
            return
        else
            a = [];
            info = cell(length(k_signal),1);

            %----------------- Raw Signal
            if ~isempty(k_signal)
                P = get(H.lbh12,'Userdata');
                LeadName = fieldnames(P);
                c = struct2cell(P); %
                for i = 1:length(k_signal)
                    a = [a;c{k_signal(i)}'];
                    for j =1:2:length(signal_arch)
                        aa =  fieldnames(signal_arch{j});
                        if  strmatch(LeadName(k_signal(i)),aa,'exact')
                            info{i} = signal_arch{j}.(char(aa{end}));
                            info{i}.Lead = LeadName{k_signal(i)};
                        end
                    end
                end
            end
        end
        
        structx.a = a;
        structx.info = info;

        SAIDutil('SAIDwaveletdesign','',structx,H.filterno);
        H.filterno = H.filterno+1;
        set(fig,'Userdata',H);
    end
    set(H.Apply_filter_but,'enable','on');
    %==============================================================
    %                        display
    %==============================================================
elseif strcmp(cmd,'display')
    m = get(H.lbh12,'Value');
    n = get(H.lbh11,'Value');
    p = get(H.lbh32,'Value');
    q = get(H.lbh31,'Value');

    signal_arch = get(H.frame1,'Userdata');
    signal_filtered_arch = get(H.frame4,'Userdata');
    signal_fft_arch = get(H.h12,'Userdata');
    signal_filtered_fft_arch = get(H.h32,'Userdata');

    num1 = length(m)+length(p);
    num2 = length(n)+length(q);
    a = [];
    b = [];
    info = cell(num1+num2,1);
    
    if isempty(m) & isempty(n) & isempty(p) & isempty(q)
        errordlg('You must select at least one lead to be displayed','Error');
    end

    %----------------- Raw Signal
    if ~isempty(m)
        P = get(H.lbh12,'Userdata');
        LeadName = fieldnames(P);
        c = struct2cell(P); %
        for i = 1:length(m)
            a{i} = [c{m(i)}'];
            for j =1:2:length(signal_arch)
                aa =  fieldnames(signal_arch{j});
                if  strmatch(LeadName(m(i)),aa,'exact')
                    info{i} = signal_arch{j}.(char(aa{end}));
                    info{i}.Lead = LeadName{m(i)};
                end
            end
        end
    end
    %--------- Filtered Signal
    if ~isempty(p)
        P_filtered = get(H.lbh32,'Userdata');
        LeadName = fieldnames(P_filtered);
        c = struct2cell(P_filtered); %
        ii = 1;
        for i = (length(m)+1):(length(m)+length(p)),
            a{i} = [c{p(ii)}'];
            for j =1:2:length(signal_filtered_arch)
                aa =  fieldnames(signal_filtered_arch{j});
                if  strmatch(LeadName(p(ii)),aa,'exact')
                    info{ii+length(m)} = signal_filtered_arch{j}.(char(aa{end}));
                    info{ii+length(m)}.Lead = LeadName{p(ii)};
                end
            end
            ii=ii+1;
        end
    end
    %----------------- Raw Signal_fft
    if ~isempty(n)
        P_fft = get(H.lbh11,'Userdata');
        LeadName = fieldnames(P_fft);
        c = struct2cell(P_fft); %
        for i = 1:length(n)
            b{i} = [c{n(i)}'];
            for j =1:2:length(signal_fft_arch)
                aa =  fieldnames(signal_fft_arch{j});
                if  strmatch(LeadName(n(i)),aa,'exact')
                    info{i+length(m)+length(p)} = signal_fft_arch{j}.(char(aa{end}));
                    info{i+length(m)+length(p)}.Lead = LeadName{n(i)};
                end
            end
        end
    end
    %--------- Filtered Signal_fft
    if ~isempty(q)
        P_filtered_fft = get(H.lbh31,'Userdata');
        LeadName = fieldnames(P_filtered_fft);
        c = struct2cell(P_filtered_fft); %
        ii = 1;
        for i = (length(n)+1):(length(q)+length(n)),
            b{i} = [c{q(ii)}'];
            for j =1:2:length(signal_filtered_fft_arch)
                aa =  fieldnames(signal_filtered_fft_arch{j});
                if  strmatch(LeadName(q(ii)),aa,'exact')
                    info{ii+length(m)+length(p)+length(n)} = signal_filtered_fft_arch{j}.(char(aa{end}));
                    info{ii+length(m)+length(p)+length(n)}.Lead = LeadName{q(ii)};
                end
            end
            ii=ii+1;
        end
    end
    SAIDplot(a,b,info,'Time (seconds)','Time Domain Plot')
    %==============================================================
    %                        delete
    %==============================================================
elseif strcmp(cmd,'delete')
    P = get(H.lbh12,'Userdata');
    P_fft = get(H.lbh11,'Userdata');
    P_filtered = get(H.lbh32,'Userdata');
    P_filtered_fft = get(H.lbh31,'Userdata');
    signal_arch = get(H.frame1,'Userdata');
    signal_filtered_arch = get(H.frame4,'Userdata');
    signal_fft_arch = get(H.h12,'Userdata');
    signal_filtered_fft_arch = get(H.h32,'Userdata');

    k = get(H.lbh12,'Value'); % Selcted Lead of the Signal
    k_f =get(H.lbh11,'Value');% Selcted Lead of FFT Signal
    k_filtered = get(H.lbh32,'Value'); % Selected filtered lead
    k_filtered_f = get(H.lbh31,'Value'); % Selected FFT of filtered signal
    k_filter =get(H.lbh2,'Value'); % Selected filter

    %---------------Deleting raw signal
    if ~isempty(k)
        [signal_arch,P] = Update_arch_ComStruct(signal_arch,P,k);
        set(H.frame1,'Userdata',signal_arch)
        if ~isempty(fieldnames(P))
            set(H.lbh12,'String',fieldnames(P),'Value',[],'enable','on');
            set(H.lbh12,'Userdata',P);
        else
            set(H.lbh12,'String',[],'Value',[],'Userdata',[],'enable','on');
            set(H.frame1,'Userdata',[]);
            set(H.FFT_but1,'enable','off');
            set(H.error_messages,'string',sprintf('Import Data to Get Started.'));
        end
    end
    %------------- Deleting filtered signal
    if ~isempty(k_filtered)
        [signal_filtered_arch,P_filtered] = Update_arch_ComStruct(signal_filtered_arch,P_filtered,k_filtered);
        set(H.frame4,'Userdata',signal_filtered_arch);

        if ~isempty(fieldnames(P_filtered))
            set(H.lbh32,'String',fieldnames(P_filtered),'Value',[],'enable','on');
            set(H.lbh32,'Userdata',P_filtered);
        else
            set(H.lbh32,'String',[],'Value',[],'Userdata',[],'enable','on');
            set(H.Statistics_but,'enable','off');
            set(H.FFT_but3,'enable','off');
            set(H.frame4,'Userdata',[]);
            set(H.error_messages,'string',sprintf('Apply Filter to Obtain Filtered Signal.'));

        end
    end
    %-----------  Deleting FFT of signal
    if ~isempty(k_f)

        [signal_fft_arch,P_fft] = Update_arch_ComStruct(signal_fft_arch,P_fft,k_f);
        set(H.h12,'Userdata',signal_fft_arch);

        if ~isempty(fieldnames(P_fft))
            set(H.lbh11,'String',fieldnames(P_fft),'Value',[],'enable','on');
            set(H.lbh11,'Userdata',P_fft);
        else
            set(H.lbh11,'String',[],'Value',[],'Userdata',[],'enable','on');
            set(H.h12,'Userdata',[]);
        end
    end
    %-----------Deleting FFT of filtered signal
    if ~isempty(k_filtered_f)
        [signal_filtered_fft_arch,P_filtered_fft] = Update_arch_ComStruct(signal_filtered_fft_arch,P_filtered_fft,k_filtered_f);
        set(H.h32,'Userdata',signal_filtered_fft_arch)

        if ~isempty(fieldnames(P_filtered_fft))
            set(H.lbh31,'String',fieldnames(P_filtered_fft),'Value',[],'enable','on');
            set(H.lbh31,'Userdata',P_filtered_fft);
        else
            set(H.lbh31,'String',[],'Value',[],'Userdata',[],'enable','on');
            set(H.h32,'Userdata',[]);
        end
    end
    %------------- Deleting filter(s)
    if ~isempty(k_filter)
        filter_arch = get(H.lbh2,'Userdata');
        k_filter = [2*k_filter-1;2*k_filter];
        filter_arch(k_filter)=[];

        if isempty(filter_arch)
            set(H.lbh2,'String',[],'Userdata',[],'Value',[],'enable','on');
            set(H.Apply_filter_but,'enable','off');
            set(H.error_messages,'string',sprintf('Import Filter to Filter Data.'));
            set( H.Export_but,'enable','off');
        else
            set(H.lbh2,'String',filter_arch(2:2:end),'Userdata',filter_arch,'Value',[]);
        end
    end
    
    if isempty(k)& isempty(k_f)& isempty(k_filtered_f)&isempty(k_filter)& isempty(k_filtered)
        errordlg('You must select at least one lead to be deleted','Error');
    end

    %==============================================================
    %                        Export
    %==============================================================
elseif strcmp(cmd,'export')
    arg3 = get(H.lbh2,'Userdata');
    arg4 = get(H.lbh2,'Value');
    k_signal = get(H.lbh12,'Value');
    k_fft = get(H.lbh11,'Value');
    k_filtered = get(H.lbh32,'Value');
    k_filtered_fft = get(H.lbh31,'Value');
    if isempty(arg4)
        errordlg('You must select a filter to export','Error');
    elseif ~isempty(k_signal) | ~isempty(k_filtered)| ~isempty(k_fft)| ~isempty(k_filtered_fft)
        errordlg('Only filters can be exported','Error');
    elseif length(arg4)~=1
        errordlg('You must select only one filter to be exported','Error');
    elseif length(arg4)==1
        SAIDutil('SAIDexport','init','','',arg3,arg4);
    end
    
    % End for the main elseif
end
%======================================================================
% Intenal Functions
%======================================================================
% Constructing a common structure
%======================================================================
function P = ComStruct(arg1)

for i=1:2:length(arg1)
    LeadName = fieldnames(arg1{i});
    StoC = struct2cell(arg1{i});
    N = length(LeadName);
    for j = 1:N-1
        P.(char(LeadName(j))) = StoC{j};
    end
end
%======================================================================
% Updating arch & Comon Structure
%======================================================================
function [argin1,argin2] = Update_arch_ComStruct(argin1,argin2,argin3)

% argin1 = signal_arch
% argin2 = P
% argin3 = k

LeadName = fieldnames(argin2);
Selected_Lead=LeadName(argin3);
argin2 = rmfield(argin2,LeadName(argin3));
% This loop will update signal_arch content when some leads
% deleted
for s = 1:length(argin3)
    for i =1:2:length(argin1)
        if  strmatch(Selected_Lead(s),fieldnames(argin1{i}),'exact')
            argin1{i}=rmfield(argin1{i},Selected_Lead(s));
        end
    end
end



for i = (length(argin1)-1):-2:1
    if length(fieldnames(argin1{i}))==1,
        argin1(i+1)=[];
        argin1(i)=[];
    end
end

%======================================================================
% Updating arch
%======================================================================
function [signal_filtered_arch] = Arch_Update(signal_filtered_arch,P_filtered)
LeadName = fieldnames(P_filtered);
for i =1:2:length(signal_filtered_arch)
    bb = fieldnames(signal_filtered_arch{i});
    if length(fieldnames(signal_filtered_arch{i}))-1 ~=1
        for j = 1:length(fieldnames(signal_filtered_arch{i}))-1
            k = strmatch(bb(j),LeadName,'exact');
            if isempty(k)
                signal_filtered_arch{i}=rmfield(signal_filtered_arch{i},bb(j));
            else
                LeadName(k)='';
            end
        end
    end
end

for i = (length(signal_filtered_arch)-1):-2:1
    if length(fieldnames(signal_filtered_arch{i}))==1,
        signal_filtered_arch(i+1)=[];
        signal_filtered_arch(i)=[];
    end
end
%======================================================================
% Set default values for parameters
%======================================================================
function uipos = getuipos

tlabelw = 25;
labelw = 32;
editw = 12;
border = 1.3333;
labelh = 1.5;
edith = 1.53846;
edith = 1.5;

figw = 160;
figh = 38.154;
%
sunits = get(0, 'Units');
set (0, 'Units', 'character');
ssinchar = get(0, 'ScreenSize');
set (0, 'Units', sunits);
%
figl = (ssinchar(3) - figw) / 2;
figb = (ssinchar(4) - figh) / 2;

uipos.fig = [figl,figb,figw,figh];

%
frame13w = (2/5)*(figw - (border*4));
frame13h = 27.077;
frame2w = frame13w/2;
frame2h = 20.846;
frame4w = 2*border+ 1.5*frame13w;
frame4h = 2.692;

uipos.frame1 = [border,frame4h+2*border,2*frame13w+2*border+frame2w,frame13h];
%uipos.frame3 = [3*frame13w/2+3*border,5.3586,frame13w,frame13h];
uipos.frame2 = [2*border+frame13w,frame4h+2.5*border+(frame13h-frame2h),frame13w/2,frame2h-0.5*border];
uipos.frame4 = [border,border,frame4w,frame4h];
uipos.error_messages = [border+(.3*border),0.307692+1.5*border,frame4w-(.6*border),1.64103-.5*border];

labell = (figw-tlabelw)/2;
%
buth =1.69231;
butw = 0.5*(frame13w-12*border);
%
lb11h = 0.5*(frame13h-3*border-1.5*labelh-buth);
lb11w = frame13w-2*border;
lb2h = frame2h-5*border-3*buth;
lb2w = frame2w-2*border;
%
uipos.lb11= [2*border,frame4h+3*border,lb11w,lb11h];
uipos.lb12= [2*border,frame4h+5*border+buth+labelh+lb11h,lb11w,lb11h];
uipos.lb31= [2*border+frame4w,frame4h+3*border,lb11w,lb11h];
uipos.lb32= [2*border+frame4w,frame4h+5*border+buth+labelh+lb11h,lb11w,lb11h];
%
uipos.lb2 = [3*border+frame13w,8.5*border+frame4h+5*buth,lb2w,lb2h];
%
uipos.h11 = [frame13w/2+border-tlabelw/2,2*border+frame4h+frame13h-labelh/2,tlabelw,labelh];
uipos.h12 = [frame13w/2+border-tlabelw/2,3.5*border+frame4h+lb11h-labelh/2,tlabelw,labelh];
uipos.h31 = [2*frame13w+3*border-tlabelw/2,2*border+frame4h+frame13h-labelh/2,tlabelw,labelh];
uipos.h32 = [2*frame13w+3*border-tlabelw/2,3.5*border+frame4h+lb11h-labelh/2,tlabelw,labelh];
uipos.h2 = [2.5*frame13w/2+2*border-tlabelw/2,2*border+frame4h+frame13h-labelh/2,tlabelw,labelh];
%
%
uipos.Title_std_signal_processing = [(figw-4*border-(5.5/2)*frame13w),33.8462,3*frame13w,2.23077];

%
uipos.Import_but1 = [5*border,border*4+frame4h+lb11h+labelh,butw,1.64103];
uipos.Import_but2 = [2*border+(frame2w-butw)/2+frame13w,border*4+frame4h+lb11h+labelh,butw,1.64103];
uipos.Design_filter_but = [2*border+(frame2w-butw)/2+frame13w,border*2+frame4h+lb11h+labelh,butw,1.64103];
uipos.Apply_filter_but = [2*border+(frame2w-butw)/2+frame13w,frame4h+lb11h+labelh,butw,1.64103];
uipos.Display_but = [2*border+(frame2w-butw)/2+frame13w,frame4h+lb11h+labelh-3.5*border,butw,1.64103];
uipos.Delete_but = [2*border+(frame2w-butw)/2+frame13w,frame4h+lb11h+labelh-5.5*border,butw,1.64103];
uipos.FFT_but1 = [9*border+butw,border*4+frame4h+lb11h+labelh,butw,1.64103];
uipos.FFT_but3 = [7*border+frame13w+frame2w,border*4+frame4h+lb11h+labelh,butw,1.64103];
uipos.Statistics_but = [11*border+frame13w+frame2w+butw,border*4+frame4h+lb11h+labelh,butw,1.64103];
uipos.Export_but = [figw-border-2*butw,(border*2+frame4h-buth)/2,butw-4*border,1.64103];
uipos.Close_but = [figw-2*border-1*butw,(border*2+frame4h-buth)/2,butw-4*border,1.64103];
