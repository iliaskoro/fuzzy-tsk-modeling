% ILIAS KOROMPILIS

%% Final model
format compact
clear ;
close all ;
clc

dir=[pwd, '\images2'];
mkdir(dir)
traindata = unique(table2array(readtable('train.csv')), 'rows');
S=size(traindata, 2) ; 
[trainD, checkD, testD]=split_scale(traindata, 1);
load RANK.mat
feat=27; % 27 features
rad=0.75; % grade of iterrations
Model = struct('NUMBERofFeatures', feat, 'Radius', rad);
modelfis = genfis2(trainD(:, RANK(1 : feat)), trainD(:, end), rad);
[trnFis, trainErr, ~, valFis, validErr] = anfis(trainD(:, [RANK(1: feat), S]), modelfis ,...
   [600 0 0.01 0.9 1.1], [ ], checkD(:, [RANK(1: feat), S]));
tsYhat=evalfis(valFis, testD(:, RANK(1 : feat)));

   % Exercise's formulas
   S_E=sum((tsYhat-testD(:, end)).^2);
   S_S=sum((mean(testD(:, end))-testD(:, end)).^2);
   Model.('MSE')=S_E/size(testD, 1);
   Model.('R2')=1-S_E/S_S;
   Model.('RMSE')=sqrt(S_E/size(testD, 1));

   % Membership Functions for each input
for i=[1, 5, 10, 15, 19] 
      figure() 
      subplot(2, 1, 1) 
      [x, mf]=plotmf(modelfis, 'input', i);
      plot(x, mf)
      title(['Initial MFs for Feature-Input ', num2str(i)])
      subplot(2 , 1 , 2)
      [x, mf]=plotmf(valFis, 'input', i);
      plot(x, mf)
      title(['Tuned MFs for Feature-Input ', num2str(i)])
      saveas(gcf, fullfile (dir, ['Model_', 'Final', '_CompMfs_', num2str(i), '.png']))
end
      % Learning Curve Plot
      figure()
      plot([trainErr, validErr], 'LineWidth', 1);
      grid on;
      xlabel('# of Iterations');
      ylabel('Error');
      legend('Training Error', 'Validation Error');
      title('Learning Curve');
      saveas(gcf , fullfile(dir, 'Learningcurve.png'))
      
      % Estimation Error Plot
      figure()
      plot(1 : size(testD, 1), testD(:, end), '*r', 1:size(testD, 1), tsYhat, '.b');
      title('Estimation Error');
      legend('Reference Outputs', 'Model Outputs');
      saveas(gcf, fullfile(dir, 'Instances.png')) 
      