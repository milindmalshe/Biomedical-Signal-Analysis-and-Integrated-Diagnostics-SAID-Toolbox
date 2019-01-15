function SAIDplot(a,b,info,xName,figTitle)

 
    
    if ~isempty(a)
        [num1] = length(a);
        figure
        for i= 1:length(a)
            t = (1:length(a{i}))/info{i}.fs;
            
            plot(t, a{i});
            hold all;
        end
        title(figTitle);
        xlabel(xName);
        hold off;
        
        leg = cell(num1,1);
        for i=1:num1,
          leg{i} = info{i}.Lead;
        end 
        lh = legend(leg);
        set(lh,'interpreter','none')
    else
% RJ
        num1 = 0;
    end

    if ~isempty(b)
        figure
        for i = 1:length(b)

            [num2,L] = size(b{i});
            %L = length(b(1,:));
            L = fix(L/50);
            f = info{1}.fs*linspace(0,1,L)/50;
            plot(f,abs(b{i}(1:L)));
            
            hold all;
        end
        title('Frequency Domain Plot');
        xlabel('Hz');
        hold off;
        
        for i=1:length(b)
            % f = info{num1+i}.SamplingFrequency*linspace(0,1,L/50);
            leg2{i} = info{num1+i}.Lead;
        end
        lh2 = legend(leg2);
        set(lh2,'interpreter','none')
    else
% RJ
        num2 = 0;
    end
info