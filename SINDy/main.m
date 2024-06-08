% Generate Data
%% 
clc;close all;clear ;
global L M Msk EA H Cv  fv s y U d R  fw f0 GJ J Isk sy sz a1 a2 a3 b1 b2 b3 c1 c2 c3 ri Cw C0 A1 A2 A3 A4 A5 A6 A7 A8 A9 A10 A11 A12 A13 A14 A15 A16 A17 A19 A20 A21 A22 A23 A24 A25 A26 A27 A28 A29 A30 A31 A32 A33 A34 A35 A36 A37 B1 B2 B3 B4 B5 B6 B7 B8 B9 B10 B11 B12 B13 B14 B15 B16 B17 B19 B20 B21 B22 B23 B24 B25 B26 B27 B28 B29 B30 B31 B32 B33 B34 B35 B36 B37 C1 C2 C3 C4 C5 C6 C7 C8 C9 C10 C11 C12 C13 C14 C15 C16 C17 C18 C19 C20 C21 C22 C23 C25 C26 C27 C28 C29 C30 C31 C32 C33 C34 C35 C36 C37 C38 C39 C40 C41 C42 C43    

% % L=300;
% % M=9.5156;
% % H=25000;
% % y=(M/4*9.8/2/H)*(s^2-s*L);
% % EA=45*H^3/(M/4*9.8*L)^2
% % fimplicit(@(x,y) tan(0.5*y)-0.5*y+y^3/(2*x^2),[0 10 0 8]);
% % hold on
% % fimplicit(@(x) x-sqrt(45))
% % hold off
% % fv=0.8317*(1-cos(6.563*s/L)-tan(6.563/2)*sin(6.563*s/L));
% % Cv=2*9.5156*6.563/(300*sqrt(2.3789/H))*0.000515;
% % Cw=2*9.5156*sqrt(H/2.3789)/600*2*pi*0.000515;
% % C0=2*0.5284*sqrt(H/2.3789)/600*2*pi*0.308;
% % sqrt(2*6.563*(cos(0.5*6.563))^2/((2+cos(6.563))*6.563-3*sin(6.563)))
% %% 
% L=300;
% M=9.5156;
% H=29000;
% y=(M/4*9.8/2/H)*(s^2-s*L);
% EA=30.0846*H^3/(M/4*9.8*L)^2;%E=1.5e7
% Cv=2*9.5156*5.743/(300*sqrt(2.3789/H))*0.000515;
% Cw=2*9.5156*sqrt(H/2.3789)/600*2*pi*0.000515;
% C0=2*0.5284*sqrt(H/2.3789)/600*2*pi*0.308;
% fimplicit(@(x,y) tan(0.5*y)-0.5*y+y^3/(2*x^2),[0 10 0 8]);
% hold on
% fimplicit(@(x) x-sqrt(30.0846));
% hold off
% fv=0.7708*(1-cos(5.743*s/L)-tan(5.743/2)*sin(5.743*s/L));
% %% 
% U=9;
% d=0.1144;
% R=1.2929;
% fw=sin(pi*s/L);
% f0=sin(pi*s/L);
% 
% Msk=4.8;
% ri=0.2355;
% GJ=101;
% J=0.5284;
% Isk=0.002;
% sy=-0.0313;
% sz=0.0313;
% a1=-0.667;
% a2=-16.2188;
% a3=33.4324;
% b1=3.442;
% b2=3.33;
% b3=7.1262;
% c1=-2.9086;
% c2=1.1738;
% c3=23.8816;
% 
% syms s
% %%V
% 
% A1=double(-(int(M*fv^2,s,[0 L])+Msk*subs(fv^2,s,20)+Msk*subs(fv^2,s,65)+Msk*subs(fv^2,s,110)+Msk*subs(fv^2,s,150)+Msk*subs(fv^2,s,190)+Msk*subs(fv^2,s,235)+Msk*subs(fv^2,s,280)));
% A2=double(-int(Cv*fv^2,s,[0 L]));
% A3=double(4*int(fv*diff((H+EA*(diff(y,s))^2)*diff(fv,s),s),s,[0 L]));
% A4=double(4*int(fv*diff(1.5*EA*diff(y,s)*(diff(fv,s))^2,s),s,[0 L]));
% A5=double(4*int(fv*diff(.5*EA*(diff(fv,s))^3,s),s,[0 L]));
% A6=double(-2*int(fv*diff(ri*sin(pi/4)*diff(f0,s)*(H+EA*(diff(y,s))^2),s),s,[0 L])-2*int(fv*diff(ri*sin(5*pi/4)*diff(f0,s)*(H+(diff(y,s))^2),s),s,[0 L]));
% A7=double(2*int(fv*diff((EA*(sin(pi/4))^2+0.5)*ri^2*diff(y,s)*(diff(f0,s))^2),s,[0 L])+2*int(fv*diff((EA*(sin(5*pi/4))^2+0.5)*ri^2*diff(y,s)*(diff(f0,s))^2),s,[0 L]));
% A8=double(-2*int(fv*diff(.5*EA*ri^3*sin(pi/4)*(diff(f0,s))^3,s),s,[0 L])-2*int(fv*diff(.5*EA*ri^3*sin(5*pi/4)*(diff(f0,s))^3,s),s,[0 L]));
% A9=double(4*int(fv*diff(.5*EA*diff(y,s)*(diff(fw,s))^2,s),s,[0 L]));
% A10=double(4*int(fv*diff(.5*EA*diff(fv,s)*(diff(fw,s))^2,s),s,[0 L]));
% A11=double(2*int(fv*diff(EA*ri*cos(pi/4)*diff(y,s)*diff(fw,s)*diff(f0,s),s),s,[0 L])+2*int(fv*diff(EA*ri*cos(5*pi/4)*diff(y,s)*diff(fw,s)*diff(f0,s),s),s,[0 L]));
% A12=double(-2*int(fv*diff(.5*EA*ri^2*sin(pi/2)*diff(fw,s)*(diff(f0,s))^2,s),s,[0 L])-2*int(fv*diff(.5*EA*ri^2*sin(3*pi/2)*diff(fw,s)*(diff(f0,s))^2,s),s,[0 L]));
% A13=double(-2*int(fv*diff(3*EA*ri*sin(pi/4)*diff(y,s)*diff(fv,s)*diff(f0,s),s),s,[0 L])-2*int(fv*diff(3*ri*sin(5*pi/4)*diff(y,s)*diff(fv,s)*diff(f0,s),s),s,[0 L]));
% A14=double(-2*int(fv*diff(EA*ri*sin(pi/4)*diff(f0,s)*(diff(fv,s))^2,s),s,[0 L])-2*int(fv*diff(EA*ri*sin(5*pi/4)*diff(f0,s)*(diff(fv,s))^2,s),s,[0 L]));
% A15=double(2*int(fv*diff(EA*diff(fv,s)*(ri*sin(pi/4)*diff(f0,s))^2,s),s,[0 L])+2*int(fv*diff(EA*diff(fv,s)*(ri*sin(5*pi/4)*diff(f0,s))^2,s),s,[0 L]));
% A16=double(2*int(fv*diff(EA*ri*cos(pi/4)*diff(fv,s)*diff(fw,s)*diff(f0,s),s),s,[0 L])+2*int(fv*diff(EA*ri*cos(5*pi/4)*diff(fv,s)*diff(fw,s)*diff(f0,s),s),s,[0 L]));
% A17=double(int(sy*fv*f0,s,[0 L]));
% 
% A19=double(0.5*R*d*U^2*int(a1*f0*fv,s,[0 L]));
% A20=double(-0.5*R*d*U^2*int(a1*fv^2/U,s,[0 L]));
% A21=double(-0.5*R*d*U^2*int(0.5*a1*fv*f0*d/U,s,[0 L]));
% A22=double(0.5*R*d*U^2*int(a2*f0^2*fv,s,[0 L]));
% A23=double(-0.5*R*d*U^2*int(2*a2*f0*fv^2/U,s,[0 L]));
% A24=double(-0.5*R*d*U^2*int(a2*f0^2*fv*d/U,s,[0 L]));
% A25=double(0.5*R*d*U^2*int(a2*fv^3/U^2,s,[0 L]));
% A26=double(0.5*R*d*U^2*int(a2*fv^2*f0*d/U^2,s,[0 L]));
% A27=double(0.5*R*d*U^2*int(0.25*a2*f0^2*fv*d^2/U^2,s,[0 L]));
% A28=double(0.5*R*d*U^2*int(a3*f0^3*fv,s,[0 L]));
% A29=double(-0.5*R*d*U^2*int(3*a3*f0^2*fv^2/U,s,[0 L]));
% A30=double(-0.5*R*d*U^2*int(1.5*a3*f0^3*fv*d/U,s,[0 L]));
% A31=double(0.5*R*d*U^2*int(3*a3*fv^3*f0/U^2,s,[0 L]));
% A32=double(0.5*R*d*U^2*int(3*a3*fv^2*f0^2*d/U^2,s,[0 L]));
% A33=double(0.5*R*d*U^2*int(0.75*a3*fv*f0^3*d^2/U^2,s,[0 L]));
% A34=double(-0.5*R*d*U^2*int(a3*fv^4/U^3,s,[0 L]));
% A35=double(-0.5*R*d*U^2*int(1.5*a3*fv^3*f0/U^3,s,[0 L]));
% A36=double(-0.5*R*d*U^2*int(.75*a3*fv^2*f0^2*d^2/U^3,s,[0 L]));
% A37=double(-0.5*R*d*U^2*int(.125*a3*f0^3*fv*d^3/U^3,s,[0 L]));
% % W
% B1=double(-(int(M*fw^2,s,[0 L])+Msk*subs(fw^2,s,20)+Msk*subs(fw^2,s,65)+Msk*subs(fw^2,s,110)+Msk*subs(fw^2,s,150)+Msk*subs(fw^2,s,190)+Msk*subs(fw^2,s,235)+Msk*subs(fw^2,s,280)));
% B2=double(-int(Cw*fw^2,s,[0 L]));
% B3=double(4*int(fw*diff(H*diff(fw,s),s),s,[0 L]));
% B4=double(4*int(fw*diff(.5*EA*(diff(fw,s))^3,s),s,[0 L]));
% B5=double(2*int(fw*diff(H*ri*cos(pi/4)*diff(f0,s),s),s,[0 L])+2*int(fw*diff(H*ri*cos(5*pi/4)*diff(f0,s),s),s,[0 L]));
% B6=double(-2*int(fw*diff(.5*EA*diff(y,s)*sin(pi/2)*(ri*diff(f0,s))^2,s),s,[0 L])-2*int(fw*diff(.5*EA*sin(3*pi/2)*(ri*diff(f0,s))^2,s),s,[0 L]));
% B7=double(2*int(fw*diff(.5*EA*cos(pi/4)*(ri*diff(f0,s))^3,s),s,[0 L])+2*int(fw*diff(.5*EA*cos(5*pi/4)*(ri*diff(f0,s))^3,s),s,[0 L]));
% B8=double(4*int(fw*diff(EA*diff(y,s)*diff(fv,s)*diff(fw,s),s),s,[0 L]));
% B9=double(4*int(fw*diff(.5*EA*diff(fw,s)*(diff(fv,s))^2,s),s,[0 L]));
% B10=double(-2*int(fw*diff(EA*ri*sin(pi/4)*diff(y,s)*diff(f0,s)*diff(fw,s),s),s,[0 L])-2*int(fw*diff(EA*ri*sin(5*pi/4)*diff(y,s)*diff(f0,s)*diff(fw,s),s),s,[0 L]));
% B11=double(-2*int(fw*diff(EA*ri*sin(pi/4)*diff(fv,s)*diff(f0,s)*diff(fw,s),s),s,[0 L])-2*int(fw*diff(EA*ri*sin(5*pi/4)*diff(fv,s)*diff(f0,s)*diff(fw,s),s),s,[0 L]));
% B12=double(2*int(fw*diff(1.5*EA*ri*cos(pi/4)*diff(f0,s)*(diff(fw,s))^2,s),s,[0 L])+2*int(fw*diff(1.5*EA*ri*cos(5*pi/4)*diff(f0,s)*(diff(fw,s))^2,s),s,[0 L]));
% B13=double(2*int(fw*diff(EA*ri*cos(pi/4)*diff(y,s)*diff(fv,s)*diff(f0,s),s),s,[0 L])+2*int(fw*diff(EA*ri*cos(5*pi/4)*diff(y,s)*diff(fv,s)*diff(f0,s),s),s,[0 L]));
% B14=double(2*int(fw*diff(.5*EA*ri*cos(pi/4)*diff(f0,s)*(diff(fv,s))^2,s),s,[0 L])+2*int(fw*diff(.5*EA*ri*cos(5*pi/4)*diff(f0,s)*(diff(fv,s))^2,s),s,[0 L]));
% B15=double(-2*int(fw*diff(.5*EA*ri*sin(pi/2)*diff(fv,s)*(ri*diff(f0,s))^2,s),s,[0 L])-2*int(fw*diff(.5*EA*ri*sin(3*pi/2)*diff(fv,s)*(ri*diff(f0,s))^2,s),s,[0 L]));
% B16=double(2*int(fw*diff(EA*(0.5+diff(fw,s)*(cos(pi/4))^2)*(ri*diff(f0,s))^2,s),s,[0 L])+2*int(fw*diff(EA*(0.5+diff(fw,s)*(cos(5*pi/4))^2)*(ri*diff(f0,s))^2,s),s,[0 L]));
% B17=double(-int(sz*fw*f0,s,[0 L]));
% 
% B19=double(0.5*R*d*U^2*int(b1*f0*fw,s,[0 L]));
% B20=double(-0.5*R*d*U^2*int(b1*fv*fw/U,s,[0 L]));
% B21=double(-0.5*R*d*U^2*int(0.5*b1*fw*f0*d/U,s,[0 L]));
% B22=double(0.5*R*d*U^2*int(b2*f0^2*fw,s,[0 L]));
% B23=double(-0.5*R*d*U^2*int(2*b2*f0*fv*fw/U,s,[0 L]));
% B24=double(-0.5*R*d*U^2*int(b2*f0^2*fw*d/U,s,[0 L]));
% B25=double(0.5*R*d*U^2*int(b2*fv^2*fw/U^2,s,[0 L]));
% B26=double(0.5*R*d*U^2*int(b2*fv*fw*f0*d/U^2,s,[0 L]));
% B27=double(0.5*R*d*U^2*int(0.25*b2*f0^2*fw*d^2/U^2,s,[0 L]));
% B28=double(0.5*R*d*U^2*int(b3*f0^3*fw,s,[0 L]));
% B29=double(-0.5*R*d*U^2*int(3*b3*f0^2*fv*fw/U,s,[0 L]));
% B30=double(-0.5*R*d*U^2*int(1.5*b3*f0^3*fw*d/U,s,[0 L]));
% B31=double(0.5*R*d*U^2*int(3*b3*fv^2*fw*f0/U^2,s,[0 L]));
% B32=double(0.5*R*d*U^2*int(3*b3*fv*fw*f0^2*d/U^2,s,[0 L]));
% B33=double(0.5*R*d*U^2*int(0.75*b3*fw*f0^3*d^2/U^2,s,[0 L]));
% B34=double(-0.5*R*d*U^2*int(b3*fv^3*fw/U^3,s,[0 L]));
% B35=double(-0.5*R*d*U^2*int(1.5*b3*fv^2*fw*f0/U^3,s,[0 L]));
% B36=double(-0.5*R*d*U^2*int(.75*b3*fv*fw*f0^2*d^2/U^3,s,[0 L]));
% B37=double(-0.5*R*d*U^2*int(.125*b3*f0^3*fw*d^3/U^3,s,[0 L]));
% % % 0
% 
% C1=double(-(int(J*f0^2,s,[0 L])+Isk*subs(f0^2,s,20)+Isk*subs(f0^2,s,65)+Isk*subs(f0^2,s,110)+Isk*subs(f0^2,s,150)+Isk*subs(f0^2,s,190)+Isk*subs(f0^2,s,235)+Isk*subs(f0^2,s,280)));
% C2=double(-int(C0*f0^2,s,[0 L]));
% C3=double(2*int(f0*diff(diff(f0,s)*(H*ri^2+GJ+EA*(ri*sin(pi/4)*diff(y,s))^2),s),s,[0 L])+2*int(f0*diff(diff(f0,s)*(H*ri^2+GJ+EA*(ri*sin(5*pi/4)*diff(y,s))^2),s),s,[0 L]));
% C4=double(-2*int(f0*diff(1.5*EA*ri^3*sin(pi/4)*diff(y,s)*(diff(f0,s))^2,s),s,[0 L])-2*int(f0*diff(1.5*EA*ri^3*sin(5*pi/4)*diff(y,s)*(diff(f0,s))^2,s),s,[0 L]));
% C5=double(4*int(f0*diff(.5*EA*ri^4*(diff(f0,s))^3,s),s,[0 L]));
% C6=double(-2*int(f0*diff(ri*sin(pi/4)*diff(fv,s)*(H+EA*(diff(y,s))^2),s),s,[0 L])-2*int(f0*diff(ri*sin(5*pi/4)*diff(fv,s)*(H+EA*(diff(y,s))^2),s),s,[0 L]));
% C7=double(-2*int(f0*diff(1.5*EA*ri*sin(pi/4)*diff(y,s)*(diff(fv,s))^2,s),s,[0 L])-2*int(f0*diff(1.5*EA*ri*sin(5*pi/4)*diff(y,s)*(diff(fv,s))^2,s),s,[0 L]));
% C8=double(-2*int(f0*diff(.5*EA*ri*sin(pi/4)*(diff(fv,s))^3,s),s,[0 L])-2*int(f0*diff(.5*EA*ri*sin(5*pi/4)*(diff(fv,s))^3,s),s,[0 L]));
% C9=double(2*int(f0*diff(H*ri*cos(pi/4)*diff(fw,s),s),s,[0 L])+2*int(f0*diff(H*ri*cos(5*pi/4)*diff(fw,s),s),s,[0 L]));
% C10=double(-2*int(f0*diff(.5*EA*ri*sin(pi/4)*diff(y,s)*(diff(fw,s))^2,s),s,[0 L])-2*int(f0*diff(.5*EA*ri*sin(5*pi/4)*diff(y,s)*(diff(fw,s))^2,s),s,[0 L]));
% C11=double(2*int(f0*diff(.5*EA*ri*cos(pi/4)*(diff(fw,s))^3,s),s,[0 L])+2*int(f0*diff(.5*EA*ri*cos(5*pi/4)*(diff(fw,s))^3,s),s,[0 L]));
% C12=double(2*int(f0*diff(2*EA*(ri*sin(pi/4))^2*diff(y,s)*diff(fv,s)*diff(f0,s),s),s,[0 L])+2*int(f0*diff(2*EA*(ri*sin(5*pi/4))^2*diff(y,s)*diff(fv,s)*diff(f0,s),s),s,[0 L]));
% C13=double(-2*int(f0*diff(EA*ri^2*sin(pi/2)*diff(y,s)*diff(fw,s)*diff(f0,s),s),s,[0 L])-2*int(f0*diff(EA*ri^2*sin(3*pi/2)*diff(y,s)*diff(fw,s)*diff(f0,s),s),s,[0 L]));
% C14=double(2*int(f0*diff(EA*ri*cos(pi/4)*diff(y,s)*diff(fw,s)*diff(fv,s),s),s,[0 L])+2*int(f0*diff(EA*ri*cos(5*pi/4)*diff(y,s)*diff(fw,s)*diff(fv,s),s),s,[0 L]));
% C15=double(2*int(f0*diff(EA*ri^2*sin(pi/2)*diff(fv,s)*diff(fw,s)*diff(f0,s),s),s,[0 L])+2*int(f0*diff(EA*ri^2*sin(3*pi/2)*diff(fv,s)*diff(fw,s)*diff(f0,s),s),s,[0 L]));
% C16=double(2*int(f0*diff(.5*EA*ri*cos(pi/4)*diff(fw,s)*(diff(fv,s))^2,s),s,[0 L])+2*int(f0*diff(.5*EA*ri*cos(5*pi/4)*diff(fw,s)*(diff(fv,s))^2,s),s,[0 L]));
% C17=double(2*int(f0*diff(1.5*EA*ri^3*cos(pi/4)*diff(fw,s)*(diff(f0,s))^2,s),s,[0 L])+2*int(f0*diff(1.5*EA*ri^3*cos(5*pi/4)*diff(fw,s)*(diff(f0,s))^2,s),s,[0 L]));
% C18=double(2*int(f0*diff((.5+(cos(pi/4))^2)*EA*ri^2*diff(f0,s)*(diff(fw,s))^2,s),s,[0 L])+2*int(f0*diff((.5+(cos(5*pi/4))^2)*EA*ri^2*diff(f0,s)*(diff(fw,s))^2,s),s,[0 L]));
% C19=double(2*int(f0*diff((.5+(sin(pi/4))^2)*EA*ri^2*diff(f0,s)*(diff(fv,s))^2,s),s,[0 L])+2*int(f0*diff((.5+(sin(5*pi/4))^2)*EA*ri^2*diff(f0,s)*(diff(fv,s))^2,s),s,[0 L]));
% C20=double(-2*int(f0*diff(1.5*EA*ri^3*sin(pi/4)*diff(fv,s)*(diff(f0,s))^2,s),s,[0 L])-2*int(f0*diff(1.5*EA*ri^3*sin(5*pi/4)*diff(fv,s)*(diff(f0,s))^2,s),s,[0 L]));
% C21=double(-2*int(f0*diff(.5*EA*ri*sin(pi/4)*diff(fv,s)*(diff(fw,s))^2,s),s,[0 L])-2*int(f0*diff(.5*EA*ri*sin(5*pi/4)*diff(fv,s)*(diff(fw,s))^2,s),s,[0 L]));
% C22=double(int(sy*fv*f0,s,[0 L]));
% C23=double(-int(sz*fw*f0,s,[0 L]));
% 
% C25=double(0.5*R*d^2*U^2*int(c1*f0*f0,s,[0 L]));
% C26=double(-0.5*R*d^2*U^2*int(c1*fv*f0/U,s,[0 L]));
% C27=double(-0.5*R*d^2*U^2*int(0.5*c1*f0*f0*d/U,s,[0 L]));
% C28=double(0.5*R*d^2*U^2*int(c2*f0^2*f0,s,[0 L]));
% C29=double(-0.5*R*d^2*U^2*int(2*c2*f0*fv*f0/U,s,[0 L]));
% C30=double(-0.5*R*d^2*U^2*int(c2*f0^2*f0*d/U,s,[0 L]));
% C31=double(0.5*R*d^2*U^2*int(c2*fv^2*f0/U^2,s,[0 L]));
% C32=double(0.5*R*d^2*U^2*int(c2*fv*f0*f0*d/U^2,s,[0 L]));
% C33=double(0.5*R*d^2*U^2*int(0.25*c2*f0^2*f0*d^2/U^2,s,[0 L]));
% C34=double(0.5*R*d^2*U^2*int(c3*f0^4,s,[0 L]));
% C35=double(-0.5*R*d^2*U^2*int(3*c3*f0^2*fv*f0/U,s,[0 L]));
% C36=double(-0.5*R*d^2*U^2*int(1.5*c3*f0^3*f0*d/U,s,[0 L]));
% C37=double(0.5*R*d^2*U^2*int(3*c3*fv^2*f0*f0/U^2,s,[0 L]));
% C38=double(0.5*R*d^2*U^2*int(3*c3*fv*f0*f0^2*d/U^2,s,[0 L]));
% C39=double(0.5*R*d^2*U^2*int(0.75*c3*f0*f0^3*d^2/U^2,s,[0 L]));
% C40=double(-0.5*R*d^2*U^2*int(c3*fv^3*f0/U^3,s,[0 L]));
% C41=double(-0.5*R*d^2*U^2*int(1.5*c3*fv^2*f0*f0/U^3,s,[0 L]));
% C42=double(-0.5*R*d^2*U^2*int(.75*c3*fv*f0*f0^2*d^2/U^3,s,[0 L]));
% C43=double(-0.5*R*d^2*U^2*int(.125*c3*f0^3*f0*d^3/U^3,s,[0 L]));
% A3/A1
% B3/B1
%% 

