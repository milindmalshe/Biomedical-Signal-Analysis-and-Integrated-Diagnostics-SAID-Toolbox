function BatchMode(cmd,arg1,arg2,arg3,arg4)
    % BatchMode is the common GUI for all the module of SAID toolbox
    %   	
    %       Syntax
    %
    %	 BatchMode(cmd,arg1,arg2,arg3)
    %
    %       Description
    % BatchMode program will generate the bacth mode graphical user
    % interface part of SAID toolbox. This code is called from signal
    % proceessing, feature extraction and pattern recognition module. 
    % The three text boxes should be filled in order to make the program 
    % works. The source folder, definition file and destination folder are 
    % the boxes which need to be filled. 
    
    %     Algorithm
    % The program load all data from source folder. Then you should declare
    % the definition file. Finally the results will be save in the
    % desinition folder. Before saving the results in the destination
    % folder the program check the validity of the source folder and 
    % definition file. If they are incomplete in in a wrong format the 
    % error message will pop up.  
    
    % 
    % SAID Toolbox Component
    
%     clc
    
    % DEFAULTS
    if nargin == 0, cmd = ''; else cmd = lower(cmd); end

    % FIND WINDOW IF IT EXISTS
    fig = 0;

    % We alow the program to see hidden handles
    fig=findall(0,'type','figure','tag','BatchMode');
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
           BatchMode('init')
        end
    % 
    %==================================================================
    % Close the window.
    %
    % ME() or ME('')
    %==================================================================

    elseif strcmp(cmd,'close') & (fig)
        if exist(cat(2,tempdir,'BatchMode.mat'))
            delete(cat(2,tempdir,'BatchMode.mat'));
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

    
    if  strcmp(arg3,'Signal Processing Batch Mode')
        H.me='Signal Processing Batch Mode';
        H.DefFileName = 'Filter Definition File';
    
    elseif strcmp(arg3,'Feature Extraction')
        H.me = 'Feature Extraction Batch Mode';
        H.DefFileName = 'Feature Definition File';
        
    elseif strcmp(arg3,'Pattern Recognition')
        H.me = 'Pattern Recognition Batch Mode';
        H.DefFileName = 'Pattern Definition File';
    end
      
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
                 'Tag','BatchMode', ...
                 'Resize','off', ... 
                 'ToolBar','none');
        
    H.Close_but = uicontrol('Parent',fig, ...
                'Units',H.StdUnit, ...
                'Callback','SAIDutil(''BatchMode'',''Close'',gcbf)', ...
                'Enable','on', ...
                'ListboxTop',0, ...
                'Position',uipos.Close_but, ...
                'String','Close', ...
                'ToolTipStr','Close',...
                'Tag','Close_but');
            
            
    H.Frame1 = uicontrol('Parent',fig, ...
                'Units',H.StdUnit, ...
                'BackgroundColor',[0.8 0.8 0.8], ...
                'ListboxTop',0, ...
                'Position',uipos.Frame1, ...
                'Style','frame', ...
                'Tag','Frame1');
            
    H.Frame2 = uicontrol('Parent',fig, ...
                'Units',H.StdUnit, ...
                'BackgroundColor',[0.8 0.8 0.8], ...
                'ListboxTop',0, ...
                'Position',uipos.Frame2, ...
                'Style','frame', ...
                'Tag','Frame2');
            
            
    H.EditTextBox1 = uicontrol('Parent',fig, ...
                     'Units',H.StdUnit, ...
                     'BackgroundColor',[1 1 1], ...
                     'Enable','on', ...
                     'ListboxTop',0, ...
                     'Position',uipos.EditTextBox1, ...
                     'Style','edit', ...
                     'ToolTipStr','Enter the name of folder', ...
                     'Tag','FileNameEdit');
                 
                 
    H.EditTextBox2 = uicontrol('Parent',fig, ...
                     'Units',H.StdUnit, ...
                     'BackgroundColor',[1 1 1], ...
                     'Enable','on', ...
                     'ListboxTop',0, ...
                     'Position',uipos.EditTextBox2, ...
                     'Style','edit', ...
                     'ToolTipStr','Enter the name of file', ...
                     'Tag','FileNameEdit');
                 
                 
    H.EditTextBox3 = uicontrol('Parent',fig, ...
                     'Units',H.StdUnit, ...
                     'BackgroundColor',[1 1 1], ...
                     'Enable','on', ...
                     'ListboxTop',0, ...
                     'Position',uipos.EditTextBox3, ...
                     'Style','edit', ...
                     'ToolTipStr','Enter the name of folder', ...
                     'Tag','FileNameEdit');
                 
    H.Browse1 = uicontrol('Parent',fig, ...
                'Units',H.StdUnit, ...
                'Callback','BatchMode(''browse1'',gcbf)', ...
                'Enable','on', ...
                'ListboxTop',0, ...
                'Position',uipos.Browse1, ...
                'String','Browse', ...
                'ToolTipStr','Browse',...
                'Tag','Browse1');
            
     
         
    H.Browse3 = uicontrol('Parent',fig, ...
                'Units',H.StdUnit, ...
                 'Callback','BatchMode(''browse3'',gcbf)', ...
                'Enable','on', ...
                'ListboxTop',0, ...
                'Position',uipos.Browse3, ...
                'String','Browse', ...
                'ToolTipStr','Browse',...
                'Tag','Browse3');
            
            
    H.h11 = uicontrol('Parent',fig, ...
                 'Units',H.StdUnit, ...
                 'BackgroundColor',[0.8 0.8 0.8], ...
                 'Enable',window_en, ...
                 'ListboxTop',0, ...
                 'Position',uipos.h11, ...
                 'String','', ...
                 'Style','text', ...
                 'Tag','Folder Name 11');

    
    H.h12 = uicontrol('Parent',fig, ...
                 'Units',H.StdUnit, ...
                 'BackgroundColor',[0.8 0.8 0.8], ...
                 'Enable',window_en, ...
                 'ListboxTop',0, ...
                 'Position',uipos.h12, ...
                 'String','',...
                 'Style','text', ...
                 'Tag','Folder Name 12');
   
             
             
    H.h21 = uicontrol('Parent',fig, ...
                 'Units',H.StdUnit, ...
                 'BackgroundColor',[0.8 0.8 0.8], ...
                 'Enable',window_en, ...
                 'ListboxTop',0, ...
                 'Position',uipos.h21, ...
                 'String','File Name', ...
                 'Style','text', ...
                 'Tag','Folder Name 21');

    
    H.h22 = uicontrol('Parent',fig, ...
                'Units',H.StdUnit, ...
                 'BackgroundColor',[0.8 0.8 0.8], ...
                 'Enable',window_en, ...
                 'ListboxTop',0, ...
                 'Position',uipos.h22, ...
                 'String',H.DefFileName,...
                 'Style','text', ...
                 'Tag','Folder Name 22');
   
             
    H.h31 = uicontrol('Parent',fig, ...
                 'Units',H.StdUnit, ...
                 'BackgroundColor',[0.8 0.8 0.8], ...
                 'Enable',window_en, ...
                 'ListboxTop',0, ...
                 'Position',uipos.h31, ...
                 'String','', ...
                 'Style','text', ...
                 'Tag','Folder Name 31');

    
    H.h32 = uicontrol('Parent',fig, ...
                 'Units',H.StdUnit, ...
                 'BackgroundColor',[0.8 0.8 0.8], ...
                 'Enable',window_en, ...
                 'ListboxTop',0, ...
                 'Position',uipos.h32, ...
                 'String','',...
                 'Style','text', ...
                 'Tag','Folder Name 32');
           
    H.message = uicontrol('Parent',fig, ...
                 'Units',H.StdUnit, ...
                 'FontWeight','bold', ...
                'BackgroundColor',[0.8 0.8 0.8], ...
                'ForegroundColor',[0 0 1],... 
                 'Enable',window_en, ...
                 'ListboxTop',0, ...
                 'Position',uipos.message, ...
                 'String','Choose Source Folder to Get Started', ...
                 'Style','text', ...
                 'Tag','Comments'); 
             
    H.h = uicontrol('Parent',fig, ...
                 'Units',H.StdUnit, ...
                 'BackgroundColor',[0.8 0.8 0.8], ...
                 'Enable',window_en, ...
                 'ListboxTop',0, ...
                 'Position',uipos.h, ...
                 'String',H.me,...
                 'Style','text', ...
                 'Tag','Frame_Caption');
             
             
    H.Title_BatchMode = uicontrol('Parent',fig, ...
                'Units',H.StdUnit, ...
                'BackgroundColor',[0.8 0.8 0.8], ...
                'FontSize',14, ...
                'ListboxTop',0, ...
                'Position',uipos.BatchMode, ...
                'String',H.me, ...
                'Style','text', ...
                'Tag','BatchMode');
            
