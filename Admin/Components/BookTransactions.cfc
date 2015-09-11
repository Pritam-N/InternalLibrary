<!--- 
	File		:	BookTransactions.cfc
	Author		:	Pritama Nayak
	Date		:	09/Sept/2015
	Description	:	This cfc is consumed when we make 
					any interaction with service class from the client side after logged in.
--->

<cfcomponent displayname="BookTransactions">
	<!--- This function is used to save the book details --->
	<cffunction 
		name="SaveBook"
		access="remote"
		output="false">

		<cfargument name="title" required="true" type="any" />
		<cfargument name="description" required="true" type="any" />
		<cfargument name="ISBN10" required="true" type="any"/>
		<cfargument name="ISBN13" required="true" type="any" />
		<cfargument name="printType" required="true" type="any" />
		<cfargument name="language" required="true" type="any" />
		<cfargument name="maturityRating" required="true" type="any" />
		<cfargument name="publishedDate" required="true" type="any" />
		<cfargument name="pageCount" required="true" type="any" />
		<cfargument name="thumbnail" required="true" type="any" />
		<cfargument name="image" required="true" type="any" />
		<cfargument name="author" required="true" type="any" />
		<cfargument name="category" required="true" type="any" />
		<cfargument name="publisher" required="true" type="any" />
		
		<!--- Variable declarations  --->
		<cfscript>
			var IsBookSaved = 0;
			var authors = ArrayNew(1);
			var categories = ArrayNew(1);
			var bookDetail = StructNew();
		</cfscript>

		<cfscript>
			authors = ArrayToList(deserializeJSON(ARGUMENTS.author));
			categories = ArrayToList(deserializeJSON(ARGUMENTS.category));
		</cfscript>
		<cfset IsBookSaved = REQUEST.ServiceObj.saveBookDetails(
				ARGUMENTS.title
				, ARGUMENTS.description
				, ARGUMENTS.ISBN10
				, ARGUMENTS.ISBN13
				, ARGUMENTS.printType
				, ARGUMENTS.language
				, ARGUMENTS.maturityRating
				, ARGUMENTS.publishedDate
				, ARGUMENTS.pageCount
				, ARGUMENTS.thumbnail
				, ARGUMENTS.image
				, authors
				, categories
				, ARGUMENTS.publisher)>
<!--- 		<cfdump var="#IsBookSaved#">
		<cfreturn IsBookSaved /> --->
	</cffunction>
</cfcomponent>