
<cfset myVar = 10>

<!--Using a switch expression to evaluate cases-->
<cfswitch expression="#myVar#">
	
    <cfcase value="1">
    	<cfoutput>Value is 1</cfoutput>
    </cfcase>
    
    <cfcase value="9,10">
    	<cfoutput>Value is 9 or 10</cfoutput>
    </cfcase>
    
    <cfdefaultcase>
    	<cfoutput>The value is #myVar#</cfoutput>
    </cfdefaultcase>
    
</cfswitch>

<br />

<!--Using cfscript to evaluate cases-->
<cfscript>
switch(myVar){
	case 1: 
    	writeOuput('Value is 1');
    	break;
    
    case 9:
    	writeOutput('Value is 9');
        break;
        
    default:
    	writeOutput('Value is not 1 or 9');
}
</cfscript>

