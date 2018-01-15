input_big = imread('test.jpg');
input_big = im2single(input_big);
net.mode = 'test' ;
net.conserveMemory = false;
truth =imread('52.png');
truth = im2single(truth(107:end-107,108:end-107,:,:));
input_ref = input_big(107:end-107,108:end-107,:,:);
net.move('gpu')
tic;
net.eval({'input',gpuArray(input_big)});
toc;
index = net.getVarIndex('prediction_x');
result = gather(net.vars(index).value);
imwrite(input_ref-result,'product.jpg');
imwrite(input_ref,'ref.jpg');
imwrite(truth,'truth.jpg');
figure(3);
imshow(result);
figure(4);
imshow(truth);
figure(5);
imshow(input_big);


input_sub = imresize(input_big,1/2);  % compress the img as input
result_bi = imresize(input_sub,2);

tic;
net.eval({'input',gpuArray(result_bi)});
toc;
index = net.getVarIndex('prediction');
result_bi2 = gather(net.vars(index).value);

figure(7);
imshow(result_bi2);
figure(8);
imshow(result_bi);

input_big2= input_big(7:end-6,7:end-6,:);

 immse(c2,c1)