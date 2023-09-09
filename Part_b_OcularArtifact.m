%%%  Part-B Counting Detect Blinks Total 55pts
%%% First we load the data into workspace environment
% load VEPdata3.mat 
load VEPdata3.mat
%Set hLen to the length of filter h
hLen=length(h); 
%% Plotting EEGdata and a threshold line
% In this part we are going to use a new data containing blinks. 
 %plot the EEGdata and inspect to find a optimum threshold level to detect
%the eye blinks
plot(EEGdata); axis('tight') %plot EEGdata
hold on;
%Choose a threshold and create a threshold line vector
threshold=20
% thresholdLine=
%plot the threshold line, red color,
yline(threshold,'r','Threshold');legend('EEGdata','threshold');
%plot(threshold,'r')
title('Thresholding based ocular blink detection'), xlabel('Time (sec)'), ylabel('Amplitude(µA)');
%count the totalnumber of blinks using EEGdata,  threshold and filter window
total_blink_count=CountBlinks(EEGdata,threshold,hLen)
%% Now compute the magnitude spectrum of the EEGdata 
% find the frequency resolution dfx and plot the spectrum for 
% create a frequency x axis, and plot EEGdataSpec for frequencies: 0 - 40Hz
f=0:3.1002e-04:40;
EEGdataSpec=abs(EEGdata);
figure(2);
plot(f,EEGdataSpec);legend('EEGdataSpec')
title('Magnitude spectrum of the EEGdata'), xlabel('Frequency (Hz)'), ylabel('Magnitude(µA)');
%% Now Filter the signal to enhance the blinks
% Design a filter to be able to suppress the EEG signal except keeping
% the blinkings in the signal.  You are supposed to observe the EEG and
% decide on the filter characteristics by yourself, at least stop band attenuation of
% 45dB is desired
% Find the filter order and filter type 
Forder=2;
% decide on cut off frequency
fcut=15;fs=2000; %Ocular artifacts contaminate the EEG in the band ranging from 0 to 15 Hz;fs=2000;
%find the filter coefficients
[Fnum,Fdenum] =butter(Forder,fcut/(fs/2),'low');
% %visualize the filter using the freqz() or fvtool() functions
% %Filter the EEGdata and set it to EEGfiltered  
EEGfiltered=filter(Fnum,Fdenum,EEGdata);
freqz(Fnum,Fdenum,[],fs);
figure(3);
%create a two row plot and select the first row plot
subplot(2,1,1)
%select a proper threshold to detect the blinks
threshold=40;
% %Create a red threshold line and plot
% thresholdLine=
% % plot the threshold line
% plot()
yline(threshold,'r','Threshold');
hold on; 
% %plot EEGdata in black
plot(EEGdata,'black');axis('tight');
title('Unfiltered EEG Signal'), xlabel('time'), ylabel('Amplitude(µA)')
% select the second row plot
subplot(2,1,2)
% plot the EEGfiltered in blue
plot(EEGfiltered,'blue');axis('tight');
hold on; 
% % plot the threshold line again in red
% plot()
yline(threshold,'r','Threshold');
title('EEG filtered Signal'), xlabel('time (sec)'), ylabel('Amplitude(µA)');
% Detect the number of blinks using the EEGfiltered threshold and window
% length of hLen
total_blink_count2=CountBlinks(EEGdata,threshold,hLen)
%Compare the blink counts
% figure(6)
% plot(EEGdata,'black'); hold on;
% plot(EEGfiltered,'blue'); axis('tight');
%% Find the spectrum of the EEGfiltered
EEGfilteredSpec=abs(EEGfiltered);
figure(4);
% create a 2 row plot and select first row plot
subplot(2,1,1)
% create a frequency x axis and plot the EEGdataSpec  for the 0-40Hz 
plot(f,EEGdataSpec); legend('EEGdataSpec');
title('EEGdata unfiltered Magnitude spectrum'); xlabel('Frequency (Hz)'); ylabel('Magnitude(µA)');
% select second row plot
subplot(2,1,2)
% plot the EEGfilteredSpec for the 0-40Hz using the same frequency x axis
% already created
plot(f,EEGfilteredSpec);legend('EEGfilteredSpec');
title('EEGdata filtered Magnitude spectrum'); xlabel('Frequency (Hz)'); ylabel('Magnitude(µA)');
