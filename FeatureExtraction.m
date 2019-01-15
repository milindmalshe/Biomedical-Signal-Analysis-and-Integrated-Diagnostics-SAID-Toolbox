

function FeatureExtraction(cmd,arg1,arg2,arg3)

% 
% FeatureExtraction: Extract features from EKG signal
% 
% Syntax
%     FeatureExtraction()
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
fig=findall(0,'type','figure','tag','FeatureExtraction');
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
        FeatureExtraction('init')
    end

    %==================================================================
    % Close the window.
    %
    % ME() or ME('')
    %==================================================================

elseif strcmp(cmd,'close') & (fig)
    if exist(cat(2,tempdir,'FeatureExtractionData.mat'))
        delete(cat(2,tempdir,'FeatureExtractionData.mat'));
    end
    delete(fig);

% % % % % MILIND    
elseif strcmp(cmd,lower('extractFeature'))
 
    
    select_Patients = get(H.inputSignal_listBox,'Value');

    signal_arch_ALL = get(H.inputSignal_listBox,'Userdata');
    
    num_select_Patients = length(select_Patients);
    
    if( num_select_Patients == 0)
        errordlg('Select atleast 1 record for feature extraction','Error');
        return
    end
    
    for i = 1: (num_select_Patients) 
        
        %         select_Patients(i)
        %         signal_arch_ALL(select_Patients(i))
        
        signal_arch_SELECT((2*i)-1) = signal_arch_ALL((2*select_Patients(i))-1);
        signal_arch_SELECT(2*i) = signal_arch_ALL((2*select_Patients(i)));
    end
    
    numPatients = length(signal_arch_SELECT)/2;
    
    for i = 0:(numPatients-1)
        Patient{i+1} = signal_arch_SELECT{((2*i)+1)};
        PatientName(i+1) = signal_arch_SELECT(2*(i+1));
        PatientInfo{i+1} = signal_arch_SELECT{2*i+1}.info;
    end
    

    
    
%     %%%% MILIND modified on 10-07-07
%     if( get(H.MatlabFeatures_button_on,'Value') == 1)
%         call_extractFeatureList_functionsNames = get(H.MatlabFeatures_listBox,'Value');
% 
%         %     features.name = []; features.value = [];
% %         features = struct('name',{},'value',{}); % Define a structure
%         %     count_features = 0;
% 
%         numFeatureFile = length(call_extractFeatureList_functionsNames);
%         %%%% MALSHE modified on 10-07-07
        
        
        H_waitbar = waitbar(0,'Extracting features...');
        
               
        
        
        for i = 1:numPatients
            
            clear features_Call;

            if( (get(H.MatlabFeatures_button_on,'Value') == 1) | (get(H.FortranFeatures_button_on,'Value') == 1))
                
                if( (get(H.MatlabFeatures_button_on,'Value') == 1))
                    call_extractFeatureList_functionsNames = get(H.MatlabFeatures_listBox,'Value');

                    numFeatureFile = length(call_extractFeatureList_functionsNames);

                    %             features_Call = featureFunction_Call(Patient{i},PatientName{i},PatientInfo{i},H.MatlabFeatureList_functionNames,call_extractFeatureList_functionsNames);

                    features_Call = featureFunction_Call(signal_arch_SELECT{((2*i)-1)},signal_arch_SELECT(2*(i+1)-2),H.MatlabFeatureList_functionNames,call_extractFeatureList_functionsNames);
                    
                    
                end
                
                
                if((get(H.FortranFeatures_button_on,'Value') == 1))
                    
                    %%%%TEMP
                    MJ23 = (get(H.RwaveLead_popUp,'Value'));

                    downSamplingRate_popUp_String = str2num(H.downSamplingRate_popUp_String);
                    MJ16 = downSamplingRate_popUp_String(get(H.downSamplingRate_popUp,'Value'));
                    
                    if(MJ16==1)
                        MJ17=0;
                    else
                        MJ17=1;
                    end
                    
                    pointsNumericalDeriv_popUp_String = str2num(H.pointsNumericalDeriv_popUp_String);
                    MJ28 = pointsNumericalDeriv_popUp_String(get(H.pointsNumericalDeriv_popUp,'Value'));

                    MJ29  = str2num(get(H.stepSizeQRS_editBox,'String'));


                    baselineCorrection_button_Value = get(H.baselineCorrection_button_on,'Value');
                    if(baselineCorrection_button_Value == 1)
                        MJ24 = 0;
                    elseif(baselineCorrection_button_Value == 0)
                        MJ24 = 1;
                    end




%                     vectorCardio_button_Value = get(H.vectorCardio_button_on,'Value');
%                     if(vectorCardio_button_Value == 1)
%                         FeatureDefinition.vectorCardio_button = 'on';
%                     elseif(vectorCardio_button_Value == 0)
%                         FeatureDefinition.vectorCardio_button = 'off';
%                     end
                    %%%%TEMP                    
                    
