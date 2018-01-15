%% Assume using GPU mode
% Remove the gpuArray if you use cpu mode.
function inputs = getBatch(imdb, batch,opts)
% --------------------------------------------------------------------
%imlist = imdb.images.data(:,batch) ;
%labelList = imdb.images.label(:,batch);
batch_size = numel(batch);
%scaling = 1;
%TRY OPT
patchSize = imdb.patchSize;
%img = zeros(patchSize,patchSize,3,batch_size,'single');
%label = zeros(patchSize,patchSize,3,batch_size,'single');

% get img from the imdb|| Assume all jpg
% cannot use 'GPU' option here: unknown exception that crashes the matlab
%Problem:  
img = vl_imreadjpeg( imdb.images.data(:,batch),'pack','Resize',[patchSize patchSize]);
label = vl_imreadjpeg( imdb.images.label(:,batch),'pack','Resize',[patchSize patchSize]);
img = img{1}/255;
label = label{1}/255;
if imdb.batchSize-batch_size>0
    img = cat(4,img,zeros(patchSize,patchSize,3,128-batch_size));
    label = cat(4,label,zeros(patchSize,patchSize,3,128-batch_size));
end
if(rand>0.5) %mirror img
    img = fliplr(img);
    label =  fliplr(label);
end
%label =  label(29:end-28,29:end-28,:,:);
label = label(27:end-26,27:end-26,:,:);
inputs = {'input',gpuArray(img),'label',gpuArray(label)};

%{
for i=1:batch_size

     p1 = imlist{i} ;
     p2 = labelList{i};
      im_1 = im2single( imread(p1));
      im_2 = im2single( imread(p2));
    for jj = 1:scaling     
        img(:,:,:,(i-1)*scaling+jj) = im_1;
         label(:,:,:,(i-1)*scaling+jj)  = im_2;
        
    end

end
%}



% Predefined size: determined by the layers.
%trimRange = (28:end-27,28:end-27,:,:);

%label = label(7:end-6,7:end-6,:,:);  
%label = label(29:end-28,29:end-28,:,:);  
%inputs = {'input',gpuArray(img),'label',gpuArray(label)};
%'input_trim',gpuArray(img(29:end-28,29:end-28,:,:))};
end