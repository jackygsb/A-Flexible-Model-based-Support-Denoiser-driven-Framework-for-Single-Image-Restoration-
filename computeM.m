function  M = computeM(itr,m,n,u,img,W,frame,rho) 
% %     u = img ; % Ideal case   
C = W(u);  
Level=length(C);
[nD,nD1]=size(C{1});
     
for ki=1:Level 
    for ji=1:nD
        for jj=1:nD    
            M{ki}{ji,jj} = ones(m,n);
        end
    end
end

thresh = zeros(1,Level) ;
for ki = 1:Level 
    switch frame
        case 0 ; 
            thresh(ki) = max([C{ki}{1,1}(:);C{ki}{1,2}(:);C{ki}{2,1}(:);C{ki}{2,2}(:)]);
        case 1 ;
            thresh(ki) = max([C{ki}{1,1}(:);C{ki}{1,2}(:);C{ki}{1,3}(:);C{ki}{2,1}(:);C{ki}{2,2}(:);C{ki}{2,3}(:);C{ki}{3,1}(:);C{ki}{3,2}(:);C{ki}{3,3}(:)]);
        case 3 ;
            thresh(ki) = max([C{ki}{1,1}(:);C{ki}{1,2}(:);C{ki}{1,3}(:);C{ki}{1,4}(:);C{ki}{1,5}(:);C{ki}{2,1}(:);C{ki}{2,2}(:);C{ki}{2,3}(:);C{ki}{2,4}(:);C{ki}{2,5}(:);C{ki}{3,1}(:);C{ki}{3,2}(:);C{ki}{3,3}(:);C{ki}{3,4}(:);C{ki}{3,5}(:);C{ki}{4,1}(:);C{ki}{4,2}(:);C{ki}{4,3}(:);C{ki}{4,4}(:);C{ki}{4,5}(:);C{ki}{5,1}(:);C{ki}{5,2}(:);C{ki}{5,3}(:);C{ki}{5,4}(:);C{ki}{5,5}(:)]);
        otherwise ; error('we have not yet use this wavelet frame') ;  
    end
end

threshold = max(thresh);

for ki=1:Level 
    for ji=1:nD
        for jj=1:nD           
            logical{ki}{ji,jj} = abs(C{ki}{ji,jj})> threshold/rho;  
     switch itr
         case 1     
                      M{ki}{ji,jj}( logical{ki}{ji,jj}) = 0 ; 
         case 2
                      M{ki}{ji,jj}( logical{ki}{ji,jj}) = 0 ;  
        otherwise 
                      M{ki}{ji,jj}( logical{ki}{ji,jj}) = 0 ;        
     end
end
end
end




  