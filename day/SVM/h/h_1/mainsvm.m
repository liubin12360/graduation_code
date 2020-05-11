
%% ��ջ�������
close all;
clear;
clc;
format compact;
%% ���ݵ�����
clc;
clear;
close all;
data=xlsread('data1');
ts =  data(1:10,end);%ѵ�������
tsx = data(1:10,1:end-1);%ѵ��������
tts= data(15:15,end);%Ԥ�⼯���
ttx= data(15:15,1:end-1);%Ԥ�⼯����
%% ����Ԥ����,��ԭʼ���ݽ��й�һ��
tsx = tsx';
ttx=ttx';
% mapminmaxΪmatlab�Դ���ӳ�亯��
% ��tsx���й�һ��
[TSX,TSXps] = mapminmax(tsx,-1,1);	%����ֵ��һ��
[TTX,TTXps] = mapminmax(ttx,-1,1);	
% ��TSX����ת��,�Է���libsvm����������ݸ�ʽҪ��
TSX = TSX';
TTX = TTX';

%% ѡ��ع�Ԥ�������ѵ�SVM����c&g

%���в���ѡ��: 
[bestmse,bestc,bestg] = SVMcgForRegress(ts,TSX,-10,10,-10,10);
% ��ӡ����ѡ����psoSVMcgForRegress
disp('��ӡ����ѡ����');
%str = sprintf( 'Best Cross Validation MSE = %g Best c = %g Best g = %g',bestmse,bestc,bestg);
%disp(str);


%% ���ûع�Ԥ�������ѵĲ�������SVM����ѵ��
cmd = ['-c ', num2str(bestc), ' -g ', num2str(bestg) , ' -s 3 -p 0.01'];
model = svmtrain(ts,TSX,cmd);

%% SVM����ع�Ԥ���ָ�����
    N2=length(tts)
    [predict_2,mse_2] = svmpredict(tts,TTX,model)
    RMSE=sqrt((sum((tts-predict_2).^2))/N2)
    B=corrcoef(predict_2,tts);
    %R2=B(2,1)
    MSE=RMSE*RMSE
    MAE=(sum(abs(tts-predict_2)))/N2
    MAPE=(sum(abs(tts-predict_2)./tts))/N2
%% ������������Լ���
figure;
plot(tts,'-o');
hold on;
plot(predict_2,'r-^');
legend('ʵ�����','Ԥ�����');
title('SVMԤ�����ͼ','FontSize',12);
xlabel('������','FontSize',12);
ylabel('���ֵ','FontSize',12);

