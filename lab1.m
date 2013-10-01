clc;
close all;
clear all;

signal0 = zeros(1,40000);
a = rand(1,1000);
a = floor(a*4);
a = a * 2 -3;
for i = 1:length(a)
    signal0(i*40-39:i*40) = a(i);
end

signal1 = zeros(1,4000);

a1 = rand(1,1000);
a1 = floor(a1*4);
a1 = a1 * 2 -3;
for i = 1:length(a1)
    signal1(i*40-39:i*40) = a1(i);
end

signal = signal0+1i*signal1;

FFT = fft(signal);
FFT(1000:39000)=0;
signal = ifft(FFT);

out = SSMF_Dispersion( signal, 1550, 1600, 20 );
out = awgn(out,30);

subplot(2,2,1);
plot_eyespot(real(out),8);
subplot(2,2,2);
plot_eyespot(imag(out),8);

out1 = Dispersion_Compensate( out, 1550, 1600, 20);

subplot(2,2,3);
plot_eyespot(real(out1),80);
subplot(2,2,4);
plot_eyespot(imag(out1),80);