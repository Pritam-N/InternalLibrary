<!---
    File        :   EncryptService.cfc
    Description :   This Component deals with encryption.
    Created On  :   29-07-2015
--->

<cfcomponent
        output="false"
        hint="It performs password encryptions and checks"
        displayname="EncryptService"
        persistent="true">

    <!--- Generate a hashed password --->
    <cffunction name="EncryptPassword" access="public" output="true" returntype="Struct">
        <cfargument name="password" type="string" required="true" />

        <cfset salt = Hash(Rand("SHA1PRNG"), "SHA-512") />
        <cfset hashedPassword = Hash(ARGUMENTS.password & salt, "SHA-512") />
        <cfset passwordAndSalt={"Password"="#hashedPassword#","Salt"="#salt#"} />

        <cfreturn PasswordAndSalt />
    </cffunction>

	<!--- Check if the password matches --->
	<cffunction name="PasswordCheck" access="public" output="false" returntype="boolean">
		<cfargument name="enteredPassword" type="string" required="true" />
		<cfargument name="salt" type="string" required="true" />
		<cfargument name="password" type="string" required="true">

		<cfset var generatedPassword = Hash(ARGUMENTS.enteredPassword & ARGUMENTS.salt,"SHA-512") />

		<cfif password EQ generatedPassword>
			<cfdump var="true" output="console">
			<cfreturn true />
		<cfelse>
			<cfdump var="false" output="console">
			<cfreturn false />
		</cfif>
		<cfreturn false />
	</cffunction>

</cfcomponent>
