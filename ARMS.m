function ARMS=ARMS(TE,Tc,Tm,Tr,DATACONDUC,XYSENSOR)

SUM=0;
DX=DATACONDUC(23);
DY=DX;
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
NT=DATACONDUC(21);
DT=DATACONDUC(22);


for I=1:Nxc;for J=1:Nyc;Xc(I)=(I-1)*DX;Yc(J)=(J-1)*DX;end;end;
for I=1:Nxm;for J=1:Nym;Xm(I)=(I-1)*DX;Ym(J)=(J-1)*DX;end;end;
for I=1:Nxr;for J=1:Nyr;Xr(I)=(I-1)*DX;Yr(J)=(J-1)*DX;end;end;

Q=size(XYSENSOR);
NSENSOR=Q(1);

for K=1:NT
    for II=1:NSENSOR
        if XYSENSOR(II,3)==1;XX=XYSENSOR(II,1);YY=XYSENSOR(II,2);NX=Nxc;NY=Nyc;X=Xc;Y=Yc;T=Tc;end;
        if XYSENSOR(II,3)==2;XX=XYSENSOR(II,1);YY=XYSENSOR(II,2);NX=Nxm;NY=Nym;X=Xm;Y=Ym;T=Tm;end;
        if XYSENSOR(II,3)==3;XX=XYSENSOR(II,1);YY=XYSENSOR(II,2);NX=Nxr;NY=Nyr;X=Xr;Y=Yr;T=Tr;end;        
        for I=1:NX-1
            QA=1;
            for J=1:NY-1
                QA=1;
                if ((XX >= X(I))&&(XX <= X(I+1)))
                    if ((YY >= Y(J))&&(YY <= Y(J+1)))
                        %Q=0;
                        TX1=(T(K,I+1,J)-T(K,I,J))/(DX)*(XX-X(I))+T(K,I,J);
                        TX2=(T(K,I+1,J+1)-T(K,I,J+1))/(DX)*(XX-X(I))+T(K,I,J+1);
                        TXY=(TX2-TX1)/(DY)*(YY-Y(J))+TX1;
%                         AA(1,1)=TE(K,II);AA(1,2)=TXY;AA(1,3)=X(I);AA(1,4)=Y(I);
%                         AA
                        SUM=SUM+(TE(K,II)-TXY)^2;
                        QA=-1;
                    end
                end
                if (QA==-1);break;end
            end
            if (QA==-1);break;end
        end
    end
end
ARMS=SUM;