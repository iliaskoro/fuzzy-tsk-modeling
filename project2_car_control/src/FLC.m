% ILIAS KOROMPILIS

function [flc] = FLC(x)
%% Flc Inputs-Output
    flc = mamfis;
    flc = addInput(flc,[0 1],'Name', 'dH');
    flc = addInput(flc,[0 1],'Name', 'dV' );
    flc = addInput(flc, [-180 180], 'Name','theta');

    if x==0
      flc = addOutput(flc,[-130 130],'Name', 'dtheta');
    elseif x==1
      flc = addOutput(flc,[-180 180],'Name', 'dtheta');
    end
    x=1;
    
%% FUZZY SETS for Inputs-Output 
    % dH
    if x==0
       flc = addmf(flc, 'input', 1, 'VS', 'trimf', [-0.25 0 0.25]);
       flc = addmf(flc, 'input', 1, 'S', 'trimf', [0 0.25 0.5]);
       flc = addmf(flc, 'input', 1, 'M', 'trimf', [0.25 0.5 0.75]);
       flc = addmf(flc, 'input', 1, 'L', 'trimf', [0.5 0.75 1]);
       flc = addmf(flc, 'input', 1, 'VL', 'trimf', [0.75 1. 1.25]);
    elseif x==1
       flc = addmf(flc, 'input', 1, 'VS', 'trimf', [-0.2 0 0.2]);
       flc = addmf(flc, 'input', 1, 'S', 'trimf', [0 0.2 0.4]);
       flc = addmf(flc, 'input', 1, 'M', 'trimf', [0.2 0.5 0.8]);
       flc = addmf(flc, 'input', 1, 'L', 'trimf', [0.6 0.8 1]);
       flc = addmf(flc, 'input', 1, 'VL', 'trimf', [0.8 1 1.2]);
    end
     % dV
     if x==0
       flc = addmf(flc, 'input', 2, 'VS', 'trimf', [-0.25 0 0.25]);
       flc = addmf(flc, 'input', 2, 'S', 'trimf', [0 0.25 0.5]);
       flc = addmf(flc, 'input', 2, 'M', 'trimf', [0.25 0.5 0.75]);
       flc = addmf(flc, 'input', 2, 'L', 'trimf', [0.5 0.75 1]);
       flc = addmf(flc, 'input', 2, 'VL', 'trimf', [0.75 1. 1.25]);
     elseif x==1
       flc = addmf(flc, 'input', 2, 'VS', 'trimf', [-0.2 0 0.2]);
       flc = addmf(flc, 'input', 2, 'S', 'trimf', [0 0.2 0.4]);
       flc = addmf(flc, 'input', 2, 'M', 'trimf', [0.2 0.5 0.8]);
       flc = addmf(flc, 'input', 2, 'L', 'trimf', [0.6 0.8 1]);
       flc = addmf(flc, 'input', 2, 'VL', 'trimf', [0.8 1 1.2]);
     end
        % theta
    flc = addmf(flc, 'input', 3, 'NL', 'trimf', [-270 -180 -90]);
    flc = addmf(flc, 'input', 3, 'NS', 'trimf', [-180 -90 0]);
    flc = addmf(flc, 'input', 3, 'ZE', 'trimf', [-90 0 90]);
    flc = addmf(flc, 'input', 3, 'PS', 'trimf', [0 90 180]);
    flc = addmf(flc, 'input', 3, 'PL', 'trimf', [90 180 270]);
    % dtheta
    x=0;
    if x==0
       flc = addmf(flc, 'output', 1, 'NL', 'trimf', [-195 -130 -65]);
       flc = addmf(flc, 'output', 1, 'NS', 'trimf', [-130 -65 0]);
       flc = addmf(flc, 'output', 1, 'ZE', 'trimf', [-65 0 65]);
       flc = addmf(flc, 'output', 1, 'PS', 'trimf', [0 65 130]);
       flc = addmf(flc, 'output', 1, 'PL', 'trimf', [65 130 195]);
    elseif x==1
       flc = addmf(flc, 'output', 1, 'NL', 'trimf', [-270 -180 -90]);
       flc = addmf(flc, 'output', 1, 'NS', 'trimf', [-180 -90 0]);
       flc = addmf(flc, 'output', 1, 'ZE', 'trimf', [-90 0 90]);
       flc = addmf(flc, 'output', 1, 'PS', 'trimf', [0 90 180]);
       flc = addmf(flc, 'output', 1, 'PL', 'trimf', [90 180 270]);
    end
    x=1;
    
