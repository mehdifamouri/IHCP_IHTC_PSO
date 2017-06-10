function Hin2=HINTERFACE2(K,DT,P)

t=(K-1)*DT;
Hin2=P(3)*t^(P(4));
% if t<150
%     Hin2=P(3)*t+P(4);
% else
%     Hin2=P(3)*150+P(4);
% end
