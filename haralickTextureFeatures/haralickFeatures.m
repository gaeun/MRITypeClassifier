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
   
   Iflair = volumeflair(:,:,floor((4+length(path3dir))/2)); % Extract the middle slice
   normIflair = Iflair / max(Iflair(:)); % Normalize the middle slice (0-1)
   glcmflair = graycomatrix(normIflair); % Generate GLCM
   haralickFlair(i,:) = haralickTextureFeatures(glcmflair); % Extract Haralick features for glcm
   
   Ipost = volumepost(:,:,floor((4+length(path3dir))/2)); % Extract the middle slice
   normIpost = Ipost / max(Ipost(:)); % Normalize the middle slice (0-1)
   glcmpost = graycomatrix(normIpost); % Generate GLCM
   haralickPost(i,:) = haralickTextureFeatures(glcmpost); % Extract Haralick features for glcm

end

HaralickX = [haralickFlair;haralickPost];
HaralickY = [zeros(25,1);ones(25,1)];
HaralickZ = [HaralickX,HaralickY];
