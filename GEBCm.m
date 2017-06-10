function TTm=GEBCm(Tm,TTPc,TTPr,TTPm,Nxc,Nxm,Nym,Km,CPm,ROm,Kr,Twater,Hw,K,DT,DX,TETA,UF,P)

for J=2:Nym-1
    for I=2:Nxm-1
        ALFAn=Km/(CPm*ROm);
        ALFA=Km/(CPm*ROm);

        LANDAn=0.;LANDA=0;
        An=ALFAn/DX^2.*(Tm(K-1,I+1,J)-2.*Tm(K-1,I,J)+Tm(K-1,I-1,J))+ALFAn/DX^2.*(Tm(K-1,I,J+1)-2.*Tm(K-1,I,J)+Tm(K-1,I,J-1));
        A=ALFA/DX^2.*(TTPm(I+1,J)+TTPm(I-1,J))+ALFA/DX^2.*(TTPm(I,J+1)+TTPm(I,J-1));

        B=(1-TETA)*(LANDAn+An)+TETA*(LANDA+A)+Tm(K-1,I,J)/DT;
        C=1./DT-TETA*ALFA*(-2/DX^2-2/DX^2);
        TTm(I,J)=TTPm(I,J)+UF*(-TTPm(I,J)+B/C);
    end
end
Hin=HINTERFACE(K,DT,P);
J=1;
for I=2:Nxm-1
    TTm(I,J)=(TTm(I,J+1)+Hw*DX/Km*Twater)/(1+Hw*DX/Km);
end
I=Nxc;
for J=2:Nym-1
    TTm(I,J)=(TTPm(I-1,J)+Kr/Km*TTPr(1+1,J))/(1+Kr/Km);
end
I=1;
for J=2:Nym-1
    TTm(I,J)=TTm(I+1,J);
end
J=Nym;
for I=2:Nxm-1
    TTm(I,J)=(TTm(I,J-1)+Hin*DX/Km*TTPc(I,1))/(1+Hin*DX/Km);
end

I=1;J=1;
TTm(I,J)=(TTm(I+1,J)+TTm(I,J+1))/2;
I=1;J=Nym;
TTm(I,J)=(TTm(I+1,J)+TTm(I,J-1))/2;
I=Nxm;J=1;
TTm(I,J)=(TTm(I-1,J)+TTm(I,J+1))/2;
I=Nxm;J=Nym;
TTm(I,J)=(TTm(I-1,J)+TTm(I,J-1))/2;