n=6;
dt=0.01;
tspan=[0:dt:500]; 
options=odeset('RelTol',1e-12,'AbsTol',1e-12*ones(1,n));
q0= [0.7 0.001 0 0 0 0];
% [t,q1] = ode113(@vdp1, tspan, q0,options); 
[t,q2] = ode113(@vdp1, tspan, q0,options); 
% tempdata=(q1(:,1)-q2(:,1)).^2;
% tempdata2=(q1(:,1)-mean(q1(:,1))).^2;
% R2=1-(sum(tempdata)/sum(tempdata2))

figure(1);
% plot(t,q1(:,1))
hold on
plot(t,q2(:,3))
% figure(3);
% plot(t,q2(:,5))
% figure(4);
% plot(q(:,1),q(:,3))
%%  Compute Derivative
% for i=1:length(q2)
%     dq2(i,:) = vdp2(0,q2(i,:));
% end
% rand('state',19); randn('state',19); % make data reproducible
% eps=0.1;
% y1 = q(:,1)+eps*randn(size(q(:,1)))* rms(q(:,1));%velocity
% y2 = q(:,3)+eps*randn(size(q(:,3)))* rms(q(:,3));%velocity
% y3 = dq(:,2)+eps*randn(size(dq(:,2)))* rms(dq(:,2));% acceleration
% y4 = dq(:,4)+eps*randn(size(dq(:,4)))* rms(dq(:,4));% acceleration
% % set maximum regularization parameter lambda_max
% lambda_max1 = l1tf_lambdamax(y1);%
% lambda_max2 = l1tf_lambdamax(y2);%
% lambda_max3 = l1tf_lambdamax(y3);
% lambda_max4 = l1tf_lambdamax(y4);
% %----------------------------------------------------------------------
% % 	l1 trend filtering
% %----------------------------------------------------------------------
% [z1,status] = l1tf(y1, 0.000001*lambda_max1);%
% [z2,status] = l1tf(y2, 0.00001*lambda_max2);%
% [z3,status] = l1tf(y3, 0.00001*lambda_max3);
% [z4,status] = l1tf(y4, 0.00001*lambda_max4);
% %----------------------------------------------------------------------
% % 	plot results
%----------------------------------------------------------------------
for i=1:length(q2)
    dq2(i,:) = vdp2(0,q2(i,:));
