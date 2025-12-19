% ILIAS KOROMPILIS

format compact ;
clear ;
close all ;

% Example 9.9.1
HVc = tf(18.69*1.33*[1 8], [1 12.064+18.69*1.3 18.69*1.3*8]);
HTc = tf(-2.92*[1 440 0], [1 12.064+18.69*1.3 18.69*1.3*8]);

% Print Step Response
step(150*HVc);
t = 0 : 0.01 :30;
S=stepinfo(150*HVc);
RT=S.RiseTime;
OS=S.Overshoot;
Peak=S.Peak;
PT=S.PeakTime;
hold on
text(0.3,80,sprintf("RiseTime=%.2f sec",RT))
text(0.3,70,sprintf("OverShoot=%.2f %%",OS))
text(PT-0.375,60,sprintf("Peak=%.2f",Peak))

% Print Bode diagram of HVc
figure();
bode(HVc);

% Print Bode diagram of HTc
figure();
bode(HTc);

uV = 150*stepfun(t,0);
%uT1 = 150*stepfun(t,0);
%uT2 = -50 * stepfun(t,10);
%uT3 = 50*stepfun(t,20);
%uT = uT1 + uT2 + uT3;
uT = 0*stepfun(t,0);
yV = lsim(HVc, uV, t);
yT = lsim(HTc, uT, t);
y = yV +yT;

% Print 
figure();
plot(t, y, t, 20*uT);

%% Fuzzy PI Controller

FZPI=readfis('dc.fis');

figure()
plotmf(FZPI, 'input',1);
title('Membership function of E');

figure()
plotmf(FZPI, 'input',2);
title('Membership function of dE/dt');

figure()
plotmf(FZPI, 'output',1);
title('Membership function of dU/dt');