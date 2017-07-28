%% TEST for the laplacian:
%		This script executes two functions to calcualte regularization
%		matrices.
%		
%		3D Laplacian computes a similar set of matrices, although in this
%		case the operators take into account euclidean distances instead of
%		the geometry provided by the mesh.
%
%		INPUT:
%			- heart - struct - heart geometry:
%								heart.node - <3,M>double - positions of the
%									nodes of the geometry.
%								heart.face - <3,F>double - triplets of the
%									surface triangles.
%

%% INPUT
	heart = field1;
	sigma = o1;


%% Estimate the 3D laplacian

% compute weight function
[wghFcn] = invExplonentialWeight(heart, sigma, 0);

% compute gradient and hessian
[cDf, cHf] = meshVolDiffHessMatrix(heart,wghFcn);

% compute weights
M = max(size(heart.node));
W = zeros(M);
for ii = 1:M
	
	W(:,ii) = wghFcn(ii);
end


%% OUTPUT
	o4 = W;			% weight functions (to plot as validation
	
	o2 = cDf;		% volumetric gradient
	o3 = cHf;		% volumetric hessian
