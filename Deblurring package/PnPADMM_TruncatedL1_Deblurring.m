function u = PnPADMM_TruncatedL1_Deblurring(f,ker,blur,oimg,opts)
lambda1 = opts.lambda1 ;
mu1 = opts.mu1 ;
lambda2 = opts.lambda2 ;
mu2 = opts.mu2 ;
frame = opts.frame;
Level = opts.Level  ;
maxit = opts.maxit ;
rho = opts.rho ;
tol = opts.tol ;
[m,n] = size(oimg) ; 
[D,R]=GenerateFrameletFilter(frame);nD=length(D);
W  = @(x) FraDecMultiLevel(x,D,Level); % Frame decomposition
WT = @(x) FraRecMultiLevel(x,R,Level); % Frame reconstruction
[m,n]=size(f);
cker=rot90(ker,2);
A = @(x) blur(x,ker); AT = @(x) blur(x,cker); % Convolution operator
eigenP=eigenofP(ker,mu1+mu2,m,n);
FT = @(x)fft2(x);
IFT = @(x)ifft2(x);
ATf=AT(f);

%% Initilization
u= f ;
x = f ;
alpha = W(u) ;
v1 = f ; %% Lagrangian multiplier
v2 = alpha ; %% Lagrangian multiplier
M = computeM(1,m,n,opts.Init,oimg,W,frame,rho) ; %% Support estimation 

%% Main Deblurring Loop
for nstep=1:maxit   
%%  Solve u  
      u_prev =  u ;
      Cpb=CoeffOper('+',alpha,v2);
     u=IFT(FT(mu1*(x+v1)+mu2*WT(Cpb)+ATf)./eigenP);
     u(u>255)=255;u(u<0)=0;        
%%  Solve x   %% NOTE: One can use other denoising methods 
%%% Using the BM3D denoiser
     Z = u - v1 ; Sigma = sqrt(lambda1/mu1) ;
     x = DenoiserBM3D(Z,Sigma) ;
%%%  Using the WNNM Denoiser     
%      Par = ParSet(Sigma);  
%      x = WNNM_DeNoising(Z,oimg,Par) ;   
%%  Solve alpha   
     C = W(u) ;
     Cmb=CoeffOper('-',C,v2);
     alpha = Support_guided_softshrinkage(Cmb,lambda2,mu2,M);
%%   Update v1
      v1 = v1 + x - u ;     
%%   Update v2
      Cmb1 = CoeffOper('-',alpha,C);
      v2 = CoeffOper('+',v2,Cmb1);           
%%% Check the tolerence      
error=norm(u-u_prev,'fro')/norm(u,'fro'); 
disp(['error on step ' num2str(nstep)  ' is ' num2str(error) ', ' 'and PSNR is ' num2str(psnr(u/255,oimg/255)) ', and SSIM is ' num2str(ssim_index(u,oimg)) ] );  
 if error<tol
        break;
 end
end

function eigenP=eigenofP(ker,mu,m,n)
[nker,mker]=size(ker);
tmp=zeros(m,n);tmp(1:nker,1:mker)=ker;
tmp=circshift(tmp,[-floor(nker/2),-floor(mker/2)]);
eigenP=abs(fft2(tmp)).^2 + mu;




