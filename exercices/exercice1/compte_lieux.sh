#t31-exo2b

#script  qui compte le nombre d'entités données en arguments pour chaque année 

#!/usr/bin/bash

echo "arguments :$1, $2, $3 "

ANNEE=$1
MOIS=$2
LIEUX=$3

cat ann/$ANNEE/$ANNEE"_"$MOIS* | grep Location | head -n $3
