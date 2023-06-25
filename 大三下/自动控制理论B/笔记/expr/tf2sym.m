% tf2sym - 传递函数转换为符号表达式
function sym_G=tf2sym(G)
  syms s
  [num,den]=tfdata(G);  % 提取传递函数分子和分母
  Num=poly2sym(num,s);  % 把传递函数分子系数转换为符号表达式分子
  Den=poly2sym(den,s);  % 把传递函数分母系数转换为符号表达式分母
  sym_G=Num/Den; 
end