<cfinclude template = "includes/header.cfm">

<!---Setup default params for Project variables--->
<cfparam name="form.spProjectName" default="">
<cfparam name="form.spProjectAddInfo" default="">
<cfparam name="form.spProjectReadCollaborators" default="">
<cfparam name="form.spProjectReadWriteCollaborators" default="">
<cfparam name="form.spProjectOwner" default="">

<div class="row">
  <div class="col-md-6 col-md-offset-1">
		<h1>Setup a Sharepoint Project</h1>
	</div>
</div>

<!---Form to create Project. Runs insertAction.cfm to post info to the database--->
<cfform action="insertAction.cfm" method="post">

<div class="row">
  <div class="col-md-6 col-md-offset-1">
		
		<h4>Name of SharePoint Project</h4>

			<cfinput type="text" name="spProjectName" size="30" value="#form.spProjectName#">

		<h4>Select Project Owner</h4>

			<SELECT NAME="spProjectOwner" SIZE="1">
				<OPTION value="0">
				<cfoutput query="srchUsers">
				<OPTION value="#ID#">#spUserFirstName# #spUserLastName#
				</cfoutput> 
			</SELECT>

		<h4>Select Read/Write Users</h4>

			<SELECT NAME="spProjectReadWriteCollaborators" SIZE="1">
				<OPTION value="0">
				<cfoutput query="srchUsers">
				<OPTION value="#ID#">#spUserFirstName# #spUserLastName#
				</cfoutput> 
			</SELECT>			

		<h4>Select Read Only Users</h4>

			<SELECT NAME="spProjectReadCollaborators" SIZE="1">
				<OPTION value="0">
				<cfoutput query="srchUsers">
				<OPTION value="#ID#">#spUserFirstName# #spUserLastName#
				</cfoutput> 
			</SELECT>

		<h4>Additional Information</h4>

		<!--- <cfinput name="spProjectAddInfo" size="30" value="#form.spProjectAddInfo#"> --->
		<cftextarea name="spProjectAddInfo" wrap="virtual" rows="3" cols="30" validate="maxlength" validateAt="onBlur" maxlength="100" value="#form.spProjectAddInfo#">

  	</cftextarea>

		<br /><br />
		<input type="submit" value="submit">

	</div>
</div>

</cfform>





