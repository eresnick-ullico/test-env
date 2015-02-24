
<cfset myVar = 8>

<cfswitch expression="#myVar#">
	
    <cfcase value="1">
    	writeOutput('Value is 1')
    </cfcase>
    
    <cfcase value="9,10">
    	writeOutput('Value is 9 or 10')
    </cfcase>
    
    <cfdefaultcase>
    	writeOutput('The value is #myVar#')
    </cfdefaultcase>
    
</cfswitch>