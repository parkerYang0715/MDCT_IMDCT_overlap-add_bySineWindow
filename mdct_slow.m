function y = mdct_slow(x)
% MDCTL Calculates the Modified Discrete Cosine Transform using loops
%   Use either a Sine or a Kaiser-Bessel Derived window (KBDWin)with 
%   50% overlap for perfect TDAC reconstruction.
%   Remember that MDCT coefs are symmetric: y(k)=-y(N-k-1) so the full
%   matrix (N) of coefs is: yf = [y;-flipud(y)];

%   x: input signal (can be either a column or frame per column)
%   y: MDCT of x
%  Naive with three nested loops. 
%  Fwd: mdctl.m (https://www.ee.columbia.edu/~marios/mdct/mdctl.m), 
%  Inv: imdctl.m (https://www.ee.columbia.edu/~marios/mdct/imdctl.m)

% Marios Athineos, marios@ee.columbia.edu  % http://www.ee.columbia.edu/~marios/
% Copyright (c) 2002 by Columbia University.  % All rights reserved.

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
N0 = (coefLen+1)/2; % Used in the loop

% Frame loop
for i=1:fnum
    % Coefficient loop
    for k=0:(coefLen-1)
        % Initialize
        y(k+1,i) = 0;
        % Sample loop
        for n=0:(windowLen-1)
            y(k+1,i) = y(k+1,i) + x(n+1,i)*cos(pi*(n+N0)*(k+0.5)/coefLen);
        end
    end
end

end