clc,clear
%load dianqi.txt %原始数据以列向量的方式存放在纯文本文件中
yt = [ 676 825 774 716 940 1159 1384 1524 1668 1688 1958 2031 2234 2566 2820 3006 3093 3277 3514 3770 4107];
n=length(yt);
alpha=[0.9];m=length(alpha);
yhat(1,1:m)=(yt(1)+yt(2))/2;
for i=2:n
 yhat(i,:)=alpha*yt(i-1)+(1-alpha).*yhat(i-1,:);
end 
yhat
err=sqrt(mean((repmat(yt,1,m)-yhat).^2))
yhat1988=alpha*yt(n)+(1-alpha).*yhat(n,:) 

