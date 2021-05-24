clear;clc;

[audioIn,Fs] = audioread('Queen-AnotherOneBitestheDust_CUT.wav');
audioIn=audioIn(:,1);

[lengthSignal,~] = size(audioIn);
t=[0:lengthSignal-1]/Fs;

hopLength = 256 ;
windowSize =2*hopLength; 

frameDuration = windowSize/Fs
FrameNumber = ceil(lengthSignal/hopLength);  

%% pad before and after signal
TotalLength = hopLength * FrameNumber;
diff = TotalLength - lengthSignal;
sig =zeros(TotalLength,1);
offset = floor(diff/2);
if offset>0
    sig(1+offset:offset+lengthSignal,1) = audioIn;
    clear audioIn
else
    clear sig;
    sig = audioIn;
    clear audioIn
end


%% apply sine window
ww = (0:(windowSize-1)).';
win = sin(pi*(ww+0.5)/windowSize);

MDCTcoef = zeros(windowSize/2,FrameNumber);
windowFrame = zeros(windowSize,FrameNumber);
for k = 2:FrameNumber
    windowFrame(:,k-1) = win.*sig( k*hopLength-windowSize+1 : k*hopLength,1);
end

MDCTcoef = mdctv(windowFrame);
x_imdct = imdctv(MDCTcoef);

%% window before overlap
for k=1:FrameNumber
    win_x_imdct(:,k) = win.*x_imdct(:,k);
end

%% overlap
x_out = zeros(TotalLength,1);
for k = 2:FrameNumber
    for m = 1:hopLength %windowSize/2
        x_out((k-1)*hopLength+m,1) = win_x_imdct( hopLength+m,k-1)+win_x_imdct( m,k);
    end
end

sound(x_out,Fs)