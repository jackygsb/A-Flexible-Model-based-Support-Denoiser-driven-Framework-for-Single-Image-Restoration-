% %House Gaussian Motion sigma=4.0
% x0 = [1 2 4 7 10];
% a1 = [32.84 32.93 32.75 32.62 32.48];
% a2=[32.93 32.96 32.75 32.60 32.43];
% 
% 
% b1=[17.10 17.14 16.98 16.75 16.64];
% 
% plot(x0, a1,'r o-',x0, a2, 'b+ -','LineWidth',2); 
% legend('Guassian Blur','Motion Blur')
% xlabel('T ');
% ylabel('PSNR(dB)');

% %%Barbara Gaussian Motion sigma=3.0
% x0 = [1 2 4 7 10];
% a1 = [27.15 27.14 26.99 26.73 26.47];
% a2=[27.07 27.08 26.99 26.81 26.62];
% 
% plot(x0, a1,'r o-',x0, a2, 'b+ -','LineWidth',2); 
% legend('Guassian Blur','Motion Blur')
% xlabel('T ');
% ylabel('PSNR(dB)');


% %%
% carr = [0.0 0.2 0.4 0.6 0.8 1.0];
% Psnrarr = [27.16 27.15 27.15 27.14 27.10 27.05];
% Timearr = [13.35 8.56 7.83 7.35 6.62 5.76];
% a=plotyy(carr,Psnrarr,carr,Timearr);
% text(0.2,27.16,'PSNR');
% text(0.8,27.04,'CPU time');
% set(get(a(1),'Ylabel'),'String','PSNR(dB)')
% set(get(a(2),'Ylabel'),'String','Time(s)')
% xlabel('c')






% %Barbara Gaussian sigma=3.0
% err1 = [0.0153191859906895,0.00770968126871488,0.00534954176405905,0.00369520652052648,0.00306996728561759,0.00268036806951908,0.00286454640889214,0.00258406246895972,0.00261941280778011,0.00231065309023538,0.00223157749556194,0.00198924575328649,0.00190113949065219,0.00171657747486684,0.00163390241682556,0.00148885660421718,0.00141651484779677,0.00130153177588638,0.00124084462231002,0.00114869486719706,0.00109510955599631,0.00101904285737868,0.000974276685273723,0.000910263976792559,0.000873644660774467,0.000821551739039150,0.000792986284038147,0.000749381496866205,0.000728432822666930,0.000688380582925907,0.000668675620282669,0.000635899228166125,0.000619656818311683,0.000588188005362636,0.000573943559542994,0.000545580987657404,0.000536155844919357,0.000512007638453537,0.000502407215539346,0.000480813274738770];
% err2 = [0.0172754722303768,0.0107936870780890,0.00980636163801330,0.00856284177167660,0.00719418642626189,0.00605179777021297,0.00527707499406216,0.00470844054871452,0.00425398585888948,0.00389534326920823,0.00357644556202266,0.00332353464394729,0.00312392047327904,0.00293088474141867,0.00277489498710328,0.00261828971714311,0.00249857729561942,0.00237207039134119,0.00225970620277536,0.00216062935418617,0.00208072822114136,0.00199923585731207,0.00191706133983807,0.00185282842120656,0.00178146101774936,0.00171233722448087,0.00166125735979851,0.00160330418516008,0.00154155281006628,0.00148715943475633,0.00144610145416062,0.00139636129264020,0.00136208389588929,0.00133117668161098,0.00129639600229311,0.00126310721887303,0.00123423350882961,0.00120681139617486,0.00118213754623246,0.00115172036924914,0.00111790265077814,0.00108867944475307,0.00106321662106656,0.00103823960866327,0.00101631494268918,0.000993486667433623,0.000964545663034547,0.000939960646852304,0.000922942032949609,0.000903074113648080,0.000887663939484683,0.000873374570646300,0.000860609327032801,0.000844951843468081,0.000831905925933351,0.000813940985130801,0.000798393851531332,0.000784677516177004,0.000768638504703921,0.000759845254793314,0.000751599955902802,0.000740093978551819,0.000726166399798940,0.000720135283673044,0.000706735853182498,0.000693769758651439,0.000685634705601238,0.000672535535702956,0.000661466217968814,0.000651595015650501,0.000644452396504399,0.000635445347890174,0.000627611326814108,0.000619201870583491,0.000610258951039354,0.000602755257972439,0.000595205249906197,0.000591918899760197,0.000583105561010658,0.000577444092051177,0.000571605133218759,0.000564012770123162,0.000556713465119580,0.000549378729405562,0.000541934239504417,0.000532638236904314,0.000527415475375952,0.000521723052986421,0.000514912722626583,0.000508308033567395,0.000502206246358552,0.000497219071247517];
% plot(1:40, log(err1),'r +-',1:92, log(err2), 'b -', 'LineWidth',2); 
% legend('Algorithm 1', 'MDAL for l_{0} minimization')
% xlabel('k (iteration number)');
% ylabel('error value');

