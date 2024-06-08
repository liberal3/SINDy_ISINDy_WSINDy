%
clc
clear
close all

addpath('./fdaM') % "http://www.psych.mcgill.ca/misc/fda/" for basis functions
addpath('./odes')
addpath('./utils')

%% Sate-space equation

% STAGE I: state equation
q0 = [0.001;0;0;0;0;0];                	% initial vector
n = length(q0);                 % dimension of state varibale

dt = 0.01;
tspan = [0:dt:350];               % sampling time instant
options = odeset('RelTol',1e-12,'AbsTol',1e-12*ones(1,n));
[~, qtru] = ode113(@vdp2,tspan,q0,options);

% STAGE II: observation equation
eps = 0;
rng(3,'twister')  % for reproducibility
nois = eps*rms(qtru).*randn(size(qtru));
qobs = qtru + nois;

%% Identification
pord = 3;
lambda = 0.005;

% noise-free case
Theta=poolData(qtru,n,pord);
xi0 = stlsIntg(qtru,Theta,lambda,dt);

% noisy case
Theta=poolData(qobs,n,pord);
xi1 = stlsIntg(qobs,Theta,lambda,dt);


%% Solution
eta = xi1(1,:); 
Xi = xi1(2:end,:);
poolDataLIST({'qv ','qv* ','qw ','qw* ','qo ','qo* '},Xi,n,3);
%%  integrate true and identified systems
tspan = [0:dt:700]; 
[t_true,q_true] = ode113(@vdp2, tspan, q0,options);
[t_pred,q_pred]=ode113(@(t,q)sparseGalerkin(t,q,Xi,3),tspan,q0,options); 

figure('name','Prediction curve')
plot(t_true,q_true(:,1),'k','linewidth',1);
hold on
plot(t_pred,q_pred(:,1),'r','linewidth',1);
legend('True curve','Prediction curve','location','best')
title('True curve VS Prediction curve')
grid on
box on

%% R2
tempdata=(q_true(:,1)-q_pred(:,1)).^2;
tempdata2=(q_true(:,1)-mean(q_true(:,1))).^2;
R2_V=1-(sum(tempdata)/sum(tempdata2))

tempdata=(q_true(:,3)-q_pred(:,3)).^2;
tempdata2=(q_true(:,3)-mean(q_true(:,3))).^2;
R2_W=1-(sum(tempdata)/sum(tempdata2))

tempdata=(q_true(:,5)-q_pred(:,5)).^2;
tempdata2=(q_true(:,5)-mean(q_true(:,5))).^2;
R2_O=1-(sum(tempdata)/sum(tempdata2))

%%
MSE_V=sum((q_pred(:,1)-q_true(:,1)).^2)/length(q_pred(:,1));
MSE_W=sum((q_pred(:,3)-q_true(:,3)).^2)/length(q_pred(:,3));
MSE_O=sum((q_pred(:,5)-q_true(:,5)).^2)/length(q_pred(:,5));
MSE=[MSE_V MSE_W MSE_O]

RMSE_V=sqrt(sum((q_pred(:,1)-q_true(:,1)).^2)/length(q_pred(:,1)));
RMSE_W=sqrt(sum((q_pred(:,3)-q_true(:,3)).^2)/length(q_pred(:,3)));
RMSE_O=sqrt(sum((q_pred(:,5)-q_true(:,5)).^2)/length(q_pred(:,5)));
RMSE=[RMSE_V RMSE_W RMSE_O]

MAE_V=sum(abs((q_pred(:,1)-q_true(:,1))))/length(q_pred(:,1));
MAE_W=sum(abs((q_pred(:,3)-q_true(:,3))))/length(q_pred(:,3));
MAE_O=sum(abs((q_pred(:,5)-q_true(:,5))))/length(q_pred(:,5));
MAE=[MAE_V MAE_W MAE_O]