%                     MJ1  ---  NUMBER OF EKG LEADS
%                     MJ16 (Down sampling rate)---  FREQUENCY OF PRUNNING --- EVERY OTHER POINT ICONTR(16) = 2, NO PRUNNING: ICONTR(16)=1
%                     MJ17 ---  (0 if Down sampling rate == 1)ZERO IF NO PRUNNING.   1 IF DATA ARE PRUNNED
%                     MJ23 ---  (Lead for R-wave analysis)LEAD TO BE USED FOR R WAVE ANALYSIS - 16 = SIGNAL MAGNITUDE
%                     MJ24 ---  BASE LINE CORRECTION POINT:  0 = Q POINT;  1 = P WAVE START
%                     MJ28 ---  NUMBER OF DATA USED TO EXTRACT NUMERICAL DERIVATIVES: 3, 5, 7, 9
%                     MJ29 ---  STEP SIZE IN MSEC USED TO CHARACTERIZE QRS COMPLEX
%                     DDDT ---  (1/fs) TIME INTERVAL IN SECONDS BETWEEN EKG DATA POINTS
%                     NDATA ---  (length of EKG signal) TOTAL NUMBER OF ROWS (TIMES) IN EKG MATRIX
%                     EKGDATA --- ARRAY CONTAINING EKG DATA. FIRST COLUMN IS TIME, REST ARE LEADS
                    
                    array_size = 99999;
                    MJ16=int32(MJ16);
                    MJ17=int32(MJ17);
                    MJ23=int32(MJ23);
                    MJ24=int32(MJ24);
                    MJ28=int32(MJ28);
                    MJ29=int32(MJ29);
                    DDDT= 1/signal_arch_SELECT{2*i-1}.info.fs; %0.001;
                    
                    EKGDATA = signal_arch_SELECT{((2*i)-1)};
                    
                    
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
                    
                    if(exist('features_Call'))
                        features_Call.value = [features_Call.value features_value_FORTRAN'];
                        features_Call.name = cat(2,features_Call.name,features_name_FORTRAN);
                    else
                        features_Call.value = [features_value_FORTRAN'];
                        features_Call.name = features_name_FORTRAN;
                    end
                    
                    
                    
                    
                    
                    
                end

                %             if i == 1
                %                 features(i).Patient.name = PatientName(i);
                %             else
                %                 features.Patient.name(i) = PatientName(i);
                %             end

                %             for j=1:numFeatureFile
                %
                %             end %% end j

                %signal_arch_SELECT{((2*i)-1)},signal_arch_SELECT(2*(i+1)-2)
                if (i == 1)
                    features(1,1).name = features_Call.name;
                    features(i,1).value = features_Call.value;
                    features(i,1).Patient.name = {signal_arch_SELECT(2*(i))};
                    features(i,1).Patient.info = {signal_arch_SELECT{((2*i)-1)}.info};
                    features(i,1).diagnosis = {signal_arch_SELECT{((2*i)-1)}.info.Diagnosis};
                else
                    %                 features.name(1) = features_Call.name;
                    features.value(i,:) = features_Call.value;
                    features.Patient.name(i,:) = {signal_arch_SELECT(2*(i))};
                    features.Patient.info(i,:) = {signal_arch_SELECT{((2*i)-1)}.info};
                    features.diagnosis(i,:) = {signal_arch_SELECT{((2*i)-1)}.info.Diagnosis};
                end

            end

            waitbar(i/numPatients);
        end

        close(H_waitbar);


        if(exist('features'))
            features.name = features.name';
            features.value = features.value';
            features.Patient.name = features.Patient.name';
            features.Patient.info = features.Patient.info';
            features.diagnosis = features.diagnosis';

            features.feature.Name = 'FeatureDef';
            features.feature.Date = datestr(now);


            save 'Features' features;
            set(H.frameExtractParam,'Userdata',features);

            set(H.export_button,'Enable','On');
            set(H.commentText,'String','Export Feature Definition File for Use in Batch Mode');
            Spreadsheet_Features(features);
        end
    % % % % % % % % % % % % % % % % % % % %     MALSHE TRY2222
    
    

    
    % % % % %=========== START import data==================
    
    
    %=============================================================
    %                        have_file
    %============================================================
    elseif strcmp(cmd,'have_file')
        signal_arch = get(H.inputSignal_listBox,'Userdata');
        if isempty(signal_arch)   
             
            
            set(H.display_button,'enable','on');  
            set(H.delete_button,'enable','on');
            set(H.extractFeatures_button,'Enable','On');
            %             set(H.export_button,'enable','on');
            
            %             set(H.error_messages,'string',sprintf('Import Filter to Filter Signal.'));
            
            arg1 = ChangeFieldName(arg1,'');
            signal_obj = arg1;
            signal_name = arg2;
            signal_arch{1} = signal_obj;
            signal_arch{2} = signal_name;
            P = ComStruct(signal_arch);
            %             set(H.inputSignal_listBox,'String',fieldnames(P),'Userdata',P);
            set(H.inputSignal_listBox,'String',signal_arch{2},'Userdata',signal_arch);
            %             set(H.inputSignal_listBox,'Userdata',signal_arch)
            %             ;
           
        else
            % To check whether the selected signal is already exist or not
            k = length(signal_arch);
            for i = 2 : 2 : k
                signal_name = signal_arch{i};
                 if strmatch(arg2,signal_name,'exact')
                    errordlg('Selected patient already exists. Please select another patient','Error');
                return
                end
            end
            arg1 = ChangeFieldName(arg1,'');
            signal_arch{end+1} = arg1;
            signal_arch{end+1} = arg2;
            P = ComStruct(signal_arch);
            set(H.inputSignal_listBox,'Userdata',signal_arch);
            set(H.inputSignal_listBox,'String',signal_arch(2:2:end));
            %             set(H.error_messages,'string',sprintf('Import Filter to Filter Data.'));
        end


        set(H.MatlabFeatures_listBox,'Value',[1:size(H.MatlabFeatureList_functionNames,1)])
        
        set(H.commentText,'String','Select/ Deselct Features to Be Extracted');
        
        
        %         set(H.display_button,'Enable','On');
        %         set(H.delete_button,'Enable','On');
        %         set(H.extractFeatures_button,'Enable','On');
        %         set(H.export_button,'Enable','On');
    
        % % % % %=========== END import data==================
    
    
    
        
        %===============================================================

    
        %===============================================================
 % % % % %  Display the signal
    elseif strcmp(cmd,'display')
        m = get(H.inputSignal_listBox,'Value');
                   
        signal_arch = get(H.inputSignal_listBox,'Userdata');
                        
        if isempty(m)
            errordlg('You must select at least one patient to be displayed','Error');  
        end
        
        %----------------- Raw Signal
        j=1;
        for k = 1:length(m)
            a = [];
            c = struct2cell(signal_arch{2*m(k)-1}); %
            for i = 1:(length(c)-1)
                a = [a;c{i}'];
            end
            plot12leads(a',signal_arch{2*m(k)})
        end   
     
% % % % % %=========== END display =========================
    

     
% % % % % %=========== END display =========================
    
    
    
    % % % % % Delete a signal
    elseif strcmp(cmd,lower('delete'))
        m = get(H.inputSignal_listBox,'Value');
                   
        signal_arch = get(H.inputSignal_listBox,'Userdata');
        
        num1 = length(m);
        
        signal_delete = get(H.inputSignal_listBox,'Value');
        set(H.inputSignal_listBox,'Value',[])
        
        if ~isempty(signal_delete)    
            [signal_arch] = Update_arch_ComStruct(signal_arch,[],signal_delete); 
            set(H.inputSignal_listBox,'Userdata',signal_arch)
            set(H.inputSignal_listBox,'String',signal_arch(2:2:end));
        end
        

        if(isempty(get(H.inputSignal_listBox,'Userdata')))
            set(H.display_button,'Enable','Off');
            set(H.delete_button,'Enable','Off');
            set(H.extractFeatures_button,'Enable','Off');
            %             set(H.export_button,'Enable','Off');
        end

        % % % % %========================END delete =============================
    
    
        
        
        
        
elseif strcmp(cmd,lower('importFeatureExtractionDefinitionFile'))
    SAIDutil('SAIDimport','init','','','Import Feature Definition');
    
    
        
        
        
elseif strcmp(cmd,lower('have_file_Import Feature Definition'))
        arg1;
        
        if (~ isempty(arg1.MatlabFeatureList))
            set(H.MatlabFeatures_listBox,'String',arg1.MatlabFeatureList);
            set(H.MatlabFeatures_listBox,'Value',(1:size(arg1.MatlabFeatureList,1)));
            
            H.MatlabFeatureList_functionNames = arg1.MatlabFeatureList_functionNames;
            
            
        end
        
        argCall = strcat('MatlabFeatures_button_',arg1.MatlabFeatures_button);
        if strcmp(arg1.MatlabFeatures_button,'on')
            set(H.MatlabFeatures_button_on,'Value',1);
        elseif strcmp(arg1.MatlabFeatures_button,'off')
            set(H.MatlabFeatures_button_off,'Value',1);
        end
        FeatureExtraction(argCall);      
        
        
        argCall = strcat('FortranFeatures_button_',arg1.FortranFeatures_button);
        if strcmp(arg1.FortranFeatures_button,'on')
            set(H.FortranFeatures_button_on,'Value',1);
        elseif strcmp(arg1.FortranFeatures_button,'off')
            set(H.FortranFeatures_button_off,'Value',1);
        end
        FeatureExtraction(argCall);
        
        
        arg1.RwaveLead_popUp_String_SELECT;
        argValue = find(strcmp((H.RwaveLead_popUp_String),arg1.RwaveLead_popUp_String_SELECT)==1);
        set(H.RwaveLead_popUp,'Value',argValue);
        
        
        arg1.downSamplingRate_popUp;
        argValue = (find(str2num(H.downSamplingRate_popUp_String)==arg1.downSamplingRate_popUp));
        set(H.downSamplingRate_popUp,'Value',argValue);
        
        
        
        arg1.pointsNumericalDeriv_popUp;
        argValue = (find(str2num(H.pointsNumericalDeriv_popUp_String)==arg1.pointsNumericalDeriv_popUp));
        set(H.pointsNumericalDeriv_popUp,'Value',argValue);
        
        
        
        arg1.stepSizeQRS_editBox;
        %         argValue = (find(str2num(H.pointsNumericalDeriv_popUp_String)==arg1.pointsNumericalDeriv_popUp));
        set(H.stepSizeQRS_editBox,'String',arg1.stepSizeQRS_editBox);
        
        
%         argCall = strcat('baselineCorrection_button_',arg1.baselineCorrection_button);
        if(arg1.baselineCorrection_button == 0)
           argCall = strcat('baselineCorrection_button_','on'); 
        elseif(arg1.baselineCorrection_button == 1)
            argCall = strcat('baselineCorrection_button_','off'); 
        end          
            
        %         if strcmp(arg1.baselineCorrection_button,'on')
        %             set(H.baselineCorrection_button_on,'Value',1);
        %         elseif strcmp(arg1.baselineCorrection_button,'off')
        %             set(H.baselineCorrection_button_off,'Value',1);
        %         end
        
        if (arg1.baselineCorrection_button == 0)
            set(H.baselineCorrection_button_on,'Value',1);
        elseif (arg1.baselineCorrection_button == 1)
            set(H.baselineCorrection_button_off,'Value',1);
        end
        
        FeatureExtraction(argCall);
        
        
        
        argCall = strcat('vectorCardio_button_',arg1.vectorCardio_button);
        if strcmp(arg1.vectorCardio_button,'on')
            set(H.vectorCardio_button_on,'Value',1);
        elseif strcmp(arg1.vectorCardio_button,'off')
            set(H.vectorCardio_button_off,'Value',1);
        end
        FeatureExtraction(argCall);





        %==============================================================
        %                        Export
        %==============================================================
elseif strcmp(cmd,lower('export'))
    
%     arg3{1} = {get(H.frameExtractParam,'Userdata')};
%     arg3{2} = 'features';
%     %     arg4 = get(H.frameExtractParam,'Value');

    FortranFeatures_button_Value = get(H.FortranFeatures_button_on,'Value');
    if(FortranFeatures_button_Value == 1)
        FeatureDefinition.FortranFeatures_button = 'on';
    elseif (FortranFeatures_button_Value == 0)
        FeatureDefinition.FortranFeatures_button = 'off';
    end
    
    FeatureDefinition.RwaveLead_popUp_String_SELECT = char(H.RwaveLead_popUp_String(get(H.RwaveLead_popUp,'Value')));
    FeatureDefinition.RwaveLead_popUp_Value = get(H.RwaveLead_popUp,'Value');
    
    H.downSamplingRate_popUp_String = str2num(H.downSamplingRate_popUp_String);
    FeatureDefinition.downSamplingRate_popUp = H.downSamplingRate_popUp_String(get(H.downSamplingRate_popUp,'Value'));
    
    H.pointsNumericalDeriv_popUp_String = str2num(H.pointsNumericalDeriv_popUp_String);
    FeatureDefinition.pointsNumericalDeriv_popUp = H.pointsNumericalDeriv_popUp_String(get(H.pointsNumericalDeriv_popUp,'Value'));
    
    FeatureDefinition.stepSizeQRS_editBox  = str2num(get(H.stepSizeQRS_editBox,'String'));

    
    baselineCorrection_button_Value = get(H.baselineCorrection_button_on,'Value');
    if(baselineCorrection_button_Value == 1)
        FeatureDefinition.baselineCorrection_button = 0; %0 for Q-point as per Dr. Raff's convention    %'on';
    elseif(baselineCorrection_button_Value == 0)
        FeatureDefinition.baselineCorrection_button = 1; %1 for P-start as per Dr. Raff's convention    'off';
    end
    
    
    
    
    vectorCardio_button_Value = get(H.vectorCardio_button_on,'Value');
    if(vectorCardio_button_Value == 1)
        FeatureDefinition.vectorCardio_button = 'on';
    elseif(vectorCardio_button_Value == 0)
        FeatureDefinition.vectorCardio_button = 'off';
    end
    
    
    
    
    MatlabFeatures_button_Value = get(H.MatlabFeatures_button_on,'Value');
    if(MatlabFeatures_button_Value == 1)
        FeatureDefinition.MatlabFeatures_button = 'on';
    elseif(MatlabFeatures_button_Value == 0)
        FeatureDefinition.MatlabFeatures_button = 'off';
    end
    
    
    
    call_extractFeatureList_functionsNames = get(H.MatlabFeatures_listBox,'Value');
    numFeatureFile = length(call_extractFeatureList_functionsNames);
    
    for i = 1:numFeatureFile
        FeatureDefinition.MatlabFeatureList_functionNames{i,1} = H.MatlabFeatureList_functionNames{i};
    end
    
    for i = 1:numFeatureFile
        FeatureDefinition.MatlabFeatureList{i,1} = H.MatlabFeatureList{i};
    end



    arg3(1) = {FeatureDefinition};
    arg3(2) = {'featureDefinition'};
    
    arg4 = 1;
    
    %     k_signal = get(H.lbh12,'Value');
    %     k_fft = get(H.lbh11,'Value');
    %     k_filtered = get(H.lbh32,'Value');
    %     k_filtered_fft = get(H.lbh31,'Value');
    if isempty(arg4)
        errordlg('You must select a features to export','Error');
        %     elseif ~isempty(k_signal) | ~isempty(k_filtered)| ~isempty(k_fft)| ~isempty(k_filtered_fft)
        %         errordlg('Only filters can be exported','Error');
    elseif length(arg4)~=1
        errordlg('You must select only one feature file to be exported','Error');
    elseif length(arg4)==1
        SAIDutil('SAIDexport','init','','',arg3,arg4);
    end


        
        
        
        
        
        
        
        
        
    
elseif (strcmp(cmd,lower('FortranFeatures_button_on')) | strcmp(cmd,lower('FortranFeatures_button_off')) )
    if (strcmp(cmd,lower('FortranFeatures_button_on')))
        if( get(H.FortranFeatures_button_on,'Value') == 1)
            set(H.FortranFeatures_button_on,'Value',1);
            set(H.FortranFeatures_button_off,'Value',0);
            
            set(H.textRwaveLead_popUp,'Enable','on');
            set(H.RwaveLead_popUp,'Enable','on');
            set(H.textDownSamplingRate_popUp,'Enable','on');
            set(H.downSamplingRate_popUp,'Enable','on');
            set(H.textBaselineCorrection_button,'Enable','on');
            set(H.baselineCorrection_button_on,'Enable','on');
            set(H.baselineCorrection_button_off,'Enable','on');
            %             set(H.textRectangularFilter_button,'Enable','on');
            %             set(H.rectangularFilter_button_on,'Enable','on');
            %             set(H.rectangularFilter_button_off,'Enable','on');
            set(H.textStepSizeQRS,'Enable','on');
            set(H.stepSizeQRS_editBox,'Enable','on');
            set(H.textPointsNumericalDeriv,'Enable','on');
            set(H.pointsNumericalDeriv_popUp,'Enable','on');
            
            set(H.textVectorCardio_button,'Enable','on');
            set(H.vectorCardio_button_on,'Enable','on');
            set(H.vectorCardio_button_off,'Enable','on');
            %             set(H.debugOptions_button,'Enable','on');

        end

        if( get(H.FortranFeatures_button_on,'Value') == 0 & get(H.FortranFeatures_button_off,'Value') == 0)
            set(H.FortranFeatures_button_on,'Value',1);
            set(H.FortranFeatures_button_off,'Value',0);
        end
    end

    if (strcmp(cmd,lower('FortranFeatures_button_off')))
        if( get(H.FortranFeatures_button_off,'Value') == 1)
            set(H.FortranFeatures_button_on,'Value',0);
            set(H.FortranFeatures_button_off,'Value',1);
            
            set(H.textRwaveLead_popUp,'Enable','off');
            set(H.RwaveLead_popUp,'Enable','off');
            set(H.textDownSamplingRate_popUp,'Enable','off');
            set(H.downSamplingRate_popUp,'Enable','off');
            set(H.textBaselineCorrection_button,'Enable','off');
            set(H.baselineCorrection_button_on,'Enable','off');
            set(H.baselineCorrection_button_off,'Enable','off');
            %             set(H.textRectangularFilter_button,'Enable','off');
            %             set(H.rectangularFilter_button_on,'Enable','off');
            %             set(H.rectangularFilter_button_off,'Enable','off');
            set(H.textStepSizeQRS,'Enable','off');
            set(H.stepSizeQRS_editBox,'Enable','off');
            set(H.textPointsNumericalDeriv,'Enable','off');
            set(H.pointsNumericalDeriv_popUp,'Enable','off');
            
            set(H.textVectorCardio_button,'Enable','off');
            set(H.vectorCardio_button_on,'Enable','off');
            set(H.vectorCardio_button_off,'Enable','off');
            %             set(H.debugOptions_button,'Enable','off');
        end

        if( get(H.FortranFeatures_button_off,'Value') == 0 & get(H.FortranFeatures_button_on,'Value') == 0)
            set(H.FortranFeatures_button_on,'Value',0);
            set(H.FortranFeatures_button_off,'Value',1);
        end

    end
    % % %---------------------
    
    


elseif (strcmp(cmd,lower('vectorCardio_button_on')) | strcmp(cmd,lower('vectorCardio_button_off')) )
    if (strcmp(cmd,lower('vectorCardio_button_on')))
        if( get(H.vectorCardio_button_on,'Value') == 1)
            set(H.vectorCardio_button_on,'Value',1);
            set(H.vectorCardio_button_off,'Value',0);
        end

        if( get(H.vectorCardio_button_on,'Value') == 0 & get(H.vectorCardio_button_off,'Value') == 0)
            set(H.vectorCardio_button_on,'Value',1);
            set(H.vectorCardio_button_off,'Value',0);
        end
    end

    if (strcmp(cmd,lower('vectorCardio_button_off')))
        if( get(H.vectorCardio_button_off,'Value') == 1)
            set(H.vectorCardio_button_on,'Value',0);
            set(H.vectorCardio_button_off,'Value',1);
        end

        if( get(H.vectorCardio_button_off,'Value') == 0 & get(H.vectorCardio_button_on,'Value') == 0)
            set(H.vectorCardio_button_on,'Value',0);
            set(H.vectorCardio_button_off,'Value',1);
        end

    end
    % % %---------------------

    % % %---------------------

    
    

    elseif (strcmp(cmd,lower('baselineCorrection_button_on')) | strcmp(cmd,lower('baselineCorrection_button_off')) )
    if (strcmp(cmd,lower('baselineCorrection_button_on')))
        if( get(H.baselineCorrection_button_on,'Value') == 1)
            set(H.baselineCorrection_button_on,'Value',1);
            set(H.baselineCorrection_button_off,'Value',0);
        end

        if( get(H.baselineCorrection_button_on,'Value') == 0 & get(H.baselineCorrection_button_off,'Value') == 0)
            set(H.baselineCorrection_button_on,'Value',1);
            set(H.baselineCorrection_button_off,'Value',0);
        end
    end

    if (strcmp(cmd,lower('baselineCorrection_button_off')))
        if( get(H.baselineCorrection_button_off,'Value') == 1)
            set(H.baselineCorrection_button_on,'Value',0);
            set(H.baselineCorrection_button_off,'Value',1);
        end

        if( get(H.baselineCorrection_button_off,'Value') == 0 & get(H.baselineCorrection_button_on,'Value') == 0)
            set(H.baselineCorrection_button_on,'Value',0);
            set(H.baselineCorrection_button_off,'Value',1);
        end

    end
    % % %---------------------
    
    
    
    elseif (strcmp(cmd,lower('MatlabFeatures_button_on')) | strcmp(cmd,lower('MatlabFeatures_button_off')) )
    if (strcmp(cmd,lower('MatlabFeatures_button_on')))
        if( get(H.MatlabFeatures_button_on,'Value') == 1)
            set(H.MatlabFeatures_button_on,'Value',1);
            set(H.MatlabFeatures_button_off,'Value',0);
            
            
            set(H.MatlabFeatures_listBox,'Enable','on');
            %             set(H.importMatlabFeature_button,'Enable','on');
        end

        if( get(H.MatlabFeatures_button_on,'Value') == 0 & get(H.MatlabFeatures_button_off,'Value') == 0)
            set(H.MatlabFeatures_button_on,'Value',1);
            set(H.MatlabFeatures_button_off,'Value',0);
        end
    end

    if (strcmp(cmd,lower('MatlabFeatures_button_off')))
        if( get(H.MatlabFeatures_button_off,'Value') == 1)
            set(H.MatlabFeatures_button_on,'Value',0);
            set(H.MatlabFeatures_button_off,'Value',1);
            
            
            set(H.MatlabFeatures_listBox,'Enable','off');
            %             set(H.importMatlabFeature_button,'Enable','off');
        end

        if( get(H.MatlabFeatures_button_off,'Value') == 0 & get(H.MatlabFeatures_button_on,'Value') == 0)
            set(H.MatlabFeatures_button_on,'Value',0);
            set(H.MatlabFeatures_button_off,'Value',1);
        end
             
    end
    
        
    
% % % % MALSHE


    
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

    H.me='FeatureExtraction';

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
        'Tag','FeatureExtraction', ...
        'Resize','off', ...
        'ToolBar','none');




    H.frameInputSignal = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ListboxTop',0, ...
        'Position',uipos.frameInputSignal, ...
        'Style','frame', ...
        'Tag','frameInputSignal');





    H.frameExtractParam = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ListboxTop',0, ...
        'Position',uipos.frameExtractParam, ...
        'Style','frame', ...
        'Tag','frameExtractParam');


    H.text1 = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.text1, ...
        'String','Feature Extraction Design/Debug Mode', ...
        'FontSize', 14,...
        'Style','text', ...
        'Tag','StaticText1');

    signalList = [''; ''; '']; %%%%% ***** Should we use 'Courier' Font for this text, so that the width of each letter is same
    H.inputSignal_listBox = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[1 1 1], ...
        'Position',uipos.inputSignal_listBox, ...
        'Min',0,...
        'Max',1000,...
        'Style','Listbox', ...
        'String',signalList, ...
        'Tag','inputSignal_listBox', ...
        'ToolTipStr','Select signals for feature extraction, use ''CTRL'' key to select multiple signals', ...
        'Value',1);



    H.textInputSignal = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.textInputSignal, ...
        'String','Input Signal', ...
        'Style','text', ...
        'Tag','textInputSignal');


    H.textExtractParam = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.textExtractParam, ...
        'String','Extraction Parameters', ...
        'Style','text', ...
        'Tag','textExtractParam');



    H.importInputSignal_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','SAIDutil(''SAIDimport'',''init'','''','''',''Import Feature Data'');', ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position',uipos.importInputSignal_button, ...
        'String','Import', ...
        'ToolTipStr','Import EKG signal',...
        'Tag','importInputSignal_button');





    H.display_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','', ...
        'Callback','FeatureExtraction(''display'');', ...
        'Enable','off', ...
        'ListboxTop',0, ...
        'Position',uipos.display_button, ...
        'String','Display', ...
        'ToolTipStr','Display EKG signal',...
        'Tag','display_button');




    H.delete_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','FeatureExtraction(''delete'')', ...
        'Enable','off', ...
        'ListboxTop',0, ...
        'Position',uipos.delete_button, ...
        'String','Delete', ...
        'ToolTipStr','Delete EKG signal',...
        'Tag','delete_button');




    H.importMatlabFeature_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','FeatureExtraction(''importFeatureExtractionDefinitionFile'')', ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position',uipos.importMatlabFeature_button, ...
        'String','Import', ...
        'ToolTipStr','Import definition file for Matlab features',...
        'Tag','importMatlabFeature_button');



    [H.MatlabFeatureList,H.MatlabFeatureList_functionNames] = MatlabFeatureFunctions;
    %     H.MatlabFeatureList = {'R-R interval';'Heart Rate';'Basic Features'};
    %     H.MatlabFeatureList_functionNames = {'rr_interval_wav';'heart_rate_fft';'basicFeatures'}; %%%%%*****These are the filenames of the functions for the featues defined in 'MatlabFeatureList', in the same order
    H.MatlabFeatures_listBox = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[1 1 1], ...
        'Position',uipos.MatlabFeatures_listBox, ...
        'Style','Listbox', ...
        'String',H.MatlabFeatureList, ...
        'Max',999, ...
        'Tag','MatlabFeatures_listBox', ...
        'ToolTipStr','Select features to be extracted, use ''CTRL'' key to select multiple features', ...
        'Value',1);

    set(H.MatlabFeatures_listBox,'Value',[1:size(H.MatlabFeatureList_functionNames ,1)]);

    H.textMatlabFeatures_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.textMatlabFeatures_button, ...
        'String','Matlab Features', ...
        'HorizontalAlignment','Left', ...
        'Style','text', ...
        'Tag','textMatlabFeatures_button');

        
    
    H.MatlabFeatures_button_on = uicontrol('Parent',fig, ...
        'Unit',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Callback','FeatureExtraction(''MatlabFeatures_button_on'')', ...
        'ListboxTop',0, ...
        'Position',uipos.MatlabFeatures_button_on, ...
        'String','On', ...
        'Style','radiobutton', ...
        'ToolTipStr','Compute features using Matlab code',...
        'Tag','MatlabFeatures_button_on',...
        'Value',1);
    
    
    H.MatlabFeatures_button_off = uicontrol('Parent',fig, ...
        'Unit',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Callback','FeatureExtraction(''MatlabFeatures_button_off'')', ...
        'ListboxTop',0, ...
        'Position',uipos.MatlabFeatures_button_off, ...
        'String','Off', ...
        'Style','radiobutton', ...
        'ToolTipStr','Disable feature extraction using Matlab code',...
        'Tag','MatlabFeatures_button_off',...
        'Value',0);
    
    
    
    
    
    
    
    


