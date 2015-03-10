<cfoutput>

<cfparam name="form.spRequestDate" default="#CreateODBCDateTime(now())#">
<cfparam name="form.spProjectOwner" default="#user.id#">

<cfinsert datasource="#application.db#" tablename="SharePointRequestTable">

<!--- <cfquery name="AddProject" datasource="#application.db#"> 
    INSERT INTO SharePointRequestTable 
    VALUES ('#form.spProjectName#', '#form.spProjectAddInfo#', '#form.spProjectOwner#', #form.spProjectReadCollaborators#, #form.spProjectReadWriteCollaborators#, #form.spRequestDate#, #form.spRequestDelete#, #form.spDeleteDate#) 
</cfquery> 
  --->

<h1>Project Request Succesfully Sent</h1> 

<table style="width:100%">

	<tr>
		<td>Project Name</td>
		<td>Owner</td>
		<td>Read/Write</td>
		<td>Read Only</td>
		<td>Date Requested</td>
	</tr>

	<tr>
		<td>#form.spProjectName#</td>
		<td>#user.firstname# #user.lastname#</td>
		<td>#form.spProjectReadWriteCollaborators#</td>
		<td>#form.spProjectReadCollaborators#</td>
		<td>#form.spRequestDate#</td>
	</tr>

</table>

</cfoutput>

<p>
<a href="index.cfm">Create New Request</a> 
</p>
