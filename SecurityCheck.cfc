<!---
    File        :   SecurityCheck.cfc
    Description :   This cfc is used for login and signup check.
    Created On  :   29-07-2015
--->

<cfcomponent>
    <cfset VARIABLES.UserServiceObj = createObject("component","Data.Service")>

    <!--- This function receives the email and checks if it is present in the db --->
    <cffunction
            name="EmailCheck"
            access="remote"
            returntype="boolean">
        <cfargument name="email" required="true" type="string"/>
        <cfreturn VARIABLES.UserServiceObj.CheckEmail(ARGUMENTS.email) />
    </cffunction>

	<!--- Function Name : CheckLogin --->
	<!--- This Function checks if the email exists, if yes it checks if the password matches --->
	<cffunction
            name="CheckLogin"
            access="remote"
            returntype="any"
			returnformat="JSON">

        <cfargument name="email" required="true" type="string" />
        <cfargument name="password" required="true" type="string" />

		<cfscript>
			var loginDetails = QueryNew("");
			var EncryptServiceObj = "";
			var checkLoginResult = StructNew();
		</cfscript>
        <cfset loginDetails = VARIABLES.UserServiceObj.CheckLogin(ARGUMENTS.email,ARGUMENTS.password) />
        <cfif loginDetails.recordCount>
	        <cfset EncryptServiceObj = createObject("component","Data.EncryptService") />

	        <cfif EncryptServiceObj.PasswordCheck(ARGUMENTS.password, loginDetails.Salt, loginDetails.Password)>
                <cfset StructDelete(Session,"auth") />
                <cfset SESSION.auth.userId = loginDetails.Id />
                <cfset SESSION.auth.userEmail = loginDetails.Email />
                <cfset SESSION.auth.role = setRole(loginDetails.AccountType) />
				<cfset checkLoginResult["email"] = SESSION.auth.userEmail>
				<cfset checkLoginResult["valid"] = true>
                <cfreturn checkLoginResult />
            <cfelse>
				<cfset checkLoginResult["email"] = "">
				<cfset checkLoginResult["valid"] = false>
                <cfreturn checkLoginResult />
            </cfif>
		<cfelse>
			<cfset checkLoginResult["email"] = "">
			<cfset checkLoginResult["valid"] = false>
			<cfreturn checkLoginResult />
        </cfif>
    </cffunction>

	<!--- Function Name : NewUserDetail --->
	<!--- This function inserts the newly created user details--->
	<cffunction
			name="NewUserDetail"
			returntype="any"
			access="remote"
			returnformat="JSON">

		<cfargument name="email" required="true" type="string" />
		<cfargument name="password" required="true" type="string" />
		<cfargument name="firstName" required="true" type="string" />
		<cfargument name="middleName" required="false" type="string" />
		<cfargument name="lastName" required="true" type="string" />
		<cfargument name="phone" required="false" type="numeric" default="9999999999" />
		<cfargument name="street1" required="false" type="string" default="Bhubaneswar" />
		<cfargument name="street2" required="false" type="string" default=""/>
		<cfargument name="cityId" required="false" type="string" default="2" />
		<cfargument name="zip" required="false" type="numeric" default="751018" />

		<cfscript>
			var ajaxReturn = StructNew();
			var EncryptServiceObj = "";
			var hashedPassword = "";
			var serviceObj = "";
			var IsInserted = false;
		</cfscript>

		<cfif EmailCheck(ARGUMENTS.email)>
			<cfset ajaxReturn["IsEmailExist"] = true>
		<cfelse>
			<cfset ajaxReturn["IsEmailExist"] = false>
			<cfset EncryptServiceObj = CreateObject("component","Data.EncryptService") />
			<cfset hashedPassword = encryptserviceobj.EncryptPassword(ARGUMENTS.password)>
			<cfset serviceObj = CreateObject("component", "Data.Service")>
			<cfset IsInserted = serviceObj.InsertUserData(
									ARGUMENTS.email
									, hashedPassword.Password
									, ARGUMENTS.firstName
									, ARGUMENTS.middleName
									, ARGUMENTS.lastName
									, ARGUMENTS.phone
									, ARGUMENTS.street1
									, ARGUMENTS.street2
									, ARGUMENTS.cityId
									, ARGUMENTS.zip
									, 2
									, hashedPassword.Salt
									, 1)>
		</cfif>

		<cfif IsInserted>
			<cfset StructDelete(SESSION,"auth") />
			<cfset SESSION.auth.userId = IsInserted />
			<cfset SESSION.auth.userEmail = ARGUMENTS.Email />
			<cfset SESSION.auth.role = setRole(2) />
			<cfset ajaxReturn["IsInserted"] = IsInserted GT 0 ? true : false>
			<cfset ajaxreturn["Email"] = ARGUMENTS.email>
		</cfif>
		<cfreturn ajaxReturn>
	</cffunction>

	<!--- Function Name : SetRole --->
	<!--- this function is used to set the roles based on the arguments received --->
	<cffunction name="SetRole" access="private" returntype="string">
		<cfargument name="accountType" required="true" type="numeric" />
		<cfswitch expression="#ARGUMENTS.accountType#">
			<cfcase value="1">
				<cfreturn "Admin" />
			</cfcase>
			<cfcase value="2">
				<cfreturn "Borrower" />
			</cfcase>
			<cfcase value="3">
				<cfreturn "Lender" />
			</cfcase>
		</cfswitch>
	</cffunction>

</cfcomponent>