% [feval(@rr_interval_wav,EKGSignal,fp)], [feval(@heart_rate_fft,EKGSignal,fp)]

    H.extractFeatures_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','FeatureExtraction(''extractFeature'')', ...
        'Enable','off', ...
        'ListboxTop',0, ...
        'Position',uipos.extractFeatures_button, ...
        'String','Extract Features', ...
        'ToolTipStr','Extract Features',...
        'Tag','extractFeatures_button');






    % % % %     H.line_extractParam_MatlabFeatures %%%% THIS IS TO DRAW THE DIVIDING LINE, Can we draw a LINE on GUI and not Frame
    H.frameSeparateFortranMatlabFeatures = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ListboxTop',0, ...
        'Position',uipos.frameSeparateFortranMatlabFeatures, ...
        'Style','frame', ...
        'Tag','frameSeparateFortranMatlabFeatures');
    


%     H.debugOptions_button = uicontrol('Parent',fig, ...
%         'Units',H.StdUnit, ...
%         'Callback','', ...
%         'Enable','on', ...
%         'ListboxTop',0, ...
%         'Position',uipos.debugOptions_button, ...
%         'String','Debugging Options', ...
%         'ToolTipStr','Set additional debugging options',...
%         'Tag','debugOptions_button');





    H.textVectorCardio_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.textVectorCardio_button, ...
        'String','Vector Cardiography', ...
        'HorizontalAlignment','Left', ...
        'Style','text', ...
        'Tag','textVectorCardio_button');


    H.vectorCardio_button_on = uicontrol('Parent',fig, ...
        'Unit',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Callback','FeatureExtraction(''vectorCardio_button_on'')', ...
        'ListboxTop',0, ...
        'Position',uipos.vectorCardio_button_on, ...
        'String','On', ...
        'Style','radiobutton', ...
        'ToolTipStr','Extract features using vector cardiography',...
        'Tag','VectorCardio_On',...
        'Value',1);



    H.vectorCardio_button_off = uicontrol('Parent',fig, ...
        'Unit',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Callback','FeatureExtraction(''vectorCardio_button_off'')', ...
        'ListboxTop',0, ...
        'Position',uipos.vectorCardio_button_off, ...
        'String','Off', ...
        'Style','radiobutton', ...
        'ToolTipStr','Turn off vector cardiography',...
        'Tag','VectorCardio_Off',...
        'Value',0);


  
    
    
    H.textBaselineCorrection_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.textBaselineCorrection_button, ...
        'String','Baseline Correction', ...
        'HorizontalAlignment','Left', ...
        'Style','text', ...
        'Tag','textRectangularFilter_button');
    
    
    
    
    H.baselineCorrection_button_on = uicontrol('Parent',fig, ...
        'Unit',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Callback','FeatureExtraction(''baselineCorrection_button_on'')', ...
        'ListboxTop',0, ...
        'Position',uipos.baselineCorrection_button_on, ...
        'String','Q point', ...
        'Style','radiobutton', ...
        'ToolTipStr','Turn on the baseline correction',...
        'Tag','baselineCorrection_button_on',...
        'Value',1);

    
    H.baselineCorrection_button_off = uicontrol('Parent',fig, ...
        'Unit',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Callback','FeatureExtraction(''baselineCorrection_button_off'')', ...
        'ListboxTop',0, ...
        'Position',uipos.baselineCorrection_button_off, ...
        'String','P start', ...
        'Style','radiobutton', ...
        'ToolTipStr','Turn off the baseline correction',...
        'Tag','baselineCorrection_button_off',...
        'Value',0);







    % % MILIND NEW

    H.textStepSizeQRS = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable','On', ...
        'ListboxTop',0, ...
        'Position',uipos.textStepSizeQRS, ...
        'String','Step size for QRS analysis (mS)', ...
        'HorizontalAlignment','Center', ...
        'Style','text', ...
        'Tag','textStepSizeQRS');



    H.stepSizeQRS_editBox = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[1 1 1], ...
        'Enable','On', ...
        'ListboxTop',0, ...
        'Position',uipos.stepSizeQRS_editBox, ...
        'String','2', ...
        'Style','edit', ...
        'Callback','', ...
        'ToolTipStr','',...
        'Tag','stepSizeQRS_editBox');


    
    
    
    
    H.textPointsNumericalDeriv = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable','On', ...
        'ListboxTop',0, ...
        'Position',uipos.textPointsNumericalDeriv, ...
        'String','Points for numerical derivative', ...
        'HorizontalAlignment','Left', ...
        'Style','text', ...
        'Tag','textPointsNumericalDeriv');
    
    
    
    
    H.pointsNumericalDeriv_popUp_String = ['  1';'  3';'  5';'  7';'  9'];
    H.pointsNumericalDeriv_popUp = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[1 1 1], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.pointsNumericalDeriv_popUp, ...
        'Max',5, ...
        'String',H.pointsNumericalDeriv_popUp_String, ...
        'Style','popupmenu', ...
        'Tag','pointsNumericalDeriv_popUp', ...
        'Value',2);
    

    % % MALSHE NEW





    H.textDownSamplingRate_popUp = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.textDownSamplingRate_popUp, ...
        'String','Downsampling Rate', ...
        'HorizontalAlignment','Left', ...
        'Style','text', ...
        'Tag','textDownSamplingRate_popUp');
    
    

    
    H.downSamplingRate_popUp_String = ['  1';'  2';'  3';'  4';'  5'];
    H.downSamplingRate_popUp = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[1 1 1], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.downSamplingRate_popUp, ...
        'Max',5, ...
        'String',H.downSamplingRate_popUp_String, ...
        'Style','popupmenu', ...
        'Tag','downSamplingRate_popUp', ...
        'Value',1);
    
    
    
    
    
    
    
    
    
    H.textRwaveLead_popUp = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.textRwaveLead_popUp, ...
        'String','Lead for R-wave analysis', ...
        'HorizontalAlignment','Left', ...
        'Style','text', ...
        'Tag','textRwaveLead_popUp');
    
    

    
    %     H.RwaveLead_popUp_String = {'   i'; '   ii'; '  iii'; 'avl'; 'avr'; 'avf'; ' v1'; ' v2'; ' v3'; ' v4'; ' v5'; ' v6'; ...
    %                               ' vx'; ' vy'; ' vz'; 'vMag'};
    
    H.RwaveLead_popUp_String = {'i'; 'ii'; 'iii'; 'avl'; 'avr'; 'avf'; 'v1'; 'v2'; 'v3'; 'v4'; 'v5'; 'v6'; ...
                              'vx'; 'vy'; 'vz'; 'vMag'};
    H.RwaveLead_popUp = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[1 1 1], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.RwaveLead_popUp, ...
        'Max',5, ...
        'String',H.RwaveLead_popUp_String, ...
        'Style','popupmenu', ...
        'Tag','RwaveLead_popUp', ...
        'Value',16);
    
    
    
    
    
    
    
    
    
    
    
    
    
    H.textFortranFeatures_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Enable',window_en, ...
        'ListboxTop',0, ...
        'Position',uipos.textFortranFeatures_button, ...
        'String','Fortran features', ...
        'HorizontalAlignment','Left', ...
        'Style','text', ...
        'Tag','FortranFeatures_button');     
    
    
    
      H.FortranFeatures_button_on = uicontrol('Parent',fig, ...
        'Unit',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Callback','FeatureExtraction(''FortranFeatures_button_on'')', ...
        'ListboxTop',0, ...
        'Position',uipos.FortranFeatures_button_on, ...
        'String','On', ...
        'Style','radiobutton', ...
        'ToolTipStr','Compute features using Fortran code',...
        'Tag','FortranFeatures_button_on',...
        'Value',1);
    
    
        H.FortranFeatures_button_off = uicontrol('Parent',fig, ...
        'Unit',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'Callback','FeatureExtraction(''FortranFeatures_button_off'')', ...
        'ListboxTop',0, ...
        'Position',uipos.FortranFeatures_button_off, ...
        'String','Off', ...
        'Style','radiobutton', ...
        'ToolTipStr','Disable feature extraction using Fortran code',...
        'Tag','FortranFeatures_button_off',...
        'Value',0);
    
    
    
    
    
    
    
      
    
    H.commentFrame = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ListboxTop',0, ...
        'Position',uipos.commentFrame, ...
        'Style','frame', ...
        'Tag','commentFrame');



    H.commentTextString = 'Import Data to Get Started';
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


    
    
