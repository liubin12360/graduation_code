%%% LSTM������ʵ������
%% ����˵��
%  1������Ϊ7�죬�ĸ�ʱ���Ŀյ����ģ���ǰ�����Ʋ���ĸ�ѵ�����������ơ���������Ϊ����
%  2��LSTM����������Ϊ12��������Ϊ4�������ؽ��18��

clear all;
clc;
%% ���ݼ��أ�����һ������
[train_data,test_data]=LSTM_data_process();
data_length=size(train_data,1);
data_num=size(train_data,2);
%% ���������ʼ��
% ���������
input_num=45;
cell_num=18;
output_num=15;
% �������ŵ�ƫ��
bias_input_gate=rand(1,cell_num);
bias_forget_gate=rand(1,cell_num);
bias_output_gate=rand(1,cell_num);
% ab=1.2;
% bias_input_gate=ones(1,cell_num)/ab;
% bias_forget_gate=ones(1,cell_num)/ab;
% bias_output_gate=ones(1,cell_num)/ab;
%����Ȩ�س�ʼ��
ab=20;
weight_input_x=rand(input_num,cell_num)/ab;
weight_input_h=rand(output_num,cell_num)/ab;
weight_inputgate_x=rand(input_num,cell_num)/ab;
weight_inputgate_c=rand(cell_num,cell_num)/ab;
weight_forgetgate_x=rand(input_num,cell_num)/ab;
weight_forgetgate_c=rand(cell_num,cell_num)/ab;
weight_outputgate_x=rand(input_num,cell_num)/ab;
weight_outputgate_c=rand(cell_num,cell_num)/ab;

%hidden_outputȨ��
weight_preh_h=rand(cell_num,output_num);

