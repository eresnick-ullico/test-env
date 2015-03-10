<cfparam name="form.spProjectName" default="">
<cfparam name="form.spProjectAddInfo" default="">
<cfparam name="form.spProjectReadCollaborators" default="">
<cfparam name="form.spProjectReadWriteCollaborators" default="">


<h1>Setup a Sharepoint Project</h1>

<cfoutput>
<h3>Hello, #user.firstname#</h3>
<!--- <cfdump var=#user#> --->
</cfoutput>

<cfform action="insertAction.cfm" method="post">

<h4>Name of SharePoint Project</h4>

	<cfinput type="text" name="spProjectName" size="30" value="#form.spProjectName#">

<h4>Select Read Only Users</h4>

	<SELECT NAME="spProjectReadCollaborators" SIZE="1">
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

<h4>Additional Information</h4>

	<cfinput name="spProjectAddInfo" size="30" value="#form.spProjectAddInfo#">

<br /><br />
<input type="submit" value="submit">

</cfform>





