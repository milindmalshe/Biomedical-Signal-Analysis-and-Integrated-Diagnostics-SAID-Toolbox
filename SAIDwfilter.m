function [signal_filtered_arch] = SAIDwfilter(filter_arch,P_filter)
wavestr = filter_arch.wavestr;
SORH = filter_arch.SORH;
y = P_filter;
scale = filter_arch.scale;
N = filter_arch.N;
T = filter_arch.T;
[C,L] = wavedec(y,scale,wavestr);
Apr = wrcoef('a',C,L,wavestr,scale);
for i=1:scale
    D(i,:) = wrcoef('d',C,L,wavestr,i);
end
NC = wthcoef('t',C,L,N,T,SORH);
NC = wthcoef('a',NC,L);
for i=1:scale
    ND(i,:) = wrcoef('d',NC,L,wavestr,i);
end
signal_filtered_arch = waverec(NC,L,wavestr);