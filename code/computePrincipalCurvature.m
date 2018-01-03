function PrincipalCurvature = computePrincipalCurvature(DoGPyramid)
%%Edge Suppression
% Takes in DoGPyramid generated in createDoGPyramid and returns
% PrincipalCurvature,a matrix of the same size where each point contains the
% curvature ratio R for the corre-sponding point in the DoG pyramid
%
% INPUTS
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
%
% OUTPUTS
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix where each 
%                      point contains the curvature ratio R for the 
%                      corresponding point in the DoG pyramid
PrincipalCurvature=zeros([size(DoGPyramid)]);
th_r=12;
%xx=[1 -2 1];
%yy=xx';
%xy=[1 0 -1;0 0 0;-1 0 1]/4;
[x,y,level]=size(PrincipalCurvature);
for l=1:level
    [gradX,gradY]=gradient(DoGPyramid(:,:,l));
    [Dxx,Dxy]=gradient(gradX);
    [Dyx,Dyy]=gradient(gradY);
    Tr=Dxx+Dyy;
    Det=(Dxx.*Dyy)-(Dxy.*Dyx);
    PrincipalCurvature(:,:,l)=(Tr.^2)./Det;
end

end

