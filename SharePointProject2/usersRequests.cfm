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
	WHERE spRequestDelete = 0
	AND (spProjectReadWriteCollaborators = #UserID#
	OR spProjectReadCollaborators = #UserID#
	OR spProjectRequestBy = "#user.id#"
	OR spProjectOwner = #UserID#)
</cfquery>

<div class="row">
  <div class="col-md-6 col-md-offset-1">
		<h2>#user.firstname# #user.lastname#'s SharePoint Projects</h2>
	</div>
</div>

<div class = "row">
	<div class="col-md-10 col-md-offset-1">
		<table class="table table-bordered">
			<tbody>
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
				<!---If the user is the Project Owner, then they can Delete the request--->
			<cfif #spProjectOwner# eq #UserID#>
				<td><form action="deleteAction.cfm?id=#id#" method="post"> <input type="submit" value="Delete"></td>
			<cfelse>
				<td>N/A</td>
			</cfif>
			</tr>
		</cfloop>
		</tbody>
		</table>
	</div>
</div>

</cfoutput>