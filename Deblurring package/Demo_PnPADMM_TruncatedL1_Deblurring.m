% -------------------------------------------------------------------------
%   These MATLAB programs implement the typical deblurring experiments (inlcuding both the first and second set) for   
%   several standard gray-scale test images using the Denoiser regularization + Trunctaed Framelet L1 regularization  model 
%   with hybrid priors \lambda1 Denoiser(u)  +  \lambdaa2 ||(Wu)T||_1 + 1/2 ||Au - f||_2^2 as described in paper.
%   REQUIREMENTS
% ------------------------------------------------------------------
% *) Matlab 7.10.0(2010a) or later with installed:
% *) BM3D denoiser package with installed:
% *) Wavelet tight frame package with installed:
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

if ~exist('experiment_number','var'), experiment_number=1; end
if ~exist('test_image_name','var'), test_image_name='Cameraman256.png'; end
%% Test images (for the second set)
% test_image_name    =    'cameraman256.png';
test_image_name    =    'house.png';
% test_image_name    =    'lena512.png';
% test_image_name    =    'barbara.png';
%% Test images (for the first set)
% test_image_name           =    'cameraman256.png';
% test_image_name           =    'boat.bmp';
% test_image_name           =    'man.bmp';
% test_image_name           =    'monarch.png';
% test_image_name           =    'peppers.tif';
% test_image_name           =    'lena256.tif';
% test_image_name           =    'barbara256.png';
% test_image_name           =    'parrots.tif';
% test_image_name           =    'starfish.tif';
% test_image_name           =    'goldhill.jpg';
filename=test_image_name;
fprintf('Experiment number: %d\n', experiment_number);
fprintf('Image: %s\n', filename);

%% Show the original clean image
y=im2double(imread(filename)); 
y = y(:,:,1); 
[yN,xN]=size(y);
figure(1) ; imshow(y,[]);

%% First test set
% experiment_number  =    2   ;
% switch experiment_number
%     case 1 
%         noise_std=sqrt(2)/255; 
%         h=ones(9); h=h./sum(h(:));
%    case 2
%         noise_std=sqrt(2)/255;
%         h=fspecial('gaussian', 25, 1.6);
% end

%% Scecond test set
experiment_number  =   2   ;
switch experiment_number
    case 1
        noise_std=sqrt(2)/255; 
        for x1=-7:7; for x2=-7:7; h(x1+8,x2+8)=1/(x1^2+x2^2+1); end, end; h=h./sum(h(:));
    case 2
        noise_std=sqrt(8)/255;
        s1=0; for a1=-7:7; s1=s1+1; s2=0; for a2=-7:7; s2=s2+1; h(s1,s2)=1/(a1^2+a2^2+1); end, end;  h=h./sum(h(:));
    case 3 
        BSNR=40;
        noise_std=-1; % if "sigma=-1", then the value of sigma depends on the BSNR
        h=ones(9); h=h./sum(h(:));
    case 4
        noise_std=7/255;
        h=[1 4 6 4 1]'*[1 4 6 4 1]; h=h./sum(h(:));  % PSF
    case 5
        noise_std=2/255;
        h=fspecial('gaussian', 25, 1.6);
    case 6
       noise_std=8/255;
        h=fspecial('gaussian', 25, .4);
end

%% Generate the bluured and noised image
ker = h ;  
y_blur = imfilter(y, h, 'circular'); % performs blurring (by circular convolution)

if noise_std == -1;   %% check whether to use BSNR in order to define value of sigma
    noise_std=sqrt(norm(y_blur(:)-mean(y_blur(:)),2)^2 /(yN*xN*10^(BSNR/10)));
    %     Xv% compute sigma from the desired BSNR
else 
    noise_std=noise_std ;
end
sigma = noise_std ; 

%%%% Create a blurred and noisy observation
randn('seed',0);
z = y_blur + sigma*randn(yN, xN);

bsnr=10*log10(norm(y_blur(:)-mean(y_blur(:)),2)^2 /sigma^2/yN/xN);
psnr_z =psnr(y,z);

