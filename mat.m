close all;
clc;
clear;
di=dir('D:\test\20180703\MAT�ļ�\�ļ�3\���ļ�1\*.mat');
data=[];
for k= 1:length(di)
    a=[];
    a=importdata(['D:/test/20180703/MAT�ļ�/�ļ�3/���ļ�1/',di(k).name]);
%     m=di(k).name;
%     m=strrep(m,'.txt','');
%     save(['ʵ������/ʵ������3/mat/data4/',m],'data') ;
    data=[data;a];   
end

