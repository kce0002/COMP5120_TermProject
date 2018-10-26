<?php
	$DBHost = "10.1.100.7";
	$DBUser = "appuser";
	$DBPass = "password";
	$DBName = "db";
	$bookQuery = "SELECT * FROM Book;";
	$tableNamesQuery = "SELECT table_name AS tables FROM information_schema.tables WHERE table_schema = DATABASE();";

	$conn = mysqli_connect($DBHost, $DBUser, $DBPass, $DBName);
	if (!$conn) {
		die("Connection failed: ".mysqli_connect_error());
	}

	$result = mysqli_query($conn, $bookQuery);

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
	<title>Bookstore</title>
	<head>
		<link rel="stylesheet" href="css/style.css">
		<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
		<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
		<script src="bootstrap/js/bootstrap.min.js"></script>
		<script src="bootstrap/js/jquery-3.3.1.min.js"></script>
		<script src="js/script.js"></script>
		
		<div class="jumbotron" style="margin: 0;">
			<div class="container" style="justify-context: center; text-align: center;">
				<h1>Online Bookstore</h1>
				<p>COMP 5120 Term Project - Fall 2018</p>
			</div>
		</div>
	</head>
	<body>
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
					echo '<table>';
					echo '<tr>';
					$columnsQuery = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'db' AND TABLE_NAME = '".$value."';";
					$columns = mysqli_query($conn, $columnsQuery);
					if (mysqli_num_rows($columns) > 0) {
						while ($row = mysqli_fetch_assoc($columns)) {
							echo '<th style="border: solid 2px lightgrey;">'.$row["COLUMN_NAME"].'</th>';
						}
					}
					echo '</tr>';
					$dataQuery = "SELECT * FROM ".$value.";";
					$dataResult = mysqli_query($conn, $dataQuery);
					if ($dataResult = mysqli_query($conn, $dataQuery)) {
						while ($row = mysqli_fetch_row($dataResult)) {								
							echo '<tr>';		
							for ($j = 0; $j < sizeof($row); $j++) {
								echo '<td style="border: solid 2px lightgrey;">'.$row[$j].'</td>';
							}
							echo '</tr>';
						}
						mysqli_free_result($dataResult);
					}
					echo '</table>';
					echo '</div>';
				}
			?>
			<div id="Book" class="tabcontent">
				<h3>BookID	Title</h3>
				<?php
					if (mysqli_num_rows($result) > 0) {
						while ($row = mysqli_fetch_assoc($result)) {
							echo "".$row["BookID"]."	".$row["Title"]."<br>";
						}
					}
					else {
						echo "0 results";
					}
					mysqli_close($conn);
				?>
			</div>
		</div>
	</body>
</html>
