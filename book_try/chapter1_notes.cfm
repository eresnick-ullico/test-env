<h2>Arrays</h2>
<!--Setup an array-->
<cfset ThingsILike = ["Warm Sandy Beaches", "Tropical Drinks", 42]>
<!--Display an array-->
<cfdump var = "#ThingsILike#" />

<br />

<!--Append an array-->
<cfset ArrayAppend(ThingsILike, "Skiing")>
<!--Display appended array-->
<cfdump var = "#ThingsILike#" />

<br />

<!--Display contents of an array by looping-->
<cfloop array="#ThingsILike#" index="thing">
	<cfoutput>#thing#</cfoutput>
</cfloop>

<h2>Dates</h2>
<!--Setup days since the Millenium-->
<cfset DaysSinceTurnOfCentury = DateDiff("d", "1/1/2000", now())>
<!--Display days since the Millenium-->
<cfoutput>Days Since 1/1/2000: #DaysSinceTurnOfCentury#</cfoutput>

<!--Setup days since I was Born-->
<cfset DaysSinceIWasBorn = DateDiff("d", "8/5/1987", now())>

<br /><br />
<!--Display days since I was Born-->
<cfoutput>Days Since I was Born: #DaysSinceIWasBorn#</cfoutput>

<h2>Structs</h2>

<!--Working with Structs-->
<cfset FruitBasket = {} />
<cfset FruitBasket["Apple"] = "Like" />
<cfset FruitBasket["Banana"] = "Like" />
<cfset FruitBasket["Cherry"] = "Dislike" />

<!--Display Struct-->
<cfdump var="#FruitBasket#" />

<br />

<!--Creating Structs with one statement-->
<cfset fruitBasket = {
	"Apple" = "Like",
	"Banana" = "Dislike",
	"Cherry" = "Like"
}>

<!--Display one statement Struct-->
<cfdump var="#fruitBasket#" />

<br />

<!--Structs with Dot Notation (Displays as uppercase)-->
<cfset FruitBasket = {} />
<cfset FruitBasket.Apple = "Dislike" />
<cfset FruitBasket.Banana = "Dislike" />
<cfset FruitBasket.Cherry = "Like" />

<!--Display Structs with Dot Notation-->
<cfdump var= #FruitBasket#>

<br />

<!--Struct Loops with lowecase fruit name-->
<cfloop collection="#FruitBasket#" item="fruit">
	<cfoutput>I #FruitBasket[fruit]# #lcase(fruit)#</cfoutput><br />
</cfloop>

<!--Queries-->
<!---
<cfquery name="FruitQuery" datasource="fruit">
	SELECT Name, Price
    FROM FruitStore
    WHERE Price < 7
</cfquery>

<cfloop query="FruitQuery">
	#FruitQuery.Name# costs #FruitQuery.Price# <br />
</cfloop>
--->

<br />

<!--Looping Over an Array: ColdFusion Tags vs. Script-->
<!--Tag-->
<cfset FruitArray = ["Apple", "Banana", "Cherry"] />
<cfloop from="1" to="#arrayLen(FruitArray)#" index="i">
	<cfoutput>#FruitArray[i]#</cfoutput>
</cfloop>

<br />

<!--Script-->
<cfscript>
	FruitArray = ["Apple", "Banana", "Cherry"];
	for(i=1; i<=arrayLen(FruitArray); i++){
		writeOutput(FruitArray[i]);
	}
</cfscript>





