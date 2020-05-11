clc,clear
%load fadian.txt %原始数据以列向量的方式存放在纯文本文件中
%yt=fadian; 
%yt = [ 676 825 774 716 940 1159 1384 1524 1668 1688 1958 2031 2234 2566 2820 3006 3093 3277 3514 ];
yt = [ 676 825 774 716 940 1159 1384 1524 1668 1688 1958 2031 2234 2566 2820 3006 3093 3277 3514 3770 4107];
n=length(yt);
figure(1);
plot(1:21,yt,'*');
alpha=0.6; st1(1)=yt(1); st2(1)=yt(1);
for i=2:n
 st1(i)=alpha*yt(i)+(1-alpha)*st1(i-1);
 st2(i)=alpha*st1(i)+(1-alpha)*st2(i-1);
end
a=2*st1-st2;
b=alpha/(1-alpha)*(st1-st2);
yhat=a+b;
yhat;
y2015 = a(n)+1*b(n);
y2016 = a(n)+2*b(n);
y2017 = a(n)+3*b(n);
test_output = [y2015 y2016 y2017]
actual_results = [4334 4653 5057];
error = abs(test_output-actual_results);
error

figure(2)
subplot(2,4,1)
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

subplot(2,4,5)
plot(error,'-*')
legend('forecasting error')
title('Error','fontsize',12)
ylabel('error','fontsize',12)
xlabel('test time','fontsize',12)
grid
hold off


alpha=0.7; st1(1)=yt(1); st2(1)=yt(1);
for i=2:n
 st1(i)=alpha*yt(i)+(1-alpha)*st1(i-1);
 st2(i)=alpha*st1(i)+(1-alpha)*st2(i-1);
end
a=2*st1-st2;
b=alpha/(1-alpha)*(st1-st2);
yhat=a+b;
yhat;
y2015 = a(n)+1*b(n);
y2016 = a(n)+2*b(n);
y2017 = a(n)+3*b(n);
test_output = [y2015 y2016 y2017]
actual_results = [4334 4653 5057];
error = abs(test_output-actual_results);
error

subplot(2,4,2)
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

subplot(2,4,6)
plot(error,'-*')
legend('forecasting error')
title('Error','fontsize',12)
ylabel('error','fontsize',12)
xlabel('test time','fontsize',12)
grid
hold off


alpha=0.8; st1(1)=yt(1); st2(1)=yt(1);
for i=2:n
 st1(i)=alpha*yt(i)+(1-alpha)*st1(i-1);
 st2(i)=alpha*st1(i)+(1-alpha)*st2(i-1);
end
a=2*st1-st2;
b=alpha/(1-alpha)*(st1-st2);
yhat=a+b;
yhat;
y2015 = a(n)+1*b(n);
y2016 = a(n)+2*b(n);
y2017 = a(n)+3*b(n);
test_output = [y2015 y2016 y2017]
actual_results = [4334 4653 5057];
error = abs(test_output-actual_results);
error

subplot(2,4,3)
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

subplot(2,4,7)
plot(error,'-*')
legend('forecasting error')
title('Error','fontsize',12)
ylabel('error','fontsize',12)
xlabel('test time','fontsize',12)
grid
hold off


alpha=0.9; st1(1)=yt(1); st2(1)=yt(1);
for i=2:n
 st1(i)=alpha*yt(i)+(1-alpha)*st1(i-1);
 st2(i)=alpha*st1(i)+(1-alpha)*st2(i-1);
end
a=2*st1-st2;
b=alpha/(1-alpha)*(st1-st2);
yhat=a+b;
yhat;
y2015 = a(n)+1*b(n);
y2016 = a(n)+2*b(n);
y2017 = a(n)+3*b(n);
test_output = [y2015 y2016 y2017]
actual_results = [4334 4653 5057];
error = abs(test_output-actual_results);
error


subplot(2,4,4)
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

subplot(2,4,8)
plot(error,'-*')
legend('forecasting error')
title('Error','fontsize',12)
ylabel('error','fontsize',12)
xlabel('test time','fontsize',12)
grid
hold off