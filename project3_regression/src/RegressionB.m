% ILIAS KOROMPILIS

format compact
clear ;
close all ;
clc
%% LOADS-SAVES
traindata=unique(table2array(readtable('train.csv')), 'rows');
S=size(traindata, 2); 
[trainD, checkD, testD]=split_scale(traindata, 1) ;
[RANK, ~]=relieff(traindata(:, 1: end-1), traindata(:, end), 100);
save ('RANK.mat','RANK')
save ('SPLITS.mat', 'trainD', 'checkD', 'testD')
load RANK.mat
load SPLITS.mat
Mdl=[ ];

%% GRIDSEARCH:

% 1
  %charFeats = [3 4 8 15];
  %Rds = [0.2 0.25 0.45 0.75];

% 2
  %charFeats = [3 5 7 9 13 16 21];
  %Rds = [0.4 0.55 0.6 0.65 0.6 0.65 0.75];

% 3
  charFeats = [ 4 6 8 10 15 19 21 23 27];
  Rds = [0.25 0.35 0.15 0.25 0.35 0.45 0.55 0.7 0.75];

%% TRAINING

for j=(1):length(charFeats) 
    
    fj=charFeats(j); 
    rj=Rds(j);
    Prtion=cvpartition(trainD(:, end ), 'KFold', 5);
    modelfis=genfis2(trainD(:, RANK(1: fj)) , trainD(:, end), rj);
    Model=struct('NUMBERofFeatures', fj, 'RADIUS', rj);
    MEAN =- (1);
    MEANErr =- (1);
    
    if length(modelfis.Rule)<(2)
       Model.('Situation')='One rule!';
       
    elseif length(modelfis.Rule)>200
       Model.('Situation')='Rules over 200!';  
       
    else
       Model.('Situation')='Appropriate choice!';
       MEAN=0;
       MEANErr=0;
       for L=1:5
          disp(['Model: ', num2str(fj), ' Features, ', num2str(rj), ' Radius, ', 'Fold ', num2str(L)])
          Tst = tic ;  
          [trnFis, trainErr, ~, valFis, validErr]=anfis(trainD(Prtion.training(L), [RANK(1: fj), S]), ...
             modelfis, [100 0 0.01 0.9 1.1], [ ], trainD(Prtion.test(L), [RANK(1: fj), S]));
          MEAN=MEAN+toc(Tst)/(5);
          tsYhat=evalfis(valFis, checkD(:, RANK(1: fj)));
          MEANErr=MEANErr+sum((tsYhat-checkD(:, end )) .^ 2) / size(checkD, 1)/(5);
       end    
       
       Model.('MEANTT')=MEAN;
       Model.('MEANERROR')=MEANErr;
       Model.('NORULES')=length(modelfis.Rule);
       Model.('RMSE')=sqrt(MEANErr);
    end      
    
    Mdl=[Mdl Model] ;
    
end
save('models.mat', 'Mdl')
