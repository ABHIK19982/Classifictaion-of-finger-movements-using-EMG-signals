function [tr_data, tr_label] = EMG_dataslctn(datapath)


folders=dir(datapath);
nfolder=length(folders);
matfiles = {};
c1=1;
for i=3:nfolder
    testdir1(i-2,:)=fullfile(datapath,folders(i).name);
    matfiles{i-2}=dir(fullfile(testdir1((i-2),:),'*.csv'));
    dirlengths=length(matfiles{i-2});
    for j=1:dirlengths
        tr_data{c1}=csvread(fullfile(testdir1((i-2),:),matfiles{i-2}(j).name)); %6=repeatations per subject and class
        tr_label{c1}=matfiles{i-2}(j).name(1:3);
        c1 = c1+1;
    end
end


end