%����״̬��ʼ��
cost_gate=1e-10;
h_state=rand(output_num,data_num);
cell_state=rand(cell_num,data_num);
%% ����ѵ��ѧϰ
for iter=1:15000
    yita=0.08;            %ÿ�ε���Ȩ�ص�������
    for m=1:data_num
        %ǰ������
        if(m==1)
            gate=tanh(train_data(:,m)'*weight_input_x);
            input_gate_input=train_data(:,m)'*weight_inputgate_x+bias_input_gate;
            output_gate_input=train_data(:,m)'*weight_outputgate_x+bias_output_gate;
            for n=1:cell_num
                input_gate(1,n)=1/(1+exp(-input_gate_input(1,n)));
                output_gate(1,n)=1/(1+exp(-output_gate_input(1,n)));
            end
            forget_gate=zeros(1,cell_num);
            forget_gate_input=zeros(1,cell_num);
            cell_state(:,m)=(input_gate.*gate)';
        else
            gate=tanh(train_data(:,m)'*weight_input_x+h_state(:,m-1)'*weight_input_h);
            input_gate_input=train_data(:,m)'*weight_inputgate_x+cell_state(:,m-1)'*weight_inputgate_c+bias_input_gate;
            forget_gate_input=train_data(:,m)'*weight_forgetgate_x+cell_state(:,m-1)'*weight_forgetgate_c+bias_forget_gate;
            output_gate_input=train_data(:,m)'*weight_outputgate_x+cell_state(:,m-1)'*weight_outputgate_c+bias_output_gate;
            for n=1:cell_num
                input_gate(1,n)=1/(1+exp(-input_gate_input(1,n)));
                forget_gate(1,n)=1/(1+exp(-forget_gate_input(1,n)));
                output_gate(1,n)=1/(1+exp(-output_gate_input(1,n)));
            end
            cell_state(:,m)=(input_gate.*gate+cell_state(:,m-1)'.*forget_gate)';   
        end
        pre_h_state=tanh(cell_state(:,m)').*output_gate;
        h_state(:,m)=(pre_h_state*weight_preh_h)';
        %������
        Error=h_state(:,m)-test_data(:,m);
        Error_Cost(1,iter)=sum(Error.^2);
        if(Error_Cost(1,iter)<cost_gate)
            flag=1;
            break;
        else
            [   weight_input_x,...
                weight_input_h,...
                weight_inputgate_x,...
                weight_inputgate_c,...
                weight_forgetgate_x,...
                weight_forgetgate_c,...
                weight_outputgate_x,...
                weight_outputgate_c,...
                weight_preh_h ]=LSTM_updata_weight(m,yita,Error,...
                                                   weight_input_x,...
                                                   weight_input_h,...
                                                   weight_inputgate_x,...
                                                   weight_inputgate_c,...
                                                   weight_forgetgate_x,...
                                                   weight_forgetgate_c,...
                                                   weight_outputgate_x,...
                                                   weight_outputgate_c,...
                                                   weight_preh_h,...
                                                   cell_state,h_state,...
                                                   input_gate,forget_gate,...
                                                   output_gate,gate,...
                                                   train_data,pre_h_state,...
                                                   input_gate_input,...
                                                   output_gate_input,...
                                                   forget_gate_input);
                
        end
    end
    if(Error_Cost(1,iter)<cost_gate)
        break;
    end
end
%% ����Error-Cost����ͼ
% for n=1:1:iter
%     text(n,Error_Cost(1,n),'*');
%     axis([0,iter,0,1]);
%     title('Error-Cost����ͼ');   
% end
for n=1:100:iter
    semilogy(n,Error_Cost(1,n),'-*');
    hold on;
    title('Error-Cost����ͼ');   
end
%% ʹ�õ��������ݼ���
%���ݼ���
test_final=[1.1857 1.1858 1.1858 1.1859 1.1859 1.1858 1.1859 1.1859 1.1859 1.186 1.186 1.186 1.1861 1.1863 1.1864 1.1864 1.1865 1.1865 1.1866 1.1866 1.1867 1.1868 1.1868 1.1869 1.187 1.1871 1.1873 1.1874 1.1875 1.1874 1.1875 1.1876 1.1878 1.1879 1.1878 1.188 1.1882 1.1884 1.1883 1.1885 1.1887 1.1888 1.189 1.1892 1.1891 ]';
test_final=test_final/sqrt(sum(test_final.^2));
test_output=test_data(:,4);
%ǰ��
m=4;
gate=tanh(test_final'*weight_input_x+h_state(:,m-1)'*weight_input_h);
input_gate_input=test_final'*weight_inputgate_x+cell_state(:,m-1)'*weight_inputgate_c+bias_input_gate;
forget_gate_input=test_final'*weight_forgetgate_x+cell_state(:,m-1)'*weight_forgetgate_c+bias_forget_gate;
output_gate_input=test_final'*weight_outputgate_x+cell_state(:,m-1)'*weight_outputgate_c+bias_output_gate;
for n=1:cell_num
    input_gate(1,n)=1/(1+exp(-input_gate_input(1,n)));
    forget_gate(1,n)=1/(1+exp(-forget_gate_input(1,n)));
    output_gate(1,n)=1/(1+exp(-output_gate_input(1,n)));
end
cell_state_test=(input_gate.*gate+cell_state(:,m-1)'.*forget_gate)';
pre_h_state=tanh(cell_state_test').*output_gate;
h_state_test=(pre_h_state*weight_preh_h)'
test_output

figure(2)
plot(h_state_test,':or');
hold on
plot(test_output,'-*');
legend('forecasting','actural')
title('LSTMresult','fontsize',12)
ylabel('power_output','fontsize',12)
xlabel('test time','fontsize',12)
%set(gcf,'color','white');
%set(gca,'color','none');
%set(gca,'XTick',[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22])
%set(gca,'XTickLabel',{'7:30','8:00','8:30','9:00','9:30','10:00','10:30','11:00','11:30','12:00','12:30','13:00','13:30','14:00','14:30','15:00','15:30','16:00','16:30','17:00','17:30','18:00'})
grid
hold off

error=abs(h_state_test-test_output);
figure(3)
plot(error,'-*')
legend('forecasting error')
title('LSTMforecasting error','fontsize',12)
ylabel('error','fontsize',12)
xlabel('test time','fontsize',12)
%set(gcf,'color','white');
%set(gca,'color','none');
%set(gca,'XTick',[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22])
%set(gca,'XTickLabel',{'7:30','8:00','8:30','9:00','9:30','10:00','10:30','11:00','11:30','12:00','12:30','13:00','13:30','14:00','14:30','15:00','15:30','16:00','16:30','17:00','17:30','18:00'})
grid
hold off









