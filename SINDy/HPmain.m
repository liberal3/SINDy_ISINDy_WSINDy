%% Generate Data
clc;close all;clear all ;

N=4;
n=350001;
dt=0.001;
tspan=[0:dt:350]; 
options=odeset('RelTol',1e-12,'AbsTol',1e-12*ones(1,N));
q0= [0.01 0.01 0 0];
[t,q] = ode113(@vdp2, tspan, q0,options);
%%  Compute Derivative
for i=1:length(q)
    dq(i,:) = vdp2(0,q(i,:));
end
%% 
rand('state',10); randn('state',8); % make data reproducible
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
[z2,status] = l1tf(y2, 0.000001*lambda_max2);
[z3,status] = l1tf(y3, 0.00001*lambda_max3);
[z4,status] = l1tf(y4, 0.000001*lambda_max4);
err11= norm(z1-y1,2);
err12= norm(z2-y2,2);
err13= norm(z3-y3,2);
err14= norm(z4-y4,2);
%% 
%----------------------------------------------------------------------
%   HP filter(1)
%----------------------------------------------------------------------
% double difference matrix
I   = speye(n,n);
I2  = speye(n-2,n-2);
O2  = zeros(n-2,1);
D   = [I2 O2 O2]+[O2 -2*I2 O2]+[O2 O2 I2];
%%%%%%%%%%%%%%%%%%%%%%
L = 1e-1; U = 1e10;
for i = 1:100
    lambda = sqrt(L*U);
    if (lambda <= L || lambda >= U) break; end
    
    z1H = (speye(n)+lambda*D'*D)\y1;
    
    err21 = norm(z1H-y1,2);
    if (err21 > err11)
        U = lambda;
    else
        L = lambda;
    end
end
%% 
%----------------------------------------------------------------------
%   HP filter(2)
%----------------------------------------------------------------------
% double difference matrix
I   = speye(n,n);
I2  = speye(n-2,n-2);
O2  = zeros(n-2,1);
D   = [I2 O2 O2]+[O2 -2*I2 O2]+[O2 O2 I2];
%%%%%%%%%%%%%%%%%%%%%%
L = 1e-1; U = 1e10;
for i = 1:100
    lambda = sqrt(L*U);
    if (lambda <= L || lambda >= U) break; end
    
    z2H = (speye(n)+lambda*D'*D)\y2;
    
    err22 = norm(z2H-y2,2);
    if (err22 > err12)
        U = lambda;
    else
        L = lambda;
    end
end
%% 
%----------------------------------------------------------------------
%   HP filter(3)
%----------------------------------------------------------------------
% double difference matrix
I   = speye(n,n);
I2  = speye(n-2,n-2);
O2  = zeros(n-2,1);
D   = [I2 O2 O2]+[O2 -2*I2 O2]+[O2 O2 I2];
%%%%%%%%%%%%%%%%%%%%%%
L = 1e-1; U = 1e10;
for i = 1:100
    lambda = sqrt(L*U);
    if (lambda <= L || lambda >= U) break; end
    
    z3H = (speye(n)+lambda*D'*D)\y3;
    
    err23 = norm(z3H-y3,2);
    if (err23 > err13)
        U = lambda;
    else
        L = lambda;
    end
end
%% 
%----------------------------------------------------------------------
%   HP filter(4)
%----------------------------------------------------------------------
% double difference matrix
I   = speye(n,n);
I2  = speye(n-2,n-2);
O2  = zeros(n-2,1);
D   = [I2 O2 O2]+[O2 -2*I2 O2]+[O2 O2 I2];
%%%%%%%%%%%%%%%%%%%%%%
L = 1e-1; U = 1e10;
for i = 1:100
    lambda = sqrt(L*U);
    if (lambda <= L || lambda >= U) break; end
    
    z4H = (speye(n)+lambda*D'*D)\y4;
    
    err24 = norm(z4H-y4,2);
    if (err24 > err14)
        U = lambda;
    else
        L = lambda;
    end
end
%----------------------------------------------------------------------
% 	plot results
%----------------------------------------------------------------------
q1=q(:,1);
q2=q(:,3);
q3=dq(:,2);
q4=dq(:,4);
xyzs = [q1 q2 q3 q4 y1 y2 y3 y4 z1H z2H z3H z4H];
maxx = max(max(xyzs));
minx = min(min(xyzs));
figure(1);
subplot(2,4,1); plot(t,q1,'b',t,y1, 'r'); ylim([minx maxx]); title('original qv');
subplot(2,4,2); plot(t,q2,'b',t,y2, 'r'); ylim([minx maxx]); title('original qw');
subplot(2,4,3); plot(t,q3,'b',t,y3, 'r'); ylim([minx maxx]); title('original ddqv');
subplot(2,4,4); plot(t,q4,'b',t,y4, 'r'); ylim([minx maxx]); title('original ddqw');
subplot(2,4,5); plot(t,q1,'b',t,z1H,'r'); ylim([minx maxx]); title('de-noise qv');
subplot(2,4,6); plot(t,q2,'b',t,z2H, 'r'); ylim([minx maxx]); title('de-noise qw');
subplot(2,4,7); plot(t,q3,'b',t,z3H, 'r'); ylim([minx maxx]); title('de-noise ddqv');
subplot(2,4,8); plot(t,q4,'b',t,z4H, 'r'); ylim([minx maxx]); title('de-noise ddqw');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% R2
tempdata=(q1-z1H).^2;
tempdata2=(q1-mean(q1)).^2;
R2=1-(sum(tempdata)/sum(tempdata2))

tempdata=(q2-z2H).^2;
tempdata2=(q2-mean(q2)).^2;
R2=1-(sum(tempdata)/sum(tempdata2))

tempdata=(q3-z3H).^2;
tempdata2=(q3-mean(q3)).^2;
R2=1-(sum(tempdata)/sum(tempdata2))

tempdata=(q4-z4H).^2;
tempdata2=(q4-mean(q4)).^2;
R2=1-(sum(tempdata)/sum(tempdata2))

dq(:,1)= gradient(z1H./gradient(tspan'));

figure;
plot(t,dq(:,1),t,q(:,2))
tempdata=(q(:,2)-dq(:,1)).^2;
tempdata2=(q(:,2)-mean(q(:,2))).^2;
R2=1-(sum(tempdata)/sum(tempdata2))

dq(:,3)= gradient(z2H./gradient(tspan'));
figure;
plot(t,dq(:,3),t,q(:,4))
tempdata=(q(:,4)-dq(:,3)).^2;
tempdata2=(q(:,4)-mean(q(:,4))).^2;
R2=1-(sum(tempdata)/sum(tempdata2))
%% 
q=[z1H dq(:,1) z2H dq(:,3)];
dq=[dq(:,1) z3H dq(:,3) z4H];
% q=q(20000:end-20000,:);
% dq=dq(20000:end-20000,:);
%% Build library and compute sparse regression
Theta=poolData(q,N,3);% up to third order polynomials
lambda= 0.002;% lambda is our sparsification knob.
Xi=sparsifyDynamics(Theta,dq,lambda,N);
poolDataLIST({'qv','dqv','qw','dqw'},Xi,N,3);
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