%% Rules
    rules = [   1 1 1 5 1 1; 
                1 1 2 5 1 1;
                1 1 3 5 1 1;
                1 1 4 4 1 1;
                1 1 5 3 1 1;
                1 2 1 5 1 1; 
                1 2 2 5 1 1;
                1 2 3 5 1 1;
                1 2 4 4 1 1;
                1 2 5 3 1 1;
                1 3 1 5 1 1; 
                1 3 2 5 1 1;
                1 3 3 5 1 1;
                1 3 4 4 1 1;
                1 3 5 3 1 1;
                1 4 1 5 1 1; 
                1 4 2 5 1 1;
                1 4 3 5 1 1;
                1 4 4 4 1 1;
                1 4 5 3 1 1;
                1 5 1 5 1 1; 
                1 5 2 5 1 1;
                1 5 3 4 1 1;
                1 5 4 3 1 1;
                1 5 5 2 1 1;
                2 1 1 5 1 1; 
                2 1 2 5 1 1;
                2 1 3 4 1 1;
                2 1 4 3 1 1;
                2 1 5 2 1 1;
                2 2 1 5 1 1; 
                2 2 2 5 1 1;
                2 2 3 4 1 1;
                2 2 4 3 1 1;
                2 2 5 2 1 1;
                2 3 1 5 1 1; 
                2 3 2 5 1 1;
                2 3 3 4 1 1;
                2 3 4 3 1 1;
                2 3 5 2 1 1;
                2 4 1 5 1 1; 
                2 4 2 4 1 1;
                2 4 3 3 1 1;
                2 4 4 2 1 1;
                2 4 5 1 1 1;
                2 5 1 5 1 1; 
                2 5 2 4 1 1;
                2 5 3 3 1 1;
                2 5 4 2 1 1;
                2 5 5 1 1 1;     
                3 1 1 5 1 1;  
                3 1 2 5 1 1;
                3 1 3 4 1 1;
                3 1 4 3 1 1;
                3 1 5 2 1 1;
                3 2 1 5 1 1; 
                3 2 2 5 1 1;
                3 2 3 3 1 1;
                3 2 4 2 1 1;
                3 2 5 1 1 1;
                3 3 1 5 1 1; 
                3 3 2 5 1 1;
                3 3 3 4 1 1;
                3 3 4 3 1 1;
                3 3 5 2 1 1;
                3 4 1 5 1 1; 
                3 4 2 4 1 1;
                3 4 3 4 1 1;
                3 4 4 3 1 1;
                3 4 5 2 1 1; 
                3 5 1 5 1 1; 
                3 5 2 4 1 1;
                3 5 3 3 1 1;
                3 5 4 2 1 1;
                3 5 5 1 1 1;
                4 1 1 5 1 1; 
                4 1 2 5 1 1;
                4 1 3 4 1 1;
                4 1 4 3 1 1;
                4 1 5 2 1 1;
                4 2 1 5 1 1; 
                4 2 2 5 1 1;
                4 2 3 3 1 1;
                4 2 4 2 1 1;
                4 2 5 1 1 1;
                4 3 1 5 1 1; 
                4 3 2 4 1 1;
                4 3 3 3 1 1;
                4 3 4 2 1 1;
                4 3 5 1 1 1;
                4 4 1 5 1 1; 
                4 4 2 4 1 1;
                4 4 3 3 1 1;
                4 4 4 2 1 1;
                4 4 5 1 1 1;
                4 5 1 5 1 1; 
                4 5 2 4 1 1;
                4 5 3 3 1 1;
                4 5 4 2 1 1;
                4 5 5 1 1 1;
                5 1 1 5 1 1; 
                5 1 2 5 1 1;
                5 1 3 4 1 1;
                5 1 4 3 1 1;
                5 1 5 2 1 1;
                5 2 1 4 1 1; 
                5 2 2 3 1 1;
                5 2 3 2 1 1;
                5 2 4 1 1 1;
                5 2 5 1 1 1;
                5 3 1 5 1 1; 
                5 3 2 4 1 1;
                5 3 3 3 1 1;
                5 3 4 2 1 1;
                5 3 5 1 1 1;
                5 4 1 5 1 1; 
                5 4 2 4 1 1;
                5 4 3 3 1 1;
                5 4 4 2 1 1;
                5 4 5 1 1 1;
                5 5 1 5 1 1; 
                5 5 2 4 1 1;
                5 5 3 3 1 1;
                5 5 4 2 1 1;
                5 5 5 1 1 1;];
             
    flc = addRule(flc, rules);
end
