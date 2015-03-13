<!---Query to take fk for Read/Write collaborators, and replace it with their Ullico ID--->
<cfoutput>
<cfquery name="GetUsersID" datasource="#application.db#">
	SELECT ID
	FROM SharePointRequestUsers
	WHERE spuserid="#user.id#"
</cfquery>
</cfoutput>

<!---Assign Read/write user id to variable called 'readWriteNames'--->
<cfoutput query="GetUsersID">
	<cfset UserID = #ID#>
</cfoutput>

<cfoutput>

<!---Query to get User's SharePoint Requests--->
<cfquery name="getSharePointRequests" datasource="#application.db#">
	SELECT *
	FROM SharePointRequestTable
	WHERE spProjectOwner = #UserID#
	OR spProjectReadWriteCollaborators = #UserID#
	OR spProjectReadCollaborators = #UserID#
	OR spProjectRequestBy = "#user.id#"
</cfquery>

	<h2>#user.firstname# #user.lastname#'s SharePoint Project Requests</h2>
	<div class = "row">
		<div class="col-md-10 col-md-offset-1">
		<table class="table table-bordered">

			<tr>
				<th>ID</th>
				<th>Project Name</th>
				<th>Project Requested By</th>
				<th>Date Requested</th>
				<th>Project Owner</th>
				<th>Read/Write</th>
				<th>Read Only</th>
				<th>Additional Info</th>
				<th>Delete</th>
			</tr>

		<cfloop query="getSharePointRequests">
			<tr>
				<td>#id#</td>
				<td>#spProjectName#</td>
				<td>#spProjectRequestBy#</td>
				<td>#spRequestDate#</td>
				<td>#spProjectOwner#</td>
				<td>#spProjectReadWriteCollaborators#</td>
				<td>#spProjectReadCollaborators#</td>
				<td>#spProjectAddInfo#</td>
				<td>#spRequestDelete#</td>
			</tr>
		</cfloop>
		</table>
		</div>
	</div>

</cfoutput>