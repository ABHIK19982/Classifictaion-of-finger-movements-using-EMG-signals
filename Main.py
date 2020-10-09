import numpy as np
from sklearn.decomposition import PCA
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis as LDA
from sklearn.svm import SVC
from sklearn.neural_network import MLPClassifier
import scipy.io
from sklearn.naive_bayes import GaussianNB
##################################
Dimension_Reduction_Method = 'PCA'
Classifier = 'SVM'
##################################

np.random.seed(845)

Features = scipy.io.loadmat('SavedFeatures/Features.mat')['Features']
Labels = scipy.io.loadmat('SavedFeatures/Labels.mat')['label']


mapping = {j[0]:i for i,j in enumerate(np.unique(Labels[0]))}
Labels = np.array([mapping[i[0]] for i in Labels[0]])

random_indx = np.random.choice(600,600)

Features = Features[random_indx]
Labels = Labels[random_indx]

Training_Features = Features[:500]
Training_Labels = Labels[:500]


Testing_Features = Features[500:]
Testing_Labels = Labels[500:]


pca = PCA(n_components=10)
lda = LDA(n_components=10)

if Dimension_Reduction_Method == 'PCA':
    pca.fit(Training_Features)
    Training_Features = pca.transform(Training_Features)
    Testing_Features = pca.transform(Testing_Features)
    
elif Dimension_Reduction_Method == 'LDA':
    lda.fit_transform(Training_Features, Training_Labels)
    Training_Features = lda.transform(Training_Features)
    Testing_Features = lda.transform(Testing_Features)
    
else:
    print ('Invalid Method')
    
    
if Classifier == 'SVM':

    SVM = SVC(100).fit(Training_Features, Training_Labels)
    Accuracy = round(SVM.score(Testing_Features, Testing_Labels), 4)

elif Classifier == 'ANN':
    
    ANN = MLPClassifier(solver='lbfgs', alpha=1e-5, random_state=1)
    ANN.fit(Training_Features, Training_Labels)
    Testing_Outputs = ANN.predict(Testing_Features)
    Accuracy = np.mean((Testing_Outputs == Testing_Labels).astype(float))
    
print ('Accuracy: ' + str(Accuracy))
