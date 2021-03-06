#############自定义函数4 ###################################
#取特定位的有效数字，通过 函数取特定位数的有效数字 #####################

## 4.1 准备阶段，仅针对数字的处理
# "反思  该功能的最优解应当是 ：
# 1 先按照要求取一个round，得到初步结果 round(num)，值相等，但小数位数可能不规范的值
# 2 正则表达式截取 含正负号的整数部分 
# 3 通过对  round(num) 进行 先取绝对值  再加0.0001 (小数点后的0等于要保留的位数，这样，末尾的一就不会造成影响了)
# 4 正则表达式截取 小数点到最后的 1  之间的部分作为小数部分
# 5 拼接整数部分和小数部分，完成格式化输出，只需要五步
# 
# "

neat_round <- function(num,digits=3){  " version 5.0 "
  options(scipen = 200)## 要加一个科学计数法位数拓展
  num <- round(num,digits = digits) 
  zheng_shu_bu_fen  <- trunc(num) 
  zheng_shu_char <- sub("([-+]?[0-9]+)\\.[0-9]*",
                        "\\1",num)###利用正则表达式提取整数部分，防止0开头的负小数时，符号被忽略
  #核心工作流程： 先取绝对值再加1,（确保不是0打头），乘以10的有效位数次方——最后需要的全部都跑到了小数点左边（可以被截取）
  # #然后刨除前面整数部分，取后面的小数部分进行衔接。
  new_xiao_shu <-  abs(num-zheng_shu_bu_fen)  ### 用原数值减整数部分直接得到小数部分,取绝对值,保障是正数. 且首位是0
  new_xiao_shu <- new_xiao_shu+0.1^(digits+1) ### 保留 n位 小数, 就加一个小数点后 n个0,1个1的数,使前面的零强制显示  
  xiao_shu_bu_fen <- substr(new_xiao_shu,3,2+digits)
  final <- paste(zheng_shu_char,".",xiao_shu_bu_fen,sep = "")
  return(final)
}


##demo
#test <- c(0,0.3000,-2.5,3.84,-0,-0.000322)
#neat_round(test,digits = 3)
