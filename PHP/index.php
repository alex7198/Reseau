<?php

	print("<br/>Contenu de la BD PostgreSQL :<br/>");
	try{
		$dbh = new PDO('pgsql:host=localhost;dbname=dbres;user=marinette;password=marinette');
		foreach($dbh->query('SELECT * FROM UTILISATEUR') as $row){
			echo "Nom : ".$row[0]." Prenom : ".$row[1]."<br/>";
		}
	$dbh=null;
	}
	catch(PDOException $e){
		print("ERREUR !!!: " . $e->getMessage() . "<br/>");
		die();
	}

	print("<br/>Contenu de la BD MySQL :<br/>");
	try{
		$dbh = new PDO('mysql:dbname=dbres;user=eric;password=eric');
		foreach($dbh->query('SELECT * FROM UTILISATEUR') as $row){
			echo "Nom : ".$row[0]." Prenom : ".$row[1]."<br/>";
		}
	$dbh=null;
	}
	catch(PDOException $e){
		print("ERREUR !!!: " . $e->getMessage() . "<br/>");
		die();
	}	
 	

	
?>
