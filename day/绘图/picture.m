%‘§≤‚(≤‚ ‘£©«˙œﬂ
really =[235.7 241.3 152.2];
test = [244.0 232.9 141.9];
mae=mean(abs(really-test))
mse=(sum((really-test).^2))./3
rmse=sqrt((sum((really-test).^2))./3)
figure(3)
subplot(121)
plot(test,':or');
hold on
plot(really,'-*');
legend('forecasting','actural')
title('result','fontsize',12)
ylabel('output','fontsize',12)
xlabel('test time','fontsize',12)
set(gca,'XTick',[1 2 3 ])
set(gca,'XTickLabel',{'1','2','3'})
grid
hold off

error=abs(test-really)
subplot(122)
plot(error,'-*') 
legend('forecasting error')
title('abs error','fontsize',12)
ylabel('error','fontsize',12)
%set(gca,'YTick',[1 2 3 4 5 6 7 8 9 10 11 12])
%set(gca,'YTickLabel',{'1','2','3','4','5','6','7','8','9','10','11','12'})
xlabel('test time','fontsize',12)
set(gca,'XTick',[1 2 3 ])
set(gca,'XTickLabel',{'1','2','3'})
grid
hold off