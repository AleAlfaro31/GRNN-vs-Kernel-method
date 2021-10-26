% Kernel method - gaussian
% Alejandra Alfaro 16.09.21

% Data: DS-5
%Source: 
clear  all;
close  all;

d_true = load('DS-5-1-GAP-0-1-N-0_v2.dat');
d2 = load('DS-5-1-GAP-1-1-N-1_v2.dat');
d3 = load('DS-5-1-GAP-5-1-N-3_v2.dat');


%Perform regression on d2
sigma = 50;         % width of Gaussians
t = d2(:,1); %time
n = size(t,1);     % number of samples/points

ct = t; % centres of Gaussians at observations
m = size(ct,1);    % number of kernels

Gram_matrix = K1(t,n,ct,m,ones(1,m).*sigma);

x_true = d_true(:,1);
y_true = d_true(:,2);             % True data (mag)              

x = d2(:,2);                  % Observed data (mag)
alpha = pinv(Gram_matrix')*x;  % Learning weights
h = alpha'*Gram_matrix;       % Kernel-based model
errorTesting = mean((h' - x).^2)      %MSE Training
%errorTraining = mean((h' - resize(x_true, 45, 1)).^2)    % MSE Testing

figure;
hold on;
plot(x_true,y_true),'*-g');
plot(d3(:,1),d3(:,2),'.-k');
plot(t,h,'.-b');
legend('DS-5-1-GAP-0-1-N-0','DS-5-1-GAP-1-1-N-1','Kernel-based model');
xlabel('time');
ylabel('mag');
title(['Observed data, kernel-based model  MSE = ']);
box on;


% Reconstruction at all points
t1 = d1(:,1); %time
n1 = size(t1,1);     % number of samples/points
Gram_matrix1 = K1(t1,n1,ct,m,ones(1,m).*sigma);
h1 = alpha'*Gram_matrix1;       % Kernel-based model
error1 = mean((h1' - d1(:,2)).^2);    % MSE

miss = [];
figure;
hold on;
plot(d1(:,1),d1(:,2),'*-g');
plot(d2(:,1),d2(:,2),'.-k');
plot(t1,h1,'.-b');
legend('DS-5-1-GAP-0-1-N-0','DS-5-1-GAP-1-1-N-1','Kernel-based model');
for i=1:n1,
    if sum(t1(i)==t)==0,
            plot(t1(i),h1(i),'ob');
    end
end
plot(t,h,'*-k');
legend('DS-5-1-GAP-0-1-N-0','Kernel-based model');
xlabel('time');
ylabel('mag');
title(['Observed data, kernel-based model  MSE = ',num2str(error1)]);
box on;