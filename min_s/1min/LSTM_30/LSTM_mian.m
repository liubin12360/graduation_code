%%% LSTM������ʵ������
%% ����˵��
%  1����ǰ120���Ʋ����30ѵ�����������ơ����������Ϊ����
%  2��LSTM����������Ϊ120��������Ϊ30�������ؽ��18��

clear all;
clc;
%% ���ݼ��أ�����һ������
[train_data,test_data]=LSTM_data_process();
data_length=size(train_data,1);
data_num=size(train_data,2);
%% ���������ʼ��
% ���������
input_num=120;
cell_num=18;
output_num=30;
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
for n=1:50:iter
    semilogy(n,Error_Cost(1,n),'-*');
    hold on;
    title('Error-Cost����ͼ');   
end
%% ʹ�õ��������ݼ���
%���ݼ���
test_final=[4.656 4.556 4.555 4.666 4.655 4.687 4.656 4.551 4.545 4.487 4.499 4.453 4.513 4.412 4.431 4.421 4.425 4.431 4.587 4.511 4.578 4.511 4.412 4.425 4.432 4.43 4.412 4.325 4.319 4.289 4.287 4.256 4.218 4.184 4.012 4.001 3.996 3.889 3.878 3.788 3.756 3.756 3.657 3.456 3.421 3.412 3.342 3.258 3.369 3.152 3.111 3.101 3.002 2.897 2.554 2.522 2.997 2.998 3.056 2.732 3.147 3.181 2.678 2.614 2.598 2.545 2.488 2.451 2.413 2.375 2.312 2.288 2.264 2.265 2.245 2.231 2.21 2.154 2.103 2.091 2.011 1.991 1.853 1.785 1.731 1.77 1.759 1.746 1.936 1.776 1.781 1.757 1.753 1.773 1.873 1.878 1.763 1.744 1.723 1.84 1.842 1.759 1.671 1.662 1.819 1.738 1.654 1.644 1.725 1.886 1.964 1.976 1.911 1.851 1.826 1.739 1.452 1.595 1.581 1.603 ]';
test_final=test_final;% /sqrt(sum(test_final.^2));
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









