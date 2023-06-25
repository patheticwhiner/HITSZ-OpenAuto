%% 期望频率特性法，中高频段设计比较
close all, clear; clc;
s = tf('s');
G0 = 70/(s*(0.12*s+1)*(0.02*s+1));
Gc1 = (0.25*s+1)*(0.12*s+1)/((1.35*s+1)*(0.022*s+1));
Gc2 = (0.25*s+1)*(0.12*s+1)/((1.35*s+1)*(0.029*s+1));
Gc3 = (0.25*s+1)*(0.12*s+1)/((1.35*s+1)*(0.02*s+1));
Gc4 = (0.25*s+1)*(0.12*s+1)/(1.35*s+1);
figure;
% subplot(2,2,1);
draw_bode(3,G0,Gc1);
figure
% % subplot(2,2,2);
draw_bode(3,G0,Gc2);
figure
% subplot(2,2,3);
draw_bode(3,G0,Gc3);
figure
% % subplot(2,2,4);
draw_bode(3,G0,Gc4);