<!---
	File        :   ErrorLog.cfc
	Description :   This cfc is used for error logging
	Created On  :   18-08-2015
--->
<cfcomponent accessors="true" output="false" persistent="false">


	<cffunction access="public" name="LogError" returntype="boolean" >
		<cfargument name="message" required="true" type="string">
		<cfargument name="stackTrace" required="true" type="string">

		<cftry>
			<cfquery name="InsertErrorLog" result="insertErrorLogResult" datasource="#APPLICATION.DataSource#">
				INSERT INTO ErrorLog
					(Message
					, StackTrace)
				VALUES
					( '#ARGUMENTS.message#'
					 ,'#ARGUMENTS.stackTrace#'
					)
			</cfquery>
		<cfcatch>
			<!--- logging error to a text file in case db logging fails --->
			<cffile action="write"
				file="#APPLICATION.ErrorLog#"
				output="
				Detail: #cfcatch.detail#
				Message: #cfcatch.message#
				">
		</cfcatch>
		</cftry>
		<cfreturn true>
	</cffunction>
</cfcomponent>
