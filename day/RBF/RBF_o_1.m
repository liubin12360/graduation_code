clc;
clear;
close all;
data=xlsread('D:\\�о����ڼ�\\��ҵ�������\\�ϴ�GitHub\\day\\ŷʽ����\\data1');

%% �������� ������� 
% ѵ������
P_train = data((1:10),1:3)'; %ѵ������
T_train = data((1:10),4)';%ѵ�����
% ��������
P_test = data(15,1:3)'; %Ԥ������
T_test = data(15,4)';%Ԥ�����

tic

%% ��һ��
% ѵ����
[Pn_train,inputps] = mapminmax(P_train,-1,1);
Pn_test = mapminmax('apply',P_test,inputps);
% ���Լ�
[Tn_train,outputps] = mapminmax(T_train,-1,1);
Tn_test = mapminmax('apply',T_test,outputps);

%% ���罨����ѵ��
Spread=10;
net=newrbe(Pn_train,Tn_train,Spread);
view(net)

%% �����Ч����֤

% ���ǽ�ԭ���ݻش�����������Ч����
Tn_sim=sim(net,Pn_test)
% ����һ��
T_sim = mapminmax('reverse',Tn_sim,outputps)
% ����ʹ��ͼ����������Է����Ժ��������Ч��
% ���������
n = length(Tn_test);
%% ��ͼ
figure
plot(1:length(T_test),T_test,'r:*')
hold on
plot(1:length(T_sim),T_sim,'b:o');
xlabel('���Լ�����')
ylabel('���Լ����')
title('RBF���Լ����')
legend('�������','Ԥ�����')
    N2=length(T_test);
    RMSE=sqrt((sum((T_test-T_sim).^2))/N2)
    %B=corrcoef(T_sim,T_test)
    %R2=B(2,1)
    MSE=RMSE*RMSE
    MAE=(sum(abs(T_test-T_sim)))/N2
    MAPE=(sum(abs(T_test-T_sim)./T_test))/N2
    
toc