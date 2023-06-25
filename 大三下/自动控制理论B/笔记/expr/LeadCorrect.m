% LeadCorrect - 串联超前校正
% Gc = LeadCorrect(G0,we,ye,method)
% G0 tf形式传递函数
% we 期望的剪切频率（下限）
% ye 期望的相位裕度（下限）
% method 串联超前校正的方法
%   case 1：相角裕度优先
%   case 2：剪切频率优先
%   case 3：相角裕度优先修正

function Gc = LeadCorrect(G0,we,ye,method)
    [lgW,L] = genbode(G0);
    [wc,Pm] = findwc(G0,lgW,L);
    fprintf('计算实际的剪切频率和对应的相位裕度...\n');
    switch method
        case 1
            fprintf('相角裕度优先校正\n剪切频率:%.2f\t 相位裕度: %.2f\nye-Pm: %.2f\n',wc,Pm,ye-Pm);
            delta = input('输入附加相角delta: ');
            pm = ye - Pm + delta;
            a = (1 + sin(pm*pi/180))./(1 - sin(pm*pi/180));
            % 寻找bode图与-10lg(a)的交点
            [wc1,~] = findwc(G0,lgW,L,-10*log10(a));
            % 解出时间常数
            T = 1./(wc1.*sqrt(a));
        case 2
            dex = abs(lgW-log10(we))<0.01;
            ldex = L(dex);
            a = (10^(ldex(end)/20)).^(-2);
            pm = asin((a-1)/(a+1))*180/pi;
            fprintf('剪切频率优先超前校正设计\n剪切频率:%.2f\t 相位裕度: %.2f\n pm: %.2f\tye-Pm: %.2f\n',wc,Pm, pm, ye-Pm);
            T = 1./(we.*sqrt(a));
        case 3
            Pm = cntPm(G0,we);
            fprintf('相角裕度修正校正\n剪切频率:%.2f\t 相位裕度: %.2f\nye-Pm: %.2f\n',wc,Pm,ye-Pm);
            delta = input('输入所需要的delta: ');
            pm = ye - Pm + delta;
            a = (1 + sin(pm*pi/180))./(1 - sin(pm*pi/180));
            [wc1,~] = findwc(G0,lgW,L,-10*log10(a));
            T = 1./(wc1.*sqrt(a));
    end
    num = [a.*T 1];
    den = [T 1];
    Gc = tf(num,den);
end