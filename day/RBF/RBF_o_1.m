clc;
clear;
close all;
data=xlsread('D:\\研究生期间\\毕业论文相关\\上传GitHub\\day\\欧式距离\\data1');

%% 产生输入 输出数据 
% 训练数据
P_train = data((1:10),1:3)'; %训练输入
T_train = data((1:10),4)';%训练输出
% 测试数据
P_test = data(15,1:3)'; %预测输入
T_test = data(15,4)';%预测输出

tic

%% 归一化
% 训练集
[Pn_train,inputps] = mapminmax(P_train,-1,1);
Pn_test = mapminmax('apply',P_test,inputps);
% 测试集
[Tn_train,outputps] = mapminmax(T_train,-1,1);
Tn_test = mapminmax('apply',T_test,outputps);

%% 网络建立和训练
Spread=10;
net=newrbe(Pn_train,Tn_train,Spread);
view(net)

%% 网络的效果验证

% 我们将原数据回带，测试网络效果：
Tn_sim=sim(net,Pn_test)
% 反归一化
T_sim = mapminmax('reverse',Tn_sim,outputps)
% 我们使用图像来看网络对非线性函数的拟合效果
% 均方根误差
n = length(Tn_test);
%% 绘图
figure
plot(1:length(T_test),T_test,'r:*')
hold on
plot(1:length(T_sim),T_sim,'b:o');
xlabel('测试集样本')
ylabel('测试集输出')
title('RBF测试集输出')
legend('期望输出','预测输出')
    N2=length(T_test);
    RMSE=sqrt((sum((T_test-T_sim).^2))/N2)
    %B=corrcoef(T_sim,T_test)
    %R2=B(2,1)
    MSE=RMSE*RMSE
    MAE=(sum(abs(T_test-T_sim)))/N2
    MAPE=(sum(abs(T_test-T_sim)./T_test))/N2
    
toc