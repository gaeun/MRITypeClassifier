# MRITypeClassifier
## An algorithm that extracts various features from and classifies FLAIR and T1Post MRI images.

### Image features
----------------------
I've uploaded various MATLAB files that extract features from MRI images obtained from The Cancer Imaging Archive (TCIA). Some of the code is fairly specific to the directories on my computer, but you could customize it to yours since TCIA files are generally downloaded in the same format.

The features include:
* Mean
* Standard deviation
* Gray Co-occurrence Matrix Properties (contrast, correlation, energy, homogeneity)
* Haralick Texture Features
* Gabor Filter Features (not yet complete)

### Classification
----------------------
As for classification, you can run the Classification Learner app on MATLAB. Based on what I've tried, logistic regression works best for Haralick features, and complex trees for GLCM properties yield a 0.93 AUC.
