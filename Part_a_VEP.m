%%% Digital Processing of Biomedical Signals
%% First we load the data into workspace environment
load VEPdata1.mat
%%% Visualatizaton of EEG Data %%%%%%%%%%%%%%%%%%%%%%%
%%% Data is loaded, Sampling frequency is fs=2000Hz, 
fs=2000;
t=0:1/fs:10;% Create a time vector t of 10s t=Tstart:timeStep(sampling period):Tend
%Plot 10sec of data on the y axis and time on the x axis you can use plot()
plot(t,EEGdata(1:20001)); legend('EEG data') % taking 20001 samples of the EEGdata
%Title the graphics title('10s of EEG data')
title('10s of EEG data');
%label the x and y axis as time(s) and amplitude(µA)
xlabel('time(s)');
ylabel('amplitude(µA)');
%% Stimulation sequence %%%%%%%%%%%%%%%%%%%%%
hLen=length(h);% length of the filter h and assign to hLen
% create a time vector t_h to plot the time of the filter h using the
% sampling period and the number of points in filter
t_h=0:0.5:507.5; %taking sampling period ts=1/fs=1/2khz=0.5ms as fs=2kHz
% % plot the stimulus filter sequence h with respect to time t_h using stem() 
stem(t_h,h); axis('tight'); legend('stimulus filter sequence')
%Title the graphics title('Stimulus filter sequence ')
title('Stimulus filter sequence');
%label the x and y axis as time(s) and amplitude(µA)
xlabel('time(ms)'); ylabel('amplitude(µA)');
%% Synchronous Averaging %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Nr=hLen;
% Finding the number columns Nc is easy
Nc=128;
% Now reshape the EEGdata into EEG_segments by hLen points of segment in columns 
EEG_segments=reshape(EEGdata,Nr,Nc)
%create anew figure;
figure(2);
% Now assign one of the segments of EEG_Segments as EEG_1 and plot to
% visualize the EEG containing one convolved VEP response 
EEG_1=EEG_segments(1:1016,1);
plot(t_h,EEG_1); axis('tight');
title('Synchronous Averaging'), xlabel('time(ms)'), ylabel('amplitude(µA)') 
% hold on the plot and now plot the average segment signal of all the
% EEG_segments you can use the mean function to get the average signal use mean(...,2)
% Create a VEPaverage signal by taking the average of the EEG segments 
hold on;
VEPconvAve=mean(EEG_segments,2)
plot(t_h,VEPconvAve);legend('EEG Segments','VEPconvAve');
%%%%%%% Here explain the difference between these two signals on the figure
% In the picture the first difference is frequencies and the VEPconvAve
% signal has low amplitude as compere to EEG_1 signal due to Averaging
%% Frequency Spectrums
% Nbin=70.87/1016 
f=0:0.0698:70.87; % 1016 points are need to show the EEG_1 because EEG_1 has vector with 1016 points
%15pts
EEG_1Spec=abs(EEG_1);
%Create a new figure 
figure(3);
%Plot the computed spectrum using the stem() function for thefrequency range 0 - 70.87Hz on top row of the figure. 
subplot(2,1,1);
stem(f,EEG_1Spec);xlim([0 70.87]);
title('Magnitude of EEG1 VS frequency [0-70.87Hz]') , xlabel('Frequency (Hz)'), ylabel(' Absolute Magnitude(µA)');
% Repeat the above step for the VEPconvolved average signal.
% Can you use the same frequency vector for the x axis? (yes)
subplot(2,1,2);
VEPconvAveSpec=fft(VEPconvAve);
stem(f,abs(VEPconvAveSpec));xlim([0 70.87]);
title('VEP convolved Average Spectrum') , xlabel('Frequency (Hz)'), ylabel('Magnitude');