<!--Iterative Loop that passes in the values of the myArray-->
<cfset myArray=['Jeff', 'John', 'Steve', 'Julianne'] />

<cfoutput>
<cfloop from="1" to="#arrayLen(myArray)#" index="i">
	#i#: #myArray[i]#<br>
</cfloop>
</cfoutput>

<br />

<!--Shorthand way to write loop, but unindexed-->
<cfoutput>
<cfloop array="#myArray#" index="item">
	#item#<br />
</cfloop>
</cfoutput>

<br />

<!--Looping over a list-->
<cfset myList='Jeff,John,Steve,Julliane' />
<cfoutput>
<cfloop list="#myList#" index="item">
	#item#<br />
</cfloop>
</cfoutput>

<br />

<!--Looping over a list with indexing-->
<cfoutput>
<cfloop from="1" to="#listlen(myList)#" index="i">
	#i#: #listGetAt(myList,i)#<br />
</cfloop>
</cfoutput>

<br />

<!--Looping over a string and pulling out each word into a list-->
<cfset myList2="This is a test sentence" />
<cfoutput>
<cfloop list="#myList2#" index="word" delimiters=" ">
	#word#<br />
</cfloop>
</cfoutput>

<br />

<!--Looping a collection-->
<cfset myStruct={name='Jeff K',id=12345,dob='1/1/1970'} />
<cfoutput>
<cfloop collection='#myStruct#' item='key'>
	#key#: #myStruct[key]#<br />
</cfloop>
</cfoutput>

<br />

<!--Conditional Looping an Array-->
<cfset myArray=['Jeff','John','Steve','Julianne'] />
<cfoutput>
<cfloop condition="#arrayLen(myArray)#">
	Current length = #arrayLen(myArray)#<br />
    <cfset arrayDeleteAt(myArray,1) />
</cfloop>
</cfoutput>

<br />

<!--Iterative Loop over an Array with cfscript-->
<cfscript>
	myArray=['Jeff','John','Steve','Julianne']; 
	for(i=1; i<=arrayLen(myArray); i++) {
		writeOutput('#i#: #myArray[i]#<br />');
	}
</cfscript>

<br />

<!--Array Loop with cfscript-->
<cfscript>
	myArray=['Jeff','John','Steve','Julianne']; 
	for(item in myArray) {
		writeOutput(#item# & '<br />');
	}
</cfscript>

<br />

<!--Array Loop with cfscript-->
<cfscript>
	myStruct={name='Jeff K',id=12345,dob='1/1/1970'};
	for(key in myStruct) {
		writeOutput('#key#: #myStruct[key]# <br />');
	}
</cfscript>



