%
clc
clear
close all

addpath('./fdaM') % "http://www.psych.mcgill.ca/misc/fda/" for basis functions
addpath('./odes')
addpath('./utils')
data=xlsread('data1.xlsx');
%% Sate-space equation

% STAGE I: state equation
q0 = [0.001;0;0;0];                	% initial vector
n = length(q0);                 % dimension of state varibale

dt = 0.01; 
tspan = [0:dt:500];               % sampling time instant
options = odeset('RelTol',1e-12,'AbsTol',1e-12*ones(1,n));
t=data(:,1);
qtru=data(:,4:7);
% STAGE II: observation equation
eps = 0.007;
rng(1,'twister')  % for reproducibility
nois = eps*rms(qtru).*randn(size(qtru));
qobs = qtru + nois;%加噪声

%% Identification
pord = 3;
lambda = 0.005;

% noisy case
Theta=poolData(qobs,n,pord);
xi1 = stlsIntg(qobs,Theta,lambda,dt);


%% Solution（识别光滑后的数据）
eta = xi1(1,:); % 识别出的初始值
Xi = xi1(2:end,:);
poolDataLIST({'qv ','qv* ','qw ','qw* '},Xi,n,3);%变成数组形式
%%  integrate true and identified systems(真实曲线 VS 预测曲线）
% tspan = [0:dt:500]; 
t_true =t;
q_true=qtru;
[t_pred,q_pred]=ode113(@(t,q)sparseGalerkin(t,q,Xi,3),tspan,q0,options); %可改q0为eta

figure('name','预测曲线')
plot(t_true,q_true(:,1),'k','linewidth',1);%真实曲线：黑色
hold on
plot(t_pred,q_pred(:,1),'r','linewidth',1);%预测曲线：红色
legend('真实曲线','预测曲线','location','best')
title('真实曲线 VS 预测曲线')
grid on
box on

%% R2
tempdata=(q_true(:,1)-q_pred(:,1)).^2;
tempdata2=(q_true(:,1)-mean(q_true(:,1))).^2;%竖向位移拟合优度
R2_V=1-(sum(tempdata)/sum(tempdata2))

tempdata=(q_true(:,3)-q_pred(:,3)).^2;
tempdata2=(q_true(:,3)-mean(q_true(:,3))).^2;%水平位移拟合优度
R2_W=1-(sum(tempdata)/sum(tempdata2))
%% 其他评价指标
MSE_V=sum((q_pred(:,1)-q_true(:,1)).^2)/length(q_pred(:,1))
MSE_W=sum((q_pred(:,3)-q_true(:,3)).^2)/length(q_pred(:,3))

RMSE_V=sqrt(sum((q_pred(:,1)-q_true(:,1)).^2)/length(q_pred(:,1)))
RMSE_W=sqrt(sum((q_pred(:,3)-q_true(:,3)).^2)/length(q_pred(:,3)))

MAE_V=sum(abs((q_pred(:,1)-q_true(:,1))))/length(q_pred(:,1))
MAE_W=sum(abs((q_pred(:,3)-q_true(:,3))))/length(q_pred(:,3))
