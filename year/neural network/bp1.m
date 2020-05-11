%程序
x=[676 825 774 716 940 1159 1384 1524 1668 1688 1958 2031 2234 2566 2820 3006 3093 3277 3514 3770 4107 ];
lag=5;    % 自回归阶数
iinput=x;    % x为原始序列（行向量）
n=length(iinput);

%准备输入和输出数据
inputs=zeros(lag,n-lag);
for i=1:n-lag
    inputs(:,i)=iinput(i:i+lag-1)';
end
targets=x(lag+1:end);

%创建网络
hiddenLayerSize = 11; %隐藏层神经元个数
net = fitnet(hiddenLayerSize);

% 避免过拟合，划分训练，测试和验证数据的比例
%net.divideParam.trainRatio = 70/100;
%net.divideParam.valRatio = 15/100;
%net.divideParam.testRatio = 15/100;

%训练网络
[net,tr] = train(net,inputs,targets);
%% 根据图表判断拟合好坏
yn=net(inputs);
errors=targets-yn;
figure, ploterrcorr(errors)                      %绘制误差的自相关情况（20lags）

%% 下面预测往后预测几个时间段
fn=3;  %预测步数为fn
f_in=iinput(n-lag+1:end)';
f_out=zeros(1,fn);  %预测输出
% 多步预测时，用下面的循环将网络输出重新输入
for i=1:fn
    f_out(i)=net(f_in);
    f_in=[f_in(2:end);f_out(i)];
end
f_in
f_out
% 画出预测图
figure(1),plot(1:21,iinput,'b',21:24,[iinput(end),f_out],'r')
test_output = f_out
actual_results = [4334 4653 5057];
error = abs(test_output-actual_results)
figure(2)
plot(test_output,':or');
hold on
plot(actual_results,'-*b');
legend('forecasting','actural')
title('Result','fontsize',12)
ylabel('Output','fontsize',12)
xlabel('test time','fontsize',12)
set(gca,'XTick',[ 1 2 3 ])
set(gca,'XTickLabel',{'1','2','3'})
grid
figure(3)
plot(error,'-*')
legend('forecasting error')
title('Error','fontsize',12)
ylabel('error','fontsize',12)
xlabel('test time','fontsize',12)
grid
hold off

