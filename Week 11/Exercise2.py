import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.metrics import confusion_matrix
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis
from sklearn import datasets
from sklearn.model_selection import train_test_split

def confusionM(y_true, y_predict, target_names):
    cMatrix = confusion_matrix(y_true, y_predict)
    df_cm = pd.DataFrame(cMatrix, index=target_names, columns=target_names)
    plt.figure(figsize=(6, 4))
    cm = sns.heatmap(df_cm, annot=True, fmt="d")
    cm.yaxis.set_ticklabels(cm.yaxis.get_ticklabels(), rotation=0)
    cm.xaxis.set_ticklabels(cm.xaxis.get_ticklabels(), rotation=0)
    plt.ylabel("True label")
    plt.xlabel("Predicted label")
    plt.show()

iris = datasets.load_iris()
x = iris.data
y = iris.target

target_names = iris.target_names
x_train, x_test, y_train, y_true = train_test_split(x, y)
lda = LinearDiscriminantAnalysis()
lda.fit(x_train, y_train)
y_predict = lda.predict(x_test)
confusionM(y_true, y_predict, target_names)