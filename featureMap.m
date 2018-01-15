layerId = 2;
fmap_i = getfield(net.vars(2), 'value');
test = sum(fmap_i,3)/3;
imshow(test)