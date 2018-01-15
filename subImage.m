function subImage(patchSize,originOut,compressOut)
if nargin <1
    patchSize =64;
end
if nargin <3
    originOut =  fullfile(pwd,'data','subim');
    compressOut = fullfile(pwd,'data','sublabel');
end
origin =  fullfile(pwd,'data','image2');
compress = fullfile(pwd,'data','compress2');    

step=1;
 numOfFile = 100;
 fin = numOfFile-1;
 scaling = 200;
  for ii=0:step:fin
    tempLabel=imread(fullfile(origin,sprintf('%.3d.jpg',ii)));
    tempTrain=imread(fullfile(compress,sprintf('%.3d.jpg',ii)));
    if(size(tempTrain,1)<patchSize||size(tempTrain,2)<patchSize)
         continue;
     end
    for jj = 1:scaling
         [train_cut,rw,rh] = getPatch(tempTrain);
        train_cut = im2single(train_cut);

        label_cut = im2single(getPatch(tempLabel,patchSize,rw,rh));
        imwrite(train_cut,fullfile(compressOut,sprintf('%.4d.jpg',(ii)*scaling+jj)));   
        imwrite(label_cut,fullfile(originOut,sprintf('%.4d.jpg',(ii)*scaling+jj)));      
    end
    
  end

  