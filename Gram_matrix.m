% Plot a set of Gaussian kernels
% Mar'17  'jcct
clear all;
close all;

sigma = 3;         % width of Gaussians

t_min = 0;         % min time 
t_max = 50;        % max time
inc   = 0.1;       % resolution of time
t = t_min:inc:t_max; %time
n = size(t,2);     % number of samples/points

ct    = [10 15 25 32 38 43]; % centres of Gaussians
alpha = [0.5 1 0.5 1 1.5 1]; % weights of Gaussians
m = size(ct,2);    % number of kernels

Gram_matrix = K1(t,n,ct,m,ones(1,m).*sigma);

figure;
plot(Gram_matrix');
xlabel('Samples');
ylabel('Magnitude');

figure;
hold on;
f = zeros(1,n);   % sum set of Gaussians with weights
for i=1:m,
    f = f + alpha(i) .* Gram_matrix(i,:);
    plot(t,alpha(i) .* Gram_matrix(i,:),'k');
end    
plot(t,f+2,'b');
xlabel('Time');
ylabel('Magnitude');