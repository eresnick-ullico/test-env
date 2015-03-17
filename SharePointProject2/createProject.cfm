<!---Define Request Datee and Project Owner--->
<cfoutput>
<cfparam name="form.spRequestDate" default="#CreateODBCDateTime(now())#">
<cfparam name="form.spRequestBy" default="#user.id#">
</cfoutput>

<!---Query to Add Project to ProjectTable--->
<cfquery name="AddProject" datasource="#application.db#"> 
  INSERT INTO ProjectTable (spProjectName, spAddInfo, spRequestDate, spRequestBy)
  VALUES ('#form.spProjectName#', '#form.spAddInfo#', #form.spRequestDate#, '#form.spRequestBy#'); 
</cfquery> 

div class = "row">
		<div class="col-md-10 col-md-offset-1">
		<table class="table table-bordered">

			<tr>
				<td>Project Name</td>
				<td>Project Requested By</td>
				<td>Date Requested</td>
				<td>Project Owner</td>
				<td>Read/Write</td>
				<td>Read Only</td>
				<td>Additional Info</td>
			</tr>




