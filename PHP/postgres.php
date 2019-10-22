<?php 
	print "Contenu de la BD postgreSQL :";
	echo "<br/>";
	$dbh = pg_connect("host=localhost dbname=dbres user=marinette password=marinette");
	if($dbh){
		$result = pg_query($dbh,"select * from utilisateur");
		if($result){
			while($row = pg_fetch_row($result)){
				echo "Nom : $row[0] Prenom : $row[1]<br/>";
			}
		}else echo "Aucun résultat";
	}else echo "Echec de connexion à la BD";
?>
