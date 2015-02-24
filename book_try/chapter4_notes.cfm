<!--Basic Query-->
<cfquery name="myQuery" datasource="cfartgallery" >
	SELECT * FROM artists
</cfquery>

<!--cfdump is a great way to make sure that the query is working, but cfoutput allows us to control and display the information necessary for the user-->

<!--cfdump query-->
<cfdump var="#myQuery#" />

<!--cfoutput query-->
<cfoutput query="myQuery">
	#myquery.CurrentRow# - #myquery.email# - #myquery.firstname# - #myquery.lastname#<br />
</cfoutput>

<!--cfloop query-->
<cfset artistArray = [] />
<cfloop query="myQuery">
	<cfset arrayAppend(artistArray, myquery.lastname & ', ' & myQuery.firstname) />
</cfloop>

<!--Query Output Grouping-->
<cfquery name="myQuery" datasource="cfartgallery">
	SELECT * FROM art
	ORDER BY issold
</cfquery>

<cfoutput Query="myQuery" group="issold">
<p>
	Sold?: #YesNoFormat(myQuery.issold)#:<br>
	<blockquote>
		<cfoutput>
			#myQuery.artname#: #DollarFormat(myQuery.price)#<br />
		</cfoutput>
	</blockquote>
</p>
<hr />
</cfoutput>

<!--Queries with cfscript-->
<cfscript>
	myQry = new Query();
	myQry.setDatasource("cfartgallery");
	myQry.setSQL("SELECT firstname, lastname, email FROM artists");
	myQuery = myQry.execute();
	writeDump(myQuery.getResult());
	writeDump(myQuery.getPrefix());
</cfscript>

<!--Streamlined queries with cfscript-->
<cfscript>
	myQueryResult = new Query(sql="SELECT firstname, lastname, email FROM artists", datasource = "cfartgallery").execute().getResult();
	writeDump(myQueryResult)
</cfscript>

<!--Queries with cfscript using query params-->
<cfscript>
	myQry = new Query();
	myQry.setDatasource("cfartgallery");
	myQry.setSQL("SELECT artname, description FROM art WHERE issold = :sold");
	myQry.addParam(name: "sold", value: "1", cfsqltype: "CF_SQL_INT");
	myQuery = myQry.execute();
	writeDump(myQuery.getResult());
	writeDump(myQuery.getPrefix());
</cfscript>

<!--Creating XML Doc with cf-->
<cfquery name="getData" datasource="cfartgallery">
	SELECT artistID, artID, artName, description, isSold, price, largeImage FROM art WHERE artistid = 1
</cfquery>

<cfxml variable="artxml">
	<art artistid="<cfoutput>#getdata.artistid#</cfoutput>">
	
</cfxml>


<!--These examples contain 'form', which throws an error-->
<!--Query Param-->
<cfquery name="myQuery" datasource="cfartgallery">
	SELECT * FROM artists
	WHERE firstname = <cfqueryparam value="#form.name#" cfsqltype="cf_sql_varchar" />
</cfquery>

<!--Query Params with debugging-->
myQuery (Datasource=cfartgallery, Time=1ms, Records=1) i
	SELECT * FROM artists
	WHERE firstname = ?
Query Parameter Value(s) - 
Parameter #1(cf_sql_varchar) = Austin

<!--cfqueryparam used with "in" clause-->
<cfquery name="myQuery" datasource="cfartgallery">
	SELECT * FROM artists
	WHERE artistid IN(<cfqueryparam value="#form.ids#" list="true" />)
</cfquery>

myQuery (Datasource=cfartgallery, Time=2ms, Records=4) i

SELECT * FROM artists
WHERE artistid IN(?,?,?)
Query Parameter Value(s) -
Parameter #1(CF_SQL_CHAR) = 1
Parameter #2(CF_SQL_CHAR) = 2
Parameter #3(CF_SQL_CHAR) = 3

<!--Query Chaching (for one hour in this example)-->
<cfquery name="myQuery" datasource="cfartgallery" cachedwithin="#createTimespan(0,1,0,0)#">
	SELECT * FROM artists
</cfquery>

