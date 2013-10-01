function [  ] = plot_eyespot( insignal, count_persymbol )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
L = length(insignal);
count = L/count_persymbol;
temp = reshape(insignal',count_persymbol,count);
x = [0:1/(count_persymbol-1):1];
plot(temp,'b');

end

