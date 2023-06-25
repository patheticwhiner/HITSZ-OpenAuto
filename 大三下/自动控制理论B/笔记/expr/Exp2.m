%% 例题3.6
clear; clc; close all;
s = tf('s');
G0 = 100/(s*(0.1*s+1));
we = -1; ye = 50; 
% 相角优先校正
Gc = LagCorrect(G0,we,ye,1)
figure; draw_bode(1,G0,Gc);

%% 例题3.7 
clear; clc; close all;
s = tf('s');
G0 = 25/(s*(0.1*s+1)*(0.2*s+1));
wcl = 2.5; ye = 40; 
% 频率优先
Gc2 = LagCorrect(G0,wcl,ye,2)
figure; draw_bode(1,G0,Gc2);
% 相角优先
Gc1 = LagCorrect(G0,wcl,ye,1)
figure; draw_bode(1,G0,Gc1);

%% 例题3.8 提高稳态精度
clear; clc; close all;
s = tf('s');
G0 = 100*(0.05*s+1)/(s*(0.1*s+1)*(0.01*s+1));
% 没有两个常用指标，只给了增益要求
[wc0, ~] = boder(G0);
beta = 5;
t = 10/wc0;
num = beta.*[t 1];
den = [beta.*t 1];
Gc = tf(num,den);
figure; draw_bode(1,G0,Gc);

