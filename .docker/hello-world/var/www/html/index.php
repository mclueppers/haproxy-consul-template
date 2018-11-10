<?php
session_name("APPSESSID");
session_start();
?>
<html>
<head>
	<title>Hello world!</title>
	<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700' rel='stylesheet' type='text/css'>
	<style>
	body {
		background-color: white;
		text-align: center;
		padding: 50px;
		font-family: "Open Sans","Helvetica Neue",Helvetica,Arial,sans-serif;
	}
	</style>
</head>
<body>
	<h1><?php echo "Hello ".(getenv("SERVICE_NAME") ? getenv("SERVICE_NAME") : "world")."!"; ?></h1>
	<h3>My hostname is <?php echo getenv("HOSTNAME"); ?></h3>
</body>
</html>
