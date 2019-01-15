function [feature,debug] = heart_rate_fft(EKGSignal,fp)
%HEART_RATE_FFT Calculation of heart rate using the fft.
%	
%	Syntax
%
%	  [feature,debug] = heart_rate_fft(EKGSignal,fp)
%
%  Description
%
%    HEART_RATE_FFT is a feature extraction function that calculates the heart 
%     rate from an EKG signal. It uses the fft to perform the calculation.
%     
%	  HEART_RATE_FFT(EKGSignal,fp) takes the following parameters,
%	    EKGSIGNAL - structure containing the following fields:
%                     leads i, ii, iii, v1, v2, v3, v4, v5, v6, avr, avf,
%                       avl, vx, vy, vz
%                     info.fs - sampling frequency
%	    FP - Struct of function parameters (ignored for this function).
%    and returns,
%      FEATURE  - Structure of features, names and descriptions. The fields are
%                   feature.value(1) = heart rate
%                   feature.name{1} = 'hrtrate'
%                   feature.desc{1} = 'heart rate'
%      DBUG     - Structure of information that can be used for debugging
%                   debug.yf = fft of lead i
%	
%	Example
%
%	  Here is code for calculating the heart rate for a simple sine wave.
%     This sine wave is 4 Hz.
%
%       signal.info.fs = 1000;
%       ind=1:10000;
%       signal.i = sin(2*pi*ind/250);
%	    [feature,debug] = heart_rate_fft(signal);
%
%
%	Algorithm
%
%     HEART_RATE_FFT uses the fast Fourier transform to calculate the heart rate. 
%     It performs an FFT of the signal and then locates the peak.
%
%	See also RR_INTERVAL_WAV.

% SAID Toolbox Component



% Use lead i as the signal for heart rate computation
Lead1Signal = EKGSignal.i;
fs = EKGSignal.info.fs;
N = length(Lead1Signal);
T = N/fs;  % length of signal in seconds

% Perform the fft
yf=fft(Lead1Signal);

% Find the maximum point in the magnitude of the fft 
% Ignore the DC component, and values higher than the Nyquist frequency
[maxf,ind]=max(abs(yf(2:end/2)));

% Convert to Hz
HeartRate = ind/T;

feature.value = [HeartRate];
feature.name = {'hrtrate'};
feature.desc = {'heart rate'};
debug.yf = yf;

