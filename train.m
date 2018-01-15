function [net,info] = train(patchSize,imdb,inputNet,trainOutput)
%
if nargout <2
    %it feels like hell when you finished the training but forget to save it.
    error('No enough Output!');
end
if nargin <4
     trainOutput =  './data/trainResult';
end
if nargin<3
   % input = 'data/pretrainResult/dataset_ILSVRC.mat';
   inputNet = '';
end
if nargin <2
    imdb = defineImdb();
end
if nargin<1
     patchSize = 64;
end
% Configure imdb
imdb.meta.sets={'train','val'};
ss = size(imdb.images.data);
imdb.images.set = ones(1,ss(2));
imdb.images.set(ceil(rand(1,ceil(ss(2)/20))*ss(2))) = 2;
% Get DaNN
if ~isempty(inputNet)
    if class(inputNet)=='dagnn.DagNN'
        net = inputNet
    else
        netstruct = load(inputNet); 
        net = dagnn.DagNN.loadobj(netstruct.net);
    end
else
    net = getNetModel();
end
net.conserveMemory = true;

%Set Opts
opts.train.batchSize = 128;
%opts.train.numSubBatches = 1 ;
opts.train.continue = false; 
opts.train.gpus = 1;
opts.train.prefetch = false ;
imdb.batchSize = opts.train.batchSize ;
%opts.train.sync = false ;
%opts.train.errorFunction = 'multiclass' ;
opts.train.expDir = trainOutput ; 
opts.train.learningRate = [3e-5*ones(1,3) 1.2e-5*ones(1,3) 1e-5*ones(1,5) 1e-6*ones(1,4)];
opts.train.weightDecay = 0.0005;
opts.train.numEpochs = numel(opts.train.learningRate) ;
opts.train.derOutputs = {'objective',1} ;

[opts, ~] = vl_argparse(opts.train, {'gpu',1}) ;

imdb.patchSize = patchSize;
%Create Folder 
if(~isdir(opts.expDir))
    mkdir(opts.expDir);
end

% Call training function in MatConvNet
% getBatch assume that the size of images in imdb is exactly patchSize
% so that there won`t be irrelevant operations like crop and trim in
% training process (in order to save more time when multiple trials of training is necessary)
[net,info] = cnn_train_dag(net, imdb, @getBatch,opts) ;

end
