# -*- coding: utf-8 -*-
"""
Created on Fri May  8 16:42:43 2020

@author: lenovo
"""

# -*- coding: utf-8 -*-
"""
Created on Fri May  8 15:14:59 2020

@author: lenovo
"""

import pandas as pd
import numpy as np
import math
x = pd.DataFrame([
	[2014/9/13	,95 	,16 ,79 	],
	[2013/12/9	,0 ,	5 	,95 ],
	[2013/12/10,	30 ,	4 	,94 ],
	[2013/12/11,	33 ,	4 	,90 ],
	[2013/12/12,	31 ,	5 	,95 ],
	[2013/12/13,	9 ,	7 	,95 ],
	[2013/12/14,	32 ,	8 	,86 ],
	[2013/12/15,	12 	,10 	,92 ],
	[2013/12/16,	8 	,11 	,92 ],
	[2013/12/17,	17 ,	6 	,93 ],
	[2013/12/18,	27 ,	8 	,91 ],
	[2013/12/19,	29 ,	6 	,85 ],
	[2013/12/20,	35 ,	6 	,85 ],
	[2013/12/21,	6 	,10 	,89 ],
	[2013/12/22,	25 ,	8 	,79 ],
	[2013/12/23,	8 ,	8 	,89 ],
	[2013/12/24,	13 ,	8 	,87 ],
	[2013/12/25,	27 ,	5 	,90 ],
	[2013/12/26,	33 ,	4 	,93 ],
	[2013/12/27,	11 ,	9 	,83 ],
	[2013/12/28,	34 ,	5 	,82 ],
	[2013/12/29,	40 ,	3 	,87 ],
	[2013/12/30,	8 ,	8 	,88 ],
	[2013/12/31,	11 ,	7 	,93 ],
	[2014/1/1	,7 ,	8 	,92 ],
	[2014/1/2	,42 ,	9 	,87 ],
	[2014/1/3	,26 ,	8 	,84 ],
	[2014/1/4	,13 ,	7 	,88 ],
	[2014/1/5	,26 ,	5 	,90 ],
	[2014/1/6	,26 	,11 	,84 ],
	[2014/1/7	,23 	,10 	,83 ],
	[2014/1/8	,29 ,	8 	,90 ],
	[2014/1/9	,24 ,	8 	,83 ],
	[2014/1/10,	41 ,	6 	,88 ],
	[2014/1/11,	47 ,	6 	,86 ],
	[2014/1/12,	46 ,	3 	,90 ],
	[2014/1/13,	41 ,	7 	,88 ],
	[2014/1/14,	48 ,	5 	,87 ],
	[2014/1/15,	14 ,	8 	,95 ],
	[2014/1/16,	35 ,	8 	,89 ],
	[2014/1/17,	26 ,	7 	,91 ],
	[2014/1/18,	30 ,	8 	,88 ],
	[2014/1/19,	39 ,	7 	,88 ],
	[2014/1/20,	30 ,	3 	,92 ],
	[2014/1/21,	24 ,	2 	,95 ],
	[2014/1/22,	25 ,	6 	,93 ],
	[2014/1/23,	27 ,	5 	,88 ],
	[2014/1/24,	40 ,	4 	,88 ],
	[2014/1/25,	28 ,	7 	,92 ],
	[2014/1/26,	9 ,	5 	,87 ],
	[2014/1/27,	42 ,	4 	,86 ],
	[2014/1/28,	54 ,	6 	,90 ],
	[2014/1/29,	24 ,	5 	,88 ],
	[2014/1/30,	35 ,	6 	,91 ],
	[2014/1/31,	30 ,	5 	,92 ],
	[2014/2/1	,3 ,	7 	,88 ],
	[2014/2/2	,67 ,	7 	,80 ],
	[2014/2/3	,65 ,	6 	,86 ],
	[2014/2/4	,60 ,	6 	,83 ],
	[2014/2/5	,41 ,	8 	,83 ],
	[2014/2/6	,18 ,	7 	,87 ],
	[2014/2/7	,53 ,	7 	,85 ],
	[2014/2/8	,69 ,	8 	,82 ],
	[2014/2/9	,43 ,	7 	,72 ],
	[2014/2/10,	28 ,	5 	,91 ],
	[2014/2/11,	34 ,	4 	,85 ],
	[2014/2/12,	24 ,	5 	,82 ],
	[2014/2/13,	56 ,	5 	,74 ],
	[2014/2/14,	1 ,	3 	,87 ],
	[2014/3/23,	56 ,	5 	,86 ],
	[2014/3/24,	187 ,	6 	,77 ],
	[2014/3/25,	163 ,	9 	,70 ],
	[2014/3/26,	76 ,	5 	,85 ],
	[2014/3/27,	145 ,	7 	,80 ],
	[2014/3/28,	145 ,	8 	,80 ],
	[2014/3/29,	171 	,12 	,74 ],
	[2014/3/30,	136 	,13 	,69 ],
	[2014/3/31,	66 	,13 	,76 ],
	[2014/4/1	,179 	,13 	,75 ],
	[2014/4/2	,141 	,13 	,79 ],
	[2014/4/3	,111 	,13 	,80 ],
	[2014/4/4	,53 	,12 	,84 ],
	[2014/4/5	,147 	,12 	,78 ],
	[2014/4/6	,58 	,14 	,88 ],
	[2014/4/7	,51 	,13 	,91 ],
	[2014/4/8	,110 ,	9 	,69 ],
	[2014/4/9	,192 	,11 	,69 ],
	[2014/4/10,	143 	,12 	,69 ],
	[2014/4/11,	124 	,12 	,71 ],
	[2014/4/12,	115 	,10 	,75 ],
	[2014/4/13,	205 	,11 	,66 ],
	[2014/4/14,	164 	,10 	,63 ],
	[2014/4/15,	186 ,	9 	,65 ],
	[2014/4/16,	222 ,	9 	,69 ],
	[2014/4/17,	140 	,11 	,70 ],
	[2014/4/18,	131 ,	9 	,69 ],
	[2014/4/19,	151 	,10 	,66 ],
	[2014/4/20,	47 	,11 	,88 ],
	[2014/4/21,	187 	,14 	,76 ],
	[2014/4/22,	100 	,12 	,81 ],
	[2014/4/23,	157 	,13 	,77 ],
	[2014/4/24,	158 	,14 	,75 ],
	[2014/4/25,	74 	,12 	,89 ],
	[2014/4/26,	104 	,11 	,86 ],
	[2014/4/27,	140 	,12 	,78 ],
	[2014/4/28,	207 	,14 	,75 ],
	[2014/4/29,	95 	,13 	,83 ],
	[2014/4/30,	185 	,14 	,76 ],
	[2014/5/1	,67 	,11 	,88 ],
	[2014/5/2	,72 	,10 	,80 ],
	[2014/5/3	,113 ,	8 	,66 ],
	[2014/5/4	,223 	,10 	,67 ],
	[2014/5/5	,198 	,13 	,67 ],
	[2014/5/6	,194 	,15 	,67 ],
	[2014/5/7	,144 	,13 	,69 ],
	[2014/5/8	,59 	,12 	,85 ],
	[2014/5/9	,193 	,14 	,68 ],
	[2014/5/10,	141 	,13 	,77 ],
	[2014/5/11,	109 	,11 	,75 ],
	[2014/5/12,	152 	,12 	,77 ],
	[2014/5/13,	142 	,11 	,85 ],
	[2014/5/14,	199 	,12 	,76 ],
	[2014/5/15,	210 	,13 	,72 ],
	[2014/5/16,	258 	,15 	,64 ],
	[2014/5/17,	183 	,17 	,71 ],
	[2014/5/18,	268 	,18 	,66 ],
	[2014/5/19,	268 	,19 	,63 ],
	[2014/5/20,	202 	,18 	,73 ],
	[2014/5/21,	129 	,16 	,76 ],
	[2014/5/22,	162 	,15 	,78 ],
	[2014/5/23,	185 	,15 	,72 ],
	[2014/5/24,	171 	,13 	,82 ],
	[2014/5/25,	266 	,14 	,70 ],
	[2014/5/26,	127 	,15 	,75 ],
	[2014/5/27,	44 	,13 	,94 ],
	[2014/5/28,	62 	,14 	,93 ],
	[2014/5/29,	142 	,15 	,84 ],
	[2014/5/30,	244 	,15 	,69 ],
	[2014/5/31,	180 	,13 	,71 ],
	[2014/6/1	,240 	,17 	,67 ],
	[2014/6/2	,87 	,15 	,84 ],
	[2014/6/3	,147 	,15 	,82 ],
	[2014/6/4	,124 	,13 	,82 ],
	[2014/6/5	,251 	,14 	,66 ],
	[2014/6/6	,279 	,17 	,61 ],
	[2014/6/7	,200 	,19 	,74 ],
	[2014/6/8	,265 	,19 	,64 ],
	[2014/6/9	,203 	,20 	,76 ],
	[2014/6/10,	255 	,20 	,63 ],
	[2014/6/11,	218 	,18 	,64 ],
	[2014/6/12,	219 	,19 	,62 ],
	[2014/6/13,	177 	,20 	,65 ],
	[2014/6/14,	127 	,17 	,72 ],
	[2014/6/15,	106 	,15 	,70 ],
	[2014/6/16,	100 	,14 	,78 ],
	[2014/6/17,	261 	,16 	,64 ],
	[2014/6/18,	176 	,16 	,75 ],
	[2014/6/19,	95 	,15 	,77 ],
	[2014/6/20,	167 	,15 	,71 ],
	[2014/6/21,	268 	,18 	,62 ],
	[2014/6/22,	263 	,18 	,66 ],
	[2014/6/23,	193 	,19 	,68 ],
	[2014/6/24,	173 	,18 	,73 ],
	[2014/6/25,	178 	,16 	,66 ],
	[2014/6/26,	166 	,16 	,65 ],
	[2014/6/27,	175 	,18 	,71 ],
	[2014/6/28,	77 	,15 	,82 ],
	[2014/6/29,	175 	,14 	,80 ],
	[2014/6/30,	181 	,16 	,71 ],
	[2014/7/1	,185 	,17 	,65 ],
	[2014/7/2	,235 	,16 	,69 ],
	[2014/7/3	,281 	,21 	,57 ],
	[2014/7/4	,268 	,21 	,59 ],
	[2014/7/5	,79 	,18 	,84 ],
	[2014/7/6	,151 	,18 	,72 ],
	[2014/7/7	,221 	,17 	,66 ],
	[2014/7/8	,156 	,17 	,69 ],
	[2014/7/9	,180 	,17 	,71 ],
	[2014/7/10,	52 	,15 	,88 ],
	[2014/7/11,	56 	,15 	,93 ],
	[2014/7/12,	125 	,17 	,88 ],
	[2014/7/13,	100 	,18 	,88 ],
	[2014/7/14,	256 	,18 	,65 ],
	[2014/7/15,	171 	,20 	,72 ],
	[2014/7/16,	226 	,21 	,75 ],
	[2014/7/17,	261 	,22 	,70 ],
	[2014/7/18,	252 	,24 	,69 ],
	[2014/7/19,	177 	,23 	,76 ],
	[2014/7/20,	123 	,21 	,81 ],
	[2014/7/21,	159 	,21 	,79 ],
	[2014/7/22,	237 	,20 	,75 ],
	[2014/7/23,	256 	,22 	,68 ],
	[2014/7/24,	249 	,23 	,63 ],
	[2014/7/25,	122 	,22 	,72 ],
	[2014/7/26,	197 	,22 	,72 ],
	[2014/7/27,	123 	,21 	,73 ],
	[2014/7/28,	89 	,18 	,73 ],
	[2014/7/29,	222 	,20 	,69 ],
	[2014/7/30,	216 	,20 	,62 ],
	[2014/7/31,	215 	,21 	,62 ],
	[2014/8/1	,199 	,20 	,67 ],
	[2014/8/2	,158 	,20 	,77 ],
	[2014/8/3	,184 	,19 	,59 ],
	[2014/8/4	,185 	,19 	,61 ],
	[2014/8/5	,165 	,20 	,65 ],
	[2014/8/6	,160 	,20 	,74 ],
	[2014/8/7	,150 	,20 	,74 ],
	[2014/8/8	,94 	,20 	,83 ],
	[2014/8/9	,215 	,18 	,72 ],
	[2014/8/10,	102 	,18 	,80 ],
	[2014/8/11,	166 	,16 	,69 ],
	[2014/8/12,	166 	,16 	,70 ],
	[2014/8/13,	149 	,17 	,70 ],
	[2014/8/14,	103 	,16 	,80 ],
	[2014/8/15,	148 	,16 	,78 ],
	[2014/8/16,	132 	,16 	,68 ],
	[2014/8/17,	146 	,16 	,65 ],
	[2014/8/18,	125 	,15 	,69 ],
	[2014/8/19,	153 	,14 	,66 ],
	[2014/8/20,	140 	,14 	,65 ],
	[2014/8/21,	149 	,14 	,66 ],
	[2014/8/22,	138 	,15 	,70 ],
	[2014/8/23,	117 	,14 	,67 ],
	[2014/8/24,	100 	,14 	,65 ],
	[2014/8/25,	33 	,15 	,88 ],
	[2014/8/26,	62 	,15 	,88 ],
	[2014/8/27,	166 	,16 	,75 ],
	[2014/8/28,	117 	,18 	,82 ],
	[2014/8/29,	106 	,17 	,77 ],
	[2014/8/30,	113 	,17 	,75 ],
	[2014/8/31,	126 	,16 	,73 ],
	[2014/9/1	,70 	,16 	,87 ],
	[2014/9/2	,94 	,17 	,84 ],
	[2014/9/3	,145 	,18 	,79 ],
	[2014/9/4	,76 	,18 	,82 ],
	[2014/9/5	,67 	,17 	,84 ],
	[2014/9/6	,65 	,17 	,82 ],
	[2014/9/7	,123 	,16 	,80 ],
	[2014/9/8	,156 	,15 	,71 ],
	[2014/9/9	,109 	,16 	,72 ],
	[2014/9/10,	92 	,15 	,75 ]])

#print(x)
x=x.iloc[:,1:]
#print(x)



# 2、提取参考队列和比较队列
ck=x.iloc[0,:]
print(ck)
#print(ck)
cp=x.iloc[1:,:]
print(cp)
#print(cp)
# 计算欧式距离
t=pd.DataFrame()
for j in range(cp.index.size):
    #temp=pd.Series((cp.iloc[j,:]-ck))
    temp=pd.Series(math.sqrt((cp.iloc[j,:][1]-ck[1])**2+(cp.iloc[j,:][2]-ck[2])**2+(cp.iloc[j,:][3]-ck[3])**2))
    
    #print(temp)
    t=t.append(temp,ignore_index=True)
print(t)

t=t.sum(axis=1)

#print(t.sort_values)
result=t.sort_values(ascending=True)
print(result)

'''
#print(t.sort_values)
result=t.sort_values(ascending=False)
print(result)
#print(t.sort_values)
'''