component{

	this.name='sharepointProject';
	this.datasource='who';
	this.applicationTimeout = CreateTimeSpan(0,10,0,0);
	this.sessionManagment = true;
	this.sessionTimeout = CreateTimeSpan(0,0,10,0);

	function onApplicationStart(){

	}

}