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
	</cffunction>

	<!---On Request Start--->
	<cffunction name="onRequestStart" access="public" returntype="boolean" output="false">
		
		<cf_getPortalUser out=PortalUser>
		
		<cfset PortalUser = CGI.AUTH_USER>
		<cfif PortalUser != "false">
			
		</cfif>

	</cffunction>



</cfcomponent>




		// <cfset temp = getFileFromPath (CGI.HTTP_REFERER)>
		// <cfset pos = findNoCase("?", temp, 1)-1>
		// <cfif pos gt 0>
		// 	<cfset fromPgm = Left(temp,pos)>
		// <cfelse>
		// 	<cfset fromPgm = temp>
		// </cfif>
		// <cfset currPgm = getFileFromPath(SCRIPT_NAME)>

		// <cf_getPortalUser out=portalUser out2=Portal>
		
		// <cfset CgiUser = PortalUser>
		// <cfreturn true />