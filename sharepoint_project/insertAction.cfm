<cfoutput>

<cfparam name="form.spRequestDate" default="#CreateODBCDateTime(now())#">
<cfparam name="form.spProjectOwner" default="#user.id#">

<!---Shorter Code for Insert into SharePointRequestTable--->
<!--- <cfinsert datasource="#application.db#" tablename="SharePointRequestTable"> --->

<cfquery name="AddProject" datasource="#application.db#"> 
  INSERT INTO SharePointRequestTable (spProjectName, spProjectAddInfo, spProjectOwner, spProjectReadCollaborators, spProjectReadWriteCollaborators, spRequestDate)
  VALUES ('#form.spProjectName#', '#form.spProjectAddInfo#', '#form.spProjectOwner#', #form.spProjectReadCollaborators#, #form.spProjectReadWriteCollaborators#, #form.spRequestDate#); 
</cfquery> 

<cfquery name="GetReadNames" datasource="#application.db#">
	SELECT spUserID
	FROM SharePointRequestUsers
	WHERE id=#form.spProjectReadCollaborators#
</cfquery>

<cfquery name="GetReadWriteNames" datasource="#application.db#">
	SELECT spUserID
	FROM SharePointRequestUsers
	WHERE id=#form.spProjectReadWriteCollaborators#
</cfquery>
</cfoutput>

<h1>Project Request Succesfully Sent</h1> 

<table style="width:100%">

	<tr>
		<td>Project Name</td>
		<td>Owner</td>
		<td>Date Requested</td>
		<td>Read/Write</td>
		<td>Read Only</td>
	</tr>

	<tr>
		<cfoutput>
			<td>#form.spProjectName#</td>
			<td>#user.firstname# #user.lastname#</td>
			<td>#form.spRequestDate#</td>
		</cfoutput>
		<cfoutput query="GetReadWriteNames">
			<td>#spUserID#</td>
		</cfoutput>
		<cfoutput query="GetReadNames">
			<td>#spUserID#</td>
		</cfoutput>
	</tr>


</table>



<p>
<a href="index.cfm">Create New Request</a> 
</p>
