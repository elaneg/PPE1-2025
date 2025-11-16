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
    <link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bulma@1.0.4/css/bulma.min.css" />
</head>
<body class="section">
<h1 class="title is-2">Résultats de la collecte</h1>
<table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth">
<tr>
    <th>ID</th>
    <th>URL</th>
    <th>Code HTTP</th>
    <th>Encodage</th>
    <th>Nombre de mots</th>
</tr>
" > "$sortie_html"


while read -r line;
do

	data=$(curl -s -i -L -w "%{http_code}\n%{content_type}" -o ./.data.tmp $line)
	http_code=$(echo "$data" | head -1)
	encoding=$(echo "$data" | tail -1 | grep -Po "charset=\S+" | cut -d"=" -f2)

	if [ -z "${encoding}" ]
	then
		encoding="N/A" # petit raccourci qu'on peut utiliser à la place du if : encoding=${encoding:-"N/A"}
	fi

	nbmots=$(cat ./.data.tmp | lynx -dump -nolist -stdin | wc -w)

	echo -e "			<tr>
				<td>$count</td>
				<td>$line</td>
				<td>$http_code</td>
				<td>$encoding</td>
				<td>$nbmots</td>
			</tr>" >> "$sortie_html"

	count=$(expr $count + 1)

done < "$URL";
echo "		</table>
	</body>
</html>" >> "$sortie_html"


rm ./.data.tmp


#on n'utilise pas cat car la commande cat considère les liens comme des fichiers et va essayer de les chercher (et donc va afficher "file not found"),
# or on veut juste écrire les liens.