H.export_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','FeatureExtraction(''export'')', ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position',uipos.export_button, ...
        'String','Export', ...
        'ToolTipStr','Export the feature definition file for use in Batch Mode',...
        'Tag','export_button');
    
    


    H.close_button = uicontrol('Parent',fig, ...
        'Units',H.StdUnit, ...
        'Callback','SAIDutil(''FeatureExtraction'',''close'')', ...
        'Enable','on', ...
        'ListboxTop',0, ...
        'Position',uipos.close_button, ...
        'String','Close', ...
        'ToolTipStr','Exit feature extraction module and return to SAID tool',...
        'Tag','close_button');

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
listBoxH = 20;
inputSignal_listBoxH = 20;
MatlabFeatures_listBoxH = 10;


textListBoxW = 22;
textListBoxH = 1.2;

textRadioButtonNameW = 26;
textRadioButtonW = 12;
textRadioButtonH = 1.4;

checkBoxW = 28;
checkBoxH = 2;

popUpMenuW = 10;
popUpMenuH = 1;


editBoxW = 10;
editBoxH = 1.6;

commentTextH = 2.0;

text1H = 5;

gapBetween2Frames = 2*button_gapW;

figW = 2*border + listBoxW + 2*border + gapBetween2Frames + 2*border + listBoxW + 2*border;
% figH = 2*border + 1*button_gapH + mode_buttonH + 1*button_gapH + 1*button_gapH + text1H + 2*border;
% figH = 2*border + 1*button_gapH + mode_buttonH + 2*button_gapH + listBoxH + 0*button_gapH + text1H + commentTextH + 2*border;
figH = 2*border + action_buttonH + button_gapH + mode_buttonH + button_gapH + listBoxH + textListBoxH + button_gapH + mode_buttonH + 1*7*button_gapH + 1*textListBoxH + text1H;


