#!/bin/bash

URL=$1

#on vérifie que l'utilisateur a donné un argument
if [ "$#" -ne 1 ]; then
echo "Veuillez rentrer un argument" 
exit 
fi

#on vérifie que le fichier rentré en argument est valide
if [ ! -f "$URL" ]; then
    echo "Erreur : fichier '$URL' introuvable."
    exit
fi


count=0
#sortie="tableaux/tableau-fr.tsv"
while read -r line;
do

#on vérifie si l'URL donnée est valide en vérifiant si elle commence bien par http ou https
if [[ "$line" = http://* ]] || [[ "$line" = https://* ]]; then

	count=$(( $count + 1 )) #on numérote chaque ligne

	 code_http=$(curl -s -o /dev/null -L -w "%{http_code}" $line); #on récupère la réponse http : "-s -o /dev/null" pour ne pas surcharger le résultat,
	 #"-L" pour suivre les redirections 

	 contenu=$(curl -s "$line") #contenu de la page
	 encodage=$(echo "$contenu" | grep -i -o "utf-8" | head -n 1 | cut -d= -f2) #on récupère l'encodage 

	 #on gère les cas où il n'y a pas d'encodage :
	 if [ -z "$encodage" ]; then
	 echo $encodage "encodage introuvable" #dans ce cas-là je ne sais pas pourquoi il fait un retour à la ligne
	 fi

	nb_mots=$(echo "$contenu" | wc -w) #on compte les mots
	
   echo -e "${count}\t${line}\t${code_http}\t${encodage}\t${nb_mots}" #résultat ("-e" permet de reconnaître les tabulations)

else 

echo "URL invalide"; #cas où l'URL n'est pas valide

fi

done < "$URL";


#on n'utilise pas cat car la commande cat considère les liens comme des fichiers et va essayer de les chercher (et donc va afficher "file not found"),
# or on veut juste écrire les liens.


