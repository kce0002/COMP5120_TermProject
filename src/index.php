<?php
	$userQuery = "";
    	$rowsAffected = "";
	$DBHost = "mysql.auburn.edu";
	$DBUser = "kce0002";
	$DBPass = "Auburn123";
	$DBName = "kce0002db";
	$tableNamesQuery = "SELECT table_name AS tables FROM information_schema.tables WHERE table_schema = DATABASE();";

	$conn = mysqli_connect($DBHost, $DBUser, $DBPass, $DBName);
	if (!$conn) {
		die("Connection failed: ".mysqli_connect_error());
	}

	$tables = mysqli_query($conn, $tableNamesQuery);

	$tablesArr = array();
	$i = 0;
	if (mysqli_num_rows($tables) > 0) {
		while ($row = mysqli_fetch_assoc($tables)) {
			$tablesArr[$i] = $row['tables'];
			$i++;
		}
	}
?>
<html>
	<head>
        <title>Bookstore</title>
		<link rel="stylesheet" href="css/style.css">
		<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
		<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
		<script src="bootstrap/js/bootstrap.min.js"></script>
		<script src="bootstrap/js/jquery-3.3.1.min.js"></script>
		<script src="js/script.js"></script>
	</head>
	<body>
        <div class="jumbotron" style="margin: 0; background-color: #4d4d4d;">
			<div class="container" style="justify-context: center; text-align: center;">
				<h1 style="color: #fff;">Online Bookstore</h1>
				<p style="color: #fff;">COMP 5120 Term Project - Fall 2018</p>
			</div>
		</div>
		<div style="justify-context: center; text-align: center;">
			<div class="tab">
				<?php
					foreach ($tablesArr as $value) {
						echo '<button class="tablinks" onclick="openTable(event, \''.$value.'\')">'.$value.'</button>';

					}
				?>
			</div>
			<?php
				foreach ($tablesArr as $value) {
					echo "<div id=".$value." class=\"tabcontent\">";
					echo "<h2>".$value."</h2>";
					echo '<table>';
					echo '<tr>';
					$columnsQuery = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'kce0002db' AND TABLE_NAME = '".$value."';";
					$columns = mysqli_query($conn, $columnsQuery);
					if (mysqli_num_rows($columns) > 0) {
						while ($row = mysqli_fetch_assoc($columns)) {
							echo '<th style="border: solid 2px darkgrey;">'.$row["COLUMN_NAME"].'</th>';
						}
					}
					echo '</tr>';
					$dataQuery = "SELECT * FROM ".$value.";";
					$dataResult = mysqli_query($conn, $dataQuery);
					if ($dataResult = mysqli_query($conn, $dataQuery)) {
						while ($row = mysqli_fetch_row($dataResult)) {								
							echo '<tr>';		
							for ($j = 0; $j < sizeof($row); $j++) {
								echo '<td style="border: solid 2px darkgrey;">'.$row[$j].'</td>';
							}
							echo '</tr>';
						}
						mysqli_free_result($dataResult);
					}
					echo '</table>';
					echo '</div>';
				}
			?>
		</div>
		<div style="justify-context: center; text-align: center;">
			<br>
			<form method="POST" action="">
				<h3>Query:</h3>
				<textarea name="query" rows="5" cols="40"></textarea>
				<br>
				<br>
				<input type="submit" class="btn btn-primary" style="float-left;" value="Submit">
			</form>
			<?php
				
			?>
		</div>
        <div style="justify-context: center; text-align: center;">
            <br>
            <br>
            <?php
                if (isset($_POST['query'])) {
                    $userQuery = $_POST['query'];
		    if (strpos(strtolower($userQuery), 'drop') !== false) {
			echo '<p style="color: red;">';
			echo "Drop operations are not permitted.";
			echo "</p>";
		    }
		    else {
                    	$colNames = array();
                    	if ($x = mysqli_query($conn, stripslashes($userQuery))) {
                        	echo "<table>";
                        	echo "<tr>";
                        	$z = 0;
                        	while ($z < mysqli_num_fields($x)) {
                            	$q = mysqli_fetch_field($x);
                            	echo '<th style="border: solid 2px darkgrey;">'.$q->name.'</th>';
                            	$colNames[$z] = $q->name;
                            	$z++;
		
                	        }
                        	echo "</tr>";

                        	if (mysqli_num_rows($x) > 0) {
                            		while ($r = mysqli_fetch_assoc($x)) {
                                		echo "<tr>";
                                		for ($v = 0; $v < sizeof($colNames); $v++) {
                                    			echo '<td style="border: solid 2px darkgrey;">'.$r[$colNames[$v]].'</td>';
                                		}	
                                		echo "</tr>";	
                            		}
                        	}
                        	echo "</table>";
                    		mysqli_free_result($x);
                    		mysqli_close($conn);
		    		$str = explode(' ', trim($userQuery));
		    		if (strtolower($str[0]) != "select") {
		    			echo "<meta http-equiv='refresh' content='0'>";
		    		}
                    	}
		    	else {
				echo '<p style="color: red;">';
				echo "Error: ".mysqli_error($conn);
				echo "</p>";
		    	}
		    }
		}
            ?>
	</div>
	<br>
	<br>
	</body>
</html>
