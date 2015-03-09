<!--- 
	FileName: Application.cfc
	Author: Eric Resnick
	Date: 2015-03-04
	SharePoint Request
 --->

<cfcomponent displayname="SharePointRequest" output="true" hint="SharePoint Request App">
	<cfset this.Name = "SharePointRequest">
	<cfset this.ApplicationTimeout = CreateTimeSpan( 0, 0, 20, 0 )>
	<cfset this.SessionTimeout = CreateTimeSpan( 0, 0, 10, 0 )>
	<cfset this.SessionManagement = true>
	<cfset this.SetClientCookies = true>
	<cfset NeedFooter = 0>

<!--- Define the page request properties. --->
<cfsetting requesttimeout="600" showdebugoutput="true" enablecfoutputonly="false" />

<cffunction name="OnApplicationStart" access="public" returntype="boolean" output="false" hint="Fires when the application is first created.">
	<!--- Set up the application. --->
	<cfset application.appStarted = now()>
	<cfset application.ourHitCount = 0>
	<cfset application.Title = "SharePointRequest">
	<cfset application.DB = "SharePointRequest">
	<cfif not isDefined("application.ShortName")>
		<cfset application.ShortName = "SPR">
	</cfif>
	<!--- Return out. --->
	<cfreturn true />
</cffunction>

<cffunction name="OnRequestStart" access="public" returntype="boolean" output="false" hint="Fires at first part of page processing.">
	<!--- Define arguments. --->
	<cfargument name="TargetPage" type="string" required="true" />
	<cfset application.ourHitCount = application.ourHitCount + 1>
	<cfparam name="jBug" default="0">
	<cfparam name="testEmail" default="eresnick@ullico.com">
	<cfset currDate = now()>
	<cfset currODBCDateTime = CreateODBCDateTime(currDate)>
	<cfset currYear = Year(currDate)>
	<cfset myTitle = application.Title>
	<cfif not isDefined("session.id")>
		<cfset session.id = 0>
	</cfif>


	<!---Query to find Users--->
	<cfquery name ="srchUsers" datasource="#application.db#" blockfactor="100" cachedwithin="#createTimeSpan(0, 1, 0, 0)#">
	SELECT *
	FROM  sharepointrequestusers
	ORDER BY spUserLastName
	</cfquery>

	
	<!--- Get fromPgm and currPgm --->
	<cfset temp=GetFileFromPath(CGI.HTTP_REFERER)>
	<cfset pos = FindNoCase("?",temp,1)-1>
	<cfif pos gt 0>
		<cfset fromPgm = Left(temp,pos)>
	<cfelse>
		<cfset fromPgm = temp>
	</cfif>
	<cfset currPgm=GetFileFromPath(SCRIPT_NAME)>
	<cfset prefix = "">

	<cfswitch expression = "#Server_Name#">
		<cfcase value = "ullinet2,mu2">
			<cfset TestServer = True>
		</cfcase>
		<cfdefaultcase>
			<cfset TestServer = False>
			<!--- Display custom message for "Request" Errors --->
			<cferror type="REQUEST" template="ErrorRequest.cfm">
			
			<!--- Display custom message for "Exception" Errors --->
			<cferror type="Exception" exception="Any" template="ErrorException.cfm">
		</cfdefaultcase>
	</cfswitch>
	
	<CF_getPortalUser out=PortalUser out2=Portal>
	
	<!--- Get User Info from Security and HRD Databases --->		
	<cfset CgiUser = CGI.Auth_User>
	
	<cfif PortalUser is "False">
		<cfset imgServer = ""><!--- use local image --->
	<cfelse>
		<!--- Access --->
		<cfset CgiUser = PortalUser>
		<cfset imgServer = "#Portal.ImageServerURL#/"><!--- use portal imager server image (for faster response) --->
	</cfif>
	<cfset CGIUser = ReplaceNoCase(CGIUser,"ullico\","")>
	<cfset RealUser = CGIUser><!--- Keep Real UserID for ChangeMe program --->
	<cfset tempUser = RealUser>
	
	<cfif TestServer is True>
		<!--- For TESTING purposes, allow user to impersonate other users --->
		<CF_ChangeTestUser system='#application.ShortName#' real=#RealUser# fake='*get'>
		<cfset tempUser = fake>
	</cfif>

	<!--- Find User and store in "theUser" --->		
	<CF_getUser in=#tempUser# out=theUser out2=user>
	
	<!--- Setup Special admin system --->
	<cfswitch expression = "#theUser#">
		<cfcase value = "eresnick">
			<cfset Admin = "Y">
		</cfcase>
		<cfdefaultcase>
			<cfset Admin = "N">
		</cfdefaultcase>
	</cfswitch>

	<cfreturn true /><!--- Return out. --->
</cffunction>

<cffunction name="OnRequest" access="public" returntype="void" output="true" hint="Fires after pre page processing is complete.">
	<!--- Define arguments. --->
	<cfargument name="TargetPage" type="string" required="true" />
	<!--- Include the requested page. --->
	<cfinclude template="#ARGUMENTS.TargetPage#" />
	<!--- Return out. --->
	<cfreturn />
</cffunction>

<cffunction name="OnRequestEnd" access="public" returntype="void" output="true" hint="Fires after the page processing is complete.">
	<cfif NeedFooter is 1>
		<cfinclude template="zinc-foot.cfm">
	</cfif>

	<!--- Display Structures for jBuging --->
	<cfif jBug is 1><br><br><br><br>
		<h1 class="bgBeige">jBug information...<br>&nbsp;</h1>
		<div class="PrintHide">
			<cfif isDefined("application")>
				<h2>Application Structure</h2>
				<cfdump var="#application#">
			</cfif>
			<cfif isDefined("session")>
				<h2>Session Structure</h2>
				<cfdump var="#session#">
			</cfif>
			<cfif isDefined("url")>
				<h2>URL Structure</h2>
				<cfdump var="#url#">
			</cfif>
			<cfif isDefined("form")>
				<h2>Form Structure</h2>
				<cfdump var="#form#">
			</cfif>
			<cfif isDefined("CGI")>
				<h2>CGI</h2><cfdump var="#CGI#">
			</cfif>
			<cfif isDefined("fromPgm")>
				<h2>fromPgm=#fromPgm#</h2>
			</cfif>
			<cfif isDefined("currPgm")>
				<h2>currPgm=#currPgm#</h2>
			</cfif>
			<cfif isDefined("TB")>
				<cfdump var="#TB#" label="TextBlock (TB)">
				<h3>inSidebarLeft=#inSidebarLeft#</h3>
			</cfif>
		</div>
	</cfif>
	<!--- Return out. --->
	<cfreturn />
</cffunction>

<cffunction name="OnSessionEnd" access="public" returntype="void" output="false" hint="Fires when the session is terminated.">
	<!--- Define arguments. --->
	<cfargument name="SessionScope" type="struct" required="true" />
	<cfargument name="ApplicationScope" type="struct" required="false" default="#StructNew()#" />
	<!--- Return out. --->
	<cfreturn />
</cffunction>

<cffunction name="OnApplicationEnd" access="public" returntype="void" output="false" hint="Fires when the application is terminated.">
	<!--- Define arguments. --->
	<cfargument name="ApplicationScope" type="struct" required="false" default="#StructNew()#" />
	<!--- Return out. --->
	<cfreturn />
</cffunction>

</cfcomponent>