%      H.Handles.Menus.File.Top= uimenu('Parent',fig, ...
%                 'Label','File'); 
  
     if  strcmp(arg3,'Signal Processing Batch Mode')
         H.Apply_but = uicontrol('Parent',fig, ...
                'Units',H.StdUnit, ...
                'Callback','SAIDutil(''BatchMode'',''apply'','''','''',''Signal Processing Batch Mode'')', ...
                'Enable','on', ...
                'ListboxTop',0, ...
                'enable','off',...
                'Position',uipos.Apply_but, ...
                'String','Apply', ...
                'ToolTipStr','Apply',...
                'Tag','Apply_but');
           
           
            H.Browse2 = uicontrol('Parent',fig, ...
                'Units',H.StdUnit, ...
                'Callback','SAIDutil(''SAIDimport'',''init'','''','''',''Import Filter_BatchMode'')', ...
                'Enable','on', ...
                'ListboxTop',0, ...
                'Position',uipos.Browse2, ...
                'String','Browse', ...
                'ToolTipStr','Browse',...
                'Tag','Browse2');
            
%         H.Handles.Menus.File.Browse2 = uimenu('Parent',...
%                 H.Handles.Menus.File.Top,...
%                 'Label','Browse Definition File',...
%                 'Enable','on', ...
%                 'Accelerator','A',...
%                 'Callback','SAIDutil(''SAIDimport'',''init'','''','''',''Import Filter_BatchMode'')', ...
%                 'Enable','on', ...
%                 'Tag','browse2');  
            set(H.h11,'String','Folder Name');
            set(H.h12,'String','Source Folder');
            set(H.h31,'String','Folder Name');
            set(H.h32,'String','Destination Folder');

        
    elseif strcmp(arg3,'Feature Extraction')
         H.Apply_but = uicontrol('Parent',fig, ...
                'Units',H.StdUnit, ...
                'Callback','SAIDutil(''BatchMode'',''apply'','''','''',''Feature Extraction'')', ...
                'Enable','on', ...
                'ListboxTop',0, ...
                'enable','off',...
                'Position',uipos.Apply_but, ...
                'String','Apply', ...
                'ToolTipStr','Apply',...
                'Tag','Apply_but');
                        
     
            H.Browse2 = uicontrol('Parent',fig, ...
                'Units',H.StdUnit, ...
                'Callback','SAIDutil(''SAIDimport'',''init'','''','''',''Import Feature Definition_Batch'')', ...   
                'Enable','on', ...
                'ListboxTop',0, ...
                'Position',uipos.Browse2, ...
                'String','Browse', ...
                'ToolTipStr','Browse',...
                'Tag','Browse2');
            
