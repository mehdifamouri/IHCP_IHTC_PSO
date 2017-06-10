function Hin=HINTERFACE(K,DT,P)
t=(K-1)*DT;
 Hin=P(1)*t^(P(2));
% if t<150
%     Hin=P(2)*t+P(1);
% else
%     Hin=P(2)*150+P(1);
% end