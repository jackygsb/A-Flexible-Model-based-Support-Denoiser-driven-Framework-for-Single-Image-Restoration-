clc
clf
addpath('../')
randn('seed',0); %  Fix random seed
%% Show the original clean image
sigma = 50 ; %% Noise level
OrgName = 'cameraman.tif'; %% Natual image
OrgName = '16.png'; %% Class-specific image
x = double(imread(OrgName)); % Original True Image
[N,M]=size(x); 
figure(1) ; imshow(x,[]); title(sprintf('Original clean image'),'fontsize',13);
%% Noisy image
y= x + sigma*randn(N,M) ;  
ssim_noised = ssim_index(y,x); psnr_noised = psnr(y/255,x/255) ;
figure(2);imshow(y,[]); title(sprintf('Noisy,PSNR: %4.2fdB,SSIM: %4.4f',psnr_noised,ssim_noised),'fontsize',13); 
%% OPEN INTERFACE
%% TIP17 Data
% load face_1_sigma20_TIP17.mat ;
load face_16_sigma50_TIP17.mat ;
%% Pre-compute rescale the pixel intensity
   if max(y_final(:))> 5 
            y_final =  y_final ;
    else
           y_final =  y_final*255 ;
    end       
         y_final(y_final>255)=255; y_final(y_final<0)=0;         
[mssim1 ssim_map] = ssim_index(y_final,x); psnr1 = psnr(y_final/255,x/255) ; 
fprintf('Initial PSNR: %4.2f SSIM: %4.4f \n', psnr1, mssim1);    
figure(3); imshow(y_final,[]); title(sprintf('TIP17,PSNR: %4.2fdB,SSIM: %4.4f',psnr1,mssim1),'fontsize',13);  
%% Initilaization
opts.Im0 =  y_final ; 
psnr_initial = psnr(opts.Im0/255,x/255) ; ssim_initial = ssim_index(opts.Im0,x) ;
fprintf('Observation Initial PSNR: %4.2f SSIM: %4.4f \n', psnr_initial, ssim_initial);
opts.Init= opts.Im0 ;
%% Main function (Only first stage)
opts.lambda1 = 400.0 ; %% Denoiser Regularization parameter ;
opts.lambda2 = 400.0 ; %% Framelet Regularization parameter ;
opts.mu1 = 1.0 ; %% Denoiser Penalty parameter ;
opts.mu2 = 1.0 ; %% Framelet Penalty parameter ;
opts.frame =  1  ;
opts.Level =  1  ;
switch sigma
   case 30   
       opts.rho =  500 ;  
   case 50   
       opts.rho =  300 ;  
   case 70   
       opts.rho =  200 ; 
   case 100 
       opts.rho =  100 ;        
end
opts.maxit = 300  ; %% Maximum iteration number
opts.tol = 1e-5;
fprintf('***************************************************************\n')
fprintf('***************************************************************\n')
fprintf('Running Please waitting ...\n')
[x_final] = PnPADMM_FrameL1_Denoising(y,x,opts);  
Psnr = psnr(x_final/255,x/255);  Mssim = ssim_index(x_final,x);
%% Show the final recovered image
figure(4);imshow(x_final,[]);  
title(sprintf('Proposed,PSNR: %4.2fdB,SSIM: %4.4f',Psnr,Mssim),'fontsize',13);















