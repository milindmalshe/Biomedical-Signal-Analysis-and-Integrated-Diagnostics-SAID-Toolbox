
function Spreadsheet1 = Spreadsheet_confusionMat(data,percentErrAvg)


numRows = size(data,1);
numColumns = size(data,2);




% INSTANTIATE THE CONTROL
h.f  = figure;
psn  = get(h.f,'Position');
%Spreadsheet1 = actxcontrol('OWC9.Spreadsheet.9',[0 0 psn(3:4)]);
%Spreadsheet1 = actxcontrol('OWC10.Spreadsheet.10',[0 0 psn(3:4)]);
Spreadsheet1 = actxcontrol('OWC11.Spreadsheet.11',[0 0 psn(3:4)]);

% USE AN ENUMERATED TYPE WORKAROUND
% ClassEnumType = {'cell','char','logical','numeric'};

% FIND THE ACTIVE SHEET
ActSheet = get(Spreadsheet1,'ActiveSheet');

% FIND THE ACTIVE CELL, ROW AND COLUMN
% THIS IS NOT NECESSARY, BUT IT IS DONE FOR DEMONSTRATION
ActCell = get(Spreadsheet1,'ActiveCell');
ActCellRow = get(ActCell,'Row');
ActCellColumn = get(ActCell,'Column');

% SET COLUMN WIDTH
% ActCell.ColumnWidth = 24;

% SET ROW HEIGHT
% ActCell.RowHeight = 24;


cell_current = nn2an(1,1);
Select(Range(ActSheet,cell_current));

ActCell = get(Spreadsheet1,'ActiveCell');
set(ActCell,'Value','True ');
% % -----------

cell_current = nn2an(2,1);
Select(Range(ActSheet,cell_current));

ActCell = get(Spreadsheet1,'ActiveCell');
set(ActCell,'Value','Healthy');
% % -----------

cell_current = nn2an(3,1);
Select(Range(ActSheet,cell_current));

ActCell = get(Spreadsheet1,'ActiveCell');
set(ActCell,'Value','MI');
% % -----------

cell_current = nn2an(2,2);
Select(Range(ActSheet,cell_current));

ActCell = get(Spreadsheet1,'ActiveCell');
set(ActCell,'Value',data(1,1));
% % -----------

cell_current = nn2an(2,3);
Select(Range(ActSheet,cell_current));

ActCell = get(Spreadsheet1,'ActiveCell');
set(ActCell,'Value',data(1,2));
% % -----------

cell_current = nn2an(3,2);
Select(Range(ActSheet,cell_current));

ActCell = get(Spreadsheet1,'ActiveCell');
set(ActCell,'Value',data(2,1));
% % -----------

cell_current = nn2an(3,3);
Select(Range(ActSheet,cell_current));

ActCell = get(Spreadsheet1,'ActiveCell');
set(ActCell,'Value',data(2,2));
% % -----------

cell_current = nn2an(4,2);
Select(Range(ActSheet,cell_current));

ActCell = get(Spreadsheet1,'ActiveCell');
set(ActCell,'Value','Healthy');
% % -----------

cell_current = nn2an(4,3);
Select(Range(ActSheet,cell_current));

ActCell = get(Spreadsheet1,'ActiveCell');
set(ActCell,'Value','MI');
% % -----------

cell_current = nn2an(4,4);
Select(Range(ActSheet,cell_current));

ActCell = get(Spreadsheet1,'ActiveCell');
set(ActCell,'Value','Predicted');
% % -----------

% cell_current = nn2an(5,1);
cell_current = nn2an(6,1);
Select(Range(ActSheet,cell_current));

ActCell = get(Spreadsheet1,'ActiveCell');
% ActCell.ColumnWidth = 24;

percentErrAvg_string = strcat('','Average Percent Testing Error= ',num2str(percentErrAvg));
% percentErrAvg_string = sprintf('%s%f','Average Percent Testing Error= ',percentErrAvg);
set(ActCell,'Value',percentErrAvg_string);

% % -----------











function cr = nn2an(r,c)
% Thanks Brett Shoelson

t = [floor((c - 1)/26) + 64 rem(c - 1, 26) + 65];
if(t(1)<65), t(1) = []; end
cr = [char(t) num2str(r)];



