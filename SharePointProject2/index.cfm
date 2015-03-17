<!---Setup default params for Project variables--->
<cfparam name="form.spProjectName" default="">
<cfparam name="form.spAddInfo" default="">

<div class="row">
  <div class="col-md-6 col-md-offset-1">
		<h1>Setup a SharePoint Project</h1>
		<p>Users will be added in the next step</p>
	</div>
</div>

<!---Form to create Project. Runs insertAction.cfm to post info to the database--->
<cfform action="createProject.cfm" method="post">

<div class="row">
  <div class="col-md-6 col-md-offset-1">
		
		<h4>Name of SharePoint Project</h4>

			<cfinput type="text" name="spProjectName" size="30" value="#form.spProjectName#">

		<h4>Additional Information</h4>

		<!--- <cfinput name="spProjectAddInfo" size="30" value="#form.spProjectAddInfo#"> --->
		<cftextarea name="spAddInfo" wrap="virtual" rows="3" cols="30" validate="maxlength" validateAt="onBlur" maxlength="100" value="#form.spAddInfo#">

  	</cftextarea>

		<br /><br />
		<input type="submit" value="submit">

	</div>
</div>

</cfform>





