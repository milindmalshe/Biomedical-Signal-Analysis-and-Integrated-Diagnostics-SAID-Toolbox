% Simple code to make structure for loading 
% signal to the Signal processing GUI
% 
% clc
% clear all
% close all

load ans1; load ans2; load ans3; load ans4; load ans5; load ans6; load ans7; load ans8; load ans9; load ans10;
load ans11; load ans12; load ans13; load ans14; load ans15;

% load ans;
% ans1 = ans.ans1; ans2 = ans.ans2; ans3 = ans.ans3; ans4 = ans.ans4; ans5 = ans.ans5; 
% ans6 = ans.ans6; ans7 = ans.ans7; ans8 = ans.ans8; ans9 = ans.ans9; ans10 = ans.ans10; 
% ans11 = ans.ans11; ans12 = ans.ans12; ans13 = ans.ans13; ans14 = ans.ans14; ans15 = ans.ans15; 


Patient1.i=ans1(:,1);
Patient1.ii=ans1(:,2);
Patient1.iii=ans1(:,3);
Patient1.avl=ans1(:,4);
Patient1.avr=ans1(:,5);
Patient1.avf=ans1(:,6);
Patient1.v1=ans1(:,7);
Patient1.v2=ans1(:,8);
Patient1.v3=ans1(:,9);
Patient1.v4=ans1(:,10);
Patient1.v5=ans1(:,11);
Patient1.v6=ans1(:,12);
Patient1.vx=ans1(:,13);
Patient1.vy=ans1(:,14);
Patient1.vz=ans1(:,15);
Patient1.Gender='M';
Patient1.ID='111-11-1111';
Patient1.Weight=100;
Patient1.BloodGroup ='1+';
Patient1.Age = 10;
Patient1.fs = 1000;
Patient1.Diagnosis = 'Healthy';

Patient2.i=ans2(:,1);
Patient2.ii=ans2(:,2);
Patient2.iii=ans2(:,3);
Patient2.avl=ans2(:,4);
Patient2.avr=ans2(:,5);
Patient2.avf=ans2(:,6);
Patient2.v1=ans2(:,7);
Patient2.v2=ans2(:,8);
Patient2.v3=ans2(:,9);
Patient2.v4=ans2(:,10);
Patient2.v5=ans2(:,11);
Patient2.v6=ans2(:,12);
Patient2.Gender='F';
Patient2.ID='222-22-2222';
Patient2.Weight=200;
Patient2.BloodGroup ='2+';
Patient2.Age = 20;
Patient2.fs = 1000;
Patient2.Diagnosis = 'Myocardial Infarction';

Patient3.i=ans3(:,1);
Patient3.ii=ans3(:,2);
Patient3.iii=ans3(:,3);
Patient3.avl=ans3(:,4);
Patient3.avr=ans3(:,5);
Patient3.avf=ans3(:,6);
Patient3.v1=ans3(:,7);
Patient3.v2=ans3(:,8);
Patient3.v3=ans3(:,9);
Patient3.v4=ans3(:,10);
Patient3.v5=ans3(:,11);
Patient3.v6=ans3(:,12);
Patient3.Gender='M';
Patient3.ID='333-33-3333';
Patient3.Weight=300;
Patient3.BloodGroup ='3+';
Patient3.Age = 30;
Patient3.fs = 1000;
Patient3.Diagnosis = 'Healthy';

Patient4.i=ans4(:,1);
Patient4.ii=ans4(:,2);
Patient4.iii=ans4(:,3);
Patient4.avl=ans4(:,4);
Patient4.avr=ans4(:,5);
Patient4.avf=ans4(:,6);
Patient4.v1=ans4(:,7);
Patient4.v2=ans4(:,8);
Patient4.v3=ans4(:,9);
Patient4.v4=ans4(:,10);
Patient4.v5=ans4(:,11);
Patient4.v6=ans4(:,12);
Patient4.Gender='F';
Patient4.ID='444-44-4444';
Patient4.Weight=400;
Patient4.BloodGroup ='4+';
Patient4.Age = 40;
Patient4.fs = 1000;
Patient4.Diagnosis = 'Myocardial Infarction';

