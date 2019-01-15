function [feature,dbug] = rr_interval_wav(EKGSignal,fp)
%RR_INTERVAL_WAV Calculation of RR interval and related statistics of an EKG signal
%            using wavelet transforms.
%	
%	Syntax
%
%	  [feature,debug] = rr_interval(EKGSignal,fp)
%
%  Description
%
%    RR_INTERVAL_WAV is a feature extraction function that calculates the
%    RR 
%     interval of an EKG signal. It also calculates the mean, standard deviation,
%     minimum and maximum value of the RR interval over the length of
%     the EKG signal.  This function uses the CWT function from the 
%     wavelet toolbox.
%     
%	  RR_INTERVAL_WAV(EKGSignal,fp) takes one function parameter,
%	    EKGSIGNAL - structure containing the following fields:
%                     leads i, ii, iii, v1, v2, v3, v4, v5, v6, avr, avf,
%                       avl, vx, vy, vz
%                     info.fs - sampling frequency
%	    FP - Struct of function parameters (ignored for this function).
%    and returns,
%      FEATURE  - Structure of features, names and descriptions. The fields are
%                   feature.value(1) = average RR interval
%                   feature.value(2) = standard deviation of RR intervals
%                   feature.value(3) = minimum RR interval
%                   feature.value(4) = maximum RR interval
%                   feature.name{1} = 'avRRint'
%                   feature.name{2} = 'stdRRint'
%                   feature.name{3} = 'minRRint'
%                   feature.name{4} = 'maxRRint'
%                   feature.desc{1} = 'average RR interval'
%                   feature.desc{2} = 'standard dev of RR interval'
%                   feature.desc{3} = 'minimum RR interval'
%                   feature.desc{4} = 'maximum RR interval'
%      DEBUG     - Structure of information that can be used for debugging
%                   debug.Rpeaks = sequence of locations of peaks in R wave
%	
%	Example
%
%	  Here is code for calculating the RR statistics for a simple sine wave.
%     This sine wave is 4 Hz, so the RR interval should be 0.25.  
%
%       signal.info.fs = 1000;
%       ind=1:10000;
%       signal.i = sin(2*pi*ind/250);
%	    [feature,debug] = rr_interval_wav(signal);
%
%
%	Algorithm
%
%     RR_INTERVAL_WAV uses the continuous wavelet transform to detect local 
%     R peaks in the EKG signal. For detailed information, please refer to the
%     following paper:
%
%
%	See also QT_INTERVAL.

% SAID Toolbox Component



if exist('cwt')~=2,
    error('The Wavelet Toolbox must be installed to use the function.')
end

% Use lead i as the signal for RR computation
Lead1Signal = EKGSignal.i;
fs = EKGSignal.info.fs;
scale = 14;
N = length(Lead1Signal);

% Perform the continuous wavelet transform
cof = cwt(Lead1Signal,scale,'mexh');
PeakMax = max(cof(200:N-200));

k = 1;
Rpeaks = 0;
Qpoints = 0;

for i = 1:1:N
    l = 1;
    if (cof(i)<=PeakMax)&(cof(i)>=0.4*PeakMax)
        if (i-1)<50 | (i+1)> N-50
            continue;
        end
        while (cof(i+1)<cof(i))&(cof(i-1)<cof(i))            
            if(k>=2)
                if(i-Rpeaks(k-1))< 0.2*fs
                    break;
                end
            end            
            Rpeaks(k) = i; 
            while cof(i-l-4) <= cof(i-l)
                if (i-l)<50
                    break;
                end
                l=l+1;
            end
            if l == 1
                break;
            else
                Qpoints(k) = i-l-20;
                k = k+1;
            end
        end
    end
end

RR = diff(Rpeaks)/fs;
feature.value = [mean(RR), std(RR), min(RR), max(RR)];
feature.name = {'avRRint','stdRRint','minRRint','maxRRint'};
feature.desc = {'average RR interval','standard dev of RR interval','minimum RR interval','maximum RR interval'};
dbug.Rpeaks = Rpeaks;

