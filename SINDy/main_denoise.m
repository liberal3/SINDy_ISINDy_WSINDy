%% Generate Data
% %% 
clc;close all;clear all;
% global L M Msk EA H Cv  fv s y U d R A1 A2 A3 A4 A5 A6 A7 A9 A10 A11 B1 B2 B3 B4 B5 B6 B8 B9 B10 EI fw Cw
% L=300;
% M=9.5156;
% y=0.000401952*(s*L-s^2);
% EA=1.48*1e7;
% EI=681.4033;
% H=29000;
% Cv=0.0232;
% Cw=0.0049;
% U=9;
% d=0.1144;
% R=1.2929;
% fv=0.8165*(1-cos(2*pi*s/L));
% fw=sin(pi*s/L);
% Msk=4.8;
% syms s
% A1=double(-(int(M*fv^2,s,[0 L])+Msk*subs(fv^2,s,20)+Msk*subs(fv^2,s,65)+Msk*subs(fv^2,s,110)+Msk*subs(fv^2,s,150)+Msk*subs(fv^2,s,190)+Msk*subs(fv^2,s,235)+Msk*subs(fv^2,s,280)));
% A2=double(-int(Cv*fv^2,s,[0 L]));
% A3=double(4*(EA*int(fv*diff(diff(y,s)^2*diff(fv,s),s),s,[0 L])+H*int(fv*diff(diff(fv,s),s),s,[0 L])-EI*int(fv*diff(diff(diff(fv,s),s),s),s,[0 L])));
% A4=double(4*int(fv*diff(EA*(0.5*diff(y,s)*(diff(fv,s))^2+diff(y,s)*(diff(fv,s))^2),s),s,[0 L]));
% A5=double(4*0.5*EA*int(fv*diff(diff(y,s)*(diff(fw,s))^2,s),s,[0 L]));
% A6=double(4*0.5*EA*int(fv*diff(((diff(fv,s))^3),s),s,[0 L]));
% A7=double(4*int(fv*diff(0.5*EA*diff(fv,s)*(diff(fw,s))^2,s),s,[0 L]));
% aa=2*A1*sqrt(5.4552)*0.000516/300
% A9=double(0.5*R*U^2*d*int((0.6670/U)*fv^2,s,[0 L]));
% A10=double(-0.5*R*U^2*d*int((16.2188/(U^2))*fv^3,s,[0 L]));
% A11=double(-0.5*R*U^2*d*int((33.4324/(U^3))*fv^4,s,[0 L]));
% (A2+A9)/(-1*A1)
% A10/(-1*A1)
% A11/(-1*A1)
% A3/(-1*A1)
% A4/(-1*A1)
% A5/(-1*A1)
% A6/(-1*A1)
% A7/(-1*A1)
% 
% % 
% B1=double(-(int(M*fw^2,s,[0 L])+Msk*(sin(pi*20/300)^2+sin(pi*65/300)^2+sin(pi*110/300)^2+sin(pi*150/300)^2+sin(pi*190/300)^2+sin(pi*235/300)^2+sin(pi*280/300)^2)));
% B2=double(-int(Cw*fw^2,s,[0 L]));
% B3=double(4*(H*int(fw*diff(diff(fw,s),s),s,[0 L])-EI*int(fw*diff(diff(diff(diff(fw,s),s),s),s),[0 L])));
% B4=double(4*int(fw*diff(EA*(diff(y,s)*diff(fv,s)*diff(fw,s)),s),s,[0 L]));
% B5=double(4*0.5*EA*int(fw*diff(((diff(fw,s))^3),s),s,[0 L]));
% B6=double(4*int(fw*diff(0.5*EA*diff(fw,s)*(diff(fv,s))^2,s),s,[0 L]));
% % 
% B8=double(0.5*R*U^2*d*int((-3.442/U)*fv*fw,s,[0 L]));
% B9=double(0.5*R*U^2*d*int((3.33/(U^2))*fw*fv^2,s,[0 L]));
% B10=double(0.5*R*U^2*d*int((-7.1262/(U^3))*fw*fv^3,s,[0 L]));
% bb=2*B1*sqrt(1.3211)*0.000441/300
% B2/(-1*B1)
% B8/(-1*B1)
% B9/(-1*B1)
% B10/(-1*B1)
% B3/(-1*B1)
% B4/(-1*B1)
% B5/(-1*B1)
% B6/(-1*B1)
%% 


