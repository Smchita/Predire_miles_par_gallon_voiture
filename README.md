## I - Preentation des données :


  Les données sont les spécifications techniques des voitures publiées à l'origine en 1983 pour
l'American Statistical Association Data Expo. Dans ce projet, vous allez essayer de prédire les miles par
gallon d'une voiture en utilisant la régression linéaire multiple. Les miles par gallon (mpg) d'une voiture
mesurent jusqu'où une voiture peut aller avec un gallon de carburant. Partout au monde où l'utilisation
de voitures est très courante, les consommateurs tiennent parfois compte de l'efficacité et de
l'économie de carburant de la voiture qu'ils souhaitent acheter avant de l'acheter. Tout le monde veut
acheter une voiture qui peut voyager loin et consommer moins de carburant. Dans ce cadre, supposez
que vous travaillez pour une entreprise qui vend des voitures et vous avez été chargés en tant que
scientifiques des données d'analyser ces données et de produire un bon modèle qui peut
prédire/estimer les miles par gallon d'une voiture avec une erreur minimale comptent tenu des autres
caractéristiques de la voiture. Le fichier est divisé en trois sous fichiers que je vous propose de
reconstituer et ensuite de mettre en place un modèle de prédiction que vous utiliserez pour prédire
les « mpg » du fichier auto-mpg-a-predire. Pour cela, vous aurez besoin de faire quelques analyses et
représentations graphiques. Vous serez guidés pas à pas dans cette création de modèle de prédiction

    Les variables étudiées au cours de notre analyse sont :
    o MPG : Kilométrage/miles par gallon (la variable a expliqué)
    o Cylindres : L’unité de puissance de la voiture où l'essence est transformée en électricité
    o Déplacement : Cylindrée du moteur de la voiture
    o Puissance : Puissance en chevaux - taux de performance du moteur
    o Accélération : Accélération de la voiture
    o Age : l’âge de la voiture
    o USA, Asie, Europe : des variable binaire, 1 si la voiture et de tel origine 0 sinon
    o Nom de la voiture

## II -Importation et concaténation:

   - importation des trois fichiers auto-mpg-1, auto-mpg-2 et auto-mpg-3.
   - concaténation entre auto-mpg-1 et auto-mpg-2 pour créer un fichier nommé auto-mpg-1-2.
   - concaténation entre auto-mpg-1-2 et auto-mpg-3 pour créer un fichier nommé auto-mpg.

## III -Analyse descriptive du fichier auto-mpg:

     le nettoyage des données est une chose très importante dans le domaine de l'analyse des données avant modélisation. Il nécessite de détecter et de corriger ou supprimer les enregistrements inexacts de l'ensemble de données. Cela améliore la qualité de vos données et, ce faisant, augmente la productivité globale.

* déterminer le nombre de valeurs manquantes pour chaque variable
* remplacer les valeurs manquantes.
* Création de 3 nouvelles variables (USA, Europe, Asie) à partir de la variable origine
  * a. USA =1 si le modèle est d’origine USA et 0 sinon.
  * b. Europe =1 si le modèle est d’origine Europe et 0 sinon.
  * c. Asie =1 si le modèle est d’origine Asie et 0 sinon.

## VI -Sélection des variables pour construire un modèle de prédiction

* Sélection des variables à utiliser pour construire un modèle de prédiction
  *  Corrélation des variables explicatives avec la variable à expliquer
  *  Corrélation entre les variables explicatives

## V- Construction du modèle de prédiction et prédiction

    Construire de nouveau le modèle final
     Prédire le mpg du fichier auto-mpg-a-predire à savoir des observations
