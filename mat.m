close all;
clc;
clear;
di=dir('D:\test\20180703\MAT文件\文件3\子文件1\*.mat');
data=[];
for k= 1:length(di)
    a=[];
    a=importdata(['D:/test/20180703/MAT文件/文件3/子文件1/',di(k).name]);
%     m=di(k).name;
%     m=strrep(m,'.txt','');
%     save(['实验数据/实验数据3/mat/data4/',m],'data') ;
    data=[data;a];   
end