% %Barbara Gaussian sigma=4.0
% load(['./Results/barbara_Gaussian52sigma4_ErrCurve.mat']);
% err1 = errorva1(2:end);
% err2 = errorva2(2:end);
% plot(1:48, log(err1),'r +-',1:100, log(err2), 'b -', 'LineWidth',2); 
% legend('Algorithm 1', 'MDAL for l_{0} minimization')
% xlabel('k (iteration number)');
% ylabel('error value');

% %House Motion sigma=3.0
% load(['./Results/House_Motionsigma3_ErrCurve.mat']);
% err1 = errorva1(2:end);
% err2 = errorva2(2:end);
% plot(1:46, err1,'r +-',1:57, err2, 'b -', 'LineWidth',2); 
% legend('Algorithm 1', 'MDAL for l_{0} minimization')
% xlabel('k (iteration number)');
% ylabel('error value');

% %Lena256 Motion sigma=3.0
% load(['./Results/Lena256_Motionsigma3_ErrCurve.mat']);
% err1 = errorva1(2:end);
% err2 = errorva2(2:end);
% plot(1:46, log(err1),'r +-',1:80, log(err2), 'b -', 'LineWidth',2); 
% legend('Algorithm 1', 'MDAL for l_{0} minimization')
% xlabel('k (iteration number)');
% ylabel('error value');

% %Lena256 Motion sigma=3.0
% load(['./Results/Lena256_Motionsigma4_ErrCurve.mat']);
% err1 = errorva1(2:end);
% err2 = errorva2(2:end);
% plot(1:56, log(err1),'r +-',1:88, log(err2), 'b -', 'LineWidth',2); 
% legend('Algorithm 1', 'MDAL for l_{0} minimization')
% xlabel('k (iteration number)');
% ylabel('error value');

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%revised version curve
% % load Barbara
load(['./deblurResults/barbara_motionsigma3_errorNLTV.mat']);
errorval1 = errorval;
T1 = T+(1:3)*(11.15-T(3))/3;
load(['./deblurResults/barbara_motionsigma3_errorL0.mat']);
errorval2 = errorval;
T2 = T+(1:87)*(13.81-T(87))/94;
load(['./deblurResults/barbara_motionsigma3_errorAlg1.mat']);
errorval3 = errorval;
T3 = T+(1:42)*(8.14-T(42))/42;
% plot(T1, errorval1,'k *-',T2, errorval2, 'b -',T3, errorval3, 'r  +-', 'LineWidth',2); 
% legend('NL-TV', 'MDAL for l_{0} minimization', 'Algorithm 1')
% xlabel('CPU time (s)');
% ylabel('error value');

plot(T2, log(errorval2), 'b -',T3, log(errorval3), 'r  +-', 'LineWidth',2); 
legend('MDAL for l_{0} minimization', 'Algorithm 1')
xlabel('CPU time (s)');
ylabel('error value');

load(['./deblurResults/barbara_motionsigma4_errorNLTV.mat']);
errorval1 = errorval;
T1 = T+(1:3)*(11.04-T(3))/3;
load(['./deblurResults/barbara_motionsigma4_errorL0.mat']);
errorval2 = errorval;
T2 = T+(1:94)*(14.98-T(94))/94;
load(['./deblurResults/barbara_motionsigma4_errorAlg1.mat']);
errorval3 = errorval;
T3 = T+(1:56)*(10.13-T(56))/56;
% plot(T1, errorval1,'k*-',T2, errorval2, 'b -',T3, errorval3, 'r  +-', 'LineWidth',2); 
% legend('NL-TV', 'MDAL for l_{0} minimization', 'Algorithm 1')
% xlabel('CPU time (s)');
% ylabel('error value');

