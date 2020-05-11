clc,clear
%load y.txt %把原始数据保存在纯文本文件 y.txt 中
%y = [ 676 825 774 716 940 1159 1384 1524 1668 1688 1958 2031 2234 2566 2820 3006 3093 3277 3514 ];
y = [ 676 825 774 716 940 1159 1384 1524 1668 1688 1958 2031 2234 2566 2820 3006 3093 3277 3514 3770 4107];
m1=length(y);
n=2; %n 为移动平均的项数
%n=6;
%n=5;
for i=1:m1-n+1
 yhat1(i)=sum(y(i:i+n-1))/n;
end
yhat1;
m2=length(yhat1);
for i=1:m2-n+1
 yhat2(i)=sum(yhat1(i:i+n-1))/n;
end
yhat2
plot(1:21,y,'*');
%plot(y,'*r')
a21=2*yhat1(end)-yhat2(end);
b21=2*(yhat1(end)-yhat2(end))/(n-1);
y2015=a21+b21;
y2016=a21+2*b21;
y2017=a21+3*b21;
test_output = [y2015 y2016 y2017]
actual_results = [4334 4653 5057]
error = abs(test_output-actual_results);
error

figure(2)
subplot(1,2,1)
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
hold off


%figure(3)
subplot(1,2,2)
plot(error,'-*')
legend('forecasting error')
title('abs error','fontsize',12)
ylabel('error','fontsize',12)
xlabel('test time','fontsize',12)
grid
hold off
