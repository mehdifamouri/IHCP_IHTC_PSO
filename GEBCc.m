function TTc=GEBCc(Tc,TTPc,TTPr,TTPm,Nxc,Nyc,Nym,Kc,CPc,ROc,K,DT,DX,TETA,UF)

for J=2:Nyc-1
    for I=2:Nxc-1
        ALFAn=Kc/(CPc*ROc);
        ALFA=Kc/(CPc*ROc);

        LANDAn=0.;LANDA=0;
        An=ALFAn/DX^2.*(Tc(K-1,I+1,J)-2.*Tc(K-1,I,J)+Tc(K-1,I-1,J))+ALFAn/DX^2.*(Tc(K-1,I,J+1)-2.*Tc(K-1,I,J)+Tc(K-1,I,J-1));
        A=ALFA/DX^2.*(TTPc(I+1,J)+TTPc(I-1,J))+ALFA/DX^2.*(TTPc(I,J+1)+TTPc(I,J-1));

        B=(1-TETA)*(LANDAn+An)+TETA*(LANDA+A)+Tc(K-1,I,J)/DT;
        C=1./DT-TETA*ALFA*(-2/DX^2-2/DX^2);
        TTc(I,J)=TTPc(I,J)+UF*(-TTPc(I,J)+B/C);
    end
end
Hin=HINTERFACE(K,DT);
Hin2=HINTERFACE2(K,DT);
J=1;
for I=2:Nxc-1
    TTc(I,J)=(TTc(I,J+1)+Hin*DX/Kc*TTPm(I,Nym))/(1+Hin*DX/Kc);
end
I=Nxc;
for J=2:Nyc-1
    TTc(I,J)=(TTc(I-1,J)+Hin2*DX/Kc*TTPr(1,J+Nym))/(1+Hin2*DX/Kc);
end
I=1;
for J=2:Nyc-1
    TTc(I,J)=TTc(I+1,J);
end
J=Nyc;
for I=2:Nxc-1
    TTc(I,J)=TTc(I,J-1);
end    
I=1;J=1;
TTc(I,J)=(TTc(I+1,J)+TTc(I,J+1))/2;
I=1;J=Nyc;
TTc(I,J)=(TTc(I+1,J)+TTc(I,J-1))/2;
I=Nxc;J=1;
TTc(I,J)=(TTc(I-1,J)+TTc(I,J+1))/2;
I=Nxc;J=Nyc;
TTc(I,J)=(TTc(I-1,J)+TTc(I,J-1))/2;