function TTc=GEBCc2(Tc,TTPc,TTPr,TTPm,SL,KcL,KcS,Nxc,Nyc,CPcL,CPcS,Nym,ROcS,ROcL,TS,TL,HL,K,DT,DX,TETA,UF,P)

%==========================================================================
for I=2:Nxc-1
    for J=2:Nyc-1
        %=========================
        if  SL(K,I,J)==-1;KK=KcS;RO=ROcS;end;
        if  SL(K,I,J)==1;KK=KcL;RO=ROcL;end;
        if  SL(K,I,J)==0;KK=(KcL+KcS)/2;RO=(ROcS+ROcL)/2;end;
        %=========================
        % if  SL(K-1,I,J)==-1;KKN=KcS;end;
        % if  SL(K-1,I,J)==1;KKN=KcL;end;
        % if  SL(K-1,I,J)==0;KKN=(KcL+KcS)/2;end;
        %=========================
        An=KK*DT*(1-TETA)/(RO*DX^2)*(Tc(K-1,I+1,J)-2*Tc(K-1,I,J)+Tc(K-1,I-1,J)+Tc(K-1,I,J+1)-2*Tc(K-1,I,J)+Tc(K-1,I,J-1));
        Ann=KK*DT*(TETA)/(RO*DX^2)*(TTPc(I+1,J)+TTPc(I-1,J)+TTPc(I,J+1)+TTPc(I,J-1));
        %================================================================
        if  SL(K-1,I,J)==-1;HN=CPcS*Tc(K-1,I,J);end;
        if  SL(K-1,I,J)==1;HN=CPcL*Tc(K-1,I,J)+HL;end;
        if  SL(K-1,I,J)==0;HN=(CPcL+CPcS)/2*Tc(K-1,I,J)+(Tc(K-1,I,J)-TS)/(TL-TS)*HL;end;
        %=================================================================
        if  SL(K,I,J)==-1
            A=An+Ann+HN;
            B=4*KK*DT*TETA/(RO*DX^2)+CPcS;
        end
        if  SL(K,I,J)==1
            A=An+Ann+HN-HL;
            B=4*KK*DT*TETA/(RO*DX^2)+CPcL;
        end
        if  SL(K,I,J)==0
            A=An+Ann+HN+(TS*HL)/(TL-TS);
            B=4*KK*DT*TETA/(RO*DX^2)+((CPcL+CPcS)/2+HL/(TL-TS));
        end

        TTc(I,J)=TTPc(I,J)+UF*(-TTPc(I,J)+A/B);
        %===========================

    end
end

%=========================================================================
Hin=HINTERFACE(K,DT,P);
Hin2=HINTERFACE2(K,DT,P);
J=1;
for I=2:Nxc-1
    if  SL(K,I,J)==-1;KK=KcS;end;
    if  SL(K,I,J)==1;KK=KcL;end;
    if  SL(K,I,J)==0;KK=(KcL+KcS)/2;end;

    TTc(I,J)=(TTc(I,J+1)+Hin*DX/KK*TTPm(I,Nym))/(1+Hin*DX/KK);
end
I=Nxc;
for J=2:Nyc-1
    if  SL(K,I,J)==-1;KK=KcS;end;
    if  SL(K,I,J)==1;KK=KcL;end;
    if  SL(K,I,J)==0;KK=(KcL+KcS)/2;end;

    TTc(I,J)=(TTc(I-1,J)+Hin2*DX/KK*TTPr(1,J+Nym))/(1+Hin2*DX/KK);
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