function [compareA, compareB] = makeTestPattern(patchWidth, nbits) 
%%Creates Test Pattern for BRIEF
%
% Run this routine for the given parameters patchWidth = 9 and n = 256 and
% save the results in testPattern.mat.
%
% INPUTS
% patchWidth - the width of the image patch (usually 9)
% nbits      - the number of tests n in the BRIEF descriptor
%
% OUTPUTS
% compareA and compareB - LINEAR indices into the patchWidth x patchWidth image 
%                         patch and are each nbits x 1 vectors. 
compareA=[];
compareB=[];
mu=patchWidth/2.0;
sigma=patchWidth/5.0;
x=int32(normrnd(mu,sigma,[nbits, 4]));
x=max(x,1);
x=min(x,patchWidth);
compareA=sub2ind([patchWidth, patchWidth],x(:,1),x(:,2));
compareB=sub2ind([patchWidth, patchWidth],x(:,3),x(:,4));
save('testPattern.mat','compareA','compareB'); 
end