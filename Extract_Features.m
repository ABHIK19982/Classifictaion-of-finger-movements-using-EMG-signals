clear;
addpath('./GetFeatures/');
PATH='Dataset/';
fs = 4000;
win_size = 20000;
win_inc = win_size/2; 
[data, label] = EMG_dataslctn(PATH);

thresh = 0;

disp('Extracting Features...')

for i =1:length(data)
   
    feature1(i,:) = [getrmsfeat(data{i}(:,1),win_size,win_inc)', getrmsfeat(data{i}(:,2),win_size,win_inc)'];

    ar_order = 1;
    feature2(i,:) = [getarfeat(data{i}(:,1),ar_order,win_size,win_inc)', getarfeat(data{i}(:,2),ar_order,win_size,win_inc)'];

    feature3(i,:) = [getmavfeat(data{i}(:,1), win_size, win_inc)', getmavfeat(data{i}(:,2), win_size, win_inc)'];

    feature4(i,:) = [getwlfeat(data{i}(:,1),win_size,win_inc)', getwlfeat(data{i}(:,2),win_size,win_inc)'];

    feature5(i,:) = [getiavfeat(data{i}(:,1),win_size,win_inc)', getiavfeat(data{i}(:,2),win_size,win_inc)'];

    feature6(i,:) = [getsscfeat(data{i}(:,1),0,win_size,win_inc)', getsscfeat(data{i}(:,2),0, win_size,win_inc)'];

    feature7(i,:) = [getzcfeat(data{i}(:,1),0,win_size,win_inc)', getzcfeat(data{i}(:,2),0,win_size,win_inc)'];
    
    
end

Features = [norm_feat(feature1) norm_feat(feature2) norm_feat(feature3) norm_feat(feature4) norm_feat(feature5) norm_feat(feature6) norm_feat(feature7)];

disp('Calculating Moments...')

c=1;
for i=1:length(data)
for k=1:7
feat_mom{k}(c,:)= [getmoment(data{i}(:,1),win_size,win_inc,k+2)', getmoment(data{i}(:,2),win_size,win_inc,k+2)'];
end
c=c+1;
end

for i=1:7
    feat_mom{i} = norm_feat(feat_mom{i});
    Features = [Features feat_mom{i}];
end


save ('SavedFeatures/Features', 'Features')
save ('SavedFeatures/Labels', 'label')

