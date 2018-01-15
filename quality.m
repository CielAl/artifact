function[MSE,PSNR]= quality(InputImage,ReconstructedImage)


n=size(InputImage);
M=n(1);
N=n(2);
if length(n)>2
    channel = n(3);
else
    channel = 1;
end
MSE = sum(sum((InputImage-ReconstructedImage).^2))/(M*N);
if channel>1
    MSE = sum(MSE)/channel;
end
PSNR = 10*log10(255*255/MSE);
fprintf('\nMSE: %7.2f ', MSE);
fprintf('\nPSNR: %9.7f dB', PSNR);
end