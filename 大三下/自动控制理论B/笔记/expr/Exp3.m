%% 3.9 迟后优先 迟后-超前
clear; clc; close all;
s = tf('s');
G0 = 180/(s*(s/6+1)*(s/2+1));
ye = 40; we = 3.5;
% 迟后将目标剪切频率略小于要求
Gc1 = LagCorrect(G0,2.5,ye,1);
Gc2 = LeadCorrect(G0*Gc1,we,ye,3);
draw_bode(1,G0,Gc1,Gc1*Gc2);

%% 3.10 超前优先、迟后提高稳态精度
clear; clc; close all;
s = tf('s');
% G0 = 100/(s*(0.1*s+1)*(0.01*s+1));
% ye = 40; we = 20;
G0 = 100/(s*(s+1)*(0.02*s+1));
ye = 40; we = 0.6;
% 开环增益下调越多，剪切频率越小，相位裕度越大
% beta = 100/20;
beta = 100/0.3
G0 = G0/beta;
% 超前校正
[lgW,L] = genbode(G0);
Pm = cntPm(G0,we);
fprintf('未校正系统\n相位裕度: %.2f\tye-Pm: %.2f\n',Pm,ye-Pm);
% delta1 = input('输入所需要的delta1: ');
pm = 45;
a = (1 + sin(pm*pi/180))./(1 - sin(pm*pi/180));
[wc,~] = findwc(G0,lgW,L,-10*log10(a));
T = 1./(wc.*sqrt(a));
num = [a.*T 1];
den = [T 1];
Gc1 = tf(num,den);
% 迟后校正
t = 10./(wc);
num = [t 1];
den = [beta.*t 1];
Gc2 = beta*tf(num,den);

draw_bode(3,G0,Gc1,Gc1*Gc2);

%% 3.10 超前优先、迟后降低剪切频率
clear; clc; close all;
s = tf('s');
G0 = 100/(s*(0.1*s+1)*(0.01*s+1));
ye = 40; wcl = 20;
% 此处目标wc不应该取得离目标太远
we = wcl+5;
Pm = cntPm(G0,we);
fprintf('未校正系统\n相位裕度: %.2f\tye-Pm: %.2f\n',Pm,ye-Pm);
% delta1 = input('输入所需要的delta1: ');
delta1 = 7;
delta2 = 6;
pm = ye - Pm + delta1 + delta2;
a = (1 + sin(pm*pi/180))./(1 - sin(pm*pi/180));
T = 1./(we.*sqrt(a));
num = [a.*T 1];
den = [T 1];
Gc1 = tf(num,den);
% 迟后校正
[lgW,L] = genbode(G0*Gc1);
dex = abs(lgW-log10(we))<0.01;
ldex = L(dex);
b = 10^(ldex(end)/20);
t = 10./(we);
num = [t 1];
den = [b.*t 1];
Gc2 = tf(num,den);

draw_bode(3,G0,Gc1,Gc1*Gc2);