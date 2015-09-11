<!---
	File        :   Header.cfm
	Description :   This is the layout header.
	Created On  :   29-07-2015
	--->
<!DOCTYPE html>
<html lang="en" data-ng-app="InternalLibrary">
	<head>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
		<link  rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" >
		<link  rel="stylesheet" href="Content/css/Normalizer.css" >
		<link  rel="stylesheet" href="Content/css/InternalLibrary.css">
	</head>
	<body>
		<div class="container" style="margin-top:-15px">
			<nav role="navigation" class="navbar navbar-inverse navbar-fixed-top" style="min-height:0">
				<div class="container">
					<!-- Brand and toggle get grouped for better mobile display -->
					<div class="navbar-header">
						<button type="button" data-target="#navbarCollapse" data-toggle="collapse" class="navbar-toggle collapsed" aria-expanded="false" aria-controls="navbar">
							<span class="sr-only">
								Toggle navigation
							</span>
							<span class="icon-bar">
							</span>
							<span class="icon-bar">
							</span>
							<span class="icon-bar">
							</span>
						</button>
						<a href="#" class="navbar-brand">
							Internal Library
						</a>
					</div>
					<!-- Collection of nav links and other content for toggling -->
					<div id="navbarCollapse" class="collapse navbar-collapse">
						<ul class="nav navbar-nav">
							<li class="active">
								<a href="Index.cfm">
									Home
								</a>
							</li>
							<li>
								<a href="Latest.cfm">
									Latest
								</a>
							</li>
							<li>
								<a href="About.cfm">
									About Us
								</a>
							</li>
						</ul>
						<ul class="nav navbar-nav navbar-right">
							<li>
								<div class="searchDiv">
									<input type="text" class="form-control" title="Enter your search here" autocomplete="true" placeholder=" Enter your search here" id="txtSearchBox">
								</div>
							</li>
							<li>
								<cfif StructKeyExists(SESSION,"auth")>
									<cfoutput>
										Welcome! #SESSION.auth.userEmail#
									</cfoutput>
									<a href="logout.cfm">
										Logout
									</a>
								<cfelse>
									<a id="userLogin">
										Log In | Register
									</a>
								</cfif>
							</li>
						</ul>
					</div>
			</nav>
			<cfinclude template ="LoginPage.cfm"> </div>
		</div>
