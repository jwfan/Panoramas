function [panoImg] = imageStitching(img1, img2, H2to1)
%
% INPUT
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear
%         equation
%
% OUTPUT
% Blends img1 and warped img2 and outputs the panorama image

warpim2=im2double(warpH(img2,H2to1,[800,1600]));
warpim1=im2double(warpH(img1,diag([1 1 1]),[800,1600]));
mask1 = zeros(size(img1,1), size(img1,2));
mask1(1,:) = 1; mask1(end,:) = 1; mask1(:,1) = 1; mask1(:,end) = 1;
mask1 = bwdist(mask1, 'city');
mask1 = mask1/max(mask1(:));
maskim1=warpH(mask1,diag([1 1 1]),[800,1600]);
mask2 = zeros(size(img2,1), size(img2,2));
mask2(1,:) = 1; mask2(end,:) = 1; mask2(:,1) = 1; mask2(:,end) = 1;
mask2 = bwdist(mask2, 'city');
mask2 = mask2/max(mask2(:));
maskim2=warpH(mask2,H2to1,[800,1600]);
panoImg = im2uint8((warpim1.*maskim1+warpim2.*maskim2)./(maskim1+maskim2));
end

