% Code to normalize by zscoring, calculating BDI and PCA, and outputing raw
% standard measures, normalized standard measures, BDI, and PCA
% it assumes that each subject has a unique ID number

% The script expects the data in the followign format (including headings):

% Group    Rat   Session	TrialNoByTrialType	EpochRole	NumberOfEntries    PercentBehavior   Latency
%   1       1	     1	       1	               A+	           0	            0
%   1       1	     1	       1	               B-	           1	            7.31
%   1       1	     1	       2	               A+	           3	            71
%   1       1	     1	       2	               B-	           2	            62.25
%   1       1        1	       3	               A+	           1	            87.82


% Import table
clear
datadir = input('Enter data file directory (must be sole excel doc): ', 's') ; % directory of interest
data = dir(fullfile(datadir,'*.xls*')) ;
file = [datadir '\' data(1).name] ;
tbl = readtable(file) ;

% Initialize variables
AllMeasures = [] ;
xplnd = [] ;
avgtrty = [] ;

% Grab one rat at a time
ratlst = table2array(unique(tbl(:,2))) ; % list of rat numbers

for ii=1:length(ratlst)
    %% Normalize by zscoring

fstcol = tbl.('Rat') ;
ratdata = tbl(find(fstcol==ratlst(ii)),:) ; 

ratdata.normentries = zscore(ratdata.NumberOfEntries) ; % normalize entries
ratdata.normpercent = zscore(ratdata.PercentBehavior) ; % grabbing percent, but taking into account the new column created in the previous line
ratdata.normlatency = zscore(ratdata.Latency) ; % grabbing latency, but taking into account the new column created in the previous line

%% Calculate BDI
trty = unique(ratdata.EpochRole) ;
for jj=1:length(trty)
    avgtrtyEntries(jj) = mean(ratdata.normentries(find(strcmp(ratdata.EpochRole,trty(jj))))) ;
    avgtrtyPercent(jj) = mean(ratdata.normpercent(find(strcmp(ratdata.EpochRole,trty(jj))))) ;
end

stdEntries = std(avgtrtyEntries) ;
stdPercent = std(avgtrtyPercent) ;

if stdEntries > stdPercent
    ratdata.BDI = ratdata.normentries ;
else
    ratdata.BDI = ratdata.normpercent ;
end

%% Perform PCA
data4PCA = [ratdata.normentries ratdata.normpercent ratdata.normlatency] ; % grab data for PCA
[COEFF, SCORE, LATENT, TSQUARED, EXPLAINED] = pca(data4PCA); %

ratdata.PC1 = SCORE(:,1) ; 
ratdata.PC2 = SCORE(:,2) ;
ratdata.PC3 = SCORE(:,3) ;

AllMeasures = [AllMeasures; ratdata] ; 
xplnd = [xplnd ; ratlst(ii) EXPLAINED'] % xplnd = variance explained by each component for each rat

end

% save & write to excel
dir4save = [datadir '\AllMeasures'] ;
save(dir4save,'AllMeasures')

dir4write = [datadir '\AllMeasures.xlsx'] ; 
writetable(AllMeasures,dir4write)