%% Show the blurred and noised image
figure(2) ; imshow(z,[]);title(sprintf('Bluured image'),'fontsize',13);
fprintf('Observation BSNR: %4.2f, PSNR: %4.2f\n', bsnr, psnr_z);
%% OPEN INTERFACE
%% IDD-BM3D deblurring results of the Second set
%% CASE 1 :
% load IDDBM3Dcameraman256BM3Dscenario1.mat ; 
% load IDDBM3Dhouse256BM3Dscenario1.mat ;
% load IDDBM3Dlena512BM3Dscenario1.mat ;
% load IDDBM3Dbarbara512BM3Dscenario1.mat ;
%% CASE 2 :
% load IDDBM3Dcameraman256BM3Dscenario2.mat ; 
load IDDBM3Dhouse256BM3Dscenario2.mat ;
% load IDDBM3Dlena512BM3Dscenario2.mat ;
% load IDDBM3Dbarbara512BM3Dscenario2.mat ;
%% CASE 3 :
% load IDDBM3Dcameraman256BM3Dscenario3.mat ; 
% load IDDBM3Dhouse256BM3Dscenario3.mat ;
% load IDDBM3Dlena512BM3Dscenario3.mat ;
% load IDDBM3Dbarbara512BM3Dscenario3.mat ;
%% CASE 4 :
% load IDDBM3Dcameraman256BM3Dscenario4.mat ; 
% load IDDBM3Dhouse256BM3Dscenario4.mat ;
% load IDDBM3Dlena512BM3Dscenario4.mat ;
% load IDDBM3Dbarbara512BM3Dscenario4.mat ;
%% CASE 5 :
% load IDDBM3Dcameraman256BM3Dscenario5.mat ; 
% load IDDBM3Dhouse256BM3Dscenario5.mat ;
% load IDDBM3Dlena512BM3Dscenario5.mat ;
% load IDDBM3Dbarbara512BM3Dscenario5.mat ;
%% CASE 6 :
% load IDDBM3Dcameraman256BM3Dscenario6.mat ; 
% load IDDBM3Dhouse256BM3Dscenario6.mat ;
% load IDDBM3Dlena512BM3Dscenario6.mat ;
% load IDDBM3Dbarbara512BM3Dscenario6.mat ;
%% IDD-BM3D deblurring results of First set
%% CASE 7 : 
% load BM3Dcameraman256uniform9sigma1.mat ; 
% load BM3Dboat256uniform9sigma1.mat ;
% load BM3Dman256uniform9sigma1.mat ;
% load BM3Dmonarch256uniform9sigma1.mat ;
% load BM3Dpeppers256uniform9sigma1.mat ;
% load BM3Dlena256uniform9sigma1.mat ;
% load BM3Dbarbara256uniform9sigma1.mat ;
% load BM3Dparrots256uniform9sigma1.mat ;
% load BM3Dstarfish256uniform9sigma1.mat ;
% load BM3Dgoldhill256uniform9sigma1.mat ;
%% CASE 8 : 
% load BM3Dcameraman256gaussian25sigma1.mat ;
% load BM3Dboat256gaussian25sigma1.mat ;
% load BM3Dman256gaussian25sigma1.mat ;
% load BM3Dmonarch256gaussian25sigma1.mat ;
% load BM3Dpeppers256gaussian25sigma1.mat ;
% load BM3Dlena256gaussian25sigma1.mat ;
% load BM3Dbarbara256gaussian25sigma1.mat ;
% load BM3Dparrots256gaussian25sigma1.mat ;
% load BM3Dstarfish256gaussian25sigma1.mat ;
% load BM3Dgoldhill256gaussian25sigma1.mat ;

psnr_final = psnr(y,y_hat);
isnr_final = psnr_final-psnr_z;
ssim_final = ssim_index(y_hat*255,y*255);

figure(3);imshow(y_hat,[0 1]);
title(sprintf('BM3D(Final),PSNR: %4.2fdB,SSIM: %4.4f',psnr_final,ssim_final),'fontsize',13);
disp('-------- Results --------');
fprintf('IDD-BM3D Final estimate PSNR: %4.2f SSIM: %4.4f  \n',  psnr_final, ssim_final);

%% Pre-compute rescale the pixel intensity
flag1 = max(y(:))> 2 ;  
if flag1
    y = y/255 ; 
end
img = y*255 ; sigma = sigma*255 ; 
blur=@(f,k)imfilter(f,k,'circular');
og=blur(img,ker); % adding blur
g=og+sigma*randn(size(img)); % adding noise
psnr_blur = psnr(g/255,img/255) ; ssim_blur = ssim_index(g,img) ;
fprintf('Observation Blurring PSNR: %4.2f SSIM: %4.4f \n', psnr_blur, ssim_blur);

%% Initilaization
Im0 = y_hat*255 ; 
psnr_initial = psnr(Im0/255,img/255) ; ssim_initial = ssim_index(Im0,img) ;
fprintf('Observation Initial PSNR: %4.2f SSIM: %4.4f \n', psnr_initial, ssim_initial);
opts.Init= Im0 ; opts.I=img;
PSNR_Initial = psnr(Im0/255,img/255); 
SSIM_Initial = ssim_index(Im0,img); 
disp([ 'Initial PSNR is ' num2str(PSNR_Initial),', Initial SSIM is ' num2str(SSIM_Initial) ]);

%% Main function (Only first stage)
opts.lambda1 = 2.0 ; %% Denoiser Regularization parameter ;
opts.mu1 = 0.01 ; %% Denoiser Penalty parameter ;
opts.lambda2 = 0.5 ; %% Framelet Regularization parameter ;
opts.mu2 = 0.01 ; %% Framelet Penalty parameter ;
opts.frame = 1;
opts.Level =  1  ;
opts.rho = 300 ;  
opts.maxit = 100  ; %% Maximum iteration number
opts.tol = 1e-5;
fprintf('***************************************************************\n')
fprintf('***************************************************************\n')
fprintf('Running Please waitting ...\n')
u = PnPADMM_TruncatedL1_Deblurring(g,ker,blur,img,opts);  
Psnr = psnr(u/255,img/255) ;  [Mssim ssim_map] = ssim_index(u,img);

%% Show the final recovered image
figure(4) ; imshow(u,[]); title(sprintf('Proposed,PSNR: %4.2fdB,SSIM: %4.4f',Psnr,Mssim),'fontsize',13);



