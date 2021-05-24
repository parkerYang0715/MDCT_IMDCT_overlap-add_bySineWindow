function y = imdct_slow(x)
% IMDCTL Calculates the Modified Discrete Cosine Transform using loops
%   y = imdct_slow(x)
%
%   x: input signal (can be either a column or frame per column)
%   y: IMDCT of x
%  Naive with three nested loops. 
%  Fwd: mdctl.m (https://www.ee.columbia.edu/~marios/mdct/mdctl.m), 
%  Inv: imdctl.m (https://www.ee.columbia.edu/~marios/mdct/imdctl.m)

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

% We need these for furmulas below
M  = flen;    % Number of coefficients
N  = 2*M;     % Length of window
N0 = (M+1)/2; % Used in the loop
N4 = N/4;     % Do we really need the division by N/4 ?

% Frame loop
for i=1:fnum
    % Sample loop
    for n=0:(N-1)
        % Initialize
        y(n+1,i) = 0;
        % Coefficient loop
        for k=0:(M-1)
            y(n+1,i) = y(n+1,i) + x(k+1,i)*cos(pi*(n+N0)*(k+0.5)/M)/N4;
        end
    end
end

end