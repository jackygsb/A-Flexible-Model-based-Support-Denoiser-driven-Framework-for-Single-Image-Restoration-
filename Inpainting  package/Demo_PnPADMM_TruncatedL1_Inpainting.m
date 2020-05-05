% -------------------------------------------------------------------------
%   These MATLAB programs implement four typical Inpainting experiments (pixel missing) for five standard color test 
%   images and mask removal for two of them using Denoiser regularization + Trunctaed Framelet L1 regularization 
%   model with hybrid priors \lambda1 Denoiser(u) + \lambda2 ||(Wu)T||_1 + 1/2 ||Au - f||_2^2 as described in paper:
%   REQUIREMENTS
% ------------------------------------------------------------------
% *) Matlab 7.10.0(2010a) or later with installed:
% *) BM3D denoiser with installed:
% *) Wavelet tight frame with installed:
% ------------------------------------------------------------------
%   Title: A Universal Model-based Single Image Restoration Framework Using Hybrid Priors
%   Author: Liangtgian He and Yilun Wang
%   Version 1.0
%   Author: Liangtian He
%   Email:  helt@ahu.edu.cn
%   Last modified by L. He, October 2018
%   The updated version of our source code will be released later
% -------------------------------------------------------------------------
clear
clc
clf
addpath('../')
randn('seed',0); %  Fix random seed
%% Data percentage
Ratio_Set = [0.2, 0.3, 0.5, 0.8];
for ImgNo = 3
    for ratio_num = 1
        switch ImgNo
            case 1
                OrgName = 'lena256.jpg'; 
            case 2
                OrgName = 'House256rgb.png';
            case 3
                OrgName = 'foreman.bmp';                 
            case 4
                OrgName = 'Butterfly.tif'; 
            case 5
                OrgName = 'leaves.tif';     
        end
    end
end
ratio = Ratio_Set(ratio_num); % ratio of available data, Options: [0.2, 0.3, 0.5, 0.8]
x_rgb = imread(OrgName); % Original True Image
[N,M,dim]=size(x_rgb);
figure(1);imshow(x_rgb); title(sprintf('Original clean image'),'fontsize',13);    
x_yuv = rgb2ycbcr(x_rgb);       
x = double(x_yuv(:,:,1)); % Deal with Y Component
x_org = x;
x_inpaint_rgb = zeros(size(x_rgb));
x_inpaint_yuv = zeros(size(x_yuv));
x_inpaint_yuv(:,:,2) = x_yuv(:,:,2); % Copy U Componet
x_inpaint_yuv(:,:,3) = x_yuv(:,:,3); % Copy V Componet
        
MaskType = 1; % 1 for random mask; 2 for text mask
switch MaskType
   case 1
     rand('seed',0);
     O = double(rand(size(x)) > (1-ratio));
   case 2
     O = imread('TextMask256.png'); %% 256 * 256 
%      O = imread('TextMask2.png'); %% 352 * 288 for test image 'foreman'
     O = double(O>128);
     O = O(:,:,1) ;
end    
% Generate Missing Image
y_missing_rgb = zeros(size(x_rgb));
y_missing_rgb(:,:,1) = uint8(double(x_rgb(:,:,1)).*O);
y_missing_rgb(:,:,2) = uint8(double(x_rgb(:,:,2)).*O);
y_missing_rgb(:,:,3) = uint8(double(x_rgb(:,:,3)).*O);
        
y= x.* O;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Considering the Case with Gaussian White Noise. When Noise_flag is zero, no noise is added.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Noise_flag =  0  ; 
if (Noise_flag)
%      BSNR = 40;
%      Py = var(x(:));
%      sigma = sqrt((Py/10^(BSNR/10)));
% Add noise
     sigma = 0 ;
     y = y + sigma*randn(N,M);
end              
psnr_inpainted = psnr(y/255,x/255) ;
figure(2);imshow(uint8(y_missing_rgb)); title(sprintf('Missed image,PSNR: %4.2fdB',psnr_inpainted),'fontsize',13);
%% OPEN INTERFACE
%% GSR recovered results (pixel missing)
% load GSRlenaRatio20.mat ;       %% lena ;
% load GSRlenaRatio30.mat ;
% load GSRlenaRatio50.mat ;
% load GSRlenaRatio80.mat ;
% load GSRhouseRatio20.mat ;      %% house ;
% load GSRhouseRatio30.mat ;
% load GSRhouseRatio50.mat ;
% load GSRhouseRatio80.mat ;
% load GSRbutterflyRatio20.mat ;      %% Monarch ;
% load GSRbutterflyRatio30.mat ;
% load GSRbutterflyRatio50.mat ;
% load GSRbutterflyRatio80.mat ;
load GSRforemanRatio20.mat ;      %% foreman ;
% load GSRforemanRatio30.mat ;
% load GSRforemanRatio50.mat ;
% load GSRforemanRatio80.mat ;
% load GSRleavesRatio20.mat ;      %% leaves ;
% load GSRleavesRatio30.mat ;
% load GSRleavesRatio50.mat ;
% load GSRleavesRatio80.mat ;
%% GSR recovered results (mask removal)
% load GSRlenaTextmask.mat ;
% load GSRforemanTextmask.mat ;

