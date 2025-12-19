clear all;
clc;
%% Fuzzy system
fis = newfis('dc', 'mamdani', 'min', 'max', 'min', 'max', 'centroid');

%% Inputs-Outputs
fis = addvar(fis, 'input', 'e', [-1 1]);
fis = addvar(fis, 'input', 'de', [-1 1]);
fis = addvar(fis, 'output', 'du', [-1 1]);

%% Fuzzy sets for input e
fis = addmf(fis, 'input', 1, 'NV', 'trimf', [-1 -1 -0.75]);
fis = addmf(fis, 'input', 1, 'NL', 'trimf', [-1 -0.75 -0.5]);
fis = addmf(fis, 'input', 1, 'NM', 'trimf', [-0.75 -0.5 -0.25]);
fis = addmf(fis, 'input', 1, 'NS', 'trimf', [-0.5 -0.25 0]);
fis = addmf(fis, 'input', 1, 'ZR', 'trimf', [-0.25 0 0.25]);
fis = addmf(fis, 'input', 1, 'PS', 'trimf', [0 0.25 0.5]);
fis = addmf(fis, 'input', 1, 'PM', 'trimf', [0.25 0.5 0.75]);
fis = addmf(fis, 'input', 1, 'PL', 'trimf', [0.5 0.75 1]);
fis = addmf(fis, 'input', 1, 'PV', 'trimf', [0.75 1 1]);

%% Fuzzy sets for input edot
fis = addmf(fis, 'input', 2, 'NV', 'trimf', [-1 -1 -0.75]);
fis = addmf(fis, 'input', 2, 'NL', 'trimf', [-1 -0.75 -0.5]);
fis = addmf(fis, 'input', 2, 'NM', 'trimf', [-0.75 -0.5 -0.25]);
fis = addmf(fis, 'input', 2, 'NS', 'trimf', [-0.5 -0.25 0]);
fis = addmf(fis, 'input', 2, 'ZR', 'trimf', [-0.25 0 0.25]);
fis = addmf(fis, 'input', 2, 'PS', 'trimf', [0 0.25 0.5]);
fis = addmf(fis, 'input', 2, 'PM', 'trimf', [0.25 0.5 0.75]);
fis = addmf(fis, 'input', 2, 'PL', 'trimf', [0.5 0.75 1]);
fis = addmf(fis, 'input', 2, 'PV', 'trimf', [0.75 1 1]);

%% Fuzzy sets for output udot
fis = addmf(fis, 'output', 1, 'NL', 'trimf', [-1 -0.75 -0.5]);
fis = addmf(fis, 'output', 1, 'NM', 'trimf', [-0.75 -0.5 -0.25]);
fis = addmf(fis, 'output', 1, 'NS', 'trimf', [-0.5 -0.25 0]);
fis = addmf(fis, 'output', 1, 'ZR', 'trimf', [-0.25 0 0.25]);
fis = addmf(fis, 'output', 1, 'PS', 'trimf', [0 0.25 0.5]);
fis = addmf(fis, 'output', 1, 'PM', 'trimf', [0.25 0.5 0.75]);
fis = addmf(fis, 'output', 1, 'PL', 'trimf', [0.5 0.75 1]);

%% Rules
% e = NV
ruleList = [1 9 4 1 1;
            1 8 3 1 1;
            1 7 2 1 1;
            1 6 1 1 1;
            1 5 1 1 1;
            1 4 1 1 1;
            1 3 1 1 1;
            1 2 1 1 1;
            1 1 1 1 1];
 fis = addrule(fis, ruleList);
 
% e = NL
ruleList = [2 9 5 1 1;
            2 8 4 1 1;
            2 7 3 1 1;
            2 6 2 1 1;
            2 5 1 1 1;
            2 4 1 1 1;
            2 3 1 1 1;
            2 2 1 1 1;
            2 1 1 1 1];
fis = addrule(fis, ruleList);
 
% e = NM
ruleList = [3 9 6 1 1;
            3 8 5 1 1;
            3 7 4 1 1;
            3 6 3 1 1;
            3 5 2 1 1;
            3 4 1 1 1;
            3 3 1 1 1;
            3 2 1 1 1;
            3 1 1 1 1];
fis = addrule(fis, ruleList);   

% e = NS
ruleList = [4 9 7 1 1;
            4 8 6 1 1;
            4 7 5 1 1;
            4 6 4 1 1;
            4 5 3 1 1;
            4 4 2 1 1;
            4 3 1 1 1;
            4 2 1 1 1;
            4 1 1 1 1];
fis = addrule(fis, ruleList);

% e = ZR
ruleList = [5 9 7 1 1;
            5 8 7 1 1;
            5 7 6 1 1;
            5 6 5 1 1;
            5 5 4 1 1;
            5 4 3 1 1;
            5 3 2 1 1;
            5 2 1 1 1;
            5 1 1 1 1];
fis = addrule(fis, ruleList);

% e = PS
ruleList = [6 9 7 1 1;
            6 8 7 1 1;
            6 7 7 1 1;
            6 6 6 1 1;
            6 5 5 1 1;
            6 4 4 1 1;
            6 3 3 1 1;
            6 2 2 1 1;
            6 1 1 1 1];
fis = addrule(fis, ruleList);

% e = PM
ruleList = [7 9 7 1 1;
            7 8 7 1 1;
            7 7 7 1 1;
            7 6 7 1 1;
            7 5 6 1 1;
            7 4 5 1 1;
            7 3 4 1 1;
            7 2 3 1 1;
            7 1 2 1 1];
fis = addrule(fis, ruleList);

% e = PL
ruleList = [8 9 7 1 1;
            8 8 7 1 1;
            8 7 7 1 1;
            8 6 7 1 1;
            8 5 7 1 1;
            8 4 6 1 1;
            8 3 5 1 1;
            8 2 4 1 1;
            8 1 3 1 1];
fis = addrule(fis, ruleList);

% e = PV
ruleList = [9 9 7 1 1;
            9 8 7 1 1;
            9 7 7 1 1;
            9 6 7 1 1;
            9 5 7 1 1;
            9 4 7 1 1;
            9 3 6 1 1;
            9 2 5 1 1;
            9 1 4 1 1];
fis = addrule(fis, ruleList);
 
writefis(fis,'dc.fis')