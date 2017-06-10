function SL=SLAlgorithm(SL,Tc,TS,TL,Nxc,Nyc,K)

for I=1:Nxc
    for J=1:Nyc
        if  (Tc(K,I,J)<= TS);SL(K,I,J)=-1;end;
        if  (Tc(K,I,J)>= TL);SL(K,I,J)=1;end;
        if  (((Tc(K,I,J)> TS) && (Tc(K,I,J)< TL)));SL(K,I,J)=0;end;

        if (SL(K-1,I)==0);SL(K,I)=0;end;
        if (SL(K-1,I)==-1);SL(K,I)=-1;end;
    end
end

