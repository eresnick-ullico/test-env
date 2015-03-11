<cfoutput>

<cfparam name="form.spRequestDate" default="#CreateODBCDateTime(now())#">
<cfparam name="form.spProjectOwner" default="#user.id#">

<!---Shorter Code for Insert into SharePointRequestTable--->
<!--- <cfinsert datasource="#application.db#" tablename="SharePointRequestTable"> --->

<!---Query to Add Project to SharePointRequestTable--->
<cfquery name="AddProject" datasource="#application.db#"> 
  INSERT INTO SharePointRequestTable (spProjectName, spProjectAddInfo, spProjectOwner, spProjectReadCollaborators, spProjectReadWriteCollaborators, spRequestDate)
  VALUES ('#form.spProjectName#', '#form.spProjectAddInfo#', '#form.spProjectOwner#', #form.spProjectReadCollaborators#, #form.spProjectReadWriteCollaborators#, #form.spRequestDate#); 
</cfquery> 

<!---Query to take fk for Read Only collaborators, and replace it with their Ullico ID--->
<cfquery name="GetReadNames" datasource="#application.db#">
	SELECT spUserID
	FROM SharePointRequestUsers
	WHERE id=#form.spProjectReadCollaborators#
</cfquery>
</cfoutput>

<!---Assign Read Only user id to variable called 'readNames'--->
<cfoutput query="GetReadNames">
	<cfset readNames = #spUserID#>
</cfoutput>

<cfoutput>
<!---Query to take fk for Read/Write collaborators, and replace it with their Ullico ID--->
<cfquery name="GetReadWriteNames" datasource="#application.db#">
	SELECT spUserID
	FROM SharePointRequestUsers
	WHERE id=#form.spProjectReadWriteCollaborators#
</cfquery>
</cfoutput>

<!---Assign Read/write user id to variable called 'readWriteNames'--->
<cfoutput query="GetReadWriteNames">
	<cfset readWriteNames = #spUserID#>
</cfoutput>

<!--- ttran@ullico.com, fkoetje@ullico.com, jpratte@ullico.com--->
<cfmail from="#user.id#@ullico.com" to="eresnick@ullico.com" cc="#readNames#@ullico.com, #readWriteNames#@ullico.com" subject="SharePoint Project Setup Request - #form.spProjectName#" type="html">

	<html>
		<body>
			<h4>SharePoint Project Request</h4>

			<p>
				<b>Project Name</b>: #form.spProjectName# <br />
				<b>Project Owner</b>: #user.firstname# #user.lastname# - #user.id#@ullico.com <br />
				<b>Date Requested</b>: #form.spRequestDate# <br />
				<b>Read/Write</b>: #readWriteNames# <br />
				<b>Read Only</b>: #readNames# <br />
			</p>
		
		</body>
		</html>
</cfmail>



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
			<td>#readWriteNames#</td>
			<td>#readNames#</td>
		</cfoutput>
	</tr>

</table>


<p>
<a href="index.cfm">Create New Request</a> 
</p>
