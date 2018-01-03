function [bestH] = ransacH(matches, locs1, locs2, nIter, tol)
% INPUTS
% locs1 and locs2 - matrices specifying point locations in each of the images
% matches - matrix specifying matches between these two sets of point locations
% nIter - number of iterations to run RANSAC
% tol - tolerance value for considering a point to be an inlier
%
% OUTPUTS
% bestH - homography model with the most inliers found during RANSAC

if nargin<4
    nIter=1000;
end
if nargin<5
    tol=1;
end
bestH=zeros(3,3);
p1=locs1(matches(:,1),1:2)';
p2=locs2(matches(:,2),1:2)';
range=size(p1,2);
matchnum=-1;
homo_ones=ones(1,range);
for i=1:nIter
    random=randperm(range,4);
    randomp1=p1(:,random);
    randomp2=p2(:,random);
    H=computeH(randomp1,randomp2);
    wp=H*[p2;homo_ones];
    homo_wp=wp(3,:);
    wpx=wp(1,:)./homo_wp;
    wpy=wp(2,:)./homo_wp;
    errors=sqrt(sum((p1-[wpx;wpy]).^2,1))/range;
    inliers=errors<tol;
    mn=sum(inliers);
    if mn > matchnum
        matchnum=mn;
        bestH=computeH(p1(:,inliers),p2(:,inliers));
    end
    
end
end

