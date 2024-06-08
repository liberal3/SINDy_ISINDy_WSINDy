%% Generate Data
clc;close all;clear all ;

n=4;
dt=0.01;
tspan=[0:dt:350]; 
options=odeset('RelTol',1e-12,'AbsTol',1e-12*ones(1,n));
q0= [0.01 0.01 0 0];
[t,q] = ode113(@vdp2, tspan, q0,options);


%%  Compute Derivative
for i=1:length(q)
    dq(i,:) = vdp2(0,q(i,:));
end
% q=q(15000:end-15000,:);
% dq=dq(15000:end-15000,:);
% t=t(15000:end-15000,:);
%% 
rand('state',2); randn('state',2); % make data reproducible
eps=0.01;
y1 = q(:,1)+eps*randn(size(q(:,1)))* rms(q(:,1));%velocity
y2 = q(:,3)+eps*randn(size(q(:,3)))* rms(q(:,3));%velocity
y3 = dq(:,2)+eps*randn(size(dq(:,2)))* rms(dq(:,2));% acceleration
y4 = dq(:,4)+eps*randn(size(dq(:,4)))* rms(dq(:,4));% acceleration
% set maximum regularization parameter lambda_max
lambda_max1 = l1tf_lambdamax(y1);
lambda_max2 = l1tf_lambdamax(y2);
lambda_max3 = l1tf_lambdamax(y3);
lambda_max4 = l1tf_lambdamax(y4);
%----------------------------------------------------------------------
% 	l1 trend filtering
%----------------------------------------------------------------------
[z1,status] = l1tf(y1, 0.000001*lambda_max1);
[z2,status] = l1tf(y2, 0.000001*lambda_max2)
[z3,status] = l1tf(y3, 0.00001*lambda_max3);
[z4,status] = l1tf(y4, 0.000001*lambda_max4);
%uncomment line below to solve l1 trend filtering problem using CVX
% [z1,status] = l1tf_cvx(y1, 0.00001*lambda_max1);
% [z2,status] = l1tf_cvx(y2, 0.0001*lambda_max2);
% [z3,status] = l1tf_cvx(y3, 0.0001*lambda_max3);
% [z4,status] = l1tf_cvx(y4, 0.0001*lambda_max4);
%----------------------------------------------------------------------
% 	plot results
%----------------------------------------------------------------------
q1=q(:,1);
q2=q(:,3);
q3=dq(:,2);
q4=dq(:,4);
xyzs = [q1 q2 q3 q4 y1 y2 y3 y4 z1 z2 z3 z4];
maxx = max(max(xyzs));
minx = min(min(xyzs));
figure(1);
subplot(2,4,1); plot(t,q1,'b',t,y1, 'r'); ylim([minx maxx]); title('original qv');
subplot(2,4,2); plot(t,q2,'b',t,y2,'r'); ylim([minx maxx]); title('original qw');
subplot(2,4,3); plot(t,q3,'b',t,y3, 'r'); ylim([minx maxx]); title('original ddqv');
subplot(2,4,4); plot(t,q4,'b',t,y4, 'r'); ylim([minx maxx]); title('original ddqw');
subplot(2,4,5); plot(t,q1,'b',t,z1,'r'); ylim([minx maxx]); title('de-noise qv');
subplot(2,4,6); plot(t,q2,'b',t,z2,'r'); ylim([minx maxx]); title('de-noise qw');
subplot(2,4,7); plot(t,q3,'b',t,z3,'r'); ylim([minx maxx]); title('de-noise ddqv');
subplot(2,4,8); plot(t,q4,'b',t,z4, 'r'); ylim([minx maxx]); title('de-noise ddqw');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
z(:,[1 3])= [gradient(z1)./gradient(t),gradient(z2)./gradient(t)];

figure;
plot(t,q(:,2),t,z(:,1))
tempdata=(q(:,2)-z(:,1)).^2;
tempdata2=(q(:,2)-mean(q(:,2))).^2;
R2dqv=1-(sum(tempdata)/sum(tempdata2))

tempdata=(q(:,4)-z(:,3)).^2;
tempdata2=(q(:,4)-mean(q(:,4))).^2;
R2dqw=1-(sum(tempdata)/sum(tempdata2))

q=[z1 z(:,1) z2 z(:,3)];
dq=[z(:,1) z3 z(:,3) z4];

%% R2
tempdata=(q1-z1).^2;
tempdata2=(q1-mean(q1)).^2;
R2=1-(sum(tempdata)/sum(tempdata2))

tempdata=(q2-z2).^2;
tempdata2=(q2-mean(q2)).^2;
R2=1-(sum(tempdata)/sum(tempdata2))

tempdata=(q3-z3).^2;
tempdata2=(q3-mean(q3)).^2;
R2=1-(sum(tempdata)/sum(tempdata2))

tempdata=(q4-z4).^2;
tempdata2=(q4-mean(q4)).^2;
R2=1-(sum(tempdata)/sum(tempdata2))

% q=q(50000:end-50000,:);
% dq=dq(50000:end-50000,:);

%% Build library and compute sparse regression
Theta=poolData(q,n,3);% up to third order polynomials
lambda= 0.002;% lambda is our sparsification knob.
Xi=sparsifyDynamics(Theta,dq,lambda,n);
poolDataLIST({'qv','dqv','qw','dqw'},Xi,n,3);
%%  integrate true and identified systems
[t_pred,q_pred]=ode113(@(t,q)sparseGalerkin(t,q,Xi,3),tspan,q0,options);
[tA,qA] = ode113(@vdp2, tspan, q0,options);
figure()
plot(tA,qA(:,1),'markerfacecolor','b','linewidth',1);
hold on;
plot(t_pred,q_pred(:,1),'markerfacecolor','r','linewidth',1);
%% R2
tempdata=(qA(:,1)-q_pred(:,1)).^2;
tempdata2=(qA(:,1)-mean(qA(:,1))).^2;
R2=1-(sum(tempdata)/sum(tempdata2))

tempdata=(qA(:,3)-q_pred(:,3)).^2;
tempdata2=(qA(:,3)-mean(qA(:,3))).^2;
R2=1-(sum(tempdata)/sum(tempdata2))
