#tp1-ex1 
#script  qui compte le nombre de Locations pour chaque année 

#!/usr/bin/bash

for annee in 2016 2017 2018
do 
 cat ann/$annee/* | grep Location | wc -l 
done





#----------
#code avant de mettre en place la boucle, avec le chemin en argument
#echo "argument :$1 "

#CHEMIN=$1


#echo "Nombre de lieux en 2016 :"
#cat $CHEMIN/2016/* | grep Location | wc -l
#echo "Nombre de lieux en 2017 :"
#cat $CHEMIN/2017/* | grep Location | wc -l
#echo "Nombre de lieux en 2018 :"
#cat $CHEMIN/2018/* | grep Location | wc -l 
