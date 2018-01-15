function [imt,rw,rh] = getPatch(im,margin,rw,rh)
    w = size(im,1);
    h = size(im,2);
    if nargin< 2
        margin = 64;
    end

    if nargin< 4
                %Make sure there won`t be INDEX-out-of-boundary issue by
                %subtracting the margin first
                % if <4 then it will be random.

        rh = randperm(h-margin+1);
    end
    if nargin <3
         rw = randperm(w-margin+1);
    end
    imt = im(rw(1):rw(1)+margin-1,rh(1):rh(1)+margin-1,:);
