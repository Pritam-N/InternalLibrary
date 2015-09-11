<cfset test = createobject("component","GetBookAPI")>
<cfset test1 = test.SearchBook()>
<cfdump var="#test1#">