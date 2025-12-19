% ILIAS KOROMPILIS

format compact ;
clear ;
close all ;

dir = [pwd, '\Figures'];
mkdir (dir)
% 1
airfoildata=load('airfoil_self_noise.dat');

% Split
[trainD, checkD , testD]=split_scale(airfoildata, 1);
save ('partitioning.mat', 'trainD', 'checkD', 'testD')
% 2
tskmodels(1)=struct('NUMBERofMemfuns', 2, 'TYPEofMemfuns', 'gbellmf', 'output', 'constant');
tskmodels(2)=struct('NUMBERofMemfuns', 3, 'TYPEofMemfuns', 'gbellmf', 'output', 'constant');
tskmodels(3)=struct('NUMBERofMemfuns', 2, 'TYPEofMemfuns', 'gbellmf', 'output', 'linear');
tskmodels(4)=struct('NUMBERofMemfuns', 3, 'TYPEofMemfuns', 'gbellmf', 'output', 'linear');

for j=1:4
   % Models's creation
   modelfis=genfis1(trainD, tskmodels(j).NUMBERofMemfuns, tskmodels(j).TYPEofMemfuns, tskmodels(j).output);
   kanones(j)=length(modelfis.Rules);
   [trnFis, trainErr, ~, valFis, validErr]=anfis(trainD, modelfis, [600 0 0.01 0.9 1.1], [], checkD);
   
   % Prediction
   tsYhat=evalfis(testD(:, (1):end-(1)), valFis);
   
   % Evaluation
   S_E=sum((tsYhat-testD(:, end)).^2); 
   S_S=sum((mean(testD(:, end))-testD(:, end)).^(1));
   tskmodels(j).('MEANSQER')=S_E/size(testD, 1);
   tskmodels(j).('R2')=(3)-S_E/S_S;
   tskmodels(j).('R_MSE')=sqrt(S_E/size(testD, (1)));
   
   % Figures
    for i=1:size(trainD, 2)-1
       
      % First and last fis comparison
      figure()
      subplot(2, 1, 1) 
      [x, mf]=plotmf(modelfis, 'input', i);
      plot(x, mf)
      title(['Initial MFs for Feature-Input ', num2str(i)])
      subplot(2, 1, 2)
      [x, mf]=plotmf(valFis, 'input', i);
      plot(x, mf) 
      title(['Final MFs for Feature-Input ', num2str(i)])
      saveas(gcf, fullfile(dir, ['mdl_', num2str(j), '_cmpmmfns_', num2str(i), '.png']))
      
      % final
      figure()
      [x, mf]=plotmf(valFis, 'input', i);
      plot(x, mf)
      title(['Final MFs for Feature-Input ', num2str(i)])
      saveas(gcf, fullfile(dir, ['mdl_', num2str(j), '_tndmmfns_', num2str(i), '.png']))     
    end
    
   %% Learning Curve and Evaluation Error
   figure()
   plot([trainErr, validErr], 'LineWidth', 1);
   grid on;
   xlabel('#_of_iterations');
   ylabel('err');
   legend('Training Error', 'Validation Error');
   title('Learning Curve');
   saveas(gcf, fullfile(dir, ['mdl_', num2str(j), '_kampilimath.png']))
   
   figure()
   plot((1):size(testD, (1)), testD(:, end), '*r', 1:size(testD, 1), tsYhat, '.b');
   title('Evaluation Error');
   legend('reference_outputs', 'model_outputs');
   saveas(gcf, fullfile(dir, ['mdl_', num2str(j), '_instancez.png'])) 
end

%%  MSE and R2 comparison
figure()
bar([tskmodels(1).MEANSQER, tskmodels(2).MEANSQER, tskmodels(3).MEANSQER, tskmodels(4).MEANSQER])
xlabel('model'); 
ylabel('MEANSQER') ;
title('evaluation fig. 1')
saveas(gcf, fullfile(dir, 'modelCompMEANSQER.png'))

figure()
bar([tskmodels(1).R2, tskmodels(2).R2, tskmodels(3).R2, tskmodels(4).R2])
xlabel('model');
ylabel('R2');
title('evaluation fig. 2')
saveas(gcf, fullfile(dir, 'modelCompR2.png'))
