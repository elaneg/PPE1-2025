#tp1-ex2a 
#script  qui compte le nombre d'entités données en arguments pour chaque année 

#!/usr/bin/bash

echo "arguments :$1, $2, $3 "

CHEMIN=$1
ANNEE=$2
ENTITE=$3


echo "Nombre de $3 en $2 :"
cat $CHEMIN/$ANNEE/* | grep $ENTITE | wc -l

