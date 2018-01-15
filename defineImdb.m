%% Prepare my own imdb
function [imdb] = defineImdb(origin,compress)
if nargin<2
       origin =  fullfile(pwd,'data','sublabel');
       compress = fullfile(pwd,'data','subim');
  end
   originalFields = dir(fullfile(origin,'*.jpg'));
   originalFiles=cellfun(@fullfile,extractfield(originalFields,'folder'),extractfield(originalFields,'name'),'UniformOutput',false);
   compressedFields = dir(fullfile(compress,'*.jpg'));
   compressedFiles=cellfun(@fullfile,extractfield(compressedFields,'folder'),extractfield(compressedFields,'name'),'UniformOutput',false);
   imdb.images.label = originalFiles;
   imdb.images.data = compressedFiles;
   dataSize = size(imdb.images.data,2);
    imdb.images.set = ones(1,dataSize);
    imdb.images.set(ceil(rand(1,ceil(dataSize/20))*dataSize)) = 2;

end