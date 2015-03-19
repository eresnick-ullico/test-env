<cfdump var="#form#"><cfabort>

<!---Query to Add Users to a Project--->
<cfquery name="AddUsers" datasource="#application.db#" result="AddUsersResult"> 
  INSERT INTO ProjectUserTable (ProjectID, UserID, Role)
  VALUES (#form.ProjectID#, #form.UserID#, '#form.Role#'); 
</cfquery> 
