function [locsDoG, GaussianPyramid] = DoGdetector(im, sigma0, k, ...
                                                levels, th_contrast, th_r)
%%DoGdetector
%  Putting it all together
%
%   Inputs          Description
%--------------------------------------------------------------------------
%   im              Grayscale image with range [0,1].
%
%   sigma0          Scale of the 0th image pyramid.
%
%   k               Pyramid Factor.  Suggest sqrt(2).
%
%   levels          Levels of pyramid to construct. Suggest -1:4.
%
%   th_contrast     DoG contrast threshold.  Suggest 0.03.
%
%   th_r            Principal Ratio threshold.  Suggest 12.
%
%   Outputs         Description
%--------------------------------------------------------------------------
%
%   locsDoG         N x 3 matrix where the DoG pyramid achieves a local extrema
%                   in both scale and space, and satisfies the two thresholds.
%
%   GaussianPyramid A matrix of grayscale images of size (size(im),numel(levels))
    
    if size(im,3)==3
        im= rgb2gray(im);
    end
    
    sigma0=1;
    k=2^0.5;
    th_contrast=0.03;
    th_r=12;
    levels=[-1,0,1,2,3,4];
    
    [GaussianPyramid] = createGaussianPyramid(im, sigma0, k, levels);
    [DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels);
    PrincipalCurvature = computePrincipalCurvature(DoGPyramid);
    locsDoG = getLocalExtrema(DoGPyramid, DoGLevels,PrincipalCurvature, th_contrast, th_r);
    %{
    figure(1);
    imshow(im);
    hold on;
    scatter(locsDoG(:,1),locsDoG(:,2),'*');
    %}
end

