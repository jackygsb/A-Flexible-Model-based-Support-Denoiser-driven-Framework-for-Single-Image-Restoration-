function [gamma,A,B,C]=CoeffOper(op,alpha,beta,a,b)
% This subroutine implement alpha op beta = gamma, where op= + - = * s n l0
Level=length(alpha);
[nD,nD1]=size(alpha{1});
[n,m] =size(alpha{1}{1,1});
if strcmp(op,'*s') 
    gamma = 0;    
end

if strcmp(op,'*+-n') || strcmp(op,'hard+') || strcmp(op,'-n')
    A = 0; B = 0 ; C=0; 
end

for ki=1:Level
    if strcmp(op,'vs') || strcmp(op,'v0')
        vec=0;
        for ji=1:nD
            for jj=1:nD
                if (ji~=1 || jj~=1) && sum(sum(beta{ki}{ji,jj}))~=0
                    vec=vec+alpha{ki}{ji,jj}.^2;
                end
            end
        end
      if strcmp(op,'vs')
          vec=sqrt(vec);
      else
         vec = (vec - beta{ki}{ji,jj}) > 0;
      end
    end
    for ji=1:nD
        for jj=1:nD
            if op=='='
                gamma{ki}{ji,jj}=alpha{ki}{ji,jj};
            elseif op=='-'
                gamma{ki}{ji,jj}=alpha{ki}{ji,jj}-beta{ki}{ji,jj};
            elseif op=='+'
                gamma{ki}{ji,jj}=alpha{ki}{ji,jj}+beta{ki}{ji,jj};
            elseif strcmp(op,'*c')
                gamma{ki}{ji,jj}=alpha{ki}{ji,jj}*beta;
            elseif strcmp(op,'*+')
                gamma{ki}{ji,jj}=alpha{ki}{ji,jj}*a+beta{ki}{ji,jj}*b;
            elseif strcmp(op,'*--')
                gamma{ki}{ji,jj}=alpha{ki}{ji,jj}*b-beta{ki}{ji,jj}*b - a{ki}{ji,jj};    
            elseif strcmp(op,'*+-n')
                gamma{ki}{ji,jj}=alpha{ki}{ji,jj}+beta{ki}{ji,jj}*a;
                A = A + norm(gamma{ki}{ji,jj} - b{ki}{ji,jj},'fro')^2;
            elseif strcmp(op,'*s')
                gamma=sum(sum(alpha{ki}{ji,jj}.*beta{ki}{ji,jj}))+gamma;
            elseif strcmp(op,'-n')
                gamma{ki}{ji,jj} = alpha{ki}{ji,jj} - beta{ki}{ji,jj};
                A = norm(gamma{ki}{ji,jj},'fro')^2+A;
            elseif op=='*'
                gamma{ki}{ji,jj}=alpha{ki}{ji,jj}*beta;
            elseif strcmp(op,'.*')
                gamma{ki}{ji,jj}=alpha{ki}{ji,jj}.*beta{ki}{ji,jj};
            elseif op=='s'
                gamma{ki}{ji,jj}=wthresh(alpha{ki}{ji,jj},'s',beta{ki}{ji,jj});
            elseif strcmp(op,'vs')
                if (ji~=1 || jj~=1) && sum(sum(beta{ki}{ji,jj}))~=0
                    gamma{ki}{ji,jj}=max(vec-beta{ki}{ji,jj},0).*(alpha{ki}{ji,jj}./(vec+1e-20));
                else
                    gamma{ki}{ji,jj}=alpha{ki}{ji,jj};
                end
            elseif strcmp(op,'l0')  
                gamma{ki}{ji,jj}=(alpha{ki}{ji,jj}.^2-beta{ki}{ji,jj}>0).*alpha{ki}{ji,jj};
            elseif strcmp(op,'hard')
                gamma{ki}{ji,jj} = alpha{ki}{ji,jj} - a*beta{ki}{ji,jj};
                gamma{ki}{ji,jj} = (gamma{ki}{ji,jj}.^2 - b{ki}{ji,jj}>0).*gamma{ki}{ji,jj} - alpha{ki}{ji,jj}; 
            elseif strcmp(op,'hard+')
                gamma{ki}{ji,jj} = alpha{ki}{ji,jj} - a*beta{ki}{ji,jj};
                gamma{ki}{ji,jj} = (gamma{ki}{ji,jj}.^2 - b{ki}{ji,jj}>0).*gamma{ki}{ji,jj};
                B = sum(sum(gamma{ki}{ji,jj}~=0))* b{ki}{ji,jj};
                C = sum(sum(alpha{ki}{ji,jj}~=0))* b{ki}{ji,jj};
                gamma{ki}{ji,jj} = gamma{ki}{ji,jj} - alpha{ki}{ji,jj}; 
                A = A + sum(sum(gamma{ki}{ji,jj}.*beta{ki}{ji,jj}));
            elseif strcmp(op,'v0')
                if (ji~=1 || jj~=1) && sum(sum(beta{ki}{ji,jj}))~=0 
                    gamma{ki}{ji,jj}= vec.*alpha{ki}{ji,jj};
                else
                    gamma{ki}{ji,jj}=alpha{ki}{ji,jj};
                end
            elseif strcmp(op,'h')
                if (ji~=1 || jj~=1)
                    gamma{ki}{ji,jj}=wthresh(alpha{ki}{ji,jj},'h',beta{ki}{ji,jj});
                else
                    gamma{ki}{ji,jj}=alpha{ki}{ji,jj};
                end
            end
        end
    end
end