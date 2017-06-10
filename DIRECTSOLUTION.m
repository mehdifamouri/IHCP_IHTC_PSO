function [Tc,Tm,Tr]=DIRECTSOLUTION(P,DATACONDUC)

KcL=DATACONDUC(1);
KcS=DATACONDUC(2);
CPcL=DATACONDUC(3);
CPcS=DATACONDUC(4);
ROcS=DATACONDUC(5);
ROcL=DATACONDUC(6);
TS=DATACONDUC(7);
TL=DATACONDUC(8);
HL=DATACONDUC(9);

ROm=DATACONDUC(10);
CPm=DATACONDUC(11);
Km=DATACONDUC(12);

ROr=DATACONDUC(13);
CPr=DATACONDUC(14);
Kr=DATACONDUC(15);
%=======================================================================
Tinitial=DATACONDUC(16);
Tambient=DATACONDUC(17);
Twater=DATACONDUC(18);
Ha=DATACONDUC(19);
Hw=DATACONDUC(20);
%=============   NT , DT,   =============================================
NT=DATACONDUC(21);
DT=DATACONDUC(22);
TIME=DT*(NT-1.);
%==============  Lx,Ly,Nx,Ny=============================================
DX=DATACONDUC(23);

Lxm=DATACONDUC(24);
Lxr=DATACONDUC(25);
Lym=DATACONDUC(26);
Lyc=DATACONDUC(27);

Lxc=Lxm;
Lyr=Lym+Lyc;
Nxm=fix((Lxm/DX)+1);
Nxr=fix((Lxr/DX)+1);
Nxc=Nxm;
Nym=fix((Lym/DX)+1);
Nyc=fix((Lyc/DX)+1);
Nyr=fix((Lyr/DX)+1);
%=======================================================================
Tc=0;
Tm=0;
Tr=0;
Tc(1,1:Nxc,1:Nyc)=Tinitial;
Tm(1,1:Nxm,1:Nym)=Tambient;
Tr(1,1:Nxr,1:Nyr)=Tambient;
SL(1,1:Nxc,1:Nyc)=1;
%=========================================================================
QERROR=(-4);
UF=.9;
TETA=.7;
FAMOUR=0.;
ITERATION=0;
%==========================================================================
%==========================================================================
for K=2:NT

    TTc(1:Nxc,1:Nyc)=Tc(K-1,1:Nxc,1:Nyc);
    TTr(1:Nxr,1:Nyr)=Tr(K-1,1:Nxr,1:Nyr);
    TTm(1:Nxm,1:Nym)=Tm(K-1,1:Nxm,1:Nym);
    SL(K,1:Nxc,1:Nyc)=SL(K-1,1:Nxc,1:Nyc);
    ITERATION;
    ITERATION=0;
    %=========      SPACAE SOlVING	  ================
    AERROR=-1;
    while AERROR == -1
        ITERATION=ITERATION+1;
        FAMOUR=FAMOUR+1;

        TTPc=TTc;
        TTPr=TTr;
        TTPm=TTm;

        TTc=GEBCc2(Tc,TTPc,TTPr,TTPm,SL,KcL,KcS,Nxc,Nyc,CPcL,CPcS,Nym,ROcS,ROcL,TS,TL,HL,K,DT,DX,TETA,UF,P);
        TTm=GEBCm(Tm,TTPc,TTPr,TTPm,Nxc,Nxm,Nym,Km,CPm,ROm,Kr,Twater,Hw,K,DT,DX,TETA,UF,P);
        TTr=GEBCr(Tr,TTm,TTPc,TTPr,Nyc,Nym,Nyr,Nxr,Nxm,Kr,CPr,ROr,Ha,Tambient,K,DT,DX,TETA,UF,P);
        AERROR=ERROREVAlUATION(TTPc,TTPr,TTPm,TTc,TTr,TTm,Nxc,Nxr,Nxm,Nyc,Nyr,Nym,QERROR);
        if (ITERATION < 5) ; AERROR=-1; end;

    end
    %=========     SUBSTITUTING     ================
    Tc(K,1:Nxc,1:Nyc)=TTc(1:Nxc,1:Nyc);
    Tr(K,1:Nxr,1:Nyr)=TTr(1:Nxr,1:Nyr);
    Tm(K,1:Nxm,1:Nym)=TTm(1:Nxm,1:Nym);
    SL=SLAlgorithm(SL,Tc,TS,TL,Nxc,Nyc,K);

end
FAMOUR;