%               H.Handles.Menus.File.Browse2 = uimenu('Parent',...
%                 H.Handles.Menus.File.Top,...
%                 'Label','Browse Definition File',...
%                 'Enable','on', ...
%                 'Accelerator','A',...
%                  'Callback','SAIDutil(''SAIDimport'',''init'','''','''',''Import Feature Definition_Batch'')', ... 
%                 'Enable','on', ...
%                 'Tag','browse2');  
            
           set(H.h11,'String','Folder Name');
           set(H.h12,'String','Source Folder');
           set(H.h31,'String','File Name');
           set(H.h32,'String','Destination File');


    elseif strcmp(arg3,'Pattern Recognition')
         H.Apply_but = uicontrol('Parent',fig, ...
                'Units',H.StdUnit, ...
                'Callback','SAIDutil(''BatchMode'',''apply'','''','''',''Pattern Recognition'')', ...
                'Enable','on', ...
                'ListboxTop',0, ...
                'enable','off',...
                'Position',uipos.Apply_but, ...
                'String','Apply', ...
                'ToolTipStr','Apply',...
                'Tag','Apply_but');
            
        H.Browse2 = uicontrol('Parent',fig, ...
                'Units',H.StdUnit, ...
                'Callback','SAIDutil(''SAIDimport'',''init'','''','''',''Import Network Definition_Batch'')', ...
                'Enable','on', ...
                'ListboxTop',0, ...
                'Position',uipos.Browse2, ...
                'String','Browse', ...
                'ToolTipStr','Browse',...
                'Tag','Browse2');
           
%            H.Handles.Menus.File.Browse2 = uimenu('Parent',...
%                 H.Handles.Menus.File.Top,...
%                 'Label','Browse Definition File',...
%                 'Enable','on', ...
%                 'Accelerator','A',...
%                 'Callback','SAIDutil(''SAIDimport'',''init'','''','''',''Import Network Definition_Batch'')', ...
%                 'Enable','on', ...
%                 'Tag','browse2'); 
      
           set(H.h11,'String','File Name');
           set(H.h12,'String','Source File');
           set(H.h31,'String','File Name');
           set(H.h32,'String','Destination File');
 
         
         
     end
    %=====================================================================
    % Menu 
