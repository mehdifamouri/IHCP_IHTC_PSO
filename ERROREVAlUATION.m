function AERROR=ERROREVAlUATION(TTPc,TTPr,TTPm,TTc,TTr,TTm,Nxc,Nxr,Nxm,Nyc,Nyr,Nym,QERROR)

AERROR=1;

for J=1:Nyc
    for I=1:Nxc
        ERROR=0.;
        if (abs(TTc(I,J))> 10^(-16))
            ERROR=abs(TTPc(I,J)-TTc(I,J))/abs(TTc(I,J));
        end
        if (ERROR > 10^(QERROR));AERROR=-1;end;
    end
end

for J=1:Nym
    for I=1:Nxm
        ERROR=0.;
        if (abs(TTm(I,J))> 10^(-16))
            ERROR=abs(TTPm(I,J)-TTm(I,J))/abs(TTm(I,J));
        end
        if (ERROR > 10^(QERROR));AERROR=-1;end;
    end
end

for J=1:Nyr
    for I=1:Nxr
        ERROR=0.;
        if (abs(TTr(I,J))> 10^(-16))
            ERROR=abs(TTPr(I,J)-TTr(I,J))/abs(TTr(I,J));
        end
        if (ERROR > 10^(QERROR));AERROR=-1;end;
    end
end
