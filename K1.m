% INPUT:
%  x -> the time, according to the real data 
%  n -> Points per gaussian function, quantity of points in real data
%  c -> Center of kernels
%  m -> Kernel number
%  d -> Distance at each point with their neighbors (left-right), kernels'width
%
% OUTPUT
%  K_c -> matrix (m x n) (kernels x points) 
%                                                 JCCT Mar'17

function [K_c] = K1(x,n,c,m,d)
%  K(c,x)=e^(-|x-c|^2/sigma^2) ; c is the kernel's center, and x is the time
for j = 1:m, % each Kernel
   for i = 1:n,  % all points, in real scale are x(i)
        K_c(j,i) = exp(-abs(x(i)-c(j))^2/d(j)^2);  % d(j) is sigma, at each center of Kernel c(j)
   end
end

