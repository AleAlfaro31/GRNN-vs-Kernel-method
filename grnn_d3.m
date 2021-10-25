%Alejandra Alfaro Aguilar
%25.10.21
%General Regression Neural Network
%performing on 100 columns

clear all;
close all;

d_truth = load('DS-5-1-GAP-0-1-N-0_v2.dat'); %ground truth
%d_1 = load('DS-5-1-GAP-1-1-N-1_v2.dat');
d_3 = load('DS-5-1-GAP-5-1-N-3_v2.dat');

%perform regression on d_3
%define x data: 
x_train = d_3(:, 1)'; %Input: time, dataset with noise level 1
x_test = d_truth(:, 1)';
n_truth = size(x_test,2);    % number of samples/points
y_test = d_truth(:, 2)';
sumMSE = 0;


figure;
hold on;

for i = 2:100
    y_train = d_3(:,i)'; %Output: observed data (mag)
    %Train GRNN:
    net = newgrnn(x_train, y_train, 1); 
    %Test GRNN:
    h = sim(net, x_test);
    %disp("MSE: ")
    mse = mean((h - y_test).^2); %MSE of each model
    %disp("sumMSE:")
    sumMSE = mse + sumMSE;

    %plot(x_train,y_train,'.-b');
    if i == 2
        l1 = plot(x_test,h,'.-k');
    else
        plot(x_test,h,'.-k');
    end
    for j = 1:n_truth
        if sum(x_test(j)==x_train) == 0
            if i == 2
                l2 = plot(x_test(j),h(j),'*b');
            else
                plot(x_test(j),h(j),'*b');
            end
        end
    end
end

avrgMSE = sumMSE/100;
l3 = plot(x_test,y_test,'*-g');
%legend('GRNN models','GRNN-based model','DS-5-1-GAP-0-1-N-0');
legend([l1, l2, l3],{'GRNN models','GRNN coincidences','Ground Truth'})
xlabel('time');
ylabel('mag');
title(['Observed data d_3, GRNN model  MSE = ',num2str(avrgMSE)]);
box on;