x_inpaint_yuv(:,:,1) = uint8(x_final);
x_inpaint_rgb = ycbcr2rgb(uint8(x_inpaint_yuv));
psnr_GSR = psnr(x_final/255,x/255) ; 
fprintf('GSR PSNR: %4.2f \n', psnr_GSR);
figure(3); imshow(uint8(x_inpaint_rgb)); 
title(sprintf('GSR,PSNR: %4.2fdB',psnr_GSR),'fontsize',13) ;
if max(x_final(:))> 2 %%
    x_final = x_final ;
else
    disp([ 'There is a problem in the intensity range ' ]);
end
%%%%%%%%%%%---------------------------------------------%%%%%%%%%%%
opts.Im0 = x_final ; %% reference image
%%%%%%%%%%%---------------------------------------------%%%%%%%%%%%
%% ADMM-BM3D recovered results (pixel missing)
% load PnPADMMlenaRatio20.mat ;       %% lena ;
% load PnPADMMlenaRatio30.mat ;
% load PnPADMMlenaRatio50.mat ;
% load PnPADMMlenaRatio80.mat ;
% load PnPADMMhouseRatio20.mat ;      %% house ;
% load PnPADMMhouseRatio30.mat ;
% load PnPADMMhouseRatio50.mat ;
% load PnPADMMhouseRatio80.mat ;
% load PnPADMMbutterflyRatio20.mat ;      %% Monarch ;
% load PnPADMMbutterflyRatio30.mat ;
% load PnPADMMbutterflyRatio50.mat ;
% load PnPADMMbutterflyRatio80.mat ;
load PnPADMMforemanRatio20.mat ;      %% foreman ;
% load PnPADMMforemanRatio30.mat ;
% load PnPADMMforemanRatio50.mat ;
% load PnPADMMforemanRatio80.mat ;
% load PnPADMMleavesRatio20.mat ;      %% leaves ;
% load PnPADMMleavesRatio30.mat ;
% load PnPADMMleavesRatio50.mat ;
% load PnPADMMleavesRatio80.mat ;
%% ADMM-BM3D recovered results (mask removal)
% load PnPADMMlenaTextmask.mat ;
% load PnPADMMforemanTextmask.mat ;

x_inpaint_yuv(:,:,1) = uint8(x_final);
x_inpaint_rgb = ycbcr2rgb(uint8(x_inpaint_yuv));
psnr_ADMMBM3D = psnr(x_final/255,x/255) ; 
fprintf('ADMM-BM3D PSNR: %4.2f \n', psnr_ADMMBM3D);
figure(4); imshow(uint8(x_inpaint_rgb)); 
title(sprintf('ADMM-BM3D,PSNR: %4.2fdB',psnr_ADMMBM3D),'fontsize',13) ;

%% Main Function (Only first stage)
opts.lambda1 = 1.0 ; %% Denoiser Regularization parameter ;
opts.mu1 = 0.005 ; %% Denoiser Penalty parameter ;
opts.lambda2 = 0.1 ; %% Frame Regularization parameter ;
opts.mu2 = 0.005 ; %% Frame Penalty parameter ;
opts.frame = 1;
opts.Level =  1  ;
opts.rho = 300 ;  
opts.maxit = 300  ; %% Maximum iteration number
opts.tol = 1e-5;
opts.Init= opts.Im0 ; 
fprintf('***************************************************************\n')
fprintf('***************************************************************\n')
fprintf('Running Please waitting ...\n')
x_final = PnPADMM_TruncatedL1_Inpainting(y,O,x,opts);  
Psnr = psnr(x_final/255,x/255) ;  

%% Show the recovered image
x_inpaint_yuv(:,:,1) = uint8(x_final);
x_inpaint_rgb = ycbcr2rgb(uint8(x_inpaint_yuv)); 
figure(5); imshow(uint8(x_inpaint_rgb)); title(sprintf('Proposed,PSNR: %4.2fdB',Psnr),'fontsize',13);





