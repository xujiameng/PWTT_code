clc
close all
for_yj=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if for_yj==1
% x_gap=length(x);
% gap=floor(0.03031*x_gap+0.54);

gap=ceil(fs*10 * (length(x)/length(data)));    %每隔gap个点取一个数值

num=0;
while num*gap<length(x)-1-gap
    num=num+1;
    change_X(num)= (  x(1+num*gap)-x(1+(num-1)*gap)  )/x(1+(num-1)*gap);
    change_Y(num)= (  y(1+num*gap)-y(1+(num-1)*gap)  )/y(1+(num-1)*gap);
end


% 
if length(change_X)>31
x_gap=length(change_X);
change_gap=floor(0.03031*x_gap+0.54);
[R,change_X,change_Y]=test_R(change_X,change_Y,change_gap);
end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X=x;Y=y;
if for_yj==0
for i=1:length(X)-1
    for j=i+1:length(X)
    XX(i,j)=(X(j)-X(i))/X(i);
    YY(i,j)=(Y(j)-Y(i))/Y(i);
    end
end
change_X=[];
change_Y=[];
for  i=1:length(XX)-1
    change_X=[change_X,XX(i,i+1:end)];
    change_Y=[change_Y,YY(i,i+1:end)];
end
%%%%%%%%%%%%%%
%%%%%%%%%%%%%%
gap=ceil(length(change_X)/30);
% gap=1;
l=floor(  length(change_X)/gap  );
for i=1:1:l%对pwtt和bp每60个点取平均值，分别赋值给X和Y
    xi=change_X(((i-1)*gap+1):(i*gap));
    yi=change_Y(((i-1)*gap+1):(i*gap));
    mean_X(i)=mean(xi);
    mean_Y(i)=mean(yi);
%     X(i)=median(xi);
%     Y(i)=median(yi);
end
clear change_X;clear change_Y;
change_X=mean_X;
change_Y=mean_Y;

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


plot(change_X,change_Y,'ro');hold on;         
%[b,bint,r,rint,stats]= regress(y,x);
[p1,S1]=polyfit(change_X,change_Y,1);%求得拟合参数
y1=polyval(p1,change_X);%求得拟合的直线

R1=corrcoef(change_X,change_Y);%求得X和Y的相关性
R2=corrcoef(y1,change_Y);%求得y1和Y的相关性
plot(change_X,y1);
xlabel('The percentage change of PWTT','fontsize',10)
ylabel('The percentage change of BP','fontsize',10)
clear R
R=R1(1,2)
p1
clear R
%% 数据采集
reshape_X=change_X;
reshape_Y=change_Y;


test1_X=reshape_X(  find(    abs(reshape_Y)<=0.1   )   );
test1_Y=reshape_Y(  find(    abs(reshape_Y)<=0.1   )   );
 
test2_X=reshape_X(  find(    abs(reshape_Y)<=0.2 & abs(reshape_Y)>0.1   )  );
test2_Y=reshape_Y(  find(    abs(reshape_Y)<=0.2 & abs(reshape_Y)>0.1   )  );

test3_X=reshape_X(  find(    abs(reshape_Y)<=0.3 & abs(reshape_Y)>0.2   )  );
test3_Y=reshape_Y(  find(    abs(reshape_Y)<=0.3 & abs(reshape_Y)>0.2   )  );

test4_X=reshape_X(  find(    abs(reshape_Y)<=0.4 & abs(reshape_Y)>0.3   )  );
test4_Y=reshape_Y(  find(    abs(reshape_Y)<=0.4 & abs(reshape_Y)>0.3   )  );

test5_X=reshape_X(  find(    abs(reshape_Y)<=0.5 & abs(reshape_Y)>0.4   )  );
test5_Y=reshape_Y(  find(    abs(reshape_Y)<=0.5 & abs(reshape_Y)>0.4   )  );

%% 根据拟合标准R，挑选出最优区间
    cache=[];num=0;
    R1=corrcoef( test1_X,test1_Y );  R(1)=R1(1,2);   num=num+1;cache(num,1)=min(test1_X);cache(num,2)=max(test1_X);
    if length(test2_X)>1
    R2=corrcoef( test2_X,test2_Y );  R(2)=R2(1,2);   num=num+1;cache(num,1)=min(test2_X);cache(num,2)=max(test2_X);end
    if length(test3_X)>1
    R3=corrcoef( test3_X,test3_Y );  R(3)=R3(1,2);   num=num+1;cache(num,1)=min(test3_X);cache(num,2)=max(test3_X);end
    if length(test4_X)>1
    R4=corrcoef( test4_X,test4_Y );  R(4)=R4(1,2);   num=num+1;cache(num,1)=min(test4_X);cache(num,2)=max(test4_X);end
    if length(test5_X)>1
    R5=corrcoef( test5_X,test5_Y );  R(5)=R5(1,2);   num=num+1;cache(num,1)=min(test5_X);cache(num,2)=max(test5_X);end
    R(R < -0.9999)=0;
    best_change_R = R(    find( R(:) == min( R ) )   )
    best_change_Part = find( R == min( R ) )
    min_best_change_pwtt = cache(find( R == min( R ) ),1)
    max_best_change_pwtt = cache(find( R == min( R ) ),2)



