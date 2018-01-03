function H2to1 = computeH(p1,p2)
% INPUTS:
% p1 and p2 - Each are size (2 x N) matrices of corresponding (x, y)'  
%             coordinates between two images
%
% OUTPUTS:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear 
%         equation

x=p1(1,:);
y=p1(2,:);
u=p2(1,:);
v=p2(2,:);
ux=u.*x;
vx=v.*x;
uy=u.*y;
vy=v.*y;
zero=zeros(size(u));
one=ones(size(u));
A=[u' v' one' zero' zero' zero' -ux' -vx' -x'; zero' zero' zero' u' v' one' -uy' -vy' -y'];

%[V1,~]=eig(A'*A);
[~,~,V2] = svd(A);
%h1=V1(:,end);
h2=V2(:,end);
H2to1= reshape(h2,[3,3])';
end
