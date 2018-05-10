function F = fourierSpectrum( varargin )
% return fourier specturm image,
% varargin = { I, 'noiseMode', 'gaussian', 7, 1 } % mode = gaussian, , noiseMode or basicMode ,
% size = 7 * 7, sigma = 2
% varargin = { I, 'basicMode', 'median', 7 } % mode = median, size = 7 * 7
% nargin

I = varargin{1};
noiseMode = varargin{2};
filterType = varargin{3};
filterSize = varargin{4};
if nargin > 4,
    sigma = varargin{5};
end

if strcmp(filterType, 'gaussian'),
    
    if strcmp(noiseMode, 'noiseMode'),
        filteringImg = imgaussfilt(I, sigma, 'FilterSize', [filterSize, filterSize] );
        I = I - filteringImg;
    else
        I = imgaussfilt(I, sigma, 'FilterSize', [filterSize, filterSize] );
    end
    
    F = fft2(I);
    F = fftshift(F); % Center FFT
    F = abs(F); % Get the magnitude
    F = log(F+1); % Use log, for perceptual scaling, and +1 since log(0) is undefined
    F = mat2gray(F); % Use mat2gray to scale the image between 0 and 1
    
elseif strcmp(filterType, 'median')
    
    if strcmp(noiseMode, 'noiseMode'),
        filteringImg = medfilt2(I, [filterSize, filterSize]);
        I = I - filteringImg;
    else
        I = medfilt2(I, [filterSize, filterSize]);
    end
    
    F = fft2(I);
    F = fftshift(F); % Center FFT
    F = abs(F); % Get the magnitude
    F = log(F+1); % Use log, for perceptual scaling, and +1 since log(0) is undefined
    F = mat2gray(F); % Use mat2gray to scale the image between 0 and 1
end


end

