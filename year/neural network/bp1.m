%����
x=[676 825 774 716 940 1159 1384 1524 1668 1688 1958 2031 2234 2566 2820 3006 3093 3277 3514 3770 4107 ];
lag=5;    % �Իع����
iinput=x;    % xΪԭʼ���У���������
n=length(iinput);

%׼��������������
inputs=zeros(lag,n-lag);
for i=1:n-lag
    inputs(:,i)=iinput(i:i+lag-1)';
end
targets=x(lag+1:end);

%��������
hiddenLayerSize = 11; %���ز���Ԫ����
net = fitnet(hiddenLayerSize);

% �������ϣ�����ѵ�������Ժ���֤���ݵı���
%net.divideParam.trainRatio = 70/100;
%net.divideParam.valRatio = 15/100;
%net.divideParam.testRatio = 15/100;

%ѵ������
[net,tr] = train(net,inputs,targets);
%% ����ͼ���ж���Ϻû�
yn=net(inputs);
errors=targets-yn;
figure, ploterrcorr(errors)                      %������������������20lags��

%% ����Ԥ������Ԥ�⼸��ʱ���
fn=3;  %Ԥ�ⲽ��Ϊfn
f_in=iinput(n-lag+1:end)';
f_out=zeros(1,fn);  %Ԥ�����
% �ಽԤ��ʱ���������ѭ�������������������
for i=1:fn
    f_out(i)=net(f_in);
    f_in=[f_in(2:end);f_out(i)];
end
f_in
f_out
% ����Ԥ��ͼ
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

