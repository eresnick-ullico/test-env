<cfscript>
	personalInfo = {name='Eric', dob='August 5, 1987', address='123 Test Way', phonenumber='555-555-5555', email='er@test.com', website='www.er.com', skype='er87'}; 
</cfscript>

<cfoutput>
	<div class="clr"><div class="input-box">Name: </div><span>#personalInfo.name#</span></div>
    <div class="clr"><div class="input-box">DOB: </div><span>#personalInfo.dob#</span></div>
    <div class="clr"><div class="input-box">Address: </div><span>#personalInfo.address#</span></div>
    <div class="clr"><div class="input-box">Phone Number: </div><span>#personalInfo.phonenumber#</span></div>
    <div class="clr"><div class="input-box">Email: </div><span><a href='##'>#personalInfo.email#</a></span></div>
    <div class="clr"><div class="input-box">Website: </div><span>#personalInfo.website#</span></div>
</cfoutput>


