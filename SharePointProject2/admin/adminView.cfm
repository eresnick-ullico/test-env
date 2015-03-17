<cfoutput>

<!---Query to get all SharePoint Requests--->
<cfquery name="getSharePointRequests" datasource="#application.db#">
	SELECT *
	FROM SharePointRequestTable
</cfquery>

<cfif #Admin#>
	<p>You have access</p>
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


	<cfelse>
	<p>You do not have access to this page</p>
</cfif>
</cfoutput>