%      H.Handles.Menus.File.Top= uimenu('Parent',fig, ...
%         'Label','File');
%      H.Handles.Menus.Help.Top= uimenu('Parent',fig, ...
%         'Label','Help');
%      H.Handles.Menus.File.Apply = uimenu('Parent',...
%         H.Handles.Menus.File.Top,...
%         'Label','Apply',...
%         'Enable','off', ...
%         'Accelerator','A',...
%         'Callback','SAIDutil(''BatchMode'',''apply'');',...
%         'Tag','Apply'); 
%     
%      H.Handles.Menus.File.Browse1 = uimenu('Parent',...
%          H.Handles.Menus.File.Top,...
%         'Label','Browse Sourse Folder',...
%         'Enable','on', ...
%         'Accelerator','A',...
%         'Callback','SAIDutil(''BatchMode'',''browse1'');',...
%         'Tag','Browse1');  
%     
%      H.Handles.Menus.File.Browse2 = uimenu('Parent',...
%             H.Handles.Menus.File.Top,...
%         'Label','Browse Definition File',...
%         'Enable','on', ...
%         'Accelerator','A',...
%         'Callback','SAIDutil(''BatchMode'',''browse2'');',...
%         'Tag','browse2');  
    
%      H.Handles.Menus.File.Browse3 = uimenu('Parent',...
%             H.Handles.Menus.File.Top,...
%         'Label','Browse Destinition Folder',...
%         'Enable','on', ...
%         'Accelerator','A',...
%         'Callback','SAIDutil(''BatchMode'',''browse3'');',...
%         'Tag','browse3');  
%     
%     
    H.arg3=arg3;        
    set(fig,'Userdata',H);         
    %======================================================================
    % Browse1
    %======================================================================
    elseif strcmp(cmd,'browse1')
        FilterName = get(H.EditTextBox2,'String');
        DestFolder = get(H.EditTextBox3,'String');
        arg3 = H.arg3;
        
        if  strcmp(arg3,'Signal Processing Batch Mode')
             SourceFolder = uigetdir;
             set(H.message,'string',sprintf('Choose Filter Definition File.'));    
    
             if ~SourceFolder
                 set(H.EditTextBox1,'String',[]);
             else
                 set(H.EditTextBox1,'String',SourceFolder);
             end

             if ~isempty(DestFolder) &~ isempty(SourceFolder) & ~isempty(FilterName)
                 set(H.Apply_but,'enable','on');
             end

        elseif strcmp(arg3,'Feature Extraction')
            SourceFolder = uigetdir;
            set(H.message,'string',sprintf('Choose Feature Definition File.'));

            if ~SourceFolder
                set(H.EditTextBox1,'String',[]);
            else
                set(H.EditTextBox1,'String',SourceFolder);
            end

            if ~isempty(DestFolder) &~ isempty(SourceFolder) & ~isempty(FilterName)
                set(H.Apply_but,'enable','on');
            end


        elseif strcmp(arg3,'Pattern Recognition')
            [SourceFile,pathname] = uigetfile('.mat','Import file:');
            set(H.message,'string',sprintf('Choose Pattern Definition File.'));
            set(H.h11,'Userdata',pathname);
            
            if ~SourceFile
                set(H.EditTextBox1,'String',[]);
            else
                set(H.EditTextBox1,'String',SourceFile);
            end

            if ~isempty(DestFolder) &~ isempty(SourceFile) & ~isempty(FilterName)
                set(H.Apply_but,'enable','on');
            end




        end
    %======================================================================
    % Browse2
    %======================================================================
    elseif strcmp(cmd,'browse2') 
        arg3 = H.arg3;
   
        SourceFolder = get(H.EditTextBox1,'String');
        DestFolder = get(H.EditTextBox3,'String');

        FilterObject = arg1;
        FilterName = arg2;
       
        if isempty(FilterName)
            set(H.EditTextBox2,'String',[]);
         
        else
            set(H.EditTextBox2,'String',FilterName,'Userdata',...
                FilterObject);
    
            set(H.message,'string',sprintf('Choose Destination Folder.'));
         end
        if ~isempty(DestFolder) &~ isempty(SourceFolder) & ~isempty(FilterName)
            set(H.Apply_but,'enable','on');
        end
        
        if ~isempty(DestFolder) &~ isempty(SourceFolder) & ~isempty(FilterName)
            set(H.Apply_but,'enable','on');
            %set(H.Handles.Menus.File.Apply,'enable','on'); 
        end
             
    %======================================================================
    % Browse3
    %======================================================================
    elseif strcmp(cmd,'browse3')
        arg3 = H.arg3;
        if  strcmp(arg3,'Signal Processing Batch Mode')

            SourceFolder = get(H.EditTextBox1,'String');
            FilterName = get(H.EditTextBox2,'String');
            DestFolder = uigetdir;
            if ~DestFolder
                set(H.EditTextBox3,'String',[]);
            else
                SourceFolder = get(H.EditTextBox1,'String');
                set(H.EditTextBox3,'String',DestFolder );
                set(H.message,'string',sprintf('Press Apply to Continue.'));
            end
            if ~isempty(DestFolder) &~ isempty(SourceFolder) & ~isempty(FilterName)
                set(H.Apply_but,'enable','on');
                %set(H.Handles.Menus.File.Apply,'enable','on');
            end



        elseif strcmp(arg3,'Feature Extraction')
            
            SourceFolder = get(H.EditTextBox1,'String');
            FilterName = get(H.EditTextBox2,'String');
            FileName = get(H.EditTextBox3,'String');
            [DestFile,pathname] = uiputfile('.mat','',char(FileName));
            Dest.FileName = DestFile;
            Dest.pathname = pathname;
            set(H.h31,'Userdata',Dest);
            if ~DestFile
                set(H.EditTextBox3,'String',[]);
            else
                SourceFolder = get(H.EditTextBox1,'String');
                set(H.EditTextBox3,'String',DestFile );
                set(H.message,'string',sprintf('Press Apply to Continue.'));
            end
            if ~isempty(DestFile) &~ isempty(SourceFolder) & ~isempty(FilterName)
                set(H.Apply_but,'enable','on');
           %     set(H.Handles.Menus.File.Apply,'enable','on');
            end

        elseif strcmp(arg3,'Pattern Recognition')

            SourceFile = get(H.h11,'Userdata');
            FilterName = get(H.EditTextBox2,'String');
            FileName = get(H.EditTextBox3,'String');
            [DestFile,pathname] = uiputfile('.mat','',char(FileName));
            Dest.FileName = DestFile;
            Dest.pathname = pathname;
            set(H.h31,'Userdata',Dest);
            if ~DestFile
                set(H.EditTextBox3,'String',[]);
            else
                SourceFile = get(H.EditTextBox1,'String');
                set(H.EditTextBox3,'String',DestFile );
                set(H.message,'string',sprintf('Press Apply to Continue.'));
            end
            if ~isempty(DestFile) &~ isempty(SourceFile) & ~isempty(FilterName)
                set(H.Apply_but,'enable','on');
           %     set(H.Handles.Menus.File.Apply,'enable','on');
            end


        end
            
    %======================================================================
    % Apply
    %======================================================================
    elseif strcmp(cmd,'apply')  
        
        CurrentDir = pwd;
        
        DestFolder = get(H.EditTextBox3,'String');
        FilterName = get(H.EditTextBox2,'String');
        FilterObject = get(H.EditTextBox2,'Userdata');
        
        s=1; 
        m=0;
        arg3 = H.arg3;
        if  strcmp(arg3,'Signal Processing Batch Mode')
            SourceFolder = get(H.EditTextBox1,'String');
            SLocation = strcat(SourceFolder,'/*.mat');
            z = dir(SLocation);
            h = waitbar(0,'Filtering Signals...');
            
            NumPatient = length(z);
            mesw = cell(NumPatient,1);
            for k = 1:NumPatient
