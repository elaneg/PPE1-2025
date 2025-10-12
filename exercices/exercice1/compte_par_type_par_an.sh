#tp1-ex2asuite
 
#script  qui compte lance le script compte_par_type.sh mais sur les 3 années 

#!/usr/bin/bash

echo "arguments :$1, $2 "

CHEMIN=$1
ENTITE=$2

bash compte_par_type.sh $CHEMIN 2016 $ENTITE
bash compte_par_type.sh $CHEMIN 2017 $ENTITE
bash compte_par_type.sh $CHEMIN 2018 $ENTITE



