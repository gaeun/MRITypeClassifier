default = '/Users/allisonkim/Desktop/TCGA-GBM';
paths = {'0003','0034','0037','0047','0048','0054','0068','0086','0106','0116','0164','0165','0166','0175','0213','0214','0649','0790','1395','1396','1401','1453','1458','1794','1795','3650'};
featuresflair = [];
featurespost = [];
for i = 1:25
   path = [default '/' paths{i}];
   pathdir = dir(path);
   path2 = [path '/' pathdir(4).name];
   path2dir = dir(path2);
   volumeflair = [];
   volumepost = [];
   for j = length(path2dir)-1:length(path2dir)
       volume = [];
       glcm = [];
       path3 = [path2 '/' path2dir(j).name];
       path3dir = dir(path3);
       for k = 4:length(path3dir)
           slicepath = [path3 '/' path3dir(k).name];
           slice = dicomread(slicepath);
           volume(:,:,k-3) = slice;
       end
       if j == length(path2dir)-1
           volumeflair = volume;
       else
           volumepost = volume;
       end
   end
   % Extracting features for one FLAIR volume
   featuresflair(i,1) = std(volumeflair(:));
   featuresflair(i,2) = mean(volumeflair(:));
   
   Iflair = volumeflair(:,:,floor((4+length(path3dir))/2)); % Extract the middle slice
   normIflair = Iflair / max(Iflair(:)); % Normalize the middle slice (0-1)
   glcmflair = graycomatrix(normIflair); % Generate GLCM
   
   % Extract FLAIR GLCM properties
   propsflair = graycoprops(glcmflair);
   haralickFlair = haralickTextureFeatures(glcmflair);
   featuresflair(i,3) = propsflair.Contrast;
   featuresflair(i,4) = propsflair.Correlation;
   featuresflair(i,5) = propsflair.Energy;
   featuresflair(i,6) = propsflair.Homogeneity;
   
   % Extracting features for one post volume
   featurespost(i,1) = std(volumepost(:));
   featurespost(i,2) = mean(volumepost(:));
   Ipost = volumepost(:,:,floor((4+length(path3dir))/2)); % Extract the middle slice
   normIpost = Ipost / max(Ipost(:)); % Normalize the middle slice (0-1)
   glcmpost = graycomatrix(normIpost); % Generate GLCM
   
   % Extract post GLCM properties
   propspost = graycoprops(glcmpost);
   haralickPost = haralickTextureFeatures(glcmpost);
   featurespost(i,3) = propspost.Contrast;
   featurespost(i,4) = propspost.Correlation;
   featurespost(i,5) = propspost.Energy;
   featurespost(i,6) = propspost.Homogeneity;
   
end

% figure,scatter(featuresflair(:,1),featuresflair(:,2))
% hold on
% scatter(featurespost(:,1),featurespost(:,2))

%%
X = [featuresflair;featurespost];
Y = [zeros(25,1);ones(25,1)];
Z = [X,Y];