<cfset StructClear(SESSION) />
<cfloop item="name" collection="#cookie#">
	<cfcookie name="#name#" expires="#now()#" value="" />
</cfloop>
<cflocation url="Index.cfm" addtoken="false">