% frameInputSignalW = figW - 2*border;
frameInputSignalW = 2*border + listBoxW + 1*border;
% frameInputSignalH = mode_buttonH + button_gapH + listBoxH + textListBoxH + button_gapH + mode_buttonH + 1*7*button_gapH + 1*textListBoxH;

% frameInputSignalH = figH - 2*border  - 3*border - commentTextH;

% frameInputSignalH = figH - 2*border - text1H;


frameExtractParamW = 2*border + listBoxW + 1*border;
frameExtractParamH = mode_buttonH + button_gapH + listBoxH + textListBoxH + button_gapH + mode_buttonH + 1*7*button_gapH + 1*textListBoxH;


text1W = figW - 6*border;
% text1W = frameInputSignalW - 10*border; % 
% text1H = frameInputSignalH - 1*border;

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




frameInputSignalL = border;
% frameInputSignalB = 1*border + action_buttonH + button_gapH;
% uipos.frameInputSignal = [frameInputSignalL, frameInputSignalB, frameInputSignalW, frameInputSignalH];

frameExtractParamL = frameInputSignalL + frameInputSignalW + gapBetween2Frames;
frameExtractParamB = 1*border + action_buttonH + button_gapH;
uipos.frameExtractParam = [frameExtractParamL, frameExtractParamB, frameExtractParamW, frameExtractParamH];



