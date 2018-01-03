function [panoImg] = imageStitching_noClip(img1, img2, H2to1)
%
% INPUT
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear
%         equation
%
% OUTPUT
% Blends img1 and warped img2 and outputs the panorama image
out_size = [600,3000];
[x, y, ~] = size(img2);
corners = [1,1,1;y,1,1;1,x,1;y,x,1];
Hcorner = (H2to1*corners')';
Hcorner = Hcorner ./ Hcorner(:,3);
width = max(max(Hcorner(:,1)), size(img1,2)) - min(min(Hcorner(:,1)), 1);
height = max(max(Hcorner(:,2)), size(img1,1)) - min(min(Hcorner(:,2)), 1);
ratio = out_size(2)/width;
out_size(2)=out_size(2);
out_size(1) = round(ratio*height);
w = abs(min(min(Hcorner(:,1)), 0)) ;
h = abs(min(min(Hcorner(:,2)), 0));
M = [ratio, 0,  w/1* ratio;0, ratio, h/1 * ratio;0, 0, 1];
H2to1 = M*H2to1;
warpim2=im2double(warpH(img2,H2to1,out_size));
warpim1=im2double(warpH(img1,M,out_size));
mask1 = zeros(size(img1,1), size(img1,2));
mask1(1,:) = 1; mask1(end,:) = 1; mask1(:,1) = 1; mask1(:,end) = 1;
mask1 = bwdist(mask1, 'city');
mask1 = mask1/max(mask1(:));
maskim1=warpH(mask1,M,out_size);
mask2 = zeros(size(img2,1), size(img2,2));
mask2(1,:) = 1; mask2(end,:) = 1; mask2(:,1) = 1; mask2(:,end) = 1;
mask2 = bwdist(mask2, 'city');
mask2 = mask2/max(mask2(:));
maskim2=warpH(mask2,H2to1,out_size);
panoImg = im2uint8((warpim1.*maskim1+warpim2.*maskim2)./(maskim1+maskim2));
end

