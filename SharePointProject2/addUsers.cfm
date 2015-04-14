<cfdump var = #form# >

<cfset userStruct = StructNew()>
<cfset userStruct['UserID'] = 0 >
<cfset userStruct['Role'] = "">
<cfset userStruct['ProjectID'] = 0>

<cfloop from = "1" to = "#form.counter#" index="i">
<cfoutput>
		<cfset userStruct = StructNew()>
		<cfset userStruct['UserID'] = form["UserID#i#"]>
		<cfset userStruct['Role'] = form["Role#i#"]>
		<cfset userStruct['ProjectID'] = form.ProjectID >
</cfoutput>
<cfdump var = #userStruct#>
</cfloop>



<!--- <cfsccipt>
	userStruct = StructNew();
	myStruct.UserID = #form.UserID#i##
	myStruct.Role = #form.Role#i##
	myStruct.ProjectID = #form.ProjectID#
</cfsccipt> --->

<!---Query to Add Users to a Project
<cfquery name="AddUsers" datasource="#application.db#" result="AddUsersResult"> 
  INSERT INTO ProjectUserTable (ProjectID, UserID, Role)
  VALUES (#form.ProjectID#, #form.UserID#, '#form.Role#'); 
</cfquery> --->

