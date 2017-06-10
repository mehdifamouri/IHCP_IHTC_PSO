load
format long eng
ng=200
AK=k+1

for k=AK:ng
    %======================================================================
    w=(wmax-wmin)/(1-ng)*(k-ng)+wmin;
    c1=(cmax-cmin)/(1-ng)*(k-ng)+cmin;
    c2=c1;
    if fix(k/5)== k/5
        w=wmax;
        c1=cmax;
        c2=cmax;
    end

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


