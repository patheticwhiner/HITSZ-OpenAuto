% kwv - 计算系统开环增益、转折频率、型别
function [K,wt,v] = kwv(G0)
    Gz = zpk(G0);  
    z = -Gz.z{1};   p = -Gz.p{1};
    v = length(find(p==0)); % 系统型别
    z(z==0)=[];     p(p==0)=[];
    wt = sortrows([z;p]);    % 所有转折频率
    K = Gz.k*prod(z)/prod(p);  % 开环增益
end