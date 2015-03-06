<cfcomponent>
	
	<!---Setup Project--->
	<cfset this.name = "sharepointProject">
	<cfset this.applicationTimeout = createTimeSpan(0,10,0,0)>
	<cfset this.sessionManagment = true>
	<cfset this.sessionTimeout = createTimeSpan(0,0,10,0)>
	<cfset this.setClientCookies = true>

	<!---On Application Start--->
	<cffunction name="onApplicationStart" access="public" returntype="boolean" output="false">
		<cfset application.datasource="who">
		<cfreturn true />
	</cffunction>

	<!---On Request Start--->
	<cffunction name="onRequestStart" access="public" returntype="boolean" output="false">
		
		<cf_getPortalUser out=PortalUser>
		
		<cfset portalUser = CGI.AUTH_USER>

		<cfreturn true />


	</cffunction>



</cfcomponent>




