%% Assignment 4: Ploting and analyzing a magnetic field induction time series
%
% - Answer the questions below by inserting the MATLAB commands you used into
%   the blank space below each question.
%
% - When a question asks for a specific value (e.g., what is the length of vector x)
%   list your answer as a comment by inserting it after a % symbol to the right of
%   the command you used to get the answer. For example:
%   length(x)    %  returns the value 12
%
%   This way, we should be able to run your assignment_4.m script without
%   any errors being returned.
%
%  - For each figure created, save it as a PDF file.
%
% Turn in your assignment by uploading it to GitHub into a directory named
% assignment_4. Make sure you upload the THREE figure PDF files in addition to assignment_4.m
%
%

% 0. Its usually a good idea to start your scripts with a clean workspace,
% so:

    clear all;

%% 1. In this section you will load the data file and examine what it contains.

% 1a. Load the data file (list the command):
datafile=load('Okmok_s00.mat');
info=whos('-file','Okmok_s00.mat');

% 1b. What is the name of the variable that was loaded?
info.name  %variable name is st
  
% 1c. What class type is it?
info.class %class type is struct

% 1d. How many memory bytes does it occupy?
info.bytes  %44238992 Bytes

% 1e. What is the name of the station where this data was collected?
var=datafile.st;  
var
station=var.stationName;     %s00

% 1f. What is the magnetic field component measured and what are the units of the data?
var.component  %'North'
var.units      %units: 'T'

% 1g. What island was this data collected on?
var.latitude  %53.3834
var.longitude %-167.9042  The place locates in Nikolski on Umnak Island, Alaska

% 1h. What is the sampling rate of the time series?
var.samplingFrequency  %128

% 1i. What specific variable is the time series stored in?
var.timeDataStart    %timeDataStart

% 1j. What is the start date and time of the time series? Hint: the
% variable holding the start time uses MATLAB's datenum format.
% Use the command that will convert it to a nicely formated date and time string.
date = datestr(var.timeDataStart);   %return: 04-Jul-2015 05:40:00

%% 2. In this section you will plot the data and add some labels and a title:


% 2a. How many minutes long is the time series?
timelen=(length(var.data)/128)/60;   %720 minutes
%given the sampling frequency as 128, the total length divided by 128 will
%gives the totoal seconds that contains in the data set, the total seconds
%divided by 60 will gives you the total minutes
   

% 2b. Create a vector called minutes that gives the time in units of minutes
% for each sample. The first sample should be at 0.0 minutes.
%minutes=0:0.1:length(datafile.st.data)-1;
len=length(var.data);
minutes=linspace(0.0,timelen-1,len);

% 2c. Plot the magnetic field time series vector versus the minutes vector
% as a blue line. Add labels on the x and y axes for the
% correct units.
fig1=plot(minutes,var.data);

% 2d. Add an informative title to the plot. You can create the string
% using bracket notation:
%
% titleString = ['Station: ' <insert variable> ', Date and Time: ' <insert variable>];
%
% Replace each <insert variable> with the correct variables for the station
% name and the start date and time. Then use this string to make a title on
% the plot.

titleString = ['Station:' station, ';  Date and Time:' date];
title(titleString)
xlabel('time (minutes)')
ylabel('magnetic field induction (T)')

%2e. Save the figure as the file 'timeseries.pdf'. List the command you
%    used below.

saveas(fig1,'timeseries.pdf')

%% 3. In this section you will compute the power spectral density (PSD) of the time series.
% The PSD is often just referred to as the spectrum of the time series. It
% shows the power present in the time series as a function of frequency.
% If you have already taken QMDA, you have already learned about
% power spectra. If not, have a quick read of the wikipedia page for
% Spectral Density.
%

% 3a. How many samples are in 300 seconds of the data?
samples_300s=300*128;  %return 38400, there are 38400 samples in 300 secs of the data

% 3b. Make a vector called first that has the first five minutes of data and another
% vector called last which has the last five minutes of data:
first=var.data(1:samples_300s);
last=var.data(end-(samples_300s-1):end);

% 3c. Create a new time vector called seconds that has time in seconds for
% the first and last vectors. The starting value should be zero. This should
% be similar to what you did in exercise 2b but now for seconds rather than
% minutes.
seconds=linspace(0.0,299,samples_300s);

% 3d. Make a new figure with a subplot grid containing 2 rows x 1 column.
% In the top subplot, plot both the first and last vectors versus the seconds
% vector. Plot first as a blue line and last as a red line. Make sure you label the x
% and y axes with the proper units. Add a legend with the labels 'first 5 minutes'
% and 'last 5 minutes'.
fig2=figure;
subplot(2,1,1);
plot(seconds,first,'blue')
hold on
plot(seconds,last,'red')
legend('first 5 minutes','last 5 minutes')
title('magnetic field induction versus the seconds')
xlabel('time (seconds)')
ylabel('magnetic field induction (T)')

% 3e. Compute the power spectrum of the first and last
% time series vectors. To do this, use the function
% pspectrum.m (which you downloaded above) to compute the PSD
[psd_first, f_first] = pspectrum(first, 128);
[psd_last, f_last] = pspectrum(last, 128);

% 3f. In the 2nd subplot, plot both power spectra using a log scale for
% frequency on the x axis and a log scale for power on the y axis. Again
% use a blue line for the first data and a red line for the last data. Add
% labels for the x and y axis units. Note that the units of the PSD are T^2/Hz.
subplot(2,1,2)
loglog(f_first,psd_first,'blue')
hold on
loglog(f_last,psd_last,'red')
legend('first 5 minutes','last 5 minutes')
title('power spectral density versus the frequency')
xlabel('frequency (Hz)')
ylabel('PSD (T^2/Hz)')

