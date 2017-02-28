You can function [o1 o2 info sinfo] = evaluate_defib_sim(VOLTAGE,NUMELEM,niter,res,field1,field2,string1,string2, string3)
%% evaluate_defib_sim.m
%
% This function calculates some of the statistics of the defibrillation
% simulation and the effects on the heart tissue.  Specifically, this
% function calculates the defibrillation threshold based on critical mass
% hypothesis (95 % over 5 V/cm) and similar values for effectiveness.  
% This function also creates a histogram plot of the electric field
% strength. There is an example network with this code:
% SCIRun-Exchange/SCIRun_Networks/defib_simulation_evaluation.srn.
%
%
% inputs:
%      VOLTAGE = voltage vector of the sources.  This should be a matrix with
%      the same number of elements as number of source electrodes.
%      NUMELEM = number of elements in the total geometry, ie, the torso.
%      niter = number of iterations to acheive potential solution, from the
%      SolveLinearSystem module.
%      res = residual of the potential solution, from the SolveLinearSystem
%      module.
%      field1 = electric field strength. field of the region of interest
%      (the heart tissue) with the gradient magnitude of the potential field
%      as the field data.
%      field2 = electrode overlap field. field of the region of interest
%      (the heart tissue) with label mask of the source geometrys that
%      intersect the region.  If there is no overlap of the source electrodes
%      then this field will be all zeros.  If there is some overlap, there
%      should be non-zero values.  evaluating overlap is import because it
%      can effect the threshold calculations.
%      string1 = Name for the ICD configuration
%      string2 = Name of the conductivity configuration
%      string3 = string of the source permutivities, ie, ehich source is
%      source or sink.  this can be a string of the input VOLTAGE matrix.  
%
%
% outputs:
%     o1 = voltage needed to achieve 95 % of the myocardium over 5 V/cm.
%     o2 = energy needed to achieve 95 % of the myocardium over 5 V/cm.
%     info = string of the statistics of the region of interest
%     (myocardium) 
%     sinfo = string of the statistics in 'info' without descriptive text.
%     This is use in analysis as a matrix or other software.



%find all the non zero value field1
%field1 is the data coming in, put data in variable f
f = field1.field;
f2 = field2.field;


%info for text output
info = '';
info = sprintf('RESULTS SIMULTATION\n');
info = [info 'MODELFILE: ' string1 sprintf('\n')];
info = [info 'CONDUCTIVITY CONFIGURATION: ' string2 sprintf('\n')];
info = [info 'ELEC PERMUTATION:' string3 sprintf('\n')];

sinfo = [string1 ' ' string2 ' ' string3 ' '];

%remove everypoint with a gradient of zero 
DATA = f(find(f~=0 & f2 == 0));
DATAO = find(f~=0 & f2 ~= 0);
DATAI = find(f~=0);

%Change from matrix to vector
DATA = DATA(:);
OVERLAP = length(DATAO)/length(DATAI)*100;


%sort data points from smallest to largest
SDATA = sort(DATA);


% Compute maximum voltage
I = isnan(VOLTAGE); VOLTAGE(I) = 0;
V = max(VOLTAGE);

THRESHOLD = 0.95;

% calculate voltage and energy needed to meet threshold
V5 = (500)/SDATA(ceil((1-THRESHOLD)*length(SDATA)))*V;
V5u = (500)/SDATA(ceil((1-THRESHOLD)*length(DATAI)))*V;
V5_30 = 100*length(find(SDATA*(V5/V) > 30*100))/length(SDATA);
V5_60 = 100*length(find(SDATA*(V5/V) > 60*100))/length(SDATA);
E5 = 0.5*130e-6*(V5)^2;

SSDATA = SDATA/500*V5;

% make histogram plot
figure(1)
SPACING = 1.5;
[B,X] = hist(SSDATA/100,[0:SPACING:80]); clf; B=B/length(SDATA)*100; 
idx0 = find(X <= 3);
idx1 = find(X < 60 & X > 3 );
idx2 = find(X >= 60);
bar(X(idx1),B(idx1),'g','edgecolor','none'); hold on;
bar(X(idx2),B(idx2),'r','edgecolor','none');
bar(X(idx0),B(idx0),'b','edgecolor','none');

set(gca,'XLim',[0 80]); 
set(gca, 'fontsize', 14)
xlabel('Voltage Gradient (V/cm)','fontsize',16)
ylabel('Percentage of myocardium','fontsize',16)
title('Full Heart');

s = sprintf('V(95%%>5V/cm)= %5.4gV\nOver 30V/cm = %5.4g %%\nOver 60V/cm = %5.4g %%\nEnergy based on 130uF =%5.4gJ\nUncorrected potential = %5.4gV\nElectrode Overlap = %5.4g\n',V5,V5_30,V5_60,E5,V5u,OVERLAP);
xlim = get(gca,'XLim');
ylim = get(gca,'YLim');
text(0.2*xlim(2),0.7*ylim(2),s,'Fontsize',16);


% make string of statistics of the simulation
info = [info sprintf('Statistics for full heart:\n')];
info = [info sprintf('Voltage needed for 95%% of tissue over 5V/cm       : %5.4g V\n',V5)];
info = [info sprintf('  Amount of tissue over 30V/cm for this voltage    : %5.4g %%\n',V5_30)];
info = [info sprintf('  Amount of tissue over 60V/cm for this voltage    : %5.4g %%\n',V5_60)];
info = [info sprintf('  Energy needed for 95%% of tissue over 5V/cm      : %5.4g J\n',E5)];
info = [info sprintf('  Uncorrect potenital for 95%% of tissue over 5V/cm: %5.4g V\n',V5u)];
info = [info sprintf('  Overlap of electrodes and heart                  : %5.4g %%\n',OVERLAP)];
info = [info sprintf('Number of elements: %d \n',NUMELEM)];
info = [info sprintf('Number of iterations: %d\n',niter)];
info = [info sprintf('Residue of solve: %5.4e\n',res)];

% stirng of statistics without descriptors.  For loading and processing
sinfo = [sinfo sprintf('%6.5g %6.5g %6.5g %6.5g %6.5g %6.5g %d %d %5.4e %%p', V5, V5_30, V5_60, E5, V5u, OVERLAP, NUMELEM,niter,res)];

o1 = V5;
o2 = E5;
