import pandas as pd
import numpy as np
x = pd.DataFrame([[2000,0.732,0.836,0.628,0.743], [2001,0.758,0.883,0.688,0.787], [2002,0.859,0.914,0.781,0.929],[2003,1.0125,1.0440,1.0237,0.9847],[2004,1.2356,1.1069,1.2833,1.2363],[2005,1.4013,1.2152,1.5405,1.3182]])

#print(x)
x=x.iloc[:,1:]
print(x)


# 1、数据均值化处理
x_mean=x.mean(axis=1)
#print(x_mean)
for i in range(x.index.size):
    x.iloc[i,:] = x.iloc[i,:]/x_mean[i]

#print(x)


# 2、提取参考队列和比较队列
ck=x.iloc[0,:]
#print(ck)
cp=x.iloc[1:,:]
#print(cp)
# 比较队列与参考队列相减
t=pd.DataFrame()
for j in range(cp.index.size):
    temp=pd.Series(cp.iloc[j,:]-ck)
    #print(temp)
    t=t.append(temp,ignore_index=True)
print(t)


#求最大差和最小差
mmax=t.abs().max().max()
#print(mmax)
mmin=t.abs().min().min()
rho=0.5

#3、求关联系数
ksi=((mmin+rho*mmax)/(abs(t)+rho*mmax))
print(ksi)

#4、求关联度
r=ksi.sum(axis=1)/ksi.columns.size
print(r)

#5、关联度排序，得到结果r3>r2>r1
result=r.sort_values(ascending=False)
print(result)