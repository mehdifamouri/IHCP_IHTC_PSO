clear all
clc
format long eng
np=4;
ng=200;
ns=30;
RC=.9;
NN=20;

zigma=0.01*500;

U(1)=10000;
L(1)=100;
U(2)=.0;
L(2)=-1;
U(3)=10000;
L(3)=100;
U(4)=0;
L(4)=-1;
wmax=.7;
wmin=.7;
cmax=1.2;
cmin=1.2;
w=wmax;
c1=cmax;
c2=cmax;
%=================================INVERSE PARAMETERS=======================
DATACONDUC(1)=90;          %KcL

DATACONDUC(2)= 109;          %KcS
DATACONDUC(3)= 1082;         %CPcL
DATACONDUC(4)= 991;          %CPcS
DATACONDUC(5)= 2690;         %ROcS
DATACONDUC(6)= 2389;         %ROcL
DATACONDUC(7)=577;           %TS
DATACONDUC(8)=632;           %TL
DATACONDUC(9)=339;           %HL

DATACONDUC(10)=7860;         %ROm (Steel SAE 1010)
DATACONDUC(11)=527;          %CPm
DATACONDUC(12)=46;           %Km

DATACONDUC(13)=2387;          %ROr
DATACONDUC(14)=843;           %CPr
DATACONDUC(15)=1.37;          %Kr

DATACONDUC(16)=695+273;       %Tinitial
DATACONDUC(17)=23+273;        %Tambient
DATACONDUC(18)=1+273;         %Twater
DATACONDUC(19)=5;             %Ha
DATACONDUC(20)=50;            %Hw

DATACONDUC(21)=200+1;          %NT
DATACONDUC(22)=1;           %DT
DATACONDUC(23)=4*10^(-3);    %DX (mohem nist)

DATACONDUC(24)=50*10^-3;      %Lxm
DATACONDUC(25)=20*10^-3;      %Lxr
DATACONDUC(26)=60*10^-3;     %Lym
DATACONDUC(27)=100*10^-3;      %Lyc


%=========================================================================
P(1)=5200;
P(2)=-.17;
P(3)=4000;
P(4)=-.2;

%=========================================================================
XYSENSOR=[2*.001, 13*.001,1
          2*.001, (60-3)*.001,2]
Q=size(XYSENSOR);
NSENSOR=Q(1);
%=========================================================================
tic
 [Tc,Tm,Tr]=DIRECTSOLUTION(P,DATACONDUC);
 TE=REFRENCESOLUTION(Tc,Tm,Tr,DATACONDUC,zigma,XYSENSOR);
 b1=ARMS(TE,Tc,Tm,Tr,DATACONDUC,XYSENSOR);
toc

for i=1:ns*NN
    for d=1:np
        BB(i,d)=random('unif',L(d),U(d));
    end
end
for i=1:ns*NN
    GEN(1:np)=BB(i,1:np);
    BF(i,1)=FITTNESFUNCTION(TE,P,DATACONDUC,GEN,np,XYSENSOR);
  
end
BB=[BB,BF];
BB=sortrows(BB,-(np+1));
x(1:ns,1:np+1)=BB(1:ns,1:np+1);
%=================================
v(1:ns,1:np)=0;
p(1:ns,1:np+1)=x(1:ns,1:np+1);
xs=sortrows(x,-(np+1));
pg=xs(1,1:np+1);

for k=1:ng
    %======================================================================
    w=(wmax-wmin)/(1-ng)*(k-ng)+wmin;
    c1=(cmax-cmin)/(1-ng)*(k-ng)+cmin;
    c2=c1;
%     if fix(k/10)== k/10
%         w=wmax;
%         c1=cmax;
%         c2=cmax;
%     end

    %======================================================================
    for i=1:ns
        for d=1:np
            v2(i,d)=w*v(i,d)+c1*random('unif',0,1)*(p(i,d)-x(i,d))+c2*random('unif',0,1)*(pg(d)-x(i,d));
            xx=x(i,d)+v2(i,d);
            if xx < U(d) && xx > L(d)
                x2(i,d)=xx;
            else
                x2(i,d)=random('unif',L(d),U(d));
            end
        end
        GEN= x2(i,1:np);
        x2(i,np+1)=FITTNESFUNCTION(TE,P,DATACONDUC,GEN,np,XYSENSOR);
    end
    xs=sortrows(x2,-(np+1));
    pg2=xs(1,1:np+1);
   
    pg2=[pg;pg2]
    pg2=sortrows(pg2,-(np+1));
    pg=pg2(1,1:np+1);
    for i=1:ns
        if (x2(i,np+1)> p(i,np+1))
            p(i,1:np+1)=x2(i,1:np+1);
        end
    end
   
    x=x2;
    v=v2;
    U(1:np)=(1-RC)*pg(1,1:np)+RC*U(1:np);
    L(1:np)=(1-RC)*pg(1,1:np)+RC*L(1:np);
    qq=[U;L];
   DATAPRINT(k,1)=k;
   DATAPRINT(k,2:np+2)=pg(1,1:np+1);
   AVERFITTNESS=mean(x);
   DATAPRINT(k,np+3)=AVERFITTNESS(3);
   
   save
   
    end
    
   save


