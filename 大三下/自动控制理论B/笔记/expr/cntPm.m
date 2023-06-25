% cntPm - 计算传递函数在频率点wc处的相位裕度
% Pm = cntPm(G0,wc)
function [Pm] = cntPm(G0,wc)
    syms s w real;
    Gs = tf2sym(G0);
    Gw = subs(Gs, s, 1i*wc);
    Pm = angle(double(Gw))*180/pi;
    if Pm > 90
        Pm = Pm - 180;
    else
        Pm = Pm + 180;
    end
end