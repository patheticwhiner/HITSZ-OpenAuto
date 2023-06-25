%% 例题3.2 
clear; clc; close all;
s = tf('s');
G0 = 100/(s*(0.1*s+1));
wcl = 40; ye = 45; 
% 相角优先
Gc1 = LeadCorrect(G0,wcl,ye,1)
figure; draw_bode(1,G0,Gc1);
% 频率优先
we = 45;
Gc1 = LeadCorrect(G0,we,ye,2)
figure; draw_bode(3,G0,Gc1);

%% 例题3.3
clear; clc; close all;
s = tf('s');
G0 = 1000/(s*(0.1*s+1)*(0.001*s+1));
wcl = 165; ye = 45; 
% 相角优先
Gc1 = LeadCorrect(G0,wcl,ye,1)
figure; draw_bode(1,G0,Gc1);
% 频率优先
we = 180;
Gc1 = LeadCorrect(G0,we,ye,2)
figure; draw_bode(1,G0,Gc1);

%% 例题3.4
clear; clc; close all;
s = tf('s');
G0 = 10/(s*(0.05*s+1)*(0.25*s+1));
wcl = 10.5; ye = 45; 
% 相角优先
Gc1 = LeadCorrect(G0,wcl,ye,3)
figure; draw_bode(1,G0,Gc1);
% 频率优先
we = 15;
Gc1 = LeadCorrect(G0,we,ye,2)
figure; draw_bode(1,G0,Gc1);
