<cfoutput>

<!---Query to get all SharePoint Requests--->
<cfquery name="getSharePointRequests" datasource="#application.db#">
	SELECT *
	FROM SharePointRequestTable
</cfquery>

<cfif #Admin#>
	<p>You have access</p>

		<table style="width:100%" border=1>

			<tr>
				<td>ID</td>
				<td>Project Name</td>
				<td>Project Requested By</td>
				<td>Date Requested</td>
				<td>Project Owner</td>
				<td>Read/Write</td>
				<td>Read Only</td>
				<td>Additional Info</td>
				<td>Delete</td>
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
				<td>#spRequestDelete#
			</tr>
	</cfloop>
		</table>





	<cfelse>
	<p>You do not have access to this page</p>
</cfif>
</cfoutput>