% text1L = (frameInputSignalL + frameInputSignalW)/2 - text1W/2;
text1L = figW/2 - text1W/2;
% text1B = frameInputSignalB + frameInputSignalH - 0.8*text1H;  %*****  Actually it should be 1*text1H, but for some reason the textbox looks slightly shifeted down relative to the frame, so 0.8*text1H was used which places the frame1 aprroximately in the center of the text box because it looks good
text1B = figH - 1*border - text1H + 0* commentTextH/2;

% text1B = frameInputSignalH + button_gapH;
uipos.text1 =  [text1L, text1B, text1W, text1H];


inputSignal_listBoxL = 2*border;
% inputSignal_listBoxB = 2*border + 1*button_gapH + mode_buttonH + 2*button_gapH + mode_buttonH + button_gapH + mode_buttonH + button_gapH +  commentTextH ;

% inputSignal_listBoxB = frameInputSignalB + frameInputSignalH - 1*border - inputSignal_listBoxH;
inputSignal_listBoxB = frameExtractParamB + frameExtractParamH - border - inputSignal_listBoxH;
uipos.inputSignal_listBox = [inputSignal_listBoxL, inputSignal_listBoxB, listBoxW, inputSignal_listBoxH ];




importInputSignal_buttonL = inputSignal_listBoxL + listBoxW/2 - button_gapW/2 - mode_buttonW;
importInputSignal_buttonB = inputSignal_listBoxB - button_gapH - mode_buttonH;
uipos.importInputSignal_button = [importInputSignal_buttonL,importInputSignal_buttonB,mode_buttonW, mode_buttonH];


