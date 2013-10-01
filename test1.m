clc;
close all;
clear all;

center_wl = 1550;
TransL = 100;
fs = 1000;
L = 10000;

la_model = [1200,1250,1300,1350,1400,1450,1500,1550,1600];
D_model  = [-10 ,-4  ,1   ,4   ,2.5 ,11  ,13  ,16  ,18  ];
a = polyfit(la_model,D_model,2);
D = polyval(a,center_wl);
disp('Dispersion:');
disp(D);
clear la_model D_model a;


f = 3*10^17/center_wl;
f = f + fs / 2 * 10^9;
dla = center_wl - 3*10^17/f;
dt_max = dla * D * TransL;
dp_max = dt_max * 10^(-12) * fs/2 * 10^9 * 2*pi;
disp(dp_max);

sfft = ones(1,L);

co = 1:(L/2-1);
co = co.^2;
co = co / max(co) * dp_max;

tmpL = L/2-1;
sfft(2:tmpL+1) = sfft(2:tmpL+1) .* exp(1j * co);
co = rot90(co,2);
sfft(tmpL+3:L) = sfft(tmpL+3:L) .* exp(1j * co);
sfft(1000:9000)=0;
outsignal = ifft(sfft);
co = outsignal(1:1024);

signal = zeros(1,10000);
signal(5000:5100) = 1;
signal = fft(signal);
signal(1000:9000)=0;
signal = ifft(signal);
ori = signal;
figure;
plot(real(signal));

out = SSMF_Dispersion( signal, 1550, 1000, 100 );

out1 = filter(co,1,out);

hold on;
plot(real(out1));
plot(real(ori),'g');
