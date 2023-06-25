% genbode - 根据原系统传递函数生成折线bode点
% varargin
%   1 需要标注转折频率
%   2 需要标注幅频特性斜率
%   不输入/输入其他值(默认)：
% varargout
%   lgW 频率点 varargout{1}
%   L   幅频值 varargout{2}
%   wt  转折频率 varargout{3}
%   slope  斜率 varargout{4}
function varargout = genbode(G0,varargin)
    % 将传递函数转化为零极点型，求出转折频率和开环增益
    Gz = zpk(G0);  
    z = -Gz.z{1};   p = -Gz.p{1};
    z(z==0)=[];     p(p==0)=[];
    [K,wt,v] = kwv(G0);
    wtt = [1e-5;wt;wt(end)*1e5];
    
    slope = zeros(1,length(wt)+1);
    slope(1) = v;
    lgw = 0;    l = 20*log10(K);
    lgW = [];   L = [];

    for i = 1:length(wt)+1
        wend = lgw(end);
        % 求出第i段近似bode图斜率
        if(i > 1)
            if(any(z==wt(i-1)))
                slope(i) = slope(i-1) - 1;
            end
            if(any(p==wt(i-1)))
                slope(i) = slope(i-1) + 1;
            end
        end
        % 根据第i段近似bode图斜率计算出对应的bode图离散点
        lgw = log10(wtt(i)):0.01:log10(wtt(i+1));
        l = l(end) - 20*slope(i)*(lgw-wend);
        lgW = [lgW,lgw];
        L = [L,l];
    end
    if nargin>1
        switch varargin{:}
            case 1
                varargout{1} = lgW;
                varargout{2} = L;
                varargout{3} = wt;
            case 2
                varargout{1} = lgW;
                varargout{2} = L;
                varargout{3} = wt;
                varargout{4} = slope;
            default
                varargout{1} = lgW;
                varargout{2} = L;
        end
    else
        varargout{1} = lgW;
        varargout{2} = L;
    end
    
end