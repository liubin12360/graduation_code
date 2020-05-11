
train_data_initial= [0.4413 0.4707 0.6953 0.8133 0.4379 0.4677 0.6981 0.8002 0.4517 0.4725 0.7006 0.8201;
                     0.4379 0.4677 0.6981 0.8002 0.4517 0.4725 0.7006 0.8201 0.4557 0.4790 0.7019 0.8211;
                     0.4517 0.4725 0.7006 0.8201 0.4557 0.4790 0.7019 0.8211 0.4601 0.4911 0.7101 0.8298]';
test_data_initial=[0.4557 0.4790 0.7019 0.8211;
                   0.4612 0.4845 0.7188 0.8312;
                   0.4601 0.4811 0.7101 0.8298;
                   0.4615 0.4891 0.7201 0.8330]';

%FlattenedData = test_data_initial(:); % 展开矩阵为一列，然后转置为一行。
%MappedFlattened = mapminmax(FlattenedData, 0, 1) % 归一化。
%MappedData = reshape(MappedFlattened, size(test_data_initial)) % 还原为原始矩阵形式。此处不需转置回去，因为reshape恰好是按列重新排序               

[B1,PS1]=mapminmax(train_data_initial,0,1);
mapminmax('reverse',B1,PS1)
[B2,PS2]=mapminmax(test_data_initial,0,1)
mapminmax('reverse',B2,PS2)