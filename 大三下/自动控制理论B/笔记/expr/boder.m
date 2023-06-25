% boder - 返回系统的近似剪切频率及其相位裕度
% G0 原系统传递函数
% varargin 指定bode图线型
%   'Color'  bode图颜色           'on'/'off'
%   'Slope'  是否标注各频段斜率     'on'/'off'
%   'Corner' 是否标注转折频率       'on'/'off'
% varargout 输出
%   wc 剪切频率 varargout{1}
%   Pm 相位裕度 varargout{2}
%   wt 转折频率 varargout{3}
%   slope 各频段斜率 varargout{4}

function varargout = boder(G0,varargin)
    % 解析键值对参数
    p = inputParser;
    addParameter(p, 'Color', 0);
    addParameter(p, 'Slope', 'off'); % 添加键值对参数及默认值
    addParameter(p, 'Corner', 'off'); % 添加键值对参数及默认值
    parse(p, varargin{:});
    params = p.Results;
    
    switch params.Slope 
        case 'on'
            [lgW,L,wt,slope] = genbode(G0,2);
        case 'off'
            [lgW,L,wt] = genbode(G0,1);
    end
    [wc,Pm] = findwc(G0,lgW,L);
    if params.Color
        semilogx(10.^lgW, L, params.Color);
        for i = 1:length(wt)    % 在图中使用竖线,标注出转折频率
            [~,wt,~] = kwv(G0);
        end
    end
    
    varargout{1} = wc;
    varargout{2} = Pm;
    varargout{3} = 0;
    varargout{4} = 0;
    
    switch params.Corner
        case 'on'
            varargout{3} = wt;
            varargout{4} = 0;
    end
    switch params.Slope 
        case 'on'
            varargout{3} = wt;
            varargout{4} = slope;
    end
end