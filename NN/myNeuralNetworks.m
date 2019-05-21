function [train_accuracy,test_accuracy,sim_result] = myNeuralNetworks(train_factor,train_result,test_factor,test_result,netstructure,learning_rate,batch_size,training_times,sim_factor)
%确定训练集和测试集的大小
[input_size,train_size] = size(train_factor);
[some,test_size] = size(test_factor);
[some1,sim_size] = size(sim_factor);
%初始化网络
layer_num = length(netstructure);
W = cell(1,layer_num-1);
B = cell(1,layer_num-1);
for i = 2:layer_num
    W{i-1}= 0.5*rand(netstructure(i),netstructure(i-1))-0.1;   
    B{i-1}= 0.5*rand(netstructure(i),1)-0.1;    
end
%读入数据开始训练
for i = 1:training_times
    %准备单次训练样本
   start_index = mod(i*batch_size,train_size);
   if start_index==0
      start_index = 1; 
   end
   end_index = min(start_index+batch_size,train_size);
   temp_size = end_index-start_index+1;
   samin = train_factor(:,start_index:end_index);
   samout = train_result(:,start_index:end_index);
   
   %前向传播过程
   Hidden_layer = cell(1,layer_num-1);     %保存各层的激活值
   %计算第一层的传播值
   temp = logsig(W{1}*samin+repmat(B{1},1,temp_size));
   Hidden_layer{1} = temp;
   %计算中间隐藏层的值
   for j = 2:layer_num-2
       temp = logsig(W{j}*temp+repmat(B{j},1,temp_size));
       Hidden_layer{j} = temp;
   end
   %计算输出层的值
   temp=W{layer_num-1}*temp+repmat(B{layer_num-1},1,temp_size);
   Hidden_layer{layer_num-1} = temp;
   %计算误差
   Error=samout-temp; 
   train_accuracy = Error;
   %反向传播过程
   %计算各层损失
   D = cell(1,layer_num-1);
   D{layer_num-1} = Error;
   for m = layer_num-2:-1:1
      D{m} = W{m+1}'*D{m+1}.*Hidden_layer{m}.*(1-Hidden_layer{m});
   end
   %计算各层的偏导数
   dW = cell(1,layer_num-1);
   dB = cell(1,layer_num-1);
   for n = layer_num-1:-1:2
      dW{n}=D{n}*Hidden_layer{n-1}';
      dB{n}=D{n}*ones(temp_size,1);
   end
   dW{1} = D{1}*samin';
   dB{1} = D{1}*ones(temp_size,1);
    
   %更新各层参数
   for h = 1:layer_num-1
      W{h} = W{h}+learning_rate*dW{h};
      B{h} = B{h}+learning_rate*dB{h};
   end
end

%测试集结果
test_temp = logsig(W{1}*test_factor+repmat(B{1},1,test_size));
for j = 2:layer_num-2
    test_temp = logsig(W{j}*test_temp+repmat(B{j},1,test_size));
end
test_temp=W{layer_num-1}*test_temp+repmat(B{layer_num-1},1,test_size);
test_accuracy=test_result-test_temp; 

%仿真结果
sim_temp = logsig(W{1}*sim_factor+repmat(B{1},1,sim_size));
for j = 2:layer_num-2
    sim_temp = logsig(W{j}*sim_temp+repmat(B{j},1,sim_size));
end
sim_result=W{layer_num-1}*sim_temp+repmat(B{layer_num-1},1,sim_size);

end