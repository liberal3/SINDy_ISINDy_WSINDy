function dudt = vdp3(t,q)
% global B C1 C2 C3 C4 E1 E2 E3 E4 F1 F2 F3 F4 Q1 Q2 Q3 A 
global A B C D E F
dudt=[q(2);0.1327*q(2)-0.0071*q(2)^2-0.031*q(2)^3-6.8765*q(1)-0.9357*q(1)^2-0.0244*q(1)^3-0.0069+0.0092*q(1)*q(2)^2];

% dudt=[q(2);0.00024*q(1)-q(1)*q(2)];
end