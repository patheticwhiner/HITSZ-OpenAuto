% draw_bode - 完整的绘制函数
% method 标注情况
%   case 0 不标注 转折频率 斜率
%   case 1 标注剪切频率 不标注斜率
%   case 2 不标注剪切频率 标注斜率
%   case 3 标注 转折频率 斜率
% G0 原系统传递函数
% varargin 校正环节传递函数

function draw_bode(method, G0, varargin)
    color_plate = ['b','r','g','p'];
    txt = cell(1,nargin-1);
    var = [{1},varargin(:)'];
    wcp = zeros(nargin-1, 2);
    WcP = zeros(nargin-1, 2);
    
    % 解析键值对参数
    vararg = {};
    switch method
        case 0 
            vararg = {'Slope','off','Corner', 'off'};
        case 1
            vararg = {'Slope','off','Corner', 'on'};
        case 2
            vararg = {'Slope','on','Corner', 'off'};
        case 3
            vararg = {'Slope','on','Corner', 'on'};
    end
    p = inputParser;
    addParameter(p, 'Slope', 'off'); % 添加键值对参数及默认值
    addParameter(p, 'Corner', 'off'); % 添加键值对参数及默认值
    parse(p, vararg{:});
    params = p.Results;

    for i = 1:nargin-1
        [wc, Pm, wt, slope] = boder(G0*var{i}, 'Color', color_plate(i),...
                    'Corner',params.Corner,'Slope',params.Slope); hold on;
        wt = real(wt);
        [K,~,~] = kwv(G0);
        if method > 1
            wtt = [wt(1)/30;wt;wt(end)*1e5];
            for j = 1:length(slope)
                % 在图中使用竖线,标注出转折频率
                if j <= length(wt)
                    xline(abs(wt(j)));
                end
                txt1 = [num2str(-slope(j)*20) 'dB/dec'];
                if mod(j,2)==0
                    text(wtt(j),-10*log10(K)-20*i,txt1,'Color', color_plate(i));
                else
                    text(wtt(j),-10*log10(K)-20*i-20,txt1,'Color', color_plate(i));
                end
            end
            if method == 3
                for j = 1:length(wt)
                    % 在图中使用竖线,标注出转折频率
                    xline(abs(wt(j)));
                    txt1 = num2str(abs(wt(j)),3); % 3位有效数字
                    text(abs(wt(j)), 20*log10(K)+20*(i-1), txt1,'Color', color_plate(i)); 
                end
            end
        elseif method == 1
            for j = 1:length(wt)
                % 在图中使用竖线,标注出转折频率
                xline(abs(wt(j)));
                txt1 = num2str(abs(wt(j)),3); % 3位有效数字
                text(abs(wt(j)), 20*log10(K)+20*(i-1), txt1,'Color', color_plate(i)); 
            end
        end
        wcp(i,:) = [wc, Pm];
    end
    for i = 1:nargin-1
        [~,Pm,~,Wcp] = margin(G0*var{i});
        WcP(i,:) = [Wcp, Pm];
    end
    for i = 1:nargin-1
        txt{i} = ['系统',num2str(i)];
        bode(G0*var{i},[color_plate(i),'--']);hold on;
    end
    legend(txt);
    grid on;
    for i = 1:nargin-1
        fprintf("系统%d\n近似剪切频率: %.2f \t 近似相位裕度: %.2f \n",i,wcp(i,1),wcp(i,2));
        fprintf("实际剪切频率: %.2f \t 实际相位裕度: %.2f \n ",WcP(i,1),WcP(i,2));
    end
end