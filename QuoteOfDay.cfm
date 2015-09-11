<!---
    File        :   QuoteOfDay.cfm
    Description :   This page is used to fetch the quotes from the database.
    Created On  :   21-08-2015
--->

<cfscript>
	var serviceObj = "";
	var QOD = StructNew();
</cfscript>
<cfset serviceObj = CreateObject("component","Data.Service") />
<cfset QOD = serviceObj.GetQOD()>
