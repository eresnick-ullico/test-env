<!DOCTYPE HTML>
<html>
	<head>
		<title>Ullico SharePoint Project Request App</title>
    <!-- jquery script -->
			<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
		<!-- Latest compiled and minified CSS -->
			<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- Optional theme -->
			<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
		<!-- Latest compiled and minified JavaScript -->
			<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	</head>

<body>

<nav class="navbar navbar-default">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
      	<span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
			<a class="navbar-brand" href="http://my.ullico.com" target="_blank">
        <img alt="Brand" src="./assets/images/ullicologo_20.jpg">
      </a>
    </div>

		<!---Non-collapsing menu.  Displays User name--->
    <div class="nav navbar-nav">
      <ul class="nav navbar-nav">
        <li><a href=>Hello, <cfoutput>#user.firstname# #user.lastname#</cfoutput></a></li>
      </ul>   
    </div>

    <!--- Collect the nav links, forms, and other content for toggling --->
    <div class="collapse navbar-collapse">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="./usersRequests.cfm">View Your Projects</a></li>
        <li><a href="./index.cfm">Create SharePoint Project</a></li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
