<!---  <cftry>
    <cfset bookDetail = deserializeJson(toString(getHttpRequestData().content ))>
    <cfif len( bookDetail )>
        <cfset structAppend( form, bookDetail )>
    </cfif>
    <cfset VARIABLES.obj = createObject("component","Components.BookTransactions")>
    <cfset variables.issent = variables.obj.SaveBook(bookDetail)>
    <cfdump var="#variables.issent#">
<cfcatch>
    <cfdump var="#cfcatch#">
</cfcatch>
</cftry> --->
<cfdump var="#form#">