plot(T2, log(errorval2), 'b -',T3, log(errorval3), 'r  +-', 'LineWidth',2); 
legend('MDAL for l_{0} minimization', 'Algorithm 1')
xlabel('CPU time (s)');
ylabel('error value');


%%%%%%%%%%%%%zebra_gaussian
% load(['./deblurResults/zebra_motionsigma4_errorNLTV.mat']);
% errorval1 = errorval;
% T1 = T+(1:3)*(11.27-T(3))/3;
load(['./deblurResults/zebra_gaussiansigma3_errorL0.mat']);
errorval2 = errorval;
T2=T;
% T2 = T+(1:103)*(8.58-T(103))/103;
load(['./deblurResults/zebra_gaussiansigma3_errorAlg1.mat']);
errorval3 = errorval;
T3=T;
% T3 = T+(1:49)*(5.08-T(49))/49;
% plot(T1, errorval1,'k*-',T2, errorval2, 'b -',T3, errorval3, 'r  +-', 'LineWidth',2); 
% legend('NL-TV', 'MDAL for l_{0} minimization', 'Algorithm 1')
% xlabel('CPU time (s)');
% ylabel('error value');

plot(T2, log(errorval2), 'b -',T3, log(errorval3), 'r  +-', 'LineWidth',2); 
legend('MDAL for l_{0} minimization', 'Algorithm 1')
xlabel('CPU time (s)');
ylabel('error value');

%%
% load(['./deblurResults/zebra_motionsigma4_errorNLTV.mat']);
% errorval1 = errorval;
% T1 = T+(1:3)*(11.27-T(3))/3;
load(['./deblurResults/zebra_gaussiansigma4_errorL0.mat']);
errorval2 = errorval;
T2=T;
% T2 = T+(1:103)*(8.58-T(103))/103;
load(['./deblurResults/zebra_gaussiansigma4_errorAlg1.mat']);
errorval3 = errorval;
T3=T;
% T3 = T+(1:49)*(5.08-T(49))/49;
% plot(T1, errorval1,'k*-',T2, errorval2, 'b -',T3, errorval3, 'r  +-', 'LineWidth',2); 
% legend('NL-TV', 'MDAL for l_{0} minimization', 'Algorithm 1')
% xlabel('CPU time (s)');
% ylabel('error value');

plot(T2, log(errorval2), 'b -',T3, log(errorval3), 'r  +-', 'LineWidth',2); 
legend('MDAL for l_{0} minimization', 'Algorithm 1')
xlabel('CPU time (s)');
ylabel('error value');


%%%%%»­Í¼
figure(1);
imshow(u,[]);
hold on
plot(130:220,166,'r-', 'LineWidth',2);
plot(130:220,256,'r-', 'LineWidth',2);
plot(130,166:256,'r-', 'LineWidth',2);
plot(220,166:256,'r-', 'LineWidth',2);
plot(1,10:180,'b-', 'LineWidth',2);
plot(61,10:180,'b-', 'LineWidth',2);
plot(1:61,10,'b-', 'LineWidth',2);
plot(1:61,180,'b-', 'LineWidth',2);

%house
imshow(u,[]);
hold on
plot(150:256,129,'r-', 'LineWidth',2);
plot(150:256,256,'r-', 'LineWidth',2);
plot(150,129:256,'r-', 'LineWidth',2);
plot(256,129:256,'r-', 'LineWidth',2);

%zebra
imshow(u,[]);
hold on
plot(1,1:55,'r-', 'LineWidth',2);
plot(80,1:55,'r-', 'LineWidth',2);
plot(1:80,1,'r-', 'LineWidth',2);
plot(1:80,55,'r-', 'LineWidth',2);
plot(180,50:110,'b-', 'LineWidth',2);
plot(250,50:110,'b-', 'LineWidth',2);
plot(180:250,50,'b-', 'LineWidth',2);
plot(180:250,110,'b-', 'LineWidth',2);

imshow(u(1:55,1:80),[])
imshow(u(50:110,180:250),[])


