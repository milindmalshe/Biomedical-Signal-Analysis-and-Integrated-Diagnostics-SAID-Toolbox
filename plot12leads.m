function [h] = plot12leads(ecg,select_patient)


h = figure;
    
row1=[ecg(1:2500,1)-mean(ecg(1:2500,1));ecg(1:2500,4)-mean(ecg(1:2500,4));ecg(1:2500,7)-mean(ecg(1:2500,7));ecg(1:2500,10)-mean(ecg(1:2500,10))];
row2=[ecg(1:2500,2)-mean(ecg(1:2500,2));ecg(1:2500,5)-mean(ecg(1:2500,5));ecg(1:2500,8)-mean(ecg(1:2500,8));ecg(1:2500,11)-mean(ecg(1:2500,11))];
row3=[ecg(1:2500,3)-mean(ecg(1:2500,3));ecg(1:2500,6)-mean(ecg(1:2500,6));ecg(1:2500,9)-mean(ecg(1:2500,9));ecg(1:2500,12)-mean(ecg(1:2500,12))];
row4=ecg(1:10000,7)-mean(ecg(1:10000,7));
row5=ecg(1:10000,2)-mean(ecg(1:10000,2));
row6=ecg(1:10000,11)-mean(ecg(1:10000,11));
row1=row1+10;
row2=row2+8;
row3=row3+6;
row4=row4+4;
row5=row5+2;

plot(row1,'linewidth',0.5,'color','k')
hold on
grid on
   
plot(row2,'linewidth',0.5,'color','k')
hold on
grid on
   
plot(row3,'linewidth',0.5,'color','k')
hold on
grid on
   
plot(row4,'linewidth',0.5,'color','k')
hold on
grid on
   
plot(row5,'linewidth',0.5,'color','k')
hold on
grid on
   
plot(row6,'linewidth',0.5,'color','k')
hold on
grid on
   

set(gca,'XColor','r','YColor','r');
set(gca,'XTick',[0 200 400 600 800 1000 1200 1400 1600 1800 2000 2200 2400 2600 2800 3000 3200 3400 3600 3800 4000 4200 4400 4600 4800 5000 5200 5400 5600 5800 6000 6200 6400 6600 6800 7000 7200 7400 7600 7800 8000 8200 8400 8600 8800 9000 9200 9400 9600 9800 10000]);
set(gca,'XTickLabel',{});
set(gca,'YTick',[-2 -1.5 -1 -0.5 0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 10.5 11 11.5 12]);
set(gca,'YTickLabel',{});

text(0,11,'I','FontSize',18);
text(2500,11,'avR','FontSize',18);
text(5000,11,'V1','FontSize',18);
text(7500,11,'V4','FontSize',18);
text(0,9,'II','FontSize',18);
text(2500,9,'avL','FontSize',18);
text(5000,9,'V2','FontSize',18);
text(7500,9,'V5','FontSize',18);% MILIND MALSHE : It was V3, changed to V5???
text(0,7,'III','FontSize',18);
text(2500,7,'avF','FontSize',18);
text(5000,7,'V3','FontSize',18);
text(7500,7,'V6','FontSize',18);
text(0,5,'V1','FontSize',18);
text(0,3,'II','FontSize',18);
text(0,1,'V5','FontSize',18);

lh=title(strcat(select_patient,' - 12 Lead EKG Signal Time Domain Plot'),'FontSize',10,'FontWeight','bold');
set(lh,'interpreter','none')
hold off
