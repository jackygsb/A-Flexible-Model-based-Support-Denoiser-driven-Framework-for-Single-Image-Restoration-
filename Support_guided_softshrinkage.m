function  c =  Support_guided_softshrinkage(beta,lambda2,mu2,M)
Level=length(beta);lambda0=lambda2;
[nD,nD1]=size(beta{1});
for ki = 1:Level 
           V{ki} = sqrt( (M{ki}{1,2}.*beta{ki}{1,2}).^2 + (M{ki}{1,3}.*beta{ki}{1,3}).^2 + (M{ki}{2,1}.*beta{ki}{2,1}).^2 + (M{ki}{2,2}.*beta{ki}{2,2}).^2 + (M{ki}{2,3}.*beta{ki}{2,3}).^2 + (M{ki}{3,1}.*beta{ki}{3,1}).^2 + (M{ki}{3,2}.*beta{ki}{3,2}).^2 + (M{ki}{3,3}.*beta{ki}{3,3}).^2  );
           V{ki}(V{ki}==0) = 1;    
end

for ki=1:Level
% ki=1;
    for ji=1:nD
        for jj=1:nD
            if (ji~=1 || jj~=1)  
                lambda=lambda0*(0.25)^(ki-1);                
                c{ki}{ji,jj} = max(V{ki}-M{ki}{ji,jj}.*(lambda/mu2),0)./V{ki}; 
                c{ki}{ji,jj} =  c{ki}{ji,jj}.*(beta{ki}{ji,jj}) ; 
            else
                c{ki}{ji,jj} = beta{ki}{ji,jj} ; 
            end
        end
    end
end







