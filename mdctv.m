function y = mdctv(x)
% MDCTV Calculates the Modified Discrete Cosine Transform in a vectorized way
%   Use either a Sine or a Kaiser-Bessel Derived window (KBDWin)with 
%   50% overlap for perfect TDAC reconstruction.
%   Remember that MDCT coefs are symmetric: y(k)=-y(N-k-1) so the full
%   matrix (N) of coefs is: yf = [y;-flipud(y)];
%
%   x: input signal (can be either a column or frame per column)
%   y: MDCT of x

% ------- mdctv.m ------------------------------------------
% Marios Athineos, marios@ee.columbia.edu
% http://www.ee.columbia.edu/~marios/
% Copyright (c) 2002 by Columbia University.
% All rights reserved.
% ----------------------------------------------------------

[flen,fnum] = size(x);
% Make column if it's a single row
if (flen==1)
    x = x(:);
    flen = fnum;
    fnum = 1;
end
% Make sure length is even
if (rem(flen,2)~=0)
    error('MDCT is defined only for even lengths.');
end

% We need these for furmulas below
windowLen  = flen;    % Length of window
coefLen  = windowLen/2;     % Number of coefficients
N0 = (coefLen+1)/2;

% Create the transformation matrix
[n,k] = meshgrid(0:(windowLen-1),0:(coefLen-1));
T = cos(pi*(n+N0).*(k+0.5)/coefLen);
clear k n;

% So the MDCT is simply !!!
y = T*x;

end