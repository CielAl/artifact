function downSample(imageNum,pattern,r,step,sourceFolder,outputFolder)

if nargin <6
    outputFolder = fullfile(pwd,'data','compress');
    sourceFolder = fullfile(pwd,'data','image');
end   

if nargin <4
    step = 4;
end   

if nargin <3
    r = 2;
end   
if nargin <2
    %Assume the default pattern ###.jpg
    pattern = '%.3d.jpg';
end
if nargin < 1
    imageNum = 100;
end


fin = step*imageNum-step;
    for ii=0:step:fin
        temp=imread(fullfile(sourceFolder,sprintf(pattern,ii)));
        [w,h,~,~] = size(temp);
        wr = imresize(imresize(temp,1/r),[w,h]);
        imwrite(wr,fullfile(outputFolder,sprintf(pattern,ii)));

    end
end