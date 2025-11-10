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

sortie="../tableaux/tableau-fr.tsv" #on indique le fichier de sortie

sortie_html="../tableaux/tableau-fr.html" #on indique le fichier html à écrire

echo -e "ID\tURL\tcode_http\tencodage\tnombre_de_mots" > "$sortie" #en-tête du tableau

#on initialise le fichier html
echo -e " 
<html>
<head>
    <meta charset="UTF-8">
    <title>Résultats de la collecte</title>
</head>
<body>
<h1>Résultats de la collecte</h1>
<table>
<tr>
    <th>#</th>
    <th>URL</th>
    <th>Code HTTP</th>
    <th>Encodage</th>
    <th>Nombre de mots</th>
</tr>
" > "$sortie_html"


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


	nb_mots=$(echo "$contenu" | lynx -dump -stdin -nolist | wc -w) #on compte les mots
	
	
   echo -e "${count}\t${line}\t${code_http}\t${encodage}\t${nb_mots}" #résultat CONSOLE ("-e" permet de reconnaître les tabulations)
   echo -e "${num}\t${line}\t${code_http}\t${encodage}\t${nb_mots}" >> "$sortie" #résultat FICHIER TSV

   #on inscrit le résultat dans le tableau du ficher html
   echo "<tr><td>$count</td><td>$line</td><td>$code_http</td><td>$encodage</td><td>$nb_mots</td></tr>" >> "$sortie_html"


else 

echo "URL invalide"; #cas où l'URL n'est pas valide

fi

done < "$URL";


#on n'utilise pas cat car la commande cat considère les liens comme des fichiers et va essayer de les chercher (et donc va afficher "file not found"),
# or on veut juste écrire les liens.


