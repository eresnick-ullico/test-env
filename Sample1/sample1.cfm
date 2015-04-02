<cfset testStruct = structnew() />
<cfset testStruct.key1 = "test1" />
<cfset testStruct.key2 = "test2" />
<cfset testStruct.key3 = "test3" />

<cfdump var="#testStruct#" />

<cfloop list="#structKeyList(testStruct)#" index="key">
<cfoutput>
Key: #key#, Value: #testStruct[key]#
</cfoutput>
</cfloop>

<cfset myArray=ArrayNew(1)>
<cfset myArray[1]="2">
<cfset myArray[2]="3">
<cfset myStruct2=StructNew()>
<cfset myStruct2.struct2key1="4">
<cfset myStruct2.struct2key2="5">
<cfset myStruct=StructNew()>
<cfset myStruct.key1="1">
<cfset myStruct.key2=myArray>
<cfset myStruct.key3=myStruct2>
<cfdump var=#myStruct#><br>

<cfset key1Var="key1">
<cfset key2Var="key2">
<cfset key3Var="key3">
<cfset var2="2">

<cfoutput>
Value of the first key<br>
#mystruct.key1#<br>
#mystruct["key1"]#<br>
#mystruct[key1Var]#<br>
<br>
Value of the second entry in the key2 array<br>
#myStruct.key2[2]#<br>
#myStruct["key2"][2]#<br>
#myStruct[key2Var][2]#<br>
#myStruct[key2Var][var2]#<br>
<br>
Value of the struct2key2 entry in the key3 structure<br>
#myStruct.key3.struct2key2#<br>
#myStruct["key3"]["struct2key2"]#<br>
#myStruct[key3Var]["struct2key2"]#<br>
#myStruct.key3["struct2key2"]#<br>
#myStruct["key3"].struct2key2#<br>
<br>
</cfoutput>
