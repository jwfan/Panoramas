function [locs,desc] =computeBrief(im, GaussianPyramid, locsDoG, k, ...
                                        levels, compareA, compareB)
%%Compute BRIEF feature
% INPUTS
% im      - a grayscale image with values from 0 to 1
% locsDoG - locsDoG are the keypoint locations returned by the DoG detector
% levels  - Gaussian scale levels that were given in Section1
% compareA and compareB - linear indices into the patchWidth x patchWidth image 
%                         patch and are each nbits x 1 vectors
%
% OUTPUTS
% locs - an m x 3 vector, where the first two columns are the image coordinates 
%		 of keypoints and the third column is the pyramid level of the keypoints
% desc - an m x n bits matrix of stacked BRIEF descriptors. m is the number of 
%        valid descriptors in the image and will vary
locs=[];
desc=[];
patchWidth=9;
[x,y]=size(im);
pr=ceil((patchWidth-1)/2);
for i=1:length(locsDoG)
    keypoint=locsDoG(i,1:2);
    if keypoint(1)<=pr || keypoint(1)>(y-pr) || keypoint(2)<=pr || keypoint(2)>(x-pr)
            continue
    else
    locs=[locs;locsDoG(i,:)];
    patch=im(keypoint(2)-pr:keypoint(2)+pr,keypoint(1)-pr:keypoint(1)+pr);
    descriptor=patch(compareA)<patch(compareB);
    desc=[desc;descriptor'];
    end
end
