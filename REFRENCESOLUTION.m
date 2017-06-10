function TE=REFRENCESOLUTION(Tc,Tm,Tr,DATACONDUC,zigma,XYSENSOR)
% TE2=0
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
        TE(K,II)=-.1;
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
                        TE(K,II)=TXY;
                        QA=-1;
                    end
                end
                if (QA==-1);break;end
            end
            if (QA==-1);break;end
        end
    end
end
TE2=random('norm',TE,zigma);
a=zigma;
if  (a==0)
    TE=TE2;
else
    for L=1:40
        for II=1:NSENSOR
            for K=2:NT-1
                TE3(K,II)=(TE2(K-1,II)+2*TE2(K,II)+TE2(K+1,II))/4;
            end
            TE3(1,II)=2*TE3(2,II)-TE3(3,II);
            TE3(NT,II)=2*TE3(NT-1,II)-TE3(NT-2,II);
        end
        TE2=TE2;
    end
   TE=TE3;
end