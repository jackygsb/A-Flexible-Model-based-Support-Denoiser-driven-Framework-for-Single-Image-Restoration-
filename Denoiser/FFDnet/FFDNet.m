function Iout=FFDNet(Noiseimage,imageNoiseSigma)

format compact;
global sigmas; % input noise level or input noise level map
useGPU      = 1; % CPU or GPU. For single-threaded (ST) CPU computation, use "matlab -singleCompThread" to start matlab.
inputNoiseSigma = imageNoiseSigma;  % input noise level
load(fullfile('models','FFDNet_gray.mat'));
Noiseimage=single(Noiseimage);
net = vl_simplenn_tidy(net);
if useGPU
    net = vl_simplenn_move(net, 'gpu') ;
end
   %%% convert to GPU
    if useGPU
        input = gpuArray(Noiseimage);
    end
% set noise level map
    sigmas = inputNoiseSigma; % see "vl_simplenn.m".
   res    = vl_simplenn2(net,input,[],[],'conserveMemory',true,'mode','test'); % matconvnet default
    % res    = vl_ffdnet_concise(net, input);    % concise version of vl_simplenn for testing FFDNet
    %  res    = vl_ffdnet_matlab(net, input); % use this if you did  not install matconvnet; very slow   
    output = res(end).x;
%     if mod(w,2)==1
%         output = output(1:end-1,:);
%     end
%     if mod(h,2)==1
%         output = output(:,1:end-1);
%     end
    %%% convert to CPU
    if useGPU
        output = gather(output);
    end
    Iout=double(output);
