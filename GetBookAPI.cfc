<!--- https://www.googleapis.com/books/v1/volumes?q=isbn:0099549484&key=AIzaSyDSKlXNRZLkfGBY5girwY62QP2R4Zr0R-E --->
<cfcomponent displayname="GetBookAPI">
	<!--- This function is used to send the api key for fetching the books based on ISBN --->
	<cffunction
			name="GetBookByISBN"
			access="remote"
			output="false"
			returnformat="JSON">
		<cfargument name="isbn" required="true" type="any" />
		<cfset var key = "AIzaSyDSKlXNRZLkfGBY5girwY62QP2R4Zr0R-E">
		<cfset var url = "https://www.googleapis.com/books/v1/volumes?q=isbn:#ARGUMENTS.isbn#&key=#key#">
		
		<!--- api call to get the book details --->
		<cfhttp url="#url#" result="result" resolveurl="true"></cfhttp>
		<cfset var response = DeserializeJson(result.fileContent)>
		<cfset var imageUrl = Replace(response.items[1].volumeInfo.ImageLinks.thumbnail,"zoom=","zoom=2","all")>
		<cfset var bookDetail = StructNew()>
		<cfset bookDetail = {
			"ISBN10" = response.items[1].volumeInfo.industryIdentifiers[2].identifier,
			"ISBN13" = response.items[1].volumeInfo.industryIdentifiers[1].identifier,
			"PrintType" = response.items[1].volumeInfo.printType,
			"Language" = response.items[1].volumeInfo.language,
			"MaturityRating" = response.items[1].volumeInfo.maturityRating,
			"PublishedDate" = response.items[1].volumeInfo.publishedDate,
			"Title" = response.items[1].volumeInfo.title,
			"Description" = response.items[1].volumeInfo.description,
			"PageCount" = ToString(response.items[1].volumeInfo.pageCount),
			"Image" = imageUrl,
			"Thumbnail" = response.items[1].volumeInfo.ImageLinks.smallThumbnail,
			"Authors" = response.items[1].volumeInfo.authors,
			"Categories" = response.items[1].volumeInfo.categories,
			"Publisher" = response.items[1].volumeInfo.publisher
		}>
		<cfreturn bookDetail>
	</cffunction>

	<!--- This function is used to send the api key for fetching the books based on ISBN --->
	<cffunction
			name="GetBookByTitle"
			access="remote"
			output="false"
			returnformat="JSON">
		<cfargument name="title" required="true" type="any" />
		<cfset var key = "AIzaSyDSKlXNRZLkfGBY5girwY62QP2R4Zr0R-E">
		<cfset var url = "https://www.googleapis.com/books/v1/volumes?q=#ARGUMENTS.title#&key=#key#">
		<!--- api call to get the book details --->
		<cfhttp url="#url#" result="result" resolveurl="true"></cfhttp>
		<cfset var response = DeserializeJson(result.fileContent)>
		<cfset var imageUrl = Replace(response.items[1].volumeInfo.ImageLinks.thumbnail,"zoom=","zoom=2","all")>
		<cfset var bookDetail = StructNew()>
		<cfset bookDetail = {
			"ISBN10" = response.items[1].volumeInfo.industryIdentifiers[2].identifier,
			"ISBN13" = response.items[1].volumeInfo.industryIdentifiers[1].identifier,
			"PrintType" = response.items[1].volumeInfo.printType,
			"Language" = response.items[1].volumeInfo.language,
			"MaturityRating" = response.items[1].volumeInfo.maturityRating,
			"PublishedDate" = response.items[1].volumeInfo.publishedDate,
			"Title" = response.items[1].volumeInfo.title,
			"Description" = response.items[1].volumeInfo.description,
			"PageCount" = ToString(response.items[1].volumeInfo.pageCount),
			"Image" = imageUrl,
			"Thumbnail" = response.items[1].volumeInfo.ImageLinks.smallThumbnail,
			"Authors" = response.items[1].volumeInfo.authors,
			"Categories" = response.items[1].volumeInfo.categories,
			"Publisher" = response.items[1].volumeInfo.publisher
		}>
		<cfreturn bookDetail>
	</cffunction>

	<cffunction
			name="SearchBook"
			access="remote"
			output="true"
			returnformat="JSON">
		<cfargument name="title" required="false" type="any"/>
		<cfargument name="isbn" required="false" type="any" />
		<cfargument name="searchIndex" required="false" type="any"/>

		<cfset var searchString = "">
		<cfset var bookDetail = StructNew()>
		<cfset var response = "">
		<cfset var imageUrl = "">
		<cfset var bookResult = ArrayNew(1)>

		<cfif StructKeyExists(ARGUMENTS,"title") && Len(ARGUMENTS.title)>
			<cfset searchString = searchString & ARGUMENTS.title>
			<cfif StructKeyExists(ARGUMENTS,"isbn") && Len(ARGUMENTS.isbn)> 
				<cfset searchString = searchString & "+isbn:" & ARGUMENTS.isbn>
			</cfif>
		<cfelse>
			<cfif StructKeyExists(ARGUMENTS,"isbn") && Len(ARGUMENTS.isbn)> 
				<cfset searchString = searchString & "isbn:" & ARGUMENTS.isbn>
			</cfif>
		</cfif>

		<cfif StructKeyExists(ARGUMENTS,"searchIndex") && Len(ARGUMENTS.searchIndex)>
			<cfset searchString = searchString & "&startIndex=" & ARGUMENTS.searchIndex>
		</cfif>

		<cfset var key = "AIzaSyDSKlXNRZLkfGBY5girwY62QP2R4Zr0R-E">
		<cfset var url = "https://www.googleapis.com/books/v1/volumes?q=#searchString#&maxResults=10&key=#key#">

		<!--- api call to get the book details &startIndex=#ARGUMENTS.searchIndex#&maxResults=#ARGUMENTS.maxResults#--->
		<cfhttp url="#url#" result="result" resolveurl="true"></cfhttp>

		<cfset response = DeserializeJson(result.fileContent) />

		<cfif StructKeyExists(response,"items")>
			<cfloop array="#response.items#" index="index">
			<cfset var bookinfo = index.volumeInfo />
			<cfif StructKeyExists(index.volumeInfo,"ImageLinks")>
				<cfset var imageUrl = Replace(bookinfo.ImageLinks.thumbnail,"zoom=","zoom=2","all") />
			<cfelse>
				<cfset var imageUrl = "" />
			</cfif>
			
			<cfif StructKeyExists(index.volumeInfo,"industryIdentifiers")>
				<cfif ArrayIsDefined(index.volumeInfo.industryIdentifiers,2)>
					<cfif index.volumeInfo.industryIdentifiers[2].type EQ "ISBN_10">
						<cfset var isbn10 = index.volumeInfo.industryIdentifiers[2].identifier />
					<cfelse>
						<cfset var isbn10 = 0 />
					</cfif>
					
					<cfif index.volumeInfo.industryIdentifiers[1].type EQ "ISBN_13">
						<cfset var isbn13 = index.volumeInfo.industryIdentifiers[1].identifier />
					<cfelse>
						<cfset var isbn13 = 0 />
					</cfif>
				<cfelse>
					<cfset var isbn10 = 0 />
					<cfif index.volumeInfo.industryIdentifiers[1].type EQ "ISBN_13">
						<cfset var isbn13 = index.volumeInfo.industryIdentifiers[1].identifier />
					<cfelse>
						<cfset var isbn13 = 0 />
					</cfif>
				</cfif>
			<cfelse>
				<cfset var isbn10 = 0 />
				<cfset var isbn13 = 0 />
			</cfif>
			
			<cfset bookDetail = {
				"url" = url,
				"ISBN10" = isbn10,
				"ISBN13" = isbn13,
				"PrintType" = StructKeyExists(bookinfo,"printType") ? bookinfo.printType : "",
				"Language" = StructKeyExists(bookinfo,"language") ? bookinfo.language : "",
				"MaturityRating" = StructKeyExists(bookinfo,"maturityRating") ? bookinfo.maturityRating : "",
				"PublishedDate" = StructKeyExists(bookinfo,"publishedDate") ? bookinfo.publishedDate : "",
				"Title" = bookinfo.title,
				"Description" = StructKeyExists(bookinfo,"description") ? bookinfo.description : "",
				"PageCount" =StructKeyExists(bookinfo,"pageCount") ? ToString(bookinfo.pageCount) : 0,
				"Image" = imageUrl,
				"Thumbnail" = StructKeyExists(bookinfo,"ImageLinks") ? bookinfo.ImageLinks.smallThumbnail : "",
				"Authors" = StructKeyExists(bookinfo,"authors") ? bookinfo.authors : "",
				"Categories" = StructKeyExists(bookinfo,"categories") ? bookinfo.categories : "",
				"Publisher" = StructKeyExists(bookinfo,"publisher") ? bookinfo.publisher : ""
			} />
		<cfset ArrayAppend(bookResult,bookDetail)>
		</cfloop>
		</cfif>
		<cfreturn bookResult />
	</cffunction>

</cfcomponent>