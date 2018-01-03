 im=imread('../data/model_chickenbroth.jpg');
    
    if size(im,3)==3
        im= rgb2gray(im);
    end
    immax=max(max(im));
    immin=min(min(im));
    im=double((im(:,:)-immin)).*(1/double(immax-immin));
    sigma0=1;
    k=2^0.5;
    th_contrast=0.03;
    th_r=12;
    levels=[-1,0,1,2,3,4];
    [GaussianPyramid] = createGaussianPyramid(im, sigma0, k, levels);
    displayPyramid(GaussianPyramid);
    [DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels);
    displayPyramid(DoGPyramid);