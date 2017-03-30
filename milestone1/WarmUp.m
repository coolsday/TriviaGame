close all
clear all
clc

%load the sound sample
[y, Fs] = audioread('laser.wav');
%y contains the sound samples in stereo
%Fs is the number of samples per second
y = y(:,1); %turn into mono sound

%TOGGLE SYSTEM PARAMETERS HERE
echoGain = 0.3;
echoDelay = 0.25; %in seconds

%pass the sound clip through the echo system
echoY = echoSystem(y, echoDelay*Fs, echoGain);

sound(echoY,Fs);