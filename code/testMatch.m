 im1=imread('../data/pf_scan_scaled.jpg');
 im2=imread('../data/pf_stand.jpg');
 if size(im1,3)==3
    im1= rgb2gray(im1);
 end
 if size(im2,3)==3
    im2= rgb2gray(im2);
 end
 [locs1, desc1] = briefLite(im1);
 [locs2, desc2] = briefLite(im2);
 [matches] = briefMatch(desc1, desc2);
 figure(2);
 plotMatches(im1, im2, matches, locs1, locs2);
