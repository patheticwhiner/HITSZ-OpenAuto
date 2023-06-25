[TOC]

# 频率校正解题机器

> 说明：工程文件意在
>
> + 探究折线型Bode图与实际幅频特性在求解校正环节中的差异
> + 辅助理解课堂例题与个人实验探究
> + 探究不同条件下选择校正环节的解题策略
>
> 目前版本仍然存在较多缺陷和不足，需要提后来者提供改进

## 示例.m文件

```
Exp1.m	串联超前校正部分堂上例题
Exp2.m	串联迟后校正部分堂上例题
Exp3.m	迟后-超前校正部分堂上例题
Exp4.m	期望频率特性法部分堂上例题
```

## 串联超前校正

```matlab
% LeadCorrect - 串联超前校正
% Gc = LeadCorrect(G0,we,ye,method)
% G0 tf形式传递函数
% we 期望的剪切频率（下限）
% ye 期望的相位裕度（下限）
% method 串联超前校正的方法
%   case 1：相角裕度优先
%   case 2：剪切频率优先
%   case 3：相角裕度优先修正
function Gc = LeadCorrect(G0,we,ye,method)
```

## 串联迟后校正

```matlab
% LagCorrect - 串联迟后校正
% Gc = LagCorrect(G0,we,ye,method)
% G0 tf形式传递函数
% we 期望的剪切频率（下限）
% ye 期望的相位裕度（下限）
% method 串联迟后校正的方法
%   case 1：相角裕度优先
%   case 2：剪切频率优先
function Gc = LagCorrect(G0,we,ye,method)
```

## 主要function引用关系（详情使用help/阅读文件注释）

```
LeadCorrect
├── findwc: 计算系统近似剪切频率及相位裕度
└── genbode: 根据原系统传递函数生成折线bode点

LagCorrect
├── findwc: 计算系统近似剪切频率及相位裕度
└── genbode: 根据原系统传递函数生成折线bode点

draw_bode
├── boder: 返回系统的近似剪切频率、相位裕度、转折频率、折线斜率等信息
│   ├── findwc
│   └── genbode
└── bode: matlab伯德图绘制函数
```
