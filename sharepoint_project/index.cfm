<cfparam name="form.spProjectName" default="">

<h1>Setup a Sharepoint Project</h1>

<cfoutput>
<h3>Hello, #user.firstname#</h3>
<!--- <cfdump var=#user#> --->
</cfoutput>

<cfform action="index.cfm">

<h4>Name of SharePoint Project</h4>

	<cfinput type="text" name="spProjectName" size="30" value="#form.spProjectName#">

<h4>Select Read Only Users</h4>

	<SELECT NAME="SelectUsersReadOnly" SIZE="1">
		<OPTION value="0">
		<cfoutput query="srchUsers">
		<OPTION value="#spUserID#">#spUserFirstName# #spUserLastName#
		</cfoutput> 
	</SELECT>

<h4>Select Read/Write Users</h4>

	<SELECT NAME="SelectUsersReadWrite" SIZE="1">
		<OPTION value="0">
		<cfoutput query="srchUsers">
		<OPTION value="#spUserID#">#spUserFirstName# #spUserLastName#
		</cfoutput> 
	</SELECT>


<br /><br />
<input type="submit" name="submitButton" value="submit">

</cfform>