n=4;
dt=0.01;
tspan=[0:dt:350]; 
options=odeset('RelTol',1e-12,'AbsTol',1e-12*ones(1,n));
q0= [0.01 0.01 0 0];
[t,q] = ode113(@vdp2, tspan, q0,options);
% q=q(30000:31000,:);
% t=t(30000:31000,:);
% tspan=tspan(:,30000:31000);
% qclean=q;
% figure;
% plot(t,q(:,1))
% figure;
% plot(t,q(:,3))
%%  Compute Derivative
for i=1:length(q)
    dq(i,:) = vdp2(0,q(i,:));
end
eps=0.1;
rand('state',5); randn('state',5); % make data reproducible
% dq1(:,[1 3])= dq(:,[1 3])+ eps*randn(size(dq(:,[1 3])));   % add noise
dq(:,1)= dq(:,1)+ eps*randn(size(dq(:,1)))* rms(dq(:,1));   % add noise
dq(:,3)= dq(:,3)+ eps*randn(size(dq(:,3)))* rms(dq(:,3));   % add noise
% dq(:,1)= dq(:,1)+ eps*randn(size(dq(:,1)));   % add noise
% dq(:,3)= dq(:,3)+ eps*randn(size(dq(:,3)));   % add noise


% dq(:,1)= gradient(q(:,1))./gradient(tspan');
% figure(1);
% plot(t,qclean(:,1),'markerfacecolor','b','linewidth',1);
% hold on;
% plot(t,q(:,1),'markerfacecolor','r','linewidth',1);
% figure(2)
% plot(t,qclean(:,2),'markerfacecolor','b','linewidth',1);
% hold on;
% plot(t,dq(:,1),'markerfacecolor','r','linewidth',1);
q(:,[2 4])=dq(:,[1 3]);
G=[q dq];
G=datasample(G,100,1);
q=G(:,1:4);
dq=G(:,5:8);
%% 
%%  Total Variation Regularized Differentiation
% dqt(:,1) = TVRegDiff( q(:,1), 10, .00002, [], 'small', 1e12, dt, 1, 1 );
% hold on
% plot(dqclean(:,1),'r')
% xlim([5000 7500])
% figure
% dqt(:,2) = TVRegDiff( q(:,2), 10, .00002, [], 'small', 1e12, dt, 1, 1 );
% hold on
% plot(dqclean(:,2),'r')
% xlim([5000 7500])
% figure
% dqt(:,3) = TVRegDiff( q(:,3), 10, .00002, [], 'small', 1e12, dt, 1, 1 );
% hold on
% plot(dqclean(:,3),'r')
% xlim([5000 7500])
% figure
% dqt(:,4) = TVRegDiff( q(:,4), 10, .00002, [], 'small', 1e12, dt, 1, 1 );
% hold on
% plot(dqclean(:,4),'r')
% xlim([5000 7500])
% %
% qt(:,1) = cumsum(dqt(:,1))*dt;
% qt(:,2) = cumsum(dqt(:,2))*dt;
% qt(:,3) = cumsum(dqt(:,3))*dt;
% qt(:,4) = cumsum(dqt(:,4))*dt;
% %
% qt(:,1) = qt(:,1) - (mean(qt(1000:end-1000,1)) - mean(q(1000:end-1000,1)));
% qt(:,2) = qt(:,2) - (mean(qt(1000:end-1000,2)) - mean(q(1000:end-1000,2)));
% qt(:,3) = qt(:,3) - (mean(qt(1000:end-1000,3)) - mean(q(1000:end-1000,3)));
% qt(:,4) = qt(:,4) - (mean(qt(1000:end-1000,4)) - mean(q(1000:end-1000,4)));
% qt = qt(1000:end-1000,:);
% dqt = dqt(1000:end-1000,:);  % trim off ends (overly conservative)
%% Build library and compute sparse regression
Theta=poolData(q,n,3);% up to third order polynomials
lambda= 0.0004;% lambda is our sparsification knob.
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
qA=qA(30000:31000,:);
tA=tA(30000:31000,:);
q_pred=q_pred(30000:31000,:);

tempdata=(qA(:,1)-q_pred(:,1)).^2;
tempdata2=(qA(:,1)-mean(qA(:,1))).^2;
R2=1-(sum(tempdata)/sum(tempdata2))

tempdata=(qA(:,3)-q_pred(:,3)).^2;
tempdata2=(qA(:,3)-mean(qA(:,3))).^2;
R2=1-(sum(tempdata)/sum(tempdata2))
% figure()
% plot(tA(30000:31000,:),qA(30000:31000,1),'markerfacecolor','b','linewidth',1);
% hold on;
% plot(t_pred(30000:31000,:),q_pred(30000:31000,1),'markerfacecolor','r','linewidth',1);
% %% R2
% tempdata=(qA(30000:31000,1)-q_pred(30000:31000,1)).^2;
% tempdata2=(qA(30000:31000,1)-mean(qA(30000:31000,1))).^2;
% R2=1-(sum(tempdata)/sum(tempdata2))
% 
% tempdata=(qA(30000:31000,3)-q_pred(30000:31000,3)).^2;
% tempdata2=(qA(30000:31000,3)-mean(qA(30000:31000,3))).^2;
% R2=1-(sum(tempdata)/sum(tempdata2))
%% 

% % plot(t,dq(:,1),'r','linewidth',1.5);
% % 
% % set(gca,'FontSize',40,'YLim',[-5 5],'XLim',[0 110])%,'xtick',-0.04:0.02:0.04
% % xlabel('t/s','Interpreter','latex','FontSize',40)
% % ylabel('$\dot{q}/m$','Interpreter','latex','FontSize',40)
% figure()
% % plot(t,q(:,2),'-vr','MarkerIndices',1:200:length(t),'markersize',5,'markerfacecolor','r','linewidth',1.5);
% plot(t,q(:,1),'b');
% % hold on
% % plot(q_pred50(:,1),q_pred50(:,2),'-pg','MarkerIndices',1:200:length(t),'markersize',5,'markerfacecolor','g','linewidth',1.5);
% 
% set(gca,'FontSize',60,'YLim',[-1 1],'XLim',[0 110])%,'xtick',-0.04:0.02:0.04
% xlabel('t/s','Interpreter','latex','FontSize',60)
% % ylabel('$\dot{q}/m$','Interpreter','latex','FontSize',40)
% ylabel('q/m','Interpreter','latex','FontSize',60)
% % h1=legend('\psi=0.3','real curve','\psi=0.5','FontSize',30);
% % set(h1,'orientation','horizon','box','off')
% 
% syms y x
% x=1:10;
% y1=tan(0.5.*x);
% y2=0.5.*x-x.^3/(2.*0.572691378);
%  plot(x,y1)
% hold on;
%  plot(x,y2)
% subplot(2,2,5);

% ezplot('tan(0.5*(y*pi))-(0.5*(y*pi)-(y*pi)^3/(2*(x*pi)^2))')
% hold on;
% ezplot('y-(x-sqrt(0.572691378))*1e100')
% xlim([0 10])
% ylim([1.1 2.9999])
% x(1)=1
% for n=1:1000
%     x(n+1)=(2*tan(0.5*(x(n)*pi))+(x(n)*pi)^3/(0.572691378*pi)^2)/pi;
% end
% n=1:1000;
% plot(n,x(n))
