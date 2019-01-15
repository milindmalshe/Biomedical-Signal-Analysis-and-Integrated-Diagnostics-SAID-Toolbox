function [h] = scatterplot(data,names)


figure
[r,c] = size(data);
k=1;
for i=1:c,
  for j=1:c, 
    if i==j, 
      subplot(c,c,k); 
      hist(data(:,i)); title(names{i})
    elseif i<j, 
      subplot(c,c,k); 
      plot(data(:,i),data(:,j),'k.')
      xlabel(names{i})
      ylabel(names{j})
    end
    k=k+1;
  end
end
