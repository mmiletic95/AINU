function [ signal ] = createSignal(F,numberOfHarmonics,duration,Fs,step)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
t=0:1/Fs:duration;
signal=0;
if numberOfHarmonics>0
    for i=1:step:numberOfHarmonics
        signal=signal+cos(2*pi*i*F*t);
    end
end