display_buttonL = inputSignal_listBoxL + listBoxW/2 + button_gapW/2;
display_buttonB = inputSignal_listBoxB - button_gapH - mode_buttonH;
uipos.display_button = [display_buttonL, display_buttonB, mode_buttonW, mode_buttonH];


delete_buttonL = inputSignal_listBoxL + listBoxW/2 - mode_buttonW/2;
delete_buttonB = display_buttonB - button_gapH - mode_buttonH;
uipos.delete_button = [delete_buttonL, delete_buttonB, mode_buttonW, mode_buttonH];



% % % % frameInputSignalL is defined above
frameInputSignalB = delete_buttonB - button_gapH;

frameInputSignalH = frameExtractParamB + frameExtractParamH - frameInputSignalB;
uipos.frameInputSignal = [frameInputSignalL, frameInputSignalB, frameInputSignalW, frameInputSignalH];





textInputSignalL = inputSignal_listBoxL + listBoxW/2 - textListBoxW/2;
textInputSignalB = frameInputSignalB + frameInputSignalH - textListBoxH/2;
uipos.textInputSignal = [textInputSignalL, textInputSignalB, textListBoxW, textListBoxH];


textExtractParamL = frameExtractParamL + frameExtractParamW/2  - 1.5* textListBoxW/2;
textExtractParamB = frameInputSignalB + frameInputSignalH - textListBoxH/2;
uipos.textExtractParam = [textExtractParamL, textExtractParamB, 1.5* textListBoxW, textListBoxH];





importMatlabFeature_buttonL = frameExtractParamL + 1*border + listBoxW/2 - textListBoxW/2;
importMatlabFeature_buttonB = frameExtractParamB + border;
uipos.importMatlabFeature_button = [importMatlabFeature_buttonL, importMatlabFeature_buttonB, mode_buttonW, mode_buttonH];


MatlabFeatures_listBoxL = frameExtractParamL + 1*border + border/2;
MatlabFeatures_listBoxB = importMatlabFeature_buttonB + mode_buttonH + border/2;
uipos.MatlabFeatures_listBox = [MatlabFeatures_listBoxL, MatlabFeatures_listBoxB, listBoxW, MatlabFeatures_listBoxH];





% textMatlabFeatures_buttonL = frameExtractParamL + 1*border + listBoxW/2 - textListBoxW/2;
textMatlabFeatures_buttonL = frameExtractParamL + 1*border;
textMatlabFeatures_buttonB = MatlabFeatures_listBoxB + MatlabFeatures_listBoxH + border/4;
uipos.textMatlabFeatures_button = [textMatlabFeatures_buttonL, textMatlabFeatures_buttonB,  textRadioButtonNameW, textRadioButtonH];


MatlabFeatures_button_onL = textMatlabFeatures_buttonL + textRadioButtonNameW + border;
MatlabFeatures_button_onB = textMatlabFeatures_buttonB;
uipos.MatlabFeatures_button_on = [MatlabFeatures_button_onL, MatlabFeatures_button_onB, textRadioButtonW, textRadioButtonH];


MatlabFeatures_button_offL = MatlabFeatures_button_onL + textRadioButtonW;
MatlabFeatures_button_offB = textMatlabFeatures_buttonB;
uipos.MatlabFeatures_button_off = [MatlabFeatures_button_offL, MatlabFeatures_button_offB, textRadioButtonW, textRadioButtonH];






extractFeatures_buttonL = inputSignal_listBoxL + listBoxW/2 - mode_buttonW/2;
extractFeatures_buttonB = frameExtractParamB + border;
uipos.extractFeatures_button = [extractFeatures_buttonL, extractFeatures_buttonB, mode_buttonW, mode_buttonH];


frameSeparateFortranMatlabFeaturesL = frameExtractParamL + button_gapW;
frameSeparateFortranMatlabFeaturesB = textMatlabFeatures_buttonB + textListBoxH + 1*button_gapH;
frameSeparateFortranMatlabFeaturesW = frameExtractParamW - 2*button_gapW;
% frameSeparateFortranMatlabFeaturesH = frameExtractParamB + frameExtractParamH - frameSeparateFortranMatlabFeaturesB;
frameSeparateFortranMatlabFeaturesH = 0.1; % SET THE HEIGHT TO A SMALL NUMBER, SO THAT ON THE GUI IT LOOKS LIKE A LINE
uipos.frameSeparateFortranMatlabFeatures = [frameSeparateFortranMatlabFeaturesL, frameSeparateFortranMatlabFeaturesB, frameSeparateFortranMatlabFeaturesW, frameSeparateFortranMatlabFeaturesH];



% debugOptions_buttonL = frameExtractParamL + 1*border  + listBoxW/2 - textListBoxW/2;
% debugOptions_buttonB = textMatlabFeatures_buttonB + textListBoxH + 2*button_gapH;
% uipos.debugOptions_button = [debugOptions_buttonL, debugOptions_buttonB, mode_buttonW, mode_buttonH];



textVectorCardio_buttonL = frameExtractParamL + 3*border;
textVectorCardio_buttonB = textMatlabFeatures_buttonB + textListBoxH + 2*button_gapH;
uipos.textVectorCardio_button = [textVectorCardio_buttonL, textVectorCardio_buttonB, textRadioButtonNameW, textRadioButtonH];

