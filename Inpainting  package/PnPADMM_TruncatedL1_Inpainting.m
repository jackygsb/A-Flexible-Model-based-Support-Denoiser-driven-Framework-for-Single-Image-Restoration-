function x = PnPADMM_TruncatedL1_Inpainting(f,P,oimg,opts)
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
W  = @(a) FraDecMultiLevel(a,D,Level); % Frame decomposition
WT = @(a) FraRecMultiLevel(a,R,Level); % Frame reconstruction

%% Initilization
x = f ;
d = f ;
alpha = W(x) ;
v1 = f ; %% Lagrangian multiplier
v2 = alpha ; %% Lagrangian multiplier
M = computeM(1,m,n,opts.Init,oimg,W,frame,rho) ; %% Support estimation
%% Main Deblurring Loop
for nstep=1:maxit      
%%  Solve x 
     x_prev =  x ;
     Cpb=CoeffOper('+',alpha,v2);
     x=(P.*f+mu1*(d+v1)+mu2*WT(Cpb))./(P.^2+(mu1+mu2));
     x(x>255)=255;x(x<0)=0; 
%%  Solve d
%%% Using the BM3D denoiser
     Z = x - v1 ; Sigma = sqrt(lambda1/mu1) ;
     d = DenoiserBM3D(Z,Sigma) ; 
%%%  Using the WNNM Denoiser
%    Par = ParSet(Sigma);  
%    d = WNNM_DeNoising(Z,oimg,Par) ;  
%%  Solve alpha   
     C = W(x) ;
     Cmb=CoeffOper('-',C,v2);
     alpha = Support_guided_softshrinkage(Cmb,lambda2,mu2,M);
%%   Update v1
     v1 = v1 + d - x ;     
%%   Update v2
     Cmb1 = CoeffOper('-',alpha,C);
     v2 = CoeffOper('+',v2,Cmb1);      
      
%%% Check the tolerence      
error=norm(x-x_prev,'fro')/norm(x,'fro'); 
disp(['error on step ' num2str(nstep)  ' is ' num2str(error) ', ' 'and PSNR is ' num2str(psnr(x/255,oimg/255)) ] );  

if error<tol
        break;
end
end




