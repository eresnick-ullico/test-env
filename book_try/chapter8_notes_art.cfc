component persistent="true"{

	property name="id" column="artid" fieldtype="id" generator="increment";
	property name="name" column="artName" ormtype="string";
	property name="description" ormtype="text";
	property name="price" ormtype="double";
	property name="isSold" ormtype="boolean";
	property name="artist" fieldtype="many-to-one" cfc="artist";

	function getName(){
		return uCase(variables.name);
	}

	function getProfit(){
		if (getIsSold()){
			return getPrice() * 0.2;
		} else {
			return 0;
		}
	}

}