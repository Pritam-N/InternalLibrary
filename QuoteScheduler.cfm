<cfset VARIABLES.url = CGI.ServerName & "/" & "GetQuotesFromApi.cfm">
	<!--- scheduler for Leads --->
<cfschedule
	action="update"
	task="QuoteAPISchedule"
	urL= "#VARIABLES.url#"
	operation="HTTPRequest"
	startdate="#CreateDate(year(Now()),month(Now()),day(Now()))#"
	starttime="#CreateTime(hour(Now()),minute(Now()),second(Now()))#"
	interval="21600" />