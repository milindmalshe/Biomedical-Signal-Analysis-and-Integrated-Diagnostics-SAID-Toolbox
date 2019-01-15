function arg1 = ChangeFieldName(arg1,arg2)
            
            LeadName = fieldnames(arg1);
            LeadName2 = LeadName;
            StdFieldName = {'i';'ii';'iii';'avl';'avr';'avf';'v1';'v2';'v3';...
                                     'v4';'v5';'v6';'vx';'vy';'vz'};
            if ~isempty(arg2)
                arg2 = strcat(arg2,'_');
            end
            info = strcat(arg2,'info');
            LeadName = strcat(arg2,LeadName);
            c = struct2cell(arg1);
            StdFieldName2 = strcat(arg2,StdFieldName);
       
            for i = 1:length(LeadName)
               
                if sum(strcmp(LeadName(i),StdFieldName2))
                        j = find(strcmp(LeadName(i),StdFieldName2));
                        arg1 = rmfield(arg1,StdFieldName(j));
                        arg1.(char(StdFieldName2(j)))= c{j};
                     
                else
                    arg1 = rmfield(arg1,LeadName2(i));
                    arg1.(info).(char(LeadName2(i)))=c{i};
                end
            end