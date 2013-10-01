function [ outsignal ] = SSMF_Dispersion( insignal, center_wl, fs, TransL )
%Simulate the dispersion on a SSMF
%   insignal: Input Vector Signal

la_model = [1200,1250,1300,1350,1400,1450,1500,1550,1600];
D_model  = [-10 ,-4  ,1   ,4   ,2.5 ,11  ,13  ,16  ,18  ];
a = polyfit(la_model,D_model,2);
D = polyval(a,center_wl);
disp('Dispersion:');
disp(D);
clear la_model D_model a;

L = length(real(insignal));

f = 3*10^17/center_wl;
f = f + fs / 2 * 10^9;
dla = center_wl - 3*10^17/f;
dt_max = dla * D * TransL;
dp_max = dt_max * 10^(-12) * fs/2 * 10^9 * 2*pi;
disp(dp_max);
sfft = fft(insignal);

co = 1:(L/2-1);
co = co.^2;
co = co / max(co) * dp_max;

tmpL = L/2-1;
sfft(2:tmpL+1) = sfft(2:tmpL+1) .* exp(-1j * co);
co = rot90(co,2);
sfft(tmpL+3:L) = sfft(tmpL+3:L) .* exp(-1j * co);

outsignal = ifft(sfft);

end

