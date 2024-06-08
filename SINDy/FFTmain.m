%% Generate Data
clc;close all;clear all ;

N=4;
dt=0.01;
tspan=[0:dt:350];
options=odeset('RelTol',1e-12,'AbsTol',1e-12*ones(1,N));
q0= [0.01 0.01 0 0];
[t,q] = ode113(@vdp1, tspan, q0,options);
%%  Compute Derivative
for i=1:length(q)
    dq(i,:) = vdp1(0,q(i,:));
end
%% 
rand('state',3); randn('state',3); % make data reproducible
eps=1;
y1 = q(:,1)+eps*randn(size(q(:,1)))* rms(q(:,1));%velocity
y2 = q(:,3)+eps*randn(size(q(:,3)))* rms(q(:,3));%velocity
y3 = dq(:,2)+eps*randn(size(dq(:,2)))* rms(dq(:,2));% acceleration
y4 = dq(:,4)+eps*randn(size(dq(:,4)))* rms(dq(:,4));% acceleration
%% Compute the Fast Fourier Transform FFT(y1)
n = length(tspan);
y1hat = fft(y1,n); % Compute the fast Fourier transform
PSD = y1hat.*conj(y1hat)/n; % Power spectrum (power per freq)
freq = 1/(dt*n)*(0:n); % Create x-axis of frequencies in Hz
L = 1 :floor(n/2); % Only plot the first half of freqs
% Use the PSD to filter out noise
indices = PSD>2; % Find all freqs with large power
PSDclean = PSD.*indices; % Zero out all others
y1hat = indices.*y1hat; % Zero out small Fourier coeffs. in Y
y1filt = ifft(y1hat); % Inverse FFT for filtered time signal
% PLOTS
figure();
subplot(3,1,1)
plot(t,y1,'r','LineWidth',1.2), hold on
plot(t,q(:,1),'k','LineWidth',1.5)
legend('Noisy','Clean') 
subplot(3,1,2)
plot(t,q(:,1),'k','LineWidth',1.5), hold on
plot(t,y1filt,'b','LineWidth',1.2)
legend('Clean','Filtered')
subplot(3,1,3)
plot(freq(L),PSD(L),'r','LineWidth',1.5), hold on
plot(freq(L),PSDclean(L),'-b','LineWidth',1.2)
legend('Noisy','Filtered')

%% R2(y1)
tempdata=(q(5000:end-5000,1)-y1filt(5000:end-5000,:)).^2;
tempdata2=(q(5000:end-5000,1)-mean(q(5000:end-5000,1))).^2;
R21=1-(sum(tempdata)/sum(tempdata2))