end
% rand('state',19); randn('state',19); % make data reproducible
% eps=0;
% q2 = q2+eps.*randn(size(q2)).* rms(q2);
% q2(:,[2 4 6])= [gradient(q2(:,1))./gradient(tspan'),gradient(q2(:,3))./gradient(tspan'),gradient(q2(:,5))./gradient(tspan')];
% dq2(:,[1 3 5])=q2(:,[2 4 6]);














%%  Total Variation Regularized Differentiation
% figure();
% z5= TVRegDiff( y1, 10, 5000, [], 'small', 1e12, dt, 1, 1 );
% hold on
% plot(dq(:,1),'r')
% xlim([30000 31000])
% figure();
% z6 = TVRegDiff( y2, 10, 7000, [], 'small', 1e12, dt, 1, 1 );
% hold on
% plot(dq(:,3),'r')
% xlim([30000 31000])
% z5=z5(1:end-1,:);
% z6=z6(1:end-1,:);

% z1 = cumsum(z5)*dt;
% z2 = cumsum(z6)*dt;
% 
% z1 = z1 - (mean(z1(1000:end-1000,:)) - mean(y1(1000:end-1000,:)));
% z2= z2 - (mean(z2(1000:end-1000,:)) - mean(y2(1000:end-1000,:)));
%% 
% q1=q(:,1);
% q2=q(:,3);
% q3=dq(:,2);
% q4=dq(:,4);
% xyzs = [q1 q2 q3 q4 y1 y2 y3 y4 z1 z2 z3 z4];
% maxx = max(max(xyzs));
% minx = min(min(xyzs));
% figure();
% subplot(2,4,1); plot(t,q1,'b',t,y1, 'r'); ylim([minx maxx]); title('original qv');
% subplot(2,4,2); plot(t,q2,'b',t,y2,'r'); ylim([minx maxx]); title('original qw');
% subplot(2,4,3); plot(t,q3,'b',t,y3, 'r'); ylim([minx maxx]); title('original ddqv');
% subplot(2,4,4); plot(t,q4,'b',t,y4, 'r'); ylim([minx maxx]); title('original ddqw');
% subplot(2,4,5); plot(t,q1,'b',t,z1,'r'); ylim([minx maxx]); title('de-noise qv');
% subplot(2,4,6); plot(t,q2,'b',t,z2,'r'); ylim([minx maxx]); title('de-noise qw');
% subplot(2,4,7); plot(t,q3,'b',t,z3,'r'); ylim([minx maxx]); title('de-noise ddqv');
% subplot(2,4,8); plot(t,q4,'b',t,z4, 'r'); ylim([minx maxx]); title('de-noise ddqw');
% qn=[z1 z5 z2 z6];
% dqn=[z5 z3 z6 z4];
% qn=qn(20000:end-20000,:);
% dqn=dqn(20000:end-20000,:);
%% 
% figure();
% plot(t,q(:,2),t,z5)
% tempdata=(q(:,2)-z5).^2;
% tempdata2=(q(:,2)-mean(q(:,2))).^2;
% R2_qvV=1-(sum(tempdata)/sum(tempdata2))
% 
% figure();
% plot(t,q(:,4),t,z6)
% tempdata=(q(:,4)-z6).^2;
% tempdata2=(q(:,4)-mean(q(:,4))).^2;
% R2_qwV=1-(sum(tempdata)/sum(tempdata2))
%% R2
% tempdata=(q1-z1).^2;
% tempdata2=(q1-mean(q1)).^2;
% R2_qv=1-(sum(tempdata)/sum(tempdata2))
% 
% tempdata=(q2-z2).^2;
% tempdata2=(q2-mean(q2)).^2;
% R2_qw=1-(sum(tempdata)/sum(tempdata2))
% 
% tempdata=(q3-z3).^2;
% tempdata2=(q3-mean(q3)).^2;
% R2_ddqv=1-(sum(tempdata)/sum(tempdata2))
% 
% tempdata=(q4-z4).^2;
% tempdata2=(q4-mean(q4)).^2;
% R2_ddqw=1-(sum(tempdata)/sum(tempdata2))


%% Build library and compute sparse regression
Theta=poolData(q2,n,3);% up to third order polynomials
lambda= 0.005;% lambda is our sparsification knob.
Xi=sparsifyDynamics(Theta,dq2,lambda,n);
poolDataLIST({'qv','dqv','qw','dqw','q0','dq0'},Xi,n,3);
%%  integrate true and identified systems
[t_pred,q_pred]=ode113(@(t,q)sparseGalerkin(t,q,Xi,3),tspan,q0,options);
[tA,qA] = ode113(@vdp2, tspan, q0,options);
figure()
plot(tA,qA(:,5),'markerfacecolor','b','linewidth',1);
hold on;
plot(t_pred,q_pred(:,5),'markerfacecolor','r','linewidth',1);
%% R2
tempdata=(qA(:,1)-q_pred(:,1)).^2;
tempdata2=(qA(:,1)-mean(qA(:,1))).^2;
R2=1-(sum(tempdata)/sum(tempdata2))

tempdata=(qA(:,3)-q_pred(:,3)).^2;
tempdata2=(qA(:,3)-mean(qA(:,3))).^2;
R2=1-(sum(tempdata)/sum(tempdata2))
