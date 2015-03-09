<h1>Setup a Sharepoint Project</h1>

<cfoutput>
<h3>Hello, #user.firstname#</h3>
</cfoutput>

<cfquery name ="srchUsers" datasource="#application.db#" blockfactor="100">
	SELECT *
	FROM  sharepointrequestusers
	ORDER BY spUserLastName
</cfquery>

<h4>Name of SharePoint Project</h4>

	<cfinput type="text" name="spProjectName" size="30" value="#spProjectName#">

<h4>Select Read Only Users</h4>

	<SELECT NAME="SelectUsersReadOnly" SIZE="1">
		<OPTION value="0">
		<cfoutput query="srchUsers">
		<OPTION value="#spUserID#">#spUserFirstName# #spUserLastName#
		</cfoutput> 
	</SELECT>

<h4>Select Read/Write Users</h4>

	<SELECT NAME="SelectUsersReadWrite" SIZE="1">
		<OPTION value="0">
		<cfoutput query="srchUsers">
		<OPTION value="#spUserID#">#spUserFirstName# #spUserLastName#
		</cfoutput> 
	</SELECT>