vectorCardio_button_onL = textVectorCardio_buttonL + textRadioButtonNameW - 0*border;
vectorCardio_button_onB = textVectorCardio_buttonB;
uipos.vectorCardio_button_on = [vectorCardio_button_onL, vectorCardio_button_onB, textRadioButtonW, textRadioButtonH];

vectorCardio_button_offL = vectorCardio_button_onL + textRadioButtonW;
vectorCardio_button_offB = textVectorCardio_buttonB;
uipos.vectorCardio_button_off = [vectorCardio_button_offL, vectorCardio_button_offB, textRadioButtonW, textRadioButtonH];





% textRectangularFilter_buttonL = frameExtractParamL + 3*border;
% textRectangularFilter_buttonB = textVectorCardio_buttonB + 2*button_gapH;
% uipos.textRectangularFilter_button = [textRectangularFilter_buttonL, textRectangularFilter_buttonB, textRadioButtonNameW, textRadioButtonH];
% 
% rectangularFilter_button_onL = textRectangularFilter_buttonL + textRadioButtonNameW - 1*border;
% rectangularFilter_button_onB = textRectangularFilter_buttonB;
% uipos.rectangularFilter_button_on = [rectangularFilter_button_onL, rectangularFilter_button_onB, textRadioButtonW, textRadioButtonH];
% 
% rectangularFilter_button_offL = rectangularFilter_button_onL + textRadioButtonW;
% rectangularFilter_button_offB = textRectangularFilter_buttonB;
% uipos.rectangularFilter_button_off = [rectangularFilter_button_offL, rectangularFilter_button_offB, textRadioButtonW, textRadioButtonH];











textBaselineCorrection_buttonL = frameExtractParamL + 3*border;
textBaselineCorrection_buttonB = textVectorCardio_buttonB + 2*button_gapH;
uipos.textBaselineCorrection_button = [textBaselineCorrection_buttonL, textBaselineCorrection_buttonB, textRadioButtonNameW, textRadioButtonH];

baselineCorrection_button_onL = textBaselineCorrection_buttonL + textRadioButtonNameW - 0*border;
baselineCorrection_button_onB = textBaselineCorrection_buttonB;
uipos.baselineCorrection_button_on = [baselineCorrection_button_onL, baselineCorrection_button_onB, textRadioButtonW, textRadioButtonH];


baselineCorrection_button_offL = baselineCorrection_button_onL + textRadioButtonW;
baselineCorrection_button_offB = textBaselineCorrection_buttonB;
uipos.baselineCorrection_button_off = [baselineCorrection_button_offL, baselineCorrection_button_offB, textRadioButtonW, textRadioButtonH];






% % MILIND NEW

textStepSizeQRSL = frameExtractParamL + 3*border;
textStepSizeQRSB = textBaselineCorrection_buttonB + 2*button_gapH;
uipos.textStepSizeQRS = [textStepSizeQRSL, textStepSizeQRSB,textRadioButtonNameW, 1.5*textRadioButtonH];


stepSizeQRS_editBox_L = textStepSizeQRSL + textRadioButtonNameW + 2*border;
stepSizeQRS_editBox_B = textStepSizeQRSB + border;
uipos.stepSizeQRS_editBox = [stepSizeQRS_editBox_L, stepSizeQRS_editBox_B, editBoxW, editBoxH];



textPointsNumericalDerivL = frameExtractParamL + 3*border;
textPointsNumericalDerivB = textStepSizeQRSB + 3*button_gapH;
uipos.textPointsNumericalDeriv = [textPointsNumericalDerivL,textPointsNumericalDerivB, textRadioButtonNameW, 1.5*textRadioButtonH];


pointsNumericalDeriv_popUpL = textPointsNumericalDerivL + textRadioButtonNameW + 2*border;
pointsNumericalDeriv_popUpB = textPointsNumericalDerivB + popUpMenuH;
uipos.pointsNumericalDeriv_popUp = [pointsNumericalDeriv_popUpL, pointsNumericalDeriv_popUpB, popUpMenuW, popUpMenuH];
% % MALSHE NEW


textDownSamplingRate_popUpL = frameExtractParamL + 3*border;
textDownSamplingRate_popUpB = textPointsNumericalDerivB + 3*button_gapH;
uipos.textDownSamplingRate_popUp = [textDownSamplingRate_popUpL, textDownSamplingRate_popUpB, textRadioButtonNameW, textRadioButtonH];


downSamplingRate_popUpL = textDownSamplingRate_popUpL + textRadioButtonNameW + 2*border;
downSamplingRate_popUpB = textDownSamplingRate_popUpB + popUpMenuH; %%%%%** ?????? WHY DO WE NEED TO ADD 'popUpMenuH'
uipos.downSamplingRate_popUp = [downSamplingRate_popUpL, downSamplingRate_popUpB, popUpMenuW, popUpMenuH];%%%%%** ?????? 
%%%%%** ?????? popMenuH just shifts the position of the popUpMenu up or
%%%%%down, and does not change its height, IS THE HEIGHT OF THE 'popUpMenu'
%%%%%MAY BE DETERMINED BY THE FONT SIZE







textRwaveLead_popUpL = frameExtractParamL + 3*border;
textRwaveLead_popUpB = textDownSamplingRate_popUpB + 2.5*button_gapH;
uipos.textRwaveLead_popUp = [textRwaveLead_popUpL, textRwaveLead_popUpB, textRadioButtonNameW, textRadioButtonH];


RwaveLead_popUpL = textRwaveLead_popUpL + textRadioButtonNameW + 2*border;
RwaveLead_popUpB = textRwaveLead_popUpB + popUpMenuH; %%%%%** ?????? WHY DO WE NEED TO ADD 'popUpMenuH'
uipos.RwaveLead_popUp = [RwaveLead_popUpL, RwaveLead_popUpB, popUpMenuW, popUpMenuH];%%%%%** ?????? 









textFortranFeatures_buttonL = frameExtractParamL + 1*border;
textFortranFeatures_buttonB = textRwaveLead_popUpB + 2*button_gapH + 1*button_gapH;;
uipos.textFortranFeatures_button = [textFortranFeatures_buttonL, textFortranFeatures_buttonB, textRadioButtonNameW, textRadioButtonH];

FortranFeatures_button_onL = textFortranFeatures_buttonL + textRadioButtonNameW + 2*border;
FortranFeatures_button_onB = textFortranFeatures_buttonB;
uipos.FortranFeatures_button_on = [FortranFeatures_button_onL, FortranFeatures_button_onB, textRadioButtonW, textRadioButtonH];


FortranFeatures_button_offL = FortranFeatures_button_onL + textRadioButtonW;
FortranFeatures_button_offB = textFortranFeatures_buttonB;
uipos.FortranFeatures_button_off = [FortranFeatures_button_offL, FortranFeatures_button_offB, textRadioButtonW, textRadioButtonH];












close_buttonL = figW - 2*border - action_buttonW;
close_buttonB = 1* border + 0* button_gapH ;
uipos.close_button = [close_buttonL, close_buttonB, action_buttonW, action_buttonH ];


export_buttonL = close_buttonL - button_gapW - action_buttonW;
export_buttonB = 1* border + 0* button_gapH ;
uipos.export_button = [export_buttonL, export_buttonB, action_buttonW, action_buttonH];

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
            
   
            for i = length(argin3):-1:1
                    argin1(2*argin3(i))=[];
                    argin1(2*argin3(i)-1)=[];
            end  
            

% % % % %======================= MALSHE ==============================