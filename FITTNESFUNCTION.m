function FITTNES=FITTNESFUNCTION(TE,P,DATACONDUC,GEN,np,XYSENSOR)
P(1)=GEN(1);         % P1
P(2)=GEN(2);         % P2
P(3)=GEN(3);         % P3
P(4)=GEN(4);         % P4
% ======================================================================
[Tc,Tm,Tr]=DIRECTSOLUTION(P,DATACONDUC);
B1=ARMS(TE,Tc,Tm,Tr,DATACONDUC,XYSENSOR);
FITTNES=1/(.01+sqrt(B1));
%============================================================