%                 clear Patient c
               
                [m,s,mesw{k}] = BatchFilter(SourceFolder,DestFolder,FilterObject,z(k).name,m,s,NumPatient,FilterName,H);
                cd(CurrentDir);
            end
            
            if exist('mesw')
                for i =1:length(mesw)
                    if ~isempty(mesw{i})
                        display(mesw{i})
                    end
                end
            
            end
            delete(h);
            set(H.Apply_but,'enable','off')
           %  set(H.Handles.Menus.File.Apply,'enable','off'); 
            set(H.message,'string',sprintf('All Good Signals Filtered Successfully')); 
    
            
       %===================== MILIND =========================   
        elseif strcmp(arg3,'Feature Extraction')
            mCounter = 0;
            Dest = get(H.h31,'Userdata');
            SourceFolder = get(H.EditTextBox1,'String');
            SLocation = strcat(SourceFolder,'/*.mat');
            z = dir(SLocation);
            h = waitbar(0,'Extracting Features...');
            count_GOODpatientsONLY = 0;
            
            for k = 1:length(z)
                
                clear features_Call;
                flag_NaN = 0;
                
                try
                Patient{1} = z(k).name;
                c{1} = load(fullfile(SourceFolder,Patient{1}));
                indDot = findstr(Patient{1},'.');
                if ~isempty(indDot),
                    Patient{1} = Patient{1}(1:indDot(end)-1);
                end

                arg2 = char(Patient{1});%
                LeadName = fieldnames(c{1});
                arg1 = c{1}.(char(LeadName));
                %---- Check the validity of the selected Data
                cd(CurrentDir)
                %                 [flag] = checkEKGstructformat(fieldnames(arg1));
                Value = struct2cell(arg1);%%%%%***** Changed by Milind so as to be compatible with Dr. Hagan's "checkEKGstructformat.m" code
                [flag] = checkEKGstructformat(fieldnames(arg1),Value);%%%%%***** Changed by Milind so as to be compatible with Dr. Hagan's "checkEKGstructformat.m" code

                catch
                    flag =0;
                end
          
                if flag == 0,
                    mes = ['Leads of '  arg2  ' is incomplete'];
                    mesw{k} = mes;
                    set(H.message,'string',char(mes));
                    mCounter = mCounter+1;
                    if mCounter==1
                        warndlg('Some files were bad. See the command windows for details');
                    end
                    
                    s = s+1;
                    
                else
                    count_GOODpatientsONLY = count_GOODpatientsONLY + 1;
                    cd(Dest.pathname)
                    LeadName = fieldnames(arg1);
                    cc = struct2cell(arg1);
                    StdFieldName = {'i';'ii';'iii';'avl';'avr';'avf';'v1';'v2';'v3';...
                        'v4';'v5';'v6';'vx';'vy';'vz'};

                    cd(CurrentDir);

                    arg1=ChangeFieldName(arg1,'');
                    EKGsignal = arg1;
                    EKGsignalName = arg2;

                    
                    if(strcmp(FilterObject.MatlabFeatures_button,'on'))
                        features_Call = featureFunction_Call(EKGsignal,EKGsignalName,...
                            FilterObject.MatlabFeatureList_functionNames,[1:length(FilterObject.MatlabFeatureList_functionNames)]);
                    end
                    
                    
                    
                    if(strcmp(FilterObject.FortranFeatures_button,'on'))
                        MJ23 = FilterObject.RwaveLead_popUp_Value;
                        
                        MJ16 = FilterObject.downSamplingRate_popUp;
                        if(MJ16==1)
                            MJ17=0;
                        else
                            MJ17=1;
                        end
                        
                        MJ28 = FilterObject.pointsNumericalDeriv_popUp;
                        MJ29 = FilterObject.stepSizeQRS_editBox;
                        
                        MJ24 = FilterObject.baselineCorrection_button;



                        array_size = 99999;
                        MJ16=int32(MJ16);
                        MJ17=int32(MJ17);
                        MJ23=int32(MJ23);
                        MJ24=int32(MJ24);
                        MJ28=int32(MJ28);
                        MJ29=int32(MJ29);
                        DDDT= 1/EKGsignal.info.fs; %0.001;

                        EKGDATA = EKGsignal;


                        EKGDATA=struct2cell(EKGDATA);
                        EKGDATA(end) =[];
                        EKGDATA=cell2mat(EKGDATA');


                        [m,n] = size(EKGDATA);
                        MJ1=int32(n);
                        NDATA=int32(m);

                        % Assume that original EKGDATA just has leads.  Add time as first column.
                        t = 0:DDDT:(m-1)*DDDT;
                        EKGDATA = [t(:) EKGDATA];


                        % Fill in array with zeros, up to the size that is set in the Fortran code.
                        EKGDATA = [EKGDATA;zeros(array_size-m,(n+1) )];
                        

                        features_value_FORTRAN = FortranFeatures(MJ1,MJ16,MJ17,MJ23,MJ24,MJ28,MJ29,DDDT,NDATA,EKGDATA);
                        features_name_FORTRAN = FeatureDescrip();
                        numFORTRANfeatures = length(features_name_FORTRAN);
                        features_value_FORTRAN = features_value_FORTRAN(1:numFORTRANfeatures);
                        
                        
                        % % % % %******$$$$$ MILIND
                        % % % % %******$$$$$ THIS IS TEMPORARY CODE, DELETE IT AFTER THE PROBLEM IS SOLVED,
                        %  SINCE Dr. RAFF'S FORTRAN CODE OUTPUTS NaN VALUES FOR FEATURES,
                        % WHICH CAUSES PROBLEM IN PATTERN RECOGNITION MODULE
                        if(sum(isnan(features_value_FORTRAN) > 0))
                            if(~exist('NaN_FORTRANfeatures'))
                                NaN_FORTRANfeatures = 1;
                            else
                                NaN_FORTRANfeatures = NaN_FORTRANfeatures +1;
                            end
                                NaN_FORTRANfeatures_PatientName{NaN_FORTRANfeatures} = EKGsignalName;
                                

                        end
                        % % % % %******$$$$$ MALSHE
                        NaN_ind = find(isnan(features_value_FORTRAN));
                        if(sum(isnan(features_value_FORTRAN) > 0))
                            disp(['For Patient:  ' EKGsignalName '  the following features could not be computed']);
                            for ii = 1:length(NaN_ind)
                                disp(features_name_FORTRAN{NaN_ind(ii)})
                            end
                            
                            count_GOODpatientsONLY = count_GOODpatientsONLY - 1;
                            
                            flag_NaN = 1;

                        else
                            if(exist('features_Call'))
                                features_Call.value = [features_Call.value features_value_FORTRAN'];
                                features_Call.name = cat(2,features_Call.name,features_name_FORTRAN);
                            else
                                features_Call.value = [features_value_FORTRAN'];
                                features_Call.name = features_name_FORTRAN;
                            end

                        end


                            

                    end
                    
                    if(flag_NaN == 0 )
                        if (count_GOODpatientsONLY == 1)
                            features(1,1).name = features_Call.name;
                            features(count_GOODpatientsONLY,1).value = features_Call.value;
                            features(count_GOODpatientsONLY,1).Patient.name = {EKGsignalName};
                            features(count_GOODpatientsONLY,1).Patient.info = {EKGsignal.info};
                            features(count_GOODpatientsONLY,1).diagnosis = {EKGsignal.info.Diagnosis};
                        else
                            features(1,1).name = features_Call.name;
                            features.value(count_GOODpatientsONLY,:) = features_Call.value;
                            features.Patient.name(count_GOODpatientsONLY,:) = {EKGsignalName};
                            features.Patient.info(count_GOODpatientsONLY,:) = {EKGsignal.info};
                            features.diagnosis(count_GOODpatientsONLY,:) = {EKGsignal.info.Diagnosis};
                        end


                        waitbar((s)/length(z));
                        s=s+1;
                        cd(Dest.pathname)
                        features.feature.Name = FilterName;
                        features.feature.Date = datestr(now);
                    end

                end
            end

            cd(Dest.pathname)
            
            if exist('features')
                features.name = features.name';
                features.value = features.value';
                features.Patient.name = features.Patient.name';
                features.Patient.info = features.Patient.info';
                features.diagnosis = features.diagnosis';
                
                NewName = Dest.FileName;
                
                %+++25-Oct-2007 21:18:22+++ RJ
                indDot = findstr(NewName,'.');
                if ~isempty(indDot),
                    NewName=NewName(1:indDot(end)-1);
                end
                %++++++               
                
                v = genvarname(NewName);
                eval([v ' = features;']);
                save(NewName,NewName);
                cd(CurrentDir);
            end
             cd(CurrentDir);
            if exist('mesw')
                for i =1:length(mesw)
                    if ~ isempty(mesw{i})
                        display(mesw{i})
                    end
                end
            end
            delete(h);
            set(H.Apply_but,'enable','off')
           % set(H.Handles.Menus.File.Apply,'enable','off'); 
            set(H.message,'string',sprintf('Complete, Check Matlab Workspace for Notes')); %, 'Check Matlab Workspace (Command Window) for List of Incomplete EKG Signals'
            
    %============================================================= 
        elseif strcmp(arg3,'Pattern Recognition')
            Dest = get(H.h31,'Userdata');
            SourceFile = get(H.EditTextBox1,'String');
            SLocation = strcat(SourceFile);
            pathname = get(H.h11,'Userdata');
            CurrentDir = pwd;
            cd(pathname);
            z = load(SourceFile);
            cd(CurrentDir);
            h = waitbar(0,'Classifying Patients...');
            
            % % % % %FOLLOWING CODE ARRANGES THE DATA IN A FORMAT USED IN "usingMLP.m" CODE FROM Dr. Hagan
           try 
           
            per.tr =  FilterObject.training_popUp/100;
            per.val = FilterObject.validation_popUp/100;
            per.tst = FilterObject.testing_popUp/100;

            par.per = per;
       
            if(FilterObject.numLayers_popUp == 2)
                numNeurons1 = (FilterObject.numNeurons_editBox_1);
                transferFcn1 = FilterObject.transferFunction_popUp_1;
                
                numNeurons2 = (FilterObject.numNeurons_editBox_2);
                transferFcn2 = FilterObject.transferFunction_popUp_2;
                
                par.netSize = [str2num(numNeurons1) str2num(numNeurons2)];
                par.tf = {transferFcn1,transferFcn2};
                
            elseif(FilterObject.numLayers_popUp == 3)
                numNeurons1 = (FilterObject.numNeurons_editBox_1);
                transferFcn1 = FilterObject.transferFunction_popUp_1;
                
                numNeurons2 = (FilterObject.numNeurons_editBox_2);
                transferFcn2 = FilterObject.transferFunction_popUp_2;
                
                numNeurons3 = (FilterObject.numNeurons_editBox_3);
                transferFcn3 = FilterObject.transferFunction_popUp_3;
                
                par.netSize = [str2num(numNeurons1) str2num(numNeurons2) str2num(numNeurons3)];
                par.tf = {transferFcn1,transferFcn2,transferFcn3};
            end


            par.epochs = FilterObject.epochs_editBox;

            par.trainFcn = FilterObject.trainingFunction_popUp;
            %             par.trainFcn = char(par.trainFcn);

            par.num_runs = FilterObject.numMonteCarloRuns_editBox;

            % %End of setting network training parameters
            
            
            data_features = z.(char(fieldnames(z)));
            data_fileName = fieldnames(data_features);
            arg1 = data_features;
            
            

            
            data.P = arg1.value;
            for i = 1:size(arg1.diagnosis,2)
                if(strcmp(lower(arg1.diagnosis{i}),'healthy control'))
                    data.T(i) = [1];
                elseif(strcmp(lower(arg1.diagnosis{i}),'myocardial infarction'))
                    data.T(i) = [-1];

                end
            end

            
            for i = 1:par.num_runs
                anT = sim(FilterObject.net{1},data.P);
                aT{i} = hardlims(anT);
                
                waitbar(i/par.num_runs);
            end

       
            delete(h);
            
            cd(Dest.pathname)
            
            %save Dest.FileName aT
            
            if exist('aT')
                
                NewName = Dest.FileName;
                v = genvarname(NewName);
                eval([v ' = aT;']);
                save(NewName,NewName);
                cd(CurrentDir);
            end

            catch
                warndlg('Source file does not contain features')
                delete(h);
            end
            
            
        
        end % end    if  strcmp(arg3,'Signal Processing Batch Mode')
        set(H.Apply_but,'enable','off');
       % set(H.Handles.Menus.File.Apply,'enable','off');
         
        set(H.message,'string',sprintf('Complete'));
    end
    
% % %     ===============  MALSHE   =======================
    %======================================================================
    % Set default values for parameters
    %======================================================================
    function uipos = getuipos
        labelw = 25;
        border = 1.3333;
        labelh = 1.5;
        edith = 1.5;
        buth = 1.6410;
        but_big_w = 22.9336;
        but_small_w = 17.6004;
        frame2h = 2.692;

        figw = border + border + 4*border + 4*border + border + border +...
               (1.5*border + but_big_w + 1.5*border)*3;
        figh = 2*border + buth + 2*border + 2*border + buth + border + edith+2*border+...
               2*labelh + 2*border + 2*border;
        % 
        sunits = get(0, 'Units');
        set (0, 'Units', 'character');
        ssinchar = get(0, 'ScreenSize');
        set (0, 'Units', sunits);
        % 
        figx = (ssinchar(3) - figw) / 2;
        figy = (ssinchar(4) - figh) / 2;

        uipos.fig = [figx,figy,figw,figh];

      
        %Frames
        frame1h = 2*border+buth+border+edith+2*border+2*labelh+2*border;
        frame1w = figw-2*border;
        uipos.Frame1 = [border,3*border+buth,figw-2*border,frame1h-1*border];
        uipos.Frame2 = [border,1*border,figw-2*but_small_w-5*border,frame2h];

        % Edit text field
        uipos.EditTextBox1 = [2*border,3*border+2*buth+3*border,3*border+...
                                but_big_w,edith];
        uipos.EditTextBox2 = [2*border+4*border+3*border+but_big_w,...
            3*border+2*buth+3*border,3*border+but_big_w,edith];
        uipos.EditTextBox3 = [2*border+8*border+6*border+2*but_big_w,...
            3*border+2*buth+3*border,3*border+but_big_w,edith];
        % Browse Buttom
        uipos.Browse1 = [3.5*border,3*border+buth+2*border,but_big_w,buth];
        uipos.Browse2 = [10.5*border+but_big_w,3*border+buth+2*border,...
            but_big_w,buth];
        uipos.Browse3 = [17.5*border+2*but_big_w,3*border+buth+2*border,...
            but_big_w,buth];          
          
        % Static Text
        uipos.h11 = [1.5*border,8*border+2*buth,labelw,labelh];
        uipos.h12 = [1.5*border,9*border+2*buth,labelw,labelh];
        uipos.h21 = [8.5*border+but_big_w,8*border+2*buth,labelw,labelh];
        uipos.h22 = [8.5*border+but_big_w,9*border+2*buth,labelw,labelh];
        uipos.h31 = [15.5*border+2*but_big_w,8*border+2*buth,labelw,labelh];
        uipos.h32 = [15.5*border+2*but_big_w,9*border+2*buth,labelw,labelh];
        uipos.h = [border+(frame1w-1.5*labelw)/2,figh-5*border,labelw+15,labelh];
        uipos.BatchMode = [(figw-63*border),figh-2.5*border,70,2.23077];
        
        uipos.message = [border+figw-2*but_small_w-5*border-35.5*labelh,.01*border+.7*frame2h,labelw+20*border,labelh];
        % Buttoms
        uipos.Apply_but = [figw-2*but_small_w-2-border,border+frame2h/6,...
            but_small_w,buth];
        uipos.Close_but = [figw-but_small_w-border,border+frame2h/6,...
            but_small_w,buth];
          
