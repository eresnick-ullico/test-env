component persistent="true" table="artists"{

	property name="id" column="artistID" fieldtype="id" generator="increment";
	property name="firstname" ormtype="string";
	property name="lastname" ormtype="string";

	property name="art" fieldtype="one-to-many" cfc="art" fkcolumn="artistID" cascade="delete";

}