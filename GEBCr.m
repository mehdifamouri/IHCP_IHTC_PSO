function TTr=GEBCr(Tr,TTm,TTPc,TTPr,Nyc,Nym,Nyr,Nxr,Nxm,Kr,CPr,ROr,Ha,Tambient,K,DT,DX,TETA,UF,P)

for J=2:Nyr-1
    for I=2:Nxr-1
        ALFAn=Kr/(CPr*ROr);
        ALFA=Kr/(CPr*ROr);

        LANDAn=0.;LANDA=0;
        An=ALFAn/DX^2.*(Tr(K-1,I+1,J)-2.*Tr(K-1,I,J)+Tr(K-1,I-1,J))+ALFAn/DX^2.*(Tr(K-1,I,J+1)-2.*Tr(K-1,I,J)+Tr(K-1,I,J-1));
        A=ALFA/DX^2.*(TTPr(I+1,J)+TTPr(I-1,J))+ALFA/DX^2.*(TTPr(I,J+1)+TTPr(I,J-1));

        B=(1-TETA)*(LANDAn+An)+TETA*(LANDA+A)+Tr(K-1,I,J)/DT;
        C=1./DT-TETA*ALFA*(-2/DX^2-2/DX^2);
        TTr(I,J)=TTPr(I,J)+UF*(-TTPr(I,J)+B/C);
    end
end
Hin2=HINTERFACE2(K,DT,P);
J=1;
for I=2:Nxr-1
    TTr(I,J)=(TTr(I,J+1)+Ha*DX/Kr*Tambient)/(1+Ha*DX/Kr);
end
I=Nxr;
for J=2:Nyr-1
    TTr(I,J)=(TTr(I-1,J)+Ha*DX/Kr*Tambient)/(1+Ha*DX/Kr);
end
I=1;
for J=2:Nyr-1
    if J > Nym
    TTr(I,J)=(TTr(I+1,J)+Hin2*DX/Kr*TTPc(1,J-Nym))/(1+Hin2*DX/Kr);
    else
    TTr(I,J)=TTm(Nxm,J);
    end
end
J=Nyr;
for I=2:Nxr-1
    TTr(I,J)=TTr(I,J-1);
end
I=1;J=1;
TTr(I,J)=(TTr(I+1,J)+TTr(I,J+1))/2;
I=1;J=Nyr;
TTr(I,J)=(TTr(I+1,J)+TTr(I,J-1))/2;
I=Nxr;J=1;
TTr(I,J)=(TTr(I-1,J)+TTr(I,J+1))/2;
I=Nxr;J=Nyr;
TTr(I,J)=(TTr(I-1,J)+TTr(I,J-1))/2;