% YGEI, 2023, U2- cluster algorythms, K_MEANS
clc, clear, close all

% Generating random data points
A = randn(10, 2);
B = randn(15, 2) * 1.2 + [11, 18];
C = randn(5, 2) * 1.7 + [19, 7];

% Plotting initial data points
figure(1)
plot(A(:, 1), A(:, 2), "ro", B(:, 1), B(:, 2), "bx", C(:, 1), C(:, 2), "gs")
title('Initial Data Points');

% Combining data points into a single matrix
X = [A; B; C];

% Plotting combined data points
figure(2)
plot(X(:, 1), X(:, 2), "bx")
title('Combined Data Points');

% Calculating and plotting mean and extremes
S1 = min(X);
S2 = max(X);
S3 = mean(X);
S = [S1;S2;S3];

figure(3)
plot(X(:, 1), X(:, 2), "bx", S(:, 1), S(:, 2), "gx");
title('Mean and Extremes');

% Initializing nearest_point vector
nearest_point = zeros(size(X, 1), 1);

% Assigning each point to the nearest cluster
for i = 1:size(X, 1)
    dist_S1 = sqrt((X(i, 1) - S1(1))^2 + (X(i, 2) - S1(2))^2);
    dist_S2 = sqrt((X(i, 1) - S2(1))^2 + (X(i, 2) - S2(2))^2);
    dist_S3 = sqrt((X(i, 1) - S3(1))^2 + (X(i, 2) - S3(2))^2);

    if dist_S1 <= min([dist_S1, dist_S2, dist_S3])
        nearest_point(i) = 1;
    elseif dist_S2 <= min([dist_S1, dist_S2, dist_S3])
        nearest_point(i) = 2;
    else
        nearest_point(i) = 3;
    end
end

% Creating matrix for plotting clusters
plot_matrix = [X, nearest_point];

% Separating points based on clusters
modra = plot_matrix(plot_matrix(:, 3) == 1, :);
cervena = plot_matrix(plot_matrix(:, 3) == 2, :);
zelena = plot_matrix(plot_matrix(:, 3) == 3, :);

% Plotting clustered data
figure(4);
scatter(modra(:, 1), modra(:, 2), 'b'); 
hold on
scatter(cervena(:, 1), cervena(:, 2), 'r');
scatter(zelena(:, 1), zelena(:, 2), 'g'); 
title('Initial Clustered Data');

% K-Means clustering algorithm
maxIter = 100;

for iteration = 1:maxIter
    % Assign points to clusters
    nearest_point = zeros(size(X, 1), 1);
    
    for i = 1:size(X, 1)
        dist_S1 = sqrt((X(i, 1) - S1(1))^2 + (X(i, 2) - S1(2))^2);
        dist_S2 = sqrt((X(i, 1) - S2(1))^2 + (X(i, 2) - S2(2))^2);
        dist_S3 = sqrt((X(i, 1) - S3(1))^2 + (X(i, 2) - S3(2))^2);

        if dist_S1 <= min([dist_S1, dist_S2, dist_S3])
            nearest_point(i) = 1;
        elseif dist_S2 <= min([dist_S1, dist_S2, dist_S3])
            nearest_point(i) = 2;
        else
            nearest_point(i) = 3;
        end
    end

    % Update cluster means
    S1 = mean(X(nearest_point == 1, :));
    S2 = mean(X(nearest_point == 2, :));
    S3 = mean(X(nearest_point == 3, :));
end

% Plotting the final clusters
modra = X(nearest_point == 1, :);
cervena = X(nearest_point == 2, :);
zelena = X(nearest_point == 3, :);

figure;
scatter(modra(:, 1), modra(:, 2), 'b');
hold on;
scatter(cervena(:, 1), cervena(:, 2), 'r');
scatter(zelena(:, 1), zelena(:, 2), 'g');
title('Final Clusters');

% MATLAB k-means function
[idx, C] = kmeans(X, 3); % Assuming 3 clusters

% Plotting the clusters obtained from k-means function
figure;
scatter(X(:, 1), X(:, 2), 10, idx, 'filled');
hold on;
title('K-Means Clustering Using MATLAB Function');
