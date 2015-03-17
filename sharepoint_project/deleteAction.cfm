<!--- <cfquery name="DeleteRequest" datasource="#application.db#">
        DELETE FROM SharePointRequestTable
        
        WHERE ID = #id#;
</cfquery>
 --->
<!--- <cfquery name="DeleteProject" datasource="#application.db#"> 
  UPDATE SharePointRequestTable 
  SET(spRequestDelete = #spRequestDelete#, spDeleteDate = #spDeleteDate#)
</cfquery>  --->

<cfoutput>
<cfparam name="spDeleteDate" default="#CreateODBCDateTime(now())#">
<cfparam name="spRequestDelete" default=1>
</cfoutput>

<cfquery name="DeleteProject" datasource="#application.db#"> 
  UPDATE SharePointRequestTable
  SET [spRequestDelete] = #spRequestDelete#, [spDeleteDate] = #spDeleteDate#
  WHERE [ID] = #id#;
</cfquery> 


<p>working?</p>