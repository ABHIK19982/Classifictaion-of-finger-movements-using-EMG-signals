function result = norm_feat(feature)
result = -1 + 2.*(feature - min(feature))./(max(feature) - min(feature));
