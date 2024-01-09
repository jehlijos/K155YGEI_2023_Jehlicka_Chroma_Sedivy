clear;
close all;
clc;
warning('off', 'all');

%% První příklad: Vliv transformace na první hlavní komponentu s vysokým informačním obsahem
% Generování dvourozměrných datových sad
m = 10;
n = 2;


L1 = randn(m, n);
L2 = randn(m, n) * 3;

V1 = reshape(L1, [1, m * n]);
V2 = reshape(L2, [1, m * n]);
V1 = double(V1);
V2 = double(V2);

P1(:, 1) = V1 - mean(V1);
P1(:, 2) = V2 - mean(V2);

disp('kovarianční matice (př 1.):');
S1 = cov(P1)
disp('korelační matice (př 1.):');
R1 = corrcoef(P1)
[V1, D1] = eig(S1);

[d1, ind1] = sort(abs(diag(D1)), 'descend');
disp('vlastní čísla kovarianční matice (př 1.):');
Ds1 = D1(ind1, ind1)
disp('vlastní vektory kovarianční matice (př 1.):');
Vs1 = V1(:, ind1)
pc1 = Vs1;

P_rot1 = P1 * pc1;

figure;
subplot(2, 1, 1);
plot(P1(:, 1), P1(:, 2), 'bx');
axis equal;
title('Př. 1: Vysoký informační obsah');
hold on;
legend_str = {'2-D data', 'směr 1. vlastního vektoru', 'směr 2. vlastního vektoru'};
hL = legend(legend_str, 'Location', 'eastoutside');
line([min(P1(:, 1)), max(P1(:, 1))], [min(P1(:, 1))*pc1(2,1)/pc1(1,1), max(P1(:, 1))*pc1(2,1)/pc1(1,1)], 'Color', 'r', 'LineWidth', 1);
line([min(P1(:, 1)), max(P1(:, 1))], [min(P1(:, 1))*pc1(2,2)/pc1(1,2), max(P1(:, 1))*pc1(2,2)/pc1(1,2)], 'Color', 'g', 'LineWidth', 1);
legend('2-D data', 'směr 1. vlastního vektoru', 'směr 2. vlastního vektoru');
xlabel('DN_1', 'FontSize', 12);
ylabel('DN_2', 'FontSize', 12);
hold off;
axis([min(P1(:, 1)) - 5 max(P1(:, 1)) + 5 min(P1(:, 2)) - 5, max(P1(:, 2)) + 5]);

subplot(2, 1, 2);
scatter(P_rot1(:, 1), P_rot1(:, 2), 'rx');
title('Zobrazení dat v osách hlavních komponent', 'FontSize', 12);
xlabel('PC_1', 'FontSize', 12);
ylabel('PC_2', 'FontSize', 12);
axis equal;

disp('informační obsah první komponenty (př 1.):');
d1(1) / sum(d1)
disp('informační obsah druhé komponenty (př 1.):');
d1(2) / sum(d1)

%% Druhý příklad: Vliv transformace s minimálním informačním obsahem
% Generování dvourozměrných datových sad
x(1, :) = randn(1, 20) * (-2);
x(2, :) = randn(1, 20) * 3.5;

V1 = x(1, :)';
V2 = x(2, :)';
V1 = double(V1);
V2 = double(V2);

P2 = [V1, V2];
P2 = P2 - mean(P2);

disp('kovarianční matice (př 2.):');
S2 = cov(P2)
disp('korelační matice (př 2.):');
R2 = corrcoef(P2)
[V2, D2] = eig(S2);

[d2, ind2] = sort(abs(diag(D2)), 'descend');
disp('vlastní čísla kovarianční matice (př 2.):');
Ds2 = D2(ind2, ind2)
disp('vlastní vektory kovarianční matice (př 2.):');
Vs2 = V2(:, ind2)
pc2 = Vs2;

P_rot2 = P2 * pc2;

figure;
subplot(2, 1, 1);
plot(P2(:, 1), P2(:, 2), 'bx');
axis equal;
title('Př. 2: Minimální informační obsah');
hold on;
line([min(P2(:, 1)), max(P2(:, 1))], [min(P2(:, 1))*pc2(2,1)/pc2(1,1), max(P2(:, 1))*pc2(2,1)/pc2(1,1)], 'Color', 'r', 'LineWidth', 1);
line([min(P2(:, 1)), max(P2(:, 1))], [min(P2(:, 1))*pc2(2,2)/pc2(1,2), max(P2(:, 1))*pc2(2,2)/pc2(1,2)], 'Color', 'g', 'LineWidth', 1);
legend('2-D data', 'směr 1. vlastního vektoru', 'směr 2. vlastního vektoru');
xlabel('DN_1', 'FontSize', 12);
ylabel('DN_2', 'FontSize', 12);
legend_str = {'2-D data', 'směr 1. vlastního vektoru', 'směr 2. vlastního vektoru'};
hL = legend(legend_str, 'Location', 'eastoutside');
hold off;
axis([min(P2(:, 1)) - 5 max(P2(:, 1)) + 5 min(P2(:, 2)) - 5, max(P2(:, 2)) + 5]);

subplot(2, 1, 2);
scatter(P_rot2(:, 1), P_rot2(:, 2), 'rx');
title('Zobrazení dat v osách hlavních komponent', 'FontSize', 12);
xlabel('PC_1', 'FontSize', 12);
ylabel('PC_2', 'FontSize', 12);
axis equal;

disp('informační obsah první komponenty (př 2.):');
d2(1) / sum(d2)
disp('informační obsah druhé komponenty (př 2.):');
d2(2) / sum(d2)