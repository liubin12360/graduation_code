%%% LSTM网络结合实例仿真
%% 程序说明
%  1、数据为7天，四个时间点的空调功耗，用前三个推测第四个训练，依次类推。第七天作为检验
%  2、LSTM网络输入结点为12，输出结点为4个，隐藏结点18个

clear all;
clc;
%% 数据加载，并归一化处理
[train_data,test_data]=LSTM_data_process();
data_length=size(train_data,1);
data_num=size(train_data,2);
%% 网络参数初始化
% 结点数设置
input_num=120;
cell_num=20;
output_num=40;
% 网络中门的偏置
bias_input_gate=rand(1,cell_num);
bias_forget_gate=rand(1,cell_num);
bias_output_gate=rand(1,cell_num);
% ab=1.2;
% bias_input_gate=ones(1,cell_num)/ab;
% bias_forget_gate=ones(1,cell_num)/ab;
% bias_output_gate=ones(1,cell_num)/ab;
%网络权重初始化
ab=20;
weight_input_x=rand(input_num,cell_num)/ab;
weight_input_h=rand(output_num,cell_num)/ab;
weight_inputgate_x=rand(input_num,cell_num)/ab;
weight_inputgate_c=rand(cell_num,cell_num)/ab;
weight_forgetgate_x=rand(input_num,cell_num)/ab;
weight_forgetgate_c=rand(cell_num,cell_num)/ab;
weight_outputgate_x=rand(input_num,cell_num)/ab;
weight_outputgate_c=rand(cell_num,cell_num)/ab;

%hidden_output权重
weight_preh_h=rand(cell_num,output_num);

%网络状态初始化
cost_gate=1e-10;
h_state=rand(output_num,data_num);
cell_state=rand(cell_num,data_num);
%% 网络训练学习
for iter=1:20000
    yita=0.09;            %每次迭代权重调整比例
    for m=1:data_num
        %前馈部分
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
        %误差计算
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
%% 绘制Error-Cost曲线图
% for n=1:1:iter
%     text(n,Error_Cost(1,n),'*');
%     axis([0,iter,0,1]);
%     title('Error-Cost曲线图');   
% end
for n=1:100:iter
    semilogy(n,Error_Cost(1,n),'-*');
    hold on;
    title('Error-Cost曲线图');   
end
%% 使用第七天数据检验
%数据加载
test_final=[1.1913 1.1912 1.1912 1.1912 1.1912 1.1912 1.1912 1.1914 1.1915 1.1916 1.1918 1.1918 1.1919 1.1919 1.1919 1.1921 1.1922 1.1925 1.1926 1.1926 1.1926 1.1926 1.1925 1.1925 1.1924 1.1924 1.1923 1.1923 1.1923 1.1922 1.1922 1.1919 1.1918 1.1918 1.1917 1.1916 1.1916 1.1915 1.1915 1.1915 1.1914 1.1914 1.1914 1.1914 1.1913 1.1912 1.1912 1.1911 1.191 1.1909 1.1909 1.1908 1.1907 1.1907 1.1907 1.1908 1.1908 1.1909 1.1912 1.1914 1.1915 1.1918 1.192 1.1922 1.1924 1.1924 1.1924 1.1924 1.1925 1.1925 1.1926 1.1926 1.1927 1.1928 1.1928 1.1928 1.1929 1.1929 1.1928 1.1931 1.1935 1.1936 1.1935 1.1937 1.1938 1.194 1.1942 1.1943 1.1945 1.1945 1.1946 1.1947 1.1948 1.1949 1.1949 1.1951 1.1952 1.1954 1.1955 1.1955 1.1956 1.1957 1.1957 1.1958 1.1959 1.1962 1.1965 1.1968 1.1969 1.1973 1.1974 1.1976 1.1977 1.1978 1.1979 1.198 1.1982 1.1982 1.1983 1.1984]';
test_final=test_final/sqrt(sum(test_final.^2));
test_output=test_data(:,4);
%前馈
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









