<cfoutput>

<!---Define Request Datee and Project Owner--->
<cfparam name="form.spRequestDate" default="#CreateODBCDateTime(now())#">
<cfparam name="form.spProjectRequestBy" default="#user.id#">

<!---Shorter Code for Insert into SharePointRequestTable--->
<!--- <cfinsert datasource="#application.db#" tablename="SharePointRequestTable"> --->

<!---Query to Add Project to SharePointRequestTable--->
<cfquery name="AddProject" datasource="#application.db#"> 
  INSERT INTO SharePointRequestTable (spProjectName, spProjectAddInfo, spProjectOwner, spProjectReadCollaborators, spProjectReadWriteCollaborators, spRequestDate, spProjectRequestBy)
  VALUES ('#form.spProjectName#', '#form.spProjectAddInfo#', #form.spProjectOwner#, #form.spProjectReadCollaborators#, #form.spProjectReadWriteCollaborators#, #form.spRequestDate#, '#form.spProjectRequestBy#'); 
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

<cfoutput>
<!---Query to take fk for Project Owner, and replace it with their Ullico ID--->
<cfquery name="GetOwnerNames" datasource="#application.db#">
	SELECT spUserID
	FROM SharePointRequestUsers
	WHERE id=#form.spProjectOwner#
</cfquery>
</cfoutput>

<!---Assign Owner user id to variable called 'OwnerNames'--->
<cfoutput query="GetOwnerNames">
	<cfset OwnerNames = #spUserID#>
</cfoutput>


<!---E-mail SharePoint Project Request to Fred, Tuan, Jeff, and Eric.  cc's collaborators as well--->

<!--- ttran@ullico.com, fkoetje@ullico.com, jpratte@ullico.com--->
<cfmail from="#user.id#@ullico.com" to="eresnick@ullico.com" cc="#readNames#@ullico.com, #readWriteNames#@ullico.com" subject="SharePoint Project Setup Request - #form.spProjectName#" type="html">

	<html>
		<body>
			<h4>SharePoint Project Request</h4>

			<p>
				<b>Project Name</b>: #form.spProjectName# <br />
				<b>Project Requested By</b>: #user.firstname# #user.lastname# - #user.id#@ullico.com <br />
				<b>Date Requested</b>: #form.spRequestDate# <br />
				<b>Project Owner</b>: #OwnerNames# <br />
				<b>Read/Write</b>: #readWriteNames# <br />
				<b>Read Only</b>: #readNames# <br />
				<b>Additional Info</b>: #form.spProjectAddInfo# 
			</p>
		
		</body>
</cfmail>

<!---Displayed if request is created succesfully--->
<h1>Project Request Succesfully Sent</h1> 

<table style="width:100%">

	<tr>
		<td>Project Name</td>
		<td>Project Requested By</td>
		<td>Date Requested</td>
		<td>Project Owner</td>
		<td>Read/Write</td>
		<td>Read Only</td>
		<td>Additional Info</td>
	</tr>

	<tr>
		<cfoutput>
			<td>#form.spProjectName#</td>
			<td>#user.firstname# #user.lastname#</td>
			<td>#form.spRequestDate#</td>
			<td>#OwnerNames#</td>
			<td>#readWriteNames#</td>
			<td>#readNames#</td>
			<td>#form.spProjectAddInfo#</td>
		</cfoutput>
	</tr>

</table>

