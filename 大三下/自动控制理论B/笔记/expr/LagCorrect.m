% LagCorrect - 串联迟后校正
% Gc = LagCorrect(G0,we,ye,method)
% G0 tf形式传递函数
% we 期望的剪切频率（下限）
% ye 期望的相位裕度（下限）
% method 串联迟后校正的方法
%   case 1：相角裕度优先
%   case 2：剪切频率优先

function Gc = LagCorrect(G0,we,ye,method)
    switch method
        case 1
            fprintf('相位裕度优先 串联迟后校正\n');
            delta = input('delta:');
            % 给定相角（单位为度）
            desiredPhase = ye + delta - 180; % 根据实际情况修改给定的相角值
            % 求解频率
            options = optimoptions('fsolve','Display','off');
            wc = fsolve(@(w) angle(evalfr(G0, 1i*w)) - desiredPhase*pi/180, 1, options);
            beta = abs(evalfr(G0,1i*wc));
            t = 10/wc;
        case 2
            fprintf('剪切频率优先 串联迟后校正\n');
            [lgW,L] = genbode(G0);
            dex = abs(lgW-log10(we))<0.01;
            ldex = L(dex);
            beta = 10^(ldex(end)/20);
            t = 10./(we);
    end
    num = [t 1];
    den = [beta.*t 1];
    Gc = tf(num,den);
end
