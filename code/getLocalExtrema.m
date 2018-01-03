function locsDoG = getLocalExtrema(DoGPyramid, DoGLevels, ...
                        PrincipalCurvature, th_contrast, th_r)
%%Detecting Extrema
% INPUTS
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
% DoG Levels  - The levels of the pyramid where the blur at each level is
%               outputs
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix contains the
%                      curvature ratio R
% th_contrast - remove any point that is a local extremum but does not have a
%               DoG response magnitude above this threshold
% th_r        - remove any edge-like points that have too large a principal
%               curvature ratio
%
% OUTPUTS
% locsDoG - N x 3 matrix where the DoG pyramid achieves a local extrema in both
%           scale and space, and also satisfies the two thresholds.
locsDoG=[];
maxval=DoGPyramid;
for l=1:length(DoGLevels)       
                if l==1
                    lup=1;
                    ldown=l+1;
                else
                    if l==length(DoGLevels)
                        ldown=length(DoGLevels);
                        lup=l-1;
                    else
                        lup=l-1;
                        ldown=l+1;
                    end
                end
                for i=-1:1
                    for j=-1:1
                     temp=circshift(maxval(:,:,l),[i j]);
                     maxval(:,:,l)=bsxfun(@max, maxval(:,:,l), temp);
                    end
                end
                maxval(:,:,l) = bsxfun(@max, maxval(:,:,l), maxval(:,:,lup));
                maxval(:,:,l) = bsxfun(@max, maxval(:,:,l), maxval(:,:,ldown));
                %{
                if abs(DoGPyramid(i,j,l))==max(max(abs(DoGPyramid(i-1:i+1,j-1:j+1,l))))
                    if abs(DoGPyramid(i,j,l))>=abs(DoGPyramid(i,j,lup)) && abs(DoGPyramid(i,j,l))>=abs(DoGPyramid(i,j,ldown))
                        locsDoG(index,:)=[j,i,l];
                        index=index+1;
                    end
                end
                %}
              
end
index=(maxval==DoGPyramid)&(maxval>th_contrast)&(PrincipalCurvature<th_r);
for l=1:length(DoGLevels)
    [x,y]=find(index(:,:,l));
    locsDoG=[locsDoG;[y,x,zeros(size(x))+l]];
end
end