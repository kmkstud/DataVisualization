%% exercise information visualisation data reduction
M = csvimport('M.csv');
M_sorted=sortrows(M(2:end,:),4);
Data= cell2mat(M_sorted(:,5:end));

Color = linspace(0,1,795)';
%scatter(Data(:,2), Data(:,3), 3, Data(:,1));

%% PCA
[coeff, score] = pca(Data);
[COEFF,SCORE] = princomp(Data);
figure;
PC1=SCORE(:,1);
PC2=SCORE(:,2);
scatter(PC1, PC2, 100, Color, '.');
title('Helsinki 2017 (PCA)');
xlabel('PC 1');
ylabel('PC 2');


%% Non-scalic MDS
dissimilarities = pdist(zscore(Data),'cityblock');
[Y,stress,disparities] = mdscale(dissimilarities,2,'criterion','stress');
figure;
scatter(Y(:,1), Y(:,2), 100, Color,'.');
title('Helsinki 2017 (Non-metric MDS)');
xlabel('x');
ylabel('y');
figure;
distances = pdist(Data(:,2:3));
[dum,ord] = sortrows([disparities(:) dissimilarities(:)]);
plot(dissimilarities,distances,'bo', ...
     dissimilarities(ord),disparities(ord),'r.-', ...
     [0 25],[0 25],'k-')
xlabel('Dissimilarities')
ylabel('Distances/Disparities')
legend({'Distances' 'Disparities' '1:1 Line'},...
       'Location','NorthWest');
%[y, E] = sammon(Data(:,2:3), 2)
%figure;
%scatter(y(:,2),y(:,1),100, Data(:,1),'s');
%%ISOMAP
%[I, R, E] = IsoMap(Data(:,2:3), 'k', 10);
mappedX = lle(Data, 2, 10);
scatter(mappedX(:,1), mappedX(:,2), 100, Color,'.');
title('Helsinki 2017 (LLE)');
xlabel('x');
ylabel('y');
hold on;

