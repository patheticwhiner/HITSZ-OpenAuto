% findwc - 计算系统近似剪切频率及相位裕度
% 目前是直接通过寻找穿越0dB线点的方法来找剪切频率，存在一定误差
% 改进思路：找到该点后确定其所在的转折频率区间，再通过转折频率确定
function [wc,Pm] = findwc(G0s,lgW,L,x)
    if nargin > 3
        L = L - x;
    end
    l1 = L.*[L(2:end),-1];
    dex = find(l1<=0);
    lgwc = (abs(L(dex(1)))*lgW(dex(end))+lgW(dex(1))*abs(L(dex(end))))...
        /(abs(L(dex(1)))+abs(L(dex(end))));
    wc = 10^lgwc;
    Pm = cntPm(G0s,wc);
end