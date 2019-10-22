
<?php
	$mysqli = new mysqli("localhost","eric","eric","dbres");
	if($mysqli->connect_errno){
		echo "Echec lors de la connexion à MySQL : (".$mysqli->connect_errno.") ".$mysqli->connect_error;
	}
	
	$mysqli->real_query("select nom, prenom from utilisateur");
	$res = $mysqli->use_result();
	echo "Contenu de la BD mysql : <br/>";
	while($row = $res->fetch_assoc()){
		echo "Nom : ".$row['nom']." Prenom : ".$row['prenom']."<br/>";
	}
?>
