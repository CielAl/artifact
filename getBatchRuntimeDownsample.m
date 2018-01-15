function inputs = getBatchRuntimeDownsample(imdb, batch,opts)
% Too slow. Better to prepare all dataset in disk or memory first if it is
% necessary to train for multiple times.
imlist = imdb.images.data(:,batch) ;
batch_size = numel(batch);
%hardcoded. But anyway not applied.
img = zeros(128,128,3,batch_size,'single');
% get img from the imdb
for i=1:batch_size
    p1 = imlist{i};
    im_1 = imread(p1);
    im_1 = im2single(im_1);
    im_1 = single(random_cut128(im_1));
    img(:,:,:,i) = im_1;
end
if(rand>0.5) %Flip
    img = fliplr(img);
end
% Trim the edge
label = img(7:end-6,7:end-6,:,:);  
[w,h,~,~] = size(img);
r = 2; 
input = imresize(imresize(img,1/r),[w,h]);
inputs = {'input',gpuArray(input),'label',gpuArray(label)};
end