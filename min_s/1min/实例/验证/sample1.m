

train_data_initial= [0.4413 0.4707 0.6953 0.8133 0.4379 0.4677 0.6981 0.8002 0.4517 0.4725 0.7006 0.8201;
                     0.4379 0.4677 0.6981 0.8002 0.4517 0.4725 0.7006 0.8201 0.4557 0.4790 0.7019 0.8211;
                     0.4517 0.4725 0.7006 0.8201 0.4557 0.4790 0.7019 0.8211 0.4601 0.4911 0.7101 0.8298]';
test_data_initial=[0.4557 0.4790 0.7019 0.8211;
                   0.4612 0.4845 0.7188 0.8312;
                   0.4601 0.4811 0.7101 0.8298;
                   0.4615 0.4891 0.7201 0.8330]';

data_length=size(train_data_initial,1);                
data_num=size(train_data_initial,2)
num = size(test_data_initial,2)
%%归一化过程
for n=1:data_num
    train_data(:,n)=train_data_initial(:,n)/sqrt(sum(train_data_initial(:,n).^2));
end
train_data_initial(:,1)
train_data_initial(:,1).^2
sum(train_data_initial(:,1).^2)
sqrt(sum(train_data_initial(:,1).^2))
train_data(:,1)=train_data_initial(:,1)/sqrt(sum(train_data_initial(:,1).^2))
train_data
for m=1:size(test_data_initial,2)
    test_data(:,m)=test_data_initial(:,m)/sqrt(sum(test_data_initial(:,m).^2));
end
test_data
test_final=[0.4557 0.4790 0.7019 0.8211 0.4601 0.4811 0.7101 0.8298 0.4612 0.4845 0.7188 0.8312]';
