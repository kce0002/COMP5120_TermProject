<?php
	$DBHost = "10.1.100.7";
	$DBUser = "appuser";
	$DBPass = "password";
	$DBName = "db";
	$bookQuery = "SELECT * FROM Book;";

	$conn = mysqli_connect($DBHost, $DBUser, $DBPass, $DBName);
	if (!$conn) {
		die("Connection failed: ".mysqli_connect_error());
	}
	$result = mysqli_query($conn, $bookQuery);
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
		
		<div style="justify-context: center; text-align: center;">
			<h1>Bookstore</h1>
		</div>
	</head>
	<body>
		<div style="justify-context: center; text-align: center;">
			<h2>Info</h2>
			<div class="tab">
				<button class="tablinks" onclick="openCity(event, 'London')">London</button>
				<button class="tablinks" onclick="openCity(event, 'Book')">Book</button>
				<button class="tablinks" onclick="openCity(event, 'Paris')">Paris</button>
				<button class="tablinks" onclick="openCity(event, 'Tokyo')">Tokyo</button>
			</div>
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
			<div id="London" class="tabcontent">
				<h3>London</h3>
				<p>London is the capital city of England.</p>
			</div>
			<div id="Paris" class="tabcontent">
				<h3>Paris</h3>
				<p>Paris is the capital city of France.</p>
			</div>
			<div id="Tokyo" class="tabcontent">
				<h3>Tokyo</h3>
				<p>Tokyo is the capital city of Japan.</p>
			</div>
		</div>
	</body>
</html>