% 3g. Save the figure as file 'first_last_psd.pdf'. But first use the
% command 'orient tall' to tell MATLAB to make the figure fill the
% entire printed page. List the commands you used below.
orient(fig2,'tall')
print(fig2,'first_last_psd.pdf','-dpdf')

% 3h. The broad peaks (bumps) in the spectra around 7.8, 14.3, 20.8, ... Hz are
% the Schumann resonances formed by the energy from lightning strikes
% resonating in the non-conducting cavity between the electrically
% conductive ground and conductive ionosphere about 90 km above. Large
% lightning strikes will excite normal modes in this cavity as the energy
% repeatedly travels around the Earth. Do the Shumann resonances for the
% first and last five minutes of data look similar or different?

     %Answer (3h): According to the last figure (first_last_psd.pdf), the Shumann
     %resonances looks similar for the first and last five minutes, but a
     %little diffeerence at around the frequency of 32.5 Hz

% 3g. What differences do the power spectra show at frequencies below
% 1 Hz?  Does that agree with what the time series shows?
  
  %Answer:
  % At frequency below 1 Hz, the power spectra for the first 5 minutes has
  % smaller power spectra density, while for the last 5 minutes, the power spectra
  % is larger. This indicates that the energy of maganetic field induction
  % data during the last 5 minutes is higher than the first 5 minutes under
  % low frequency (longer time period). This corresponding to what the time series 
  % plot shows that the last 5 minutes' data fluctuate with larger amplitude than the first five minutes' data
  %over longer time period (more clearly observed when time period > 10s ). 
   
    
%% 4. Spectrogram. For many time series, the PSD is non-stationary,
% meaning that it changes over time, like what we saw in exercise 3.
% You can show the time evolution in a nice graphical form by creating a spectrogram,
% which is basically a series of power spectra computed by chopping up
% a time series into small sections and computing the PSD for each section.
% The resulting matrix of PSD's can be shown as a 2D matrix or surface
% plot as a function of time and frequency. In this exercise, you
% will go through the steps to make a spectrogram.


% 4a. We will use 300 second long sections of data for the spectrogram.
% Create a variable called nSamplesPerSection which has the number of time
% series points (i.e. samples) for each 300 s long data section.

nSamplesPerSection=300*128;  %There are 38400 data points within 300 seconds.


% 4b. For an arbitrary section i (where i is an integer), write the commands
% that will give the starting and ending indices of the data for that section
% in the time series. Call them iStart and iEnd.

i=1; %just an example, i could be value from 1 to 144
iStart=(i-1)*nSamplesPerSection+1;
iEnd=iStart+(nSamplesPerSection-1);


% 4c. Given the value in nSamplesPerSection, create a variable called
% nSections that has the total number of sections that will be created by
% chopping up the time series in sections of 300 s length.
nSections=timelen/5;  %There are 144 sections of the total data set, each of them are 5 minutes' long.

% Check your formulas for iStart and iEnd. If you assign i to be the last
% section, does iEnd equal the length of st.data?

i=nSections;
iStart=(i-1)*nSamplesPerSection+1;
iEnd=iStart+(nSamplesPerSection-1);

% 4d. Now its time to put all the pieces together to compute the
% spectrogram. Create a for loop that will compute the PSD for each data section.
% The resulting spectra should be stored in a matrix call PSD_matrix.
% PSD_matrix will have length(f) rows and nSections columns.
%
% Hints: create a for loop over nSections, use iStart and iEnd to
% extract that section of data from st.data, and then compute the power spectrum of
% that section. Insert the resulting spectrum into a column in PSD_matrix.
%
% This will be somewhat computationally intensive. It took a minute to run
% on my laptop. If your for loop variable is i, insert  "disp(i);" inside the
% for loop so you can track its progress while its running.
PSD_matrix=zeros(length(f_first),nSections);
for i = 1:nSections
    iStart=(i-1)*nSamplesPerSection+1;
    iEnd=iStart+(nSamplesPerSection-1);
    [psd_t,~]=pspectrum(var.data(iStart:iEnd), 128);
    PSD_matrix(:,i)=psd_t;
    disp(i);
end

%%
% 4e. Create a new figure and plot the spectrogram using the pcolor command.
% The y axis should be frequency on a log10 scale and the x axis should
% be time in minutes (you will need to create a time vector that represents
% the 5 minute spacing between data sections).
X_a=linspace(1,720,144); %the data set are in total 720 minutes with 144 sections of 5 minutes
Y_a=f_first; %frequency vector that returns for the first 5 minutes data

fig3=figure;
pcolor(X_a,Y_a,log10(PSD_matrix))
shading interp;
caxis([-32 -15]) %tried several ranges and this is the most suitable one
title(titleString)
xlabel('Time (seconds)')
ylabel('frequency (Hz)')
colormap jet;
colorbar;



% Additional instructions:
% - Since the power spectra cover a large dynamic range, use log10(PSD_matrix) inside the pcolor command.
% - Use the "shading" command with one of its options to improve the appearance of the plot
% - Add unit labels to the x and y axis
% - Add a title using the results from exercise 2d.
% - Add a colorbar
% - Experiment with the color limits by using the "caxis" command.


% 4f.  Save the figure as file 'spectrogram.pdf'.
print(fig3,'-dpdf','spectrogram.pdf', '-opengl')