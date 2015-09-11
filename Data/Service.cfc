<!---
File        :   Service.cfc
Description :   This is the component which make the db calls.
Created On  :   29-07-2015
--->
<!--- This Component deals with the user login and sign-up db calls --->
<cfcomponent output="false" hint="It makes DB calls" displayname="UserService" persistent="true">
	<cfscript>
		VARIABLES.errorLogObj = CreateObject("component","Data.ErrorLog");
	</cfscript>

	<!--- this function checks if the received email argument is present in the db--->
	<cffunction
			name="CheckEmail"
			returnformat="JSON"
			access="public"
			returntype="boolean">
		<cfargument name="email" required="true" type="string" hint="email" />
		<cfscript>
			var IsEmailExist = QueryNew("");
		</cfscript>

		<cfquery name="IsEmailExist" datasource="#APPLICATION.DataSource#">
			SELECT
				Email
			FROM
				User
			WHERE
				Email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.email#" >
		</cfquery>

		<!---Check if any record is present--->
		<cfif IsEmailExist.recordCount>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>

		<cfreturn false />
	</cffunction>

	<!--- this function checks if the received email argument is present in the db and returns email password and salt--->

	<cffunction
			name="CheckLogin"
			access="public"
			returntype="query">

		<cfargument name="email" required="true" type="string" hint="email" />
		<cfargument name="password" required="true" type="string" hint="email" />

		<cfscript>
			var GetEmailPassword = QueryNew("");
		</cfscript>

		<cfquery name="GetEmailPassword" datasource="#APPLICATION.DataSource#">
			SELECT
				Id
				, Email
				, Password
				, Salt
				, AccountType
			FROM
				User
			WHERE
				Email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.email#">
		</cfquery>

		<cfreturn GetEmailPassword />
	</cffunction>

	<!--- This function is used to insert the user signup data --->
	<!--- InsertUserData --->
	<cffunction
			name="InsertUserData"
			returntype="any"
			access="public">

		<cfargument name="email" required="true" type="string" />
		<cfargument name="password" required="true" type="string" />
		<cfargument name="firstName" required="true" type="string" />
		<cfargument name="middleName" required="false" type="string" />
		<cfargument name="lastName" required="true" type="string" />
		<cfargument name="phone" required="true" type="numeric" />
		<cfargument name="street1" required="true" type="string" />
		<cfargument name="street2" required="false" type="string" />
		<cfargument name="cityId" required="true" type="string" />
		<cfargument name="zip" required="true" type="numeric" />
		<cfargument name="accountType" required="false" default="2" type="numeric" />
		<cfargument name="salt" required="true" type="string" />
		<cfargument name="isActive" required="false" default="1" type="numeric" />

		<cfscript>
			var insertResult = StructNew();
		</cfscript>
		<cftransaction>

			<cfscript>
				var locationId = "";
				var SaveUserDetails = QueryNew("");
				var CheckPincodeExist = QueryNew("");
				var InsertPincode = QueryNew("");
				var InsertUserAddress = QueryNew("");
				var publisherId = 0;
			</cfscript>

			<cftry>
				<!---Query to insert the user primary details--->
				<cfquery name="SaveUserDetails" datasource="#APPLICATION.DataSource#" result="userResult">
					INSERT INTO
						User(
						FirstName
						, MiddleName
						, LastName
						, Email
						, Password
						, Phone
						, AccountType
						, LastLogin
						, Salt
						, IsActive)
					VALUES
						(<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.firstName#">
						, <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.middleName#">
						, <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.lastName#">
						, <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.email#">
						, <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.password#">
						, <cfqueryparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.phone#">
						, <cfqueryparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.accountType#">
						, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">
						, <cfqueryparam  cfsqltype="cf_sql_varchar" value="#ARGUMENTS.salt#">
						, <cfqueryparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.isActive#">)
				</cfquery>
			<cfcatch>
				<cftransaction action="rollback" />
				<cfset VARIABLES.errorLogObj.LogError(cfcatch.message,cfcatch.detail) />
				<cfreturn 0 />
			</cfcatch>
			</cftry>

			<cftry>
				<!--- Query to check if the pincode exists --->
				<cfquery name="CheckPincodeExist" datasource="#APPLICATION.DataSource#">
					SELECT
						LocationId
					FROM
						Location
					WHERE
						LocationValue = <cfqueryparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.zip#">
				</cfquery>
			<cfcatch>
				<cftransaction action="rollback" />
				<cfset VARIABLES.errorLogObj.LogError(cfcatch.message,cfcatch.detail) />
				<cfreturn 0 />
			</cfcatch>
			</cftry>

			<!--- If the pincode already exists --->
			<cfif CheckPincodeExist.recordCount>
				<cfset locationId = CheckPincodeExist.LocationId />
			<cfelse>
				<cftry>
					<!---Insert pincode into location table first--->
					<cfquery name="InsertPincode" datasource="#APPLICATION.DataSource#" result="userLocation">
						INSERT INTO
							Location
							(LocationValue
							, ParentLocationId)
						VALUES
							(<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.zip#">
							, <cfqueryparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.cityId#">)
					</cfquery>
				<cfcatch>
					<cftransaction action="rollback" />
					<cfset VARIABLES.errorLogObj.LogError(cfcatch.message,cfcatch.detail) />
					<cfreturn 0 />
				</cfcatch>
				</cftry>

				<cfset locationId = userLocation.generatedKey />
			</cfif>

			<cftry>
				<!--- Insert user address --->
				<cfquery name="InsertUserAddress" datasource="#APPLICATION.DataSource#">
					INSERT INTO
						UserAddress
						(UserId
						, Street1
						, Street2
						, LocationId)
					VALUES
						(<cfqueryparam cfsqltype="cf_sql_numeric" value="#userResult.generatedKey#">
						, <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.street1#">
						, <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.street2#">
						, <cfqueryparam cfsqltype="cf_sql_numeric" value="#locationId#">)
				</cfquery>
			<cfcatch>
				<cftransaction action="rollback" />
				<cfset VARIABLES.errorLogObj.LogError(cfcatch.message,cfcatch.detail) />
				<cfreturn 0 />
			</cfcatch>
			</cftry>
		</cftransaction>

		<cfreturn userResult.generatedKey />
	</cffunction>

	<!--- GetQuotes --->
	<!--- This function is used to fetch the quotes from the quotes table for the given date --->
	<cffunction
			name="GetQuotes"
			access="remote"
			output="false"
			returnformat="JSON"
			returntype="any">

		<cfscript>
			var currentDate = DateFormat(now(),"yyyy-mm-dd");
			var QOD = StructNew();
			var GetQOD = QueryNew("");
		</cfscript>

		<cfquery name="GetQOD" datasource="#APPLICATION.DataSource#">
			SELECT
				Quote
				, Author
			FROM
				Quotes
			WHERE
				QuoteDate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#currentDate#">
		</cfquery>

		<cfset QOD["Qoute"] = GetQOD.Quote />
		<cfset QOD["Author"] = GetQOD.Author />
		<cfreturn QOD />
	</cffunction>

	<!--- Save the book Details to the db --->
	<cffunction
			name="saveBookDetails"
			access="remote"
			output="false"
			returnformat="JSON">
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

		<!--- Variables declaration --->
		<cfscript>
			var existingAuthors = "";
			var existingAuthorId = "";
			var newAuthors = "";
			var newCategories = "";
			var existingCategories = "";
			var IsAuthorExist = QueryNew("");
			var IsPublisherExist = QueryNew("");
			var IsCategoryExist = QueryNew("");
			var insertAuthor = QueryNew("");
			var insertPublisher = QueryNew("");
			var insertCategory = QueryNew("");
			var insertBook = QueryNew("");
		</cfscript>
		<cftransaction>
			<!--- Check if the author exists, if no then insert and fetch the id  --->
			<cfquery name="IsAuthorExist" datasource="#APPLICATION.DataSource#">
				SELECT
					AuthorId
					, AuthorName
				FROM
					author
				WHERE
					AuthorName IN (<cfqueryparam cfsqltype="cf_sql_varchar"  list="true" value="#ARGUMENTS.author#">)
			</cfquery>

			<cfset existingAuthors = valuelist(IsAuthorExist.AuthorName,",") />
			<cfset newAuthors = replacelist(ARGUMENTS.author,existingAuthors,"") />

			<cftry>
				<cfquery name="insertAuthor" Datasource="#APPLICATION.DataSource#" result="insertAuthorResult">
					INSERT INTO
						author(AuthorName)
					VALUES
						(<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#newAuthors#">)
				</cfquery>
			<cfcatch>
				<cftransaction action="rollback" />
				<cfset VARIABLES.errorLogObj.LogError(cfcatch.message,cfcatch.detail) />
				<cfreturn 0 />
			</cfcatch>
			</cftry>

			<!--- Insert the book data to the book table --->
			<cftry>
				<cfquery name="insertBook" datasource="#APPLICATION.DataSource#" result="insertBookresult">
					INSERT INTO
						book
						(ISBN10
						, ISBN13
						, PrintType
						, Language
						, MaturityRating
						, PublishedDate
						, Title
						, Description
						, PageCount
						, Image
						, Thumbnail)
					VALUES
						(<cfqueryparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.ISBN10#">
						, <cfqueryparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.ISBN13#">
						, <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.printType#">
						, <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.language#">
						, <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.maturityRating#">
						, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#ARGUMENTS.publishedDate#">
						, <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.title#">
						, <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#ARGUMENTS.description#">
						, <cfqueryparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.pageCount#">
						, <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.image#">
						, <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.thumbnail#">)
				</cfquery>
			<cfcatch>
				<cftransaction action="rollback" />
				<cfset VARIABLES.errorLogObj.LogError(cfcatch.message,cfcatch.detail) />
				<cfreturn 0 />
			</cfcatch>
			</cftry>

			<!--- Check if the publisher exists, if no then insert and fetch the id  --->
			<cfquery name="IsPublisherExist" datasource="#APPLICATION.DataSource#">
				SELECT
					PublisherId
				FROM
					publisher
				WHERE
					PublisherName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.publisher#" />
			</cfquery>

			<cfif (not IsPublisherExist.recordCount)>
				<cftry>
					<cfquery name="insertPublisher" Datasource="#APPLICATION.DataSource#" result="insertPublisherResult">
						INSERT INTO
							publisher(PublisherName)
						VALUES
							(<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.publisher#">)
					</cfquery>
				<cfcatch>
					<cftransaction action="rollback" />
					<cfset VARIABLES.errorLogObj.LogError(cfcatch.message,cfcatch.detail)/>
					<cfreturn 0 />
				</cfcatch>
				</cftry>

				<cfset publisherId = insertPublisherResult.generatedkey />
			<cfelse>
				<cfset publisherId = IsPublisherExist.PublisherId />
			</cfif>

			<!--- Check if the author exists, if no then insert and fetch the id  --->
			<cfquery name="IsCategoryExist" datasource="#APPLICATION.DataSource#">
				SELECT
					CategoryId
					, CategoryName
				FROM
					category
				WHERE
					CategoryName IN (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#ARGUMENTS.category#">)
			</cfquery>

			<cfif IsCategoryExist.recordCount>
				<cfset existingCategories = valuelist(IsCategoryExist.CategoryName,",") />
				<cfset newCategories = replacelist(ARGUMENTS.author,existingAuthors,"") />
			<cfelse>
				<cfset newCategories = ARGUMENTS.category />
			</cfif>
		
			<cftry>
				<cfquery name="insertCategory" Datasource="#APPLICATION.DataSource#" result="insertCategoryResult">
					INSERT INTO
						category(CategoryName)
					VALUES
						(<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#newCategories#">)
				</cfquery>
			<cfcatch>
				<cftransaction action="rollback" />
				<cfset VARIABLES.errorLogObj.LogError(cfcatch.message,cfcatch.detail) />
				<cfreturn 0 />
			</cfcatch>
			</cftry>
		</cftransaction>
	</cffunction>
</cfcomponent>
