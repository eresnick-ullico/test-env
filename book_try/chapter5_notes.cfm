<!--Includes page that function is on-->
<cfinclude template="chapter5functions_notes.cfm" />

<!--Set variables for First & Last Name-->
<cfset fullName=getFullName(firstName="Emily", lastName="Christiansen")/>

<!--Output Hello, Full Name-->
<cfoutput>
	Hello, #fullName#!
</cfoutput>

<cfset Greeting = createObject("Component", "chapter5_greeting.cfc") />
<cfset myGreeting = Greeting.getGreeting(firstName="Emily", lastName="Christiansen") />

<cfoutput>
	#myGreeting#
</cfoutput>

