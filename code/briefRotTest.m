% Script to test BRIEF under rotations
im1 = imread('../data/model_chickenbroth.jpg');
im2 = im1(:);

if size(im1,3)==3
    im1= rgb2gray(im1);
 end
 if size(im2,3)==3
    im2= rgb2gray(im2);
 end
 
[locs1, desc1] = briefLite(im1);
rotations = zeros(36,1);

for i=1:36
    im2=imrotate(im1,10*i);
    [locs2, desc2] = briefLite(im2);
    matches=briefMatch(desc1,desc2);
    rotations(i)=size(matches,1);
end

figure(4);
bar(10*[1:36],rotations);
xlabel('Rotation dgrees');
ylabel('Matches');