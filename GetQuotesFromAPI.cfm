<!---
    File        :   GetQuotes.cfm
    Description :   This file is used to get the quotes and save them to database.
    Created On  :   21-08-2015
--->

<cftry>
	<cfhttp url="http://api.theysaidso.com/qod.json?category=inspire" result="quotes" />

	<!--- If the connection is successfull and 200 ok --->
	<cfif quotes.statusCode EQ "200 OK">
		<cfscript>
			VARIABLES.response = StructNew();
			VARIABLES.quote = "";
			VARIABLES.author = "";
			VARIABLES.date = DateFormat(now());
		</cfscript>

		<!--- Get the data from the API response and assign to the required variables --->
		<cfset VARIABLES.response = DeserializeJson(quotes.fileContent) />

		<cfset VARIABLES.quote = VARIABLES.response["contents"].quotes[1].quote />
		<cfset VARIABLES.author = VARIABLES.response["contents"].quotes[1].author />

		<!--- Insert the quote details to the tables-Quotes --->
		<cfquery name="insertQuote" datasource="#APPLICATION.DataSource#">
			INSERT INTO
				Quotes
				(Quote
				, Author
				, QuoteDate)
			VALUES
				(<cfqueryparam cfsqltype="cf_sql_varchar" value="#VARIABLES.quote#">
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#VARIABLES.author#">
				, <cfqueryparam cfsqltype="cf_sql_date" value="#VARIABLES.date#">)
		</cfquery>

	<cfelse>
		<!--- Error Log Object creation --->
		<cfscript>
				VARIABLES.errorLogObj = CreateObject("component","Data.ErrorLog");
		</cfscript>
		<cfset VARIABLES.errorLogObj.LogError(quotes.statusCode,quotes.fileContent)>
	</cfif>

<cfcatch>
	<!--- Error Log Object creation --->
	<cfscript>
			VARIABLES.errorLogObj = CreateObject("component","Data.ErrorLog");
	</cfscript>
	<cfset VARIABLES.errorLogObj.LogError(cfcatch.message,cfcatch.detail)>
</cfcatch>
</cftry>