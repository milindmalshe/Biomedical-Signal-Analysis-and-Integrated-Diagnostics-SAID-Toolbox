function [m,s,mes1] = BatchFilter(SourceFolder,DestFolder,FilterObject,Patient,m,s,NumPatient,FilterName,H) 
                try
                   
                    c = load(fullfile(SourceFolder,Patient));
                    indDot = findstr(Patient,'.');
                    if ~isempty(indDot),
                        Patient = Patient(1:indDot(end)-1);
                    end

                    arg2 = char(Patient);%
                    LeadName = fieldnames(c);
                    arg1 = c.(char(LeadName));
                    %---- Check the validity of the selected Data
                    %==cd(CurrentDir)
                    %                 [flag] = checkEKGstructformat(fieldnames(arg1));
                    Value = struct2cell(arg1); %%%%%***** Changed by Milind so as to be compatible with Dr. Hagan's "checkEKGstructformat.m" code
                    [flag] = checkEKGstructformat(fieldnames(arg1),Value);%%%%%***** Changed by Milind so as to be compatible with Dr. Hagan's "checkEKGstructformat.m" code
                catch
                    flag =0;
                end
                if flag == 0,
                    %errordlg('You must select a valid structure signal','Error')
                    mes1 = ['Leads of patient ' arg2 ' are incomplete'];
%                     mesw{end+1} = mes1;
                    m = m+1;
                    if m==1
                        warndlg('Some files were bad. See the command window for details');
                        mes = ['Leads of some patients are incomplete'];
                        set(H.message,'string',char(mes));

                    end
                    
                else
                    mes1 = ''; 
                    %===cd(DestFolder)
                    LeadName = fieldnames(arg1);
                    clear cc
                    cc = struct2cell(arg1);
                    StdFieldName = {'i';'ii';'iii';'avl';'avr';'avf';'v1';'v2';'v3';...
                        'v4';'v5';'v6';'vx';'vy';'vz'};

                    %===cd(CurrentDir);
                    for i = 1:length(LeadName)
                        j = find(strcmp(LeadName{i},StdFieldName));
                        if ~isempty(j)

                            if isfield(FilterObject,'wavestr')
                                arg1_f.(char(LeadName(i)))= SAIDwfilter(FilterObject,cc{j});
                            else
                                arg1_f.(char(LeadName(i)))=filter(FilterObject,cc{j});
                            end

                        else
                            arg1_f.(char(LeadName(i)))=cc{i};

                        end

                        waitbar((s)/(length(LeadName)*NumPatient));
                        s=s+1;
                    end
                    cd(DestFolder)
                    arg1_f.Filter.Name = FilterName;
                    arg1_f.Filter.Date = datestr(now);
                    NewName = strcat(fieldnames(c),'_',FilterName);
                    NewName = NewName{1};
                    v = genvarname(NewName);
                    eval([v ' = arg1_f;']);
                    save(NewName,NewName);
            
                end
%                 cd(CurrentDir);