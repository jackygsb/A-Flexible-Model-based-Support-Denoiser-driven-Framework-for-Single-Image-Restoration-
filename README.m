% ==============================================================================
% 
%           A Universal Model-based Single Image Restoration Framework Using Hybrid Priors
%                          
% 
%                         Version 1.0, 16-October-2018
% 
%                       Copyright (C) 2018  Liangtian He
% 
% ==============================================================================
% 
% OVERVIEW:
% 
%   These MATLAB programs implement the image restoration algorithms via the 
%   Denoiser regularization + Trunctaed Framelet L1 regularization  model with hybrid priors
%   \lambda1 Denoiser(u)  +  \lambda2 ||(Wu)T||_1 + 1/2 ||Au - f||_2^2 as described in pape:
%   
%     Title:  A Universal Model-based Single Image Restoration Framework Using Hybrid Priors
%     Author: Liangtgian He and Yilun Wang   
% 
%   Specifically, this packages contains  the implementions for two applications: 
%   image inpainting and image deblurring which can be found in each directory. 
%
%   
%   This code relies on 
%   Wavelet tight frame Software package(http://bicmr.pku.edu.cn/~dongbin)
%   BM3D denoising package (http://www.cs.tut.fi/~foi/GCF-BM3D/)
%   All will need to reside within the current MATLAB search path.
% 
%
% 
% ==============================================================================
% 
% 
% AVAILABILITY:
% 
%   For updated version of the matlab sourse code, please email: helt@ahu.edu.cn
% 
% 
% ==============================================================================
% 
% 
% COPYRIGHT AND LICENSE INFORMATION:
% 
%   Copyright (C) 2018  Liangtian He
%   
%   The programs herein are free software; you can redistribute
%   them and/or modify them under the terms of the GNU General Public License
%   as published by the Free Software Foundation; either version 1
%   of the License, or (at your option) any later version.
% 
%   All programs herein are distributed in the hope that
%   they will be useful, but WITHOUT ANY WARRANTY; without even the implied
%   warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
%   the full text of the appropriate license for more details.
%   
% 
% ==============================================================================