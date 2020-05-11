clc,clear
%load touzi.txt %原始数据以列向量的方式存放在纯文本文件中
yt = [ 676 825 774 716 940 1159 1384 1524 1668 1688 1958 2031 2234 2566 2820 3006 3093 3277 3514 3770 4107];
n=length(yt);
alpha=0.8; st1_0=mean(yt(1:3)); st2_0=st1_0;st3_0=st1_0;
st1(1)=alpha*yt(1)+(1-alpha)*st1_0;
st2(1)=alpha*st1(1)+(1-alpha)*st2_0;
st3(1)=alpha*st2(1)+(1-alpha)*st3_0;
for i=2:n
 st1(i)=alpha*yt(i)+(1-alpha)*st1(i-1);
 st2(i)=alpha*st1(i)+(1-alpha)*st2(i-1);
 st3(i)=alpha*st2(i)+(1-alpha)*st3(i-1);
end
%xlswrite('touzi.xls',[st1',st2',st3'])
st1=[st1_0,st1];st2=[st2_0,st2];st3=[st3_0,st3];
a=3*st1-3*st2+st3;
b=0.5*alpha/(1-alpha)^2*((6-5*alpha)*st1-2*(5-4*alpha)*st2+(4-3*alpha)*st3);
c=0.5*alpha^2/(1-alpha)^2*(st1-2*st2+st3);
yhat=a+b+c;
yhat;
%xlswrite('touzi.xls',yhat','Sheet1','D1')
plot(1:n,yt,'*',1:n,yhat(1:n),'O')
legend('actural','forecasting')
xishu=[c(n+1),b(n+1),a(n+1)];
yhat1989=polyval(xishu,1); 
yhat1990=polyval(xishu,2);
yhat1991=polyval(xishu,3);
test_output = [yhat1989 yhat1990 yhat1991]
actual_results = [4334 4653 5057];