Patient5.i=ans5(:,1);
Patient5.ii=ans5(:,2);
Patient5.iii=ans5(:,3);
Patient5.avl=ans5(:,4);
Patient5.avr=ans5(:,5);
Patient5.avf=ans5(:,6);
Patient5.v1=ans5(:,7);
Patient5.v2=ans5(:,8);
Patient5.v3=ans5(:,9);
Patient5.v4=ans5(:,10);
Patient5.v5=ans5(:,11);
Patient5.v6=ans5(:,12);
Patient5.vx=ans5(:,13);
Patient5.vy=ans5(:,14);
Patient5.vz=ans5(:,15);
Patient5.Gender='M';
Patient5.ID='555-55-5555';
Patient5.Weight=500;
Patient5.BloodGroup ='5+';
Patient5.Age = 50;
Patient5.fs = 1000;
Patient5.Diagnosis = 'Healthy';

Patient6.i=ans6(:,1);
Patient6.ii=ans6(:,2);
Patient6.iii=ans6(:,3);
Patient6.avl=ans6(:,4);
Patient6.avr=ans6(:,5);
Patient6.avf=ans6(:,6);
Patient6.v1=ans6(:,7);
Patient6.v2=ans6(:,8);
Patient6.v3=ans6(:,9);
Patient6.v4=ans6(:,10);
Patient6.v5=ans6(:,11);
Patient6.v6=ans6(:,12);
Patient6.Gender='F';
Patient6.ID='666-66-6666';
Patient6.Weight=600;
Patient6.BloodGroup ='6+';
Patient6.Age = 60;
Patient6.fs = 1000;
Patient6.Diagnosis = 'Myocardial Infarction';

Patient7.i=ans7(:,1);
Patient7.ii=ans7(:,2);
Patient7.iii=ans7(:,3);
Patient7.avl=ans7(:,4);
Patient7.avr=ans7(:,5);
Patient7.avf=ans7(:,6);
Patient7.v1=ans7(:,7);
Patient7.v2=ans7(:,8);
Patient7.v3=ans7(:,9);
Patient7.v4=ans7(:,10);
Patient7.v5=ans7(:,11);
Patient7.v6=ans7(:,12);
Patient7.Gender='M';
Patient7.ID='777-77-7777';
Patient7.Weight=700;
Patient7.BloodGroup ='7+';
Patient7.Age = 70;
Patient7.fs = 1000;
Patient7.Diagnosis = 'Healthy';

Patient8.i=ans8(:,1);
Patient8.ii=ans8(:,2);
Patient8.iii=ans8(:,3);
Patient8.avl=ans8(:,4);
Patient8.avr=ans8(:,5);
Patient8.avf=ans8(:,6);
Patient8.v1=ans8(:,7);
Patient8.v2=ans8(:,8);
Patient8.v3=ans8(:,9);
Patient8.v4=ans8(:,10);
Patient8.v5=ans8(:,11);
Patient8.v6=ans8(:,12);
Patient8.Gender='F';
Patient8.ID='888-88-8888';
Patient8.Weight=800;
Patient8.BloodGroup ='8+';
Patient8.Age = 80;
Patient8.fs = 1000;
Patient8.Diagnosis = 'Myocardial Infarction';


Patient9.i=ans9(:,1);
Patient9.ii=ans9(:,2);
Patient9.iii=ans9(:,3);
Patient9.avl=ans9(:,4);
Patient9.avr=ans9(:,5);
Patient9.avf=ans9(:,6);
Patient9.v1=ans9(:,7);
Patient9.v2=ans9(:,8);
Patient9.v3=ans9(:,9);
Patient9.v4=ans9(:,10);
Patient9.v5=ans9(:,11);
Patient9.v6=ans9(:,12);
Patient9.vx=ans9(:,13);
Patient9.vy=ans9(:,14);
Patient9.vz=ans9(:,15);
Patient9.Gender='M';
Patient9.ID='999-99-9999';
Patient9.Weight=900;
Patient9.BloodGroup ='9+';
Patient9.Age = 90;
Patient9.fs = 1000;
Patient9.Diagnosis = 'Healthy';

Patient10.i=ans10(:,1);
Patient10.ii=ans10(:,2);
Patient10.iii=ans10(:,3);
Patient10.avl=ans10(:,4);
Patient10.avr=ans10(:,5);
Patient10.avf=ans10(:,6);
Patient10.v1=ans10(:,7);
Patient10.v2=ans10(:,8);
Patient10.v3=ans10(:,9);
Patient10.v4=ans10(:,10);
Patient10.v5=ans10(:,11);
Patient10.v6=ans10(:,12);
Patient10.Gender='F';
Patient10.ID='101010-1010-10101010';
Patient10.Weight=1000;
Patient10.BloodGroup ='10+';
Patient10.Age = 100;
Patient10.fs = 1000;
Patient10.Diagnosis = 'Myocardial Infarction';

