<!---
    File        :   Index.cfm
    Description :   This is the start page.
    Created On  :   29-07-2015
--->
<cfinclude template="Header.cfm"/>
<div class="container" style="margin-top:-15px">
    <div class="wrapper">
        <!-- <ul class="nav nav-tabs">
            <li role="presentation" class="active"><a data-toggle="tab" href="Default.cfm">Home</a></li>
            <li role="presentation"><a href="Latest.cfm">Latest</a></li>
            <li role="presentation"><a href="AboutUs.cfm">About Us</a></li>
        </ul> -->
		<nav role="navigation" class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" data-target="#navbarCollapse" data-toggle="collapse" class="navbar-toggle">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a href="#" class="navbar-brand">Internal Library</a>
        </div>
        <!-- Collection of nav links and other content for toggling -->
        <div id="navbarCollapse" class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">Home</a></li>
                <li><a href="#">Latest</a></li>
                <li><a href="#">About Us</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li>
					<cfif StructKeyExists(SESSION,"auth")>
				<span class="accountTab"><cfoutput>Welcome! #SESSION.auth.userEmail# </cfoutput><a href="logout.cfm"> Logout</a></span>
			<cfelse>
				<span class="accountTab" id="userLogin"> Log In | Register  </span>
			</cfif>
				</li>
            </ul>
        </div>
    </div>
</nav>
    </div>
</div>
<cfinclude template="Footer.cfm" />



