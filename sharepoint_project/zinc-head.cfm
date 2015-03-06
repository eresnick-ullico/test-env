<cfparam name="title" default="">

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title><cfoutput>#title#</cfoutput></title>
<link rel="stylesheet" type="text/css" href="style.css">
<link rel="stylesheet" type="text/css" href="screen.css" media="screen">
<link rel="stylesheet" type="text/css" href="print.css" media="print">
<!--- <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/> --->
<!--- <script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script> --->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
<script type="text/javascript" src="jquery.formatCurrency-1.4.0.pack.js"></script>
<script type="text/javascript" src="Enroll.js"></script>
</head>
<body>

<h1>Group Supplemental Insurance</h1>
<cfoutput>
	<cfif currPgm neq 'confirm.cfm'><a href="index.cfm">Menu</a>&nbsp;&nbsp;&nbsp;</cfif>
	<br><br>
</cfoutput>
