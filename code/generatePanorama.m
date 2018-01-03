function panoim = generatePanorama(im1, im2)
im1=imread('../data/incline_L.png');
im2=imread('../data/incline_R.png');
[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);
matches = briefMatch(desc1, desc2, 0.5);

H2to1 = ransacH(matches, locs1, locs2);
panoim1 = imageStitching(im1, im2, H2to1);
figure(1);
imshow(panoim1);
imwrite(panoim1,'../results/q6_1.jpg')
save('../results/q6_1.mat','H2to1'); 
H=ransacH(matches, locs1, locs2,1);
panoim = imageStitching_noClip(im1, im2, H);
figure(2);
imshow(panoim);
imwrite(panoim,'../results/q6_2_pan.jpg')
panoim = imageStitching_noClip(im1, im2, H2to1);
figure(3);
imshow(panoim);
imwrite(panoim,'../results/q6_3.jpg')
end