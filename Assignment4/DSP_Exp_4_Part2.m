close all;clc;clear all;

N=6;
p=512;

N_point_dft=256;
x=rand(1,N);
x_size=size(x);
r=zeros(2*p,1);

for m=1:2*p
 for n=1:N-m
 r(m,1)=r(m,1)+x(n)*x(n+m-1);
 end
 r(m,1)= (r(m,1)./N);
end

R=zeros(p+1,p+1);

for i=1:p+1
 for j=1:p+1
 R(i,j)= (r(abs(i-j)+1,1));
 end
end

R_auto=R(1:p,1:p);
C=R(2:p+1,1);
A=R_auto\(-1.*C);
var=R_auto(1,1);

for k=1:p
 var=var+A(k,1).*C(k,1);
end

sum=ones(1,N_point_dft);

for f=1:N_point_dft
 for k=1:p
 sum(1,f)=sum(1,f)+A(k,1).*exp(-1i*2*pi*f/N_point_dft*k);
 end
end

P=var./(sum.*conj(sum));

plot(-.5:1/N_point_dft:.5-1/N_point_dft,fftshift(P));
title('Power Spectral Density of sequence x(n) using Yule-Walker AR Parametric Method ');
xlabel('Frequency ------>');ylabel('Power Spectral Density ------>');
