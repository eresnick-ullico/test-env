<!--Retrieving Data-->
<cfset artists = entityLoad("artist", {firstname:"Jeff"}, "lastname")>

<cfoutput>
	<cfloop array="#artists#" index="artist">
		<h4>#artist.firstName# #artist.lastName# #artist.id#</h4>
		<cfif artist.hasArt()>
			<ul>
				<cfloop array="#artist.getArt()#" index="art">
					<li>#art.name# #dollarFormat(art.price)#</li>
				</cfloop>
			</ul>
		</cfif>
	</cfloop>
</cfoutput>

<!--Retrieving Data with HQL.  We use 'Like' to get all records where the first name begins with 'A'-->
<cfset artists = ormExecuteQuery("FROM artist WHERE firstname like :firstname ORDER BY lastname", {firstname:"A%"}) />

<!--Adding a record-->

transaction{
	
	art = entityNew("art", {name:"Painting of TV", price: 200, isSold: false});
	entitySave(art);

	artist=entityNew("artist", {firstname: "John", lastname: "Doe"});
	artist.addArt(art);

	entitySave(artist);

}

<!--Updating a record-->

transaction{
	artist = entityLoad("artist", 100, true);
	artist.firstname = "Fred";
}

<!--Deleting a record-->

transaction{
	artist = entityLoad("artist", 100, true);
	entityDelete(artist);
}



