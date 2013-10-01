clc;
clear all;
close all;

signal = zeros(1,4000);
signal(2000:2003)=1;

signal = fft(signal);
signal(1500:2500)=0;
signal = ifft(signal);

out = SSMF_Dispersion( signal, 1550, 40 , 100 );
figure;
plot(real(out));


out = Dispersion_Compensate( out, 1550, 40 , 100 );
figure;
plot(real(out));