%% Compute the Fast Fourier Transform FFT(y2)
n = length(tspan);
y2hat = fft(y2,n); % Compute the fast Fourier transform
PSD = y2hat.*conj(y2hat)/n; % Power spectrum (power per freq)
freq = 1/(dt*n)*(0:n); % Create x-axis of frequencies in Hz
L = 1 :floor(n/2); % Only plot the first half of freqs
% Use the PSD to filter out noise
indices = PSD>2; % Find all freqs with large power
PSDclean = PSD.*indices; % Zero out all others
y2hat = indices.*y2hat; % Zero out small Fourier coeffs. in Y
y2filt = ifft(y2hat); % Inverse FFT for filtered time signal
% PLOTS
figure();
subplot(3,1,1)
plot(t,y2,'r','LineWidth',1.2), hold on
plot(t,q(:,3),'k','LineWidth',1.5)
legend('Noisy','Clean') 
subplot(3,1,2)
plot(t,q(:,3),'k','LineWidth',1.5), hold on
plot(t,y2filt,'b','LineWidth',1.2)
legend('Clean','Filtered')
subplot(3,1,3)
plot(freq(L),PSD(L),'r','LineWidth',1.5), hold on
plot(freq(L),PSDclean(L),'-b','LineWidth',1.2)
legend('Noisy','Filtered')
%% R2(y2)
tempdata=(q(5000:end-5000,3)-y2filt(5000:end-5000,:)).^2;
tempdata2=(q(5000:end-5000,3)-mean(q(5000:end-5000,3))).^2;
R22=1-(sum(tempdata)/sum(tempdata2))
%% Compute the Fast Fourier Transform FFT(y3)
n = length(tspan);
y3hat = fft(y3,n); % Compute the fast Fourier transform
PSD = y3hat.*conj(y3hat)/n; % Power spectrum (power per freq)
freq = 1/(dt*n)*(0:n); % Create x-axis of frequencies in Hz
L = 1 :floor(n/2); % Only plot the first half of freqs
% Use the PSD to filter out noise
indices = PSD>10; % Find all freqs with large power
PSDclean = PSD.*indices; % Zero out all others
y3hat = indices.*y3hat; % Zero out small Fourier coeffs. in Y
y3filt = ifft(y3hat); % Inverse FFT for filtered time signal
% PLOTS
figure();
subplot(3,1,1)
plot(t,y3,'r','LineWidth',1.2), hold on
plot(t,dq(:,2),'k','LineWidth',1.5)
legend('Noisy','Clean') 
subplot(3,1,2)
plot(t,dq(:,2),'k','LineWidth',1.5), hold on
plot(t,y3filt,'b','LineWidth',1.2)
legend('Clean','Filtered')
subplot(3,1,3)
plot(freq(L),PSD(L),'r','LineWidth',1.5), hold on
plot(freq(L),PSDclean(L),'-b','LineWidth',1.2)
legend('Noisy','Filtered')
%% R2(y3)
tempdata=(dq(30000:31000,2)-y3filt(30000:31000,:)).^2;
tempdata2=(dq(30000:31000,2)-mean(dq(30000:31000,2))).^2;
R23=1-(sum(tempdata)/sum(tempdata2))
%% Compute the Fast Fourier Transform FFT(y4)
n = length(tspan);
y4hat = fft(y4,n); % Compute the fast Fourier transform
PSD = y4hat.*conj(y4hat)/n; % Power spectrum (power per freq)
freq = 1/(dt*n)*(0:n); % Create x-axis of frequencies in Hz
L = 1 :floor(n/2); % Only plot the first half of freqs
% Use the PSD to filter out noise
indices = PSD>30; % Find all freqs with large power
PSDclean = PSD.*indices; % Zero out all others
y4hat = indices.*y4hat; % Zero out small Fourier coeffs. in Y
y4filt = ifft(y4hat); % Inverse FFT for filtered time signal
% PLOTS
figure();
subplot(3,1,1)
plot(t,y4,'r','LineWidth',1.2), hold on
plot(t,dq(:,4),'k','LineWidth',1.5)
legend('Noisy','Clean') 
subplot(3,1,2)
plot(t,dq(:,4),'k','LineWidth',1.5), hold on
plot(t,y4filt,'b','LineWidth',1.2)
legend('Clean','Filtered')
subplot(3,1,3)
plot(freq(L),PSD(L),'r','LineWidth',1.5), hold on
plot(freq(L),PSDclean(L),'-b','LineWidth',1.2)
legend('Noisy','Filtered')
%% R2(y4)
tempdata=(dq(5000:end-5000,4)-y4filt(5000:end-5000,:)).^2;
tempdata2=(dq(5000:end-5000,4)-mean(dq(5000:end-5000,4))).^2;
R24=1-(sum(tempdata)/sum(tempdata2))
%% 
tF=t(5000:end-5000,:);
qF(:,1)=y1filt(5000:end-5000,:);
qF(:,3)=y2filt(5000:end-5000,:);
dqF(:,2)=y3filt(5000:end-5000,:);
dqF(:,4)=y4filt(5000:end-5000,:);
dqF(:,[1 3])= [gradient(qF(:,1))./gradient(tF),gradient(qF(:,3))./gradient(tF)];
% 
% dqF(:,[2 4])=[gradient(dqF(:,1))./gradient(tF),gradient(dqF(:,3))./gradient(tF)];


qF(:,[2 4])=dqF(:,[1 3]);

% qF(:,1)=q(5000:end-5000,1);
% qF(:,3)=q(5000:end-5000,3);
% dqF(:,2)=dq(5000:end-5000,2);
% dqF(:,4)=dq(5000:end-5000,4);
% dqF(:,[1 3])=q(5000:end-5000,[2 4]);
% qF(:,[2 4])=dqF(:,[1 3]);

%% 
figure;
plot(tF,qF(:,2),tF,q(5000:end-5000,2));
figure;
plot(tF,dqF(:,2),tF,dq(5000:end-5000,2));
%% Build library and compute sparse regression
Theta=poolData(qF,N,3);% up to third order polynomials
lambda= 0.002;% lambda is our sparsification knob.
Xi=sparsifyDynamics(Theta,dqF,lambda,N);
poolDataLIST({'qv','dqv','qw','dqw'},Xi,N,3);
%%  integrate true and identified systems
[t_pred,q_pred]=ode113(@(t,q)sparseGalerkin(t,q,Xi,3),tspan,q0,options);
[tA,qA] = ode113(@vdp1, tspan, q0,options);
figure()
plot(tA,qA(:,1),'markerfacecolor','b','linewidth',1);
hold on;
plot(t_pred,q_pred(:,1),'markerfacecolor','r','linewidth',1);
%% R2
tempdata=(qA(:,1)-q_pred(:,1)).^2;
tempdata2=(qA(:,1)-mean(qA(:,1))).^2;
R2=1-(sum(tempdata)/sum(tempdata2))
