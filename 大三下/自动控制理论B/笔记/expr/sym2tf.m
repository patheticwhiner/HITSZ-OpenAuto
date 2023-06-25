% sym2tf - 符号表达式转换为传递函数
function tf_G=sym2tf(G)
  [num,den]=numden(G); % 提取符号表达式分子和分母
  Num=sym2poly(num);   % 返回多项式项式系数
  Den=sym2poly(den);
  tf_G = tf(Num,Den);
end