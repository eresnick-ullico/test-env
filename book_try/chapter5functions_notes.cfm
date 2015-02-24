<!---Function in ColdFusion--->
<cffunction name="getFullName" output="false" access="public" returntype="string">
	<cfargument name="firstName" type="string" required="false" default="" />
	<cfargument name="lastName" type="string" required="false" default="" />
	<cfset var fullName = arguments.firstName & " " & arguments.lastName />
	<cfreturn fullName />
</cffunction>