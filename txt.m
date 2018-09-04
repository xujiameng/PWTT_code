close all;
clc;
clear;
di=dir('F:\0718\txt\*.txt');
for k= 1:length(di)
    a=importdata(['F:/0718/txt/',di(k).name]);
    data=a.data;
    m=di(k).name;
    m=strrep(m,'.txt','');
    save(['F:/0718/mat/',m],'data') ;
end

