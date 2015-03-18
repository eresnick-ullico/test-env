<!---Define Request Datee and Project Owner--->
<cfoutput>
<cfparam name="form.spRequestDate" default="#CreateODBCDateTime(now())#">
<cfparam name="form.spRequestBy" default="#user.id#">
</cfoutput>

<cftransaction>
<!---Query to Add Project to ProjectTable--->
<cfquery name="AddProject" datasource="#application.db#" result="AddProjectResult"> 
  INSERT INTO ProjectTable (spProjectName, spAddInfo, spRequestDate, spRequestBy)
  VALUES ('#form.spProjectName#', '#form.spAddInfo#', #form.spRequestDate#, '#form.spRequestBy#'); 
</cfquery> 

<!---Query to Get New Project Info--->
<cfquery name="GetProjectInfo" datasource="#application.db#">
	SELECT *
	FROM ProjectTable
	WHERE (spProjectName = '#form.spProjectName#' AND spAddInfo = '#form.spAddInfo#' AND spRequestDate = #form.spRequestDate# AND spRequestBy = '#form.spRequestBy#')
</cfquery>
</cftransaction>


<!---Display the Project that was just created in a table--->
<div class="row">
  <div class="col-md-6 col-md-offset-1">
		<h1>New Project Information</h1>
	</div>
</div>

<div class = "row">
		<div class="col-md-10 col-md-offset-1">
		<table class="table table-bordered">

			<tr>
				<th>ID</th>
				<th>Project Name</th>
				<th>Project Requested By</th>
				<th>Date Requested</th>
				<th>Additional Info</th>
			</tr>

			<cfoutput query="GetProjectInfo">
			<tr>
				<td>#id#</td>
				<td>#spProjectName#</td>
				<td>#spRequestBy#</td>
				<td>#spRequestDate#</td>
				<td>#spAddInfo#</td>
			</tr>
		</cfoutput>

		</table>
	</div>
</div>

<!---Fields to add users to the current project--->
<div class="row">
  <div class="col-md-6 col-md-offset-1">
		<h1>Add Users to Project</h1>
	</div>
</div>

<div class = "row">
		<div class="col-md-10 col-md-offset-1">
		<form id="myForm">
		    <div id="input1" style="margin-bottom:4px;" class="clonedInput">
		    <!---Dropdown of User Names--->	
			    <SELECT NAME="name1" id="name1" SIZE="1">
						<OPTION value="0">
						<cfoutput query="srchUsers">
							<OPTION value="#ID#">#spUserFirstName# #spUserLastName#
						</cfoutput> 
					</SELECT>

				<!---Dropdown of User Roles--->	
					<SELECT NAME="role1" id="role1" SIZE="1">
					<OPTION>Select a User Role</OPTION>
					<OPTION VALUE="ReadWrite">Read & Write</OPTION>
					<OPTION VALUE="ReadOnly">Read Only</OPTION>
					<OPTION VALUE="Owner">Owner</OPTION>
					</SELECT>

		       
		    </div>
		 
		    <div>
		        <input type="button" id="btnAdd" value="add another name" />
		        <input type="button" id="btnDel" value="remove name" />
		    </div>
		</form>
	</div>
</div>