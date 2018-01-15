function net = getNetModel(channel,initDepth)
net = dagnn.DagNN();
reluBlock1 = dagnn.pReLU('leak',0.000);
reluBlock2 = dagnn.pReLU('leak',0.00);
reluBlock2Deep = dagnn.pReLU('leak',0.00);
reluBlock2Deep2=dagnn.pReLU('leak',0.00);
reluBlock2Deep22=dagnn.pReLU('leak',0.00);
reluBlock3=dagnn.pReLU('leak',0.00);
reluBlock3Deep=dagnn.pReLU('leak',0.00);
reluBlock4=dagnn.pReLU('leak',0.00);
reluBlockFinal= dagnn.pReLU('leak',0.00);
%Default Value

if nargin <2
    initDepth = 64;
end
if  nargin<1
       channel = 3;
end 
%[ 8 8 channel initDepth] 
conv2_1Block = dagnn.Conv('size',[9 9 channel initDepth],'hasBias',true,'stride',[2,2],'pad',[0 0 0 0]);
net.addLayer('conv2_1',conv2_1Block,{'input'},{'conv2_1'},{'c2_1f','c2_1b'});
net.addLayer('relu2_1',reluBlock1,{'conv2_1'},{'conv2_1x'},{'p1'});
% 9 9 3 64 on 64x64 image ->56×56×64×128

conv2_2Block = dagnn.Conv('size',[1 1 initDepth 32],'hasBias',true,'stride',[1,1],'pad',[0,0,0,0]);
net.addLayer('conv2_2',conv2_2Block,{'conv2_1x'},{'conv2_2'},{'c2_2f','c2_2b'});
net.addLayer('relu2_2',reluBlock2,{'conv2_2'},{'conv2_2x'},{'p2'});

conv2_Deeper = dagnn.Conv('size',[3 3 32 16],'hasBias',true,'stride',[1,1],'pad',[1,1,1,1]);
net.addLayer('conv2_Deep',conv2_Deeper,{'conv2_2x'},{'conv2_2deep'},{'c2_2df','c2_2db'});
net.addLayer('relu2_Deep',reluBlock2Deep,{'conv2_2deep'},{'conv2_2deepx'},{'p3'});

conv2_2Block2 = dagnn.Conv('size',[1 1 16 32],'hasBias',true,'stride',[1,1],'pad',[0 0 0 0]);
net.addLayer('conv2_2d2',conv2_2Block2,{'conv2_2deepx'},{'conv2_2deeper'},{'c2_2ddf','c2_2ddb'});
net.addLayer('relu2_2d2',reluBlock2Deep2,{'conv2_2deeper'},{'conv2_2ddx'},{'p4'});



conv2_Deeper3 = dagnn.Conv('size',[3 3 32 16],'hasBias',true,'stride',[1,1],'pad',[1,1,1,1]);
net.addLayer('conv2_Deep3',conv2_Deeper3,{'conv2_2ddx'},{'conv2_3d'},{'c2_2df22','c2_2db22'});
net.addLayer('relu2_Deep3',reluBlock2Deep22,{'conv2_3d'},{'conv2_3dx'},{'p5'});

conv2_2Block3 = dagnn.Conv('size',[1 1 16 32],'hasBias',true,'stride',[1,1],'pad',[0 0 0 0]);
net.addLayer('conv2_2Block3',conv2_2Block3,{'conv2_3dx'},{'conv2_3dd'},{'c2_2dddf','c2_2dddb'});
net.addLayer('relu2_3dd',reluBlock3,{'conv2_3dd'},{'conv2_3ddx'},{'p6'});


conv2_Deeper4 = dagnn.Conv('size',[3 3 32 64],'hasBias',true,'stride',[1,1],'pad',[1,1,1,1]);
net.addLayer('conv2_Deeper4',conv2_Deeper4,{'conv2_3ddx'},{'conv2_4d'},{'c2_4f','c2_4b'});
net.addLayer('relu2_Deep4',reluBlock3Deep,{'conv2_4d'},{'conv2_4dx'},{'p7'});

conv2_2Block4 = dagnn.Conv('size',[1 1 64 32],'hasBias',true,'stride',[1,1],'pad',[0 0 0 0]);
net.addLayer('conv2_2Block4',conv2_2Block4,{'conv2_4dx'},{'conv2_4dd'},{'c2_4dddf','c2_4dddb'});
net.addLayer('relu2_4',reluBlock4,{'conv2_4dd'},{'conv2_4ddx'},{'p8'});


conv2_3Block = dagnn.Conv('size',[5 5 32 channel],'hasBias',true,'stride',[2,2],'pad',[0,0,0,0]);
net.addLayer('conv2_3',conv2_3Block,{'conv2_4ddx'},{'prediction'},{'c2_3f','c2_3b'});
%reluBlock4
net.addLayer('relu2_final',reluBlockFinal,{'prediction'},{'prediction_x'},{'p9'});
net.addLayer('loss',HuberLoss(),{'prediction_x','label'},'objective');
net.initParams();
% Make sure the input won`t be lost at the end of the epoch
 net.vars(1).precious = 1;