Patient11.i=ans11(:,1);
Patient11.ii=ans11(:,2);
Patient11.iii=ans11(:,3);
Patient11.avl=ans11(:,4);
Patient11.avr=ans11(:,5);
Patient11.avf=ans11(:,6);
Patient11.v1=ans11(:,7);
Patient11.v2=ans11(:,8);
Patient11.v3=ans11(:,9);
Patient11.v4=ans11(:,10);
Patient11.v5=ans11(:,11);
Patient11.v6=ans11(:,12);
Patient11.Gender='M';
Patient11.ID='111111-1111-11111111';
Patient11.Weight=1100;
Patient11.BloodGroup ='11+';
Patient11.Age = 110;
Patient11.fs = 1000;
Patient11.Diagnosis = 'Healthy';

Patient12.i=ans12(:,1);
Patient12.ii=ans12(:,2);
Patient12.iii=ans12(:,3);
Patient12.avl=ans12(:,4);
Patient12.avr=ans12(:,5);
Patient12.avf=ans12(:,6);
Patient12.v1=ans12(:,7);
Patient12.v2=ans12(:,8);
Patient12.v3=ans12(:,9);
Patient12.v4=ans12(:,10);
Patient12.v5=ans12(:,11);
Patient12.v6=ans12(:,12);
Patient12.Gender='F';
Patient12.ID='121212-1212-12121212';
Patient12.Weight=1200;
Patient12.BloodGroup ='12+';
Patient12.Age = 120;
Patient12.fs = 1000;
Patient12.Diagnosis = 'Myocardial Infarction';

Patient13.i=ans13(:,1);
Patient13.ii=ans13(:,2);
Patient13.iii=ans13(:,3);
Patient13.avl=ans13(:,4);
Patient13.avr=ans13(:,5);
Patient13.avf=ans13(:,6);
Patient13.v1=ans13(:,7);
Patient13.v2=ans13(:,8);
Patient13.v3=ans13(:,9);
Patient13.v4=ans13(:,10);
Patient13.v5=ans13(:,11);
Patient13.v6=ans13(:,12);
Patient13.Gender='M';
Patient13.ID='1313-1313-13131313';
Patient13.Weight=1300;
Patient13.BloodGroup ='13+';
Patient13.Age = 130;
Patient13.fs = 1000;
Patient13.Diagnosis = 'Healthy';


Patient14.i=ans14(:,1);
Patient14.ii=ans14(:,2);
Patient14.iii=ans14(:,3);
Patient14.avl=ans14(:,4);
Patient14.avr=ans14(:,5);
Patient14.avf=ans14(:,6);
Patient14.v1=ans14(:,7);
Patient14.v2=ans14(:,8);
Patient14.v3=ans14(:,9);
Patient14.v4=ans14(:,10);
Patient14.v5=ans14(:,11);
Patient14.v6=ans14(:,12);
Patient14.Gender='F';
Patient14.ID='141414-1414-14141414';
Patient14.Weight=1400;
Patient14.BloodGroup ='14+';
Patient14.Age = 140;
Patient14.fs = 1000;
Patient14.Diagnosis = 'Myocardial Infarction';


Patient15.i=ans15(:,1);
Patient15.ii=ans15(:,2);
Patient15.iii=ans15(:,3);
Patient15.avl=ans15(:,4);
Patient15.avr=ans15(:,5);
Patient15.avf=ans15(:,6);
Patient15.v1=ans15(:,7);
Patient15.v2=ans15(:,8);
Patient15.v3=ans15(:,9);
Patient15.v4=ans15(:,10);
Patient15.v5=ans15(:,11);
Patient15.v6=ans15(:,12);
Patient15.Gender='M';
Patient15.ID='151515-1515-15151515';
Patient15.Weight=1500;
Patient15.BloodGroup ='15+';
Patient15.Age = 150;
Patient15.fs = 1000;
Patient15.Diagnosis = 'Healthy';


clear ans1; clear ans2; clear ans3; clear ans4; clear ans5; clear ans6; clear ans7; clear ans8; clear ans9; clear ans10;
clear ans11; clear ans12; clear ans13; clear ans14; clear ans15;




