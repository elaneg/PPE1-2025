#!/bin/bash

URL=$1
if [ "$#" -ne 1 ]; then
echo "Veuillez rentrer un argument"
exit 
fi

while read -r line;
do
	echo ${line};
done < "$URL";


#on n'utilise pas cat car la commande cat considère les liens comme des fichiers et va essayer de les chercher (et donc va afficher "file not found"),
# or on veut juste écrire les liens.


