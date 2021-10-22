A=0.5; %Amplitude 0.5V
Fc=10; %Frequency 10Hz
Phase=30;
Fs=32*Fc;
T=1/fs;
t=0:T:2-T;
phi=Phase*pi/180;
g=A*cos(2*pi*Fc*t+phi);

subplot(3,3,1);
plot(t,g);
ylim([-0.8 0.8]);
xlim([0 2.2]);
xlabel('Time');
ylabel('Amplitude');
title('Cosine Wave');

subplot(3,3,2);
N=256;
X=1/N*fftshift(fft(g,N)); %N-point complex DFT
magni=abs(X);
Fr=(0:N-1)*Fs/N;
plot(Fr,magni);
xlabel('Frequency');
ylabel('Magnitude');
title('N point Complex DFT');

subplot(3,3,3);
stem(Fr,magni);
xlabel('Frequency');
ylabel('Magnitude');
title('N point Complex DFT');
subplot(3,3,4);
df=Fs/N; %frequency resolution
sampleIndex = -N/2:N/2-1; %ordered index for FFT plot
f=sampleIndex*df; %x-axis index converted to ordered frequencies
stem(f,magni); %magnitudes vs frequencies
xlabel('f (Hz)');
ylabel('|X(k)|');
title('Magnitude spectrum');
subplot(3,3,5);
phase=atan2(imag(X),real(X))*180/pi; %phase information
plot(f,phase); %phase vs frequencies
title('phase');
subplot(3,3,6);
X2=X;%store the FFT results in another array
%detect noise (very small numbers (eps)) and ignore them
threshold = max(abs(X))/10000; %tolerance threshold
X2(abs(X)<threshold)=0;%maskout values below the threshold
phase=atan2(imag(X2),real(X2))*180/pi; %phase information
stem(f,phase); %phase vs frequencies
xlabel('Frequency');
ylabel('Phase');
title('Phase Spectrum');
%Reconstruction of signal
subplot(3,3,7);
x_recon = N*ifft(ifftshift(X),N); %reconstructed signal
t_1 = [0:1:length(x_recon)-1]/Fs; %recompute time index
plot(t_1,x_recon);%reconstructed signal
xlabel('Time');
ylabel('Amplitude');
title('Reconstructed Signal X(t)');

