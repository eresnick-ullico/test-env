<html>
<head>

<title>Date Function Examples</title>
</head>

<body>
<h3>Date Function Examples</h3>

<CFOUTPUT>

<CFSET dateNow = Now()>
1. Today's Date: #dateNow# <br />

2. Today's Date: #DateFormat(dateNow,"mmm dd, yyyy")# <br />

3. Today's Date: #DateFormat(Now(),"mmm dd, yyyy")# <br />

4. Tomorrow: #DateFormat(dateNow + CreateTimeSpan(1,0,0,0),"mm/dd/yyyy")# <br />

</CFOUTPUT>


</body>
</html>
