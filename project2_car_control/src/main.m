% ILIAS KOROMPILIS

format compact
close all;
dir=[pwd,'\images'];
mkdir(dir)

%% Arxikopoihseis
% Arxiki thesi oximatos
xarx=3.1;
yarx=0.3;
thetarx=[0,-45,-90];

% Dimiourgia "oxima" Objects
car(1)=oxima(thesi(xarx,yarx),thetarx(1));
car(2)=oxima(thesi(xarx,yarx),thetarx(2));
car(3)=oxima(thesi(xarx,yarx),thetarx(3));

% Statheri taxitita u=0.05m/s
global u; u=0.05;

% Epithymiti thesi oximatos
    xtel=10;
    ytel=3.1;
    
% Empodia symfona me tin ekfonisi mas
    empodio_x = [5; 5; 6; 6; 7; 7; 10];
    empodio_y = [0; 1; 1; 2; 2; 3; 3];
    
%% Select Original VS Enhanced FLC

%flc_system=FLC(0);
flc_system=FLC(1);

%% Plot Membership Functions of Inputs
figure()
plotmf(flc_system, 'input', 1);
title('Membership function of dh');
saveas(gcf,fullfile(dir,['Mf_dh.png']))

figure()
plotmf(flc_system, 'input', 2);
title('Membership function of dv');
saveas(gcf,fullfile(dir,['Mf_dv.png']))

figure()
plotmf(flc_system, 'input', 3);
title('Membership function of theta');
saveas(gcf,fullfile(dir,['Mf_theta.png']))

%% Sinartiseis simmetoxis eksodou
figure()
plotmf(flc_system, 'output',1);
title('Membership function of dtheta');
saveas(gcf,fullfile(dir,['Mf_dtheta.png']))

%% Kinisi kathe oximatos
for i=1:3
   
   neathesi=car(i).thesiobj;
   ctr=1;
   xneo=car(i).thesiobj.x;
   
   while (xneo-xtel<0) 
      % sensors
      dh = car(i).get_sensors_dh(car(i)); 
      dv = car(i).get_sensors_dv(car(i)); 
      
      if or(dh<=0,dh>1)
         fprintf("\nempodio Hit\n")
         break;
      end
      if or(dv<=0,dv>1)
         fprintf("\nempodio Hit\n")
         break;
      end
      
      % Evaluate input and calculate output based on flc
      Dtheta = evalfis([dh dv car(i).theta;], flc_system);

      % Update to oxima
      car(i).theta=car(i).theta+Dtheta;
      
      if (car(i).theta<-180)
         car(i).theta=car(i).theta+360;
      elseif (car(i).theta>180)
         car(i).theta=car(i).theta-360;
      end
      
      xneo=car(i).thesiobj.x+u*cosd(car(i).theta);
      yneo=car(i).thesiobj.y+u*sind(car(i).theta);

      if xneo-xtel<0
         car(i).thesiobj= Point(xneo,yneo);
         neathesi=[neathesi car(i).thesiobj];
      end
      
      ctr=ctr+1;
   end
   %% Plots
   % Apothikeuei to x kai to y gia ta plots
   for j=1:size(neathesi,2)
       x(j)=neathesi(j).x;
       y(j)=neathesi(j).y;
   end   
    % poreia tis kinisis
    figure()
    plot(x, y, '--','LineWidth',0.75);
    hold on;
    plot(empodio_x, empodio_y, 'r','LineWidth',2);
    
    % Markarei ta arxika kai epithymita simeia sto Movement.png
    axis([2 11 0 4])
    plot(xtel, ytel, '*');
    plot(xarx, yarx, '*');
    text(xtel-2,ytel+0.5,sprintf('??????X=%.3f=%.2f%%',abs(xtel-x(end)), abs(xtel-x(end))*100/xtel))
    text(xtel-2,ytel+0.3,sprintf('??????Y=%.3f=%.2f%%',abs(ytel-y(end)), abs(ytel-y(end))*100/ytel))
    saveas(gcf,fullfile(dir,['Movement_',num2str(i),'.png']))

end
% Kanei clear ti thesi
clear dv dh i empodio_x empodio_y xtel yd j
clear xarx yarx thetarx xneo yneo x y neathesi theta u Dtheta ctr
