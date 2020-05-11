
%% 清空环境变量
close all;
clear;
clc;
format compact;
%% 数据的载入
clc;
clear;
close all;
data=xlsread('data1');
ts =  data(1:10,end);%训练集输出
tsx = data(1:10,1:end-1);%训练集输入
tts= data(15:15,end);%预测集输出
ttx= data(15:15,1:end-1);%预测集输入
%% 数据预处理,将原始数据进行归一化
tsx = tsx';
ttx=ttx';
% mapminmax为matlab自带的映射函数
% 对tsx进行归一化
[TSX,TSXps] = mapminmax(tsx,-1,1);	%特征值归一化
[TTX,TTXps] = mapminmax(ttx,-1,1);	
% 对TSX进行转置,以符合libsvm工具箱的数据格式要求
TSX = TSX';
TTX = TTX';

%% 选择回归预测分析最佳的SVM参数c&g

%进行参数选择: 
[bestmse,bestc,bestg] = SVMcgForRegress(ts,TSX,-10,10,-10,10);
% 打印参数选择结果psoSVMcgForRegress
disp('打印参数选择结果');
%str = sprintf( 'Best Cross Validation MSE = %g Best c = %g Best g = %g',bestmse,bestc,bestg);
%disp(str);


%% 利用回归预测分析最佳的参数进行SVM网络训练
cmd = ['-c ', num2str(bestc), ' -g ', num2str(bestg) , ' -s 3 -p 0.01'];
model = svmtrain(ts,TSX,cmd);

%% SVM网络回归预测的指标分析
    N2=length(tts)
    [predict_2,mse_2] = svmpredict(tts,TTX,model)
    RMSE=sqrt((sum((tts-predict_2).^2))/N2)
    B=corrcoef(predict_2,tts);
    %R2=B(2,1)
    MSE=RMSE*RMSE
    MAE=(sum(abs(tts-predict_2)))/N2
    MAPE=(sum(abs(tts-predict_2)./tts))/N2
%% 结果分析（测试集）
figure;
plot(tts,'-o');
hold on;
plot(predict_2,'r-^');
legend('实际输出','预测输出');
title('SVM预测输出图','FontSize',12);
xlabel('样本数','FontSize',12);
ylabel('输出值','FontSize',12);

