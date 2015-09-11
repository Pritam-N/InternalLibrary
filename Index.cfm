<!---
	File        :   Header.cfm
	Description :   This is the layout header.
	Created On  :   29-07-2015
	--->
<!DOCTYPE html>
<html lang="en">
	<head>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
		<link  rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" >
		<link  rel="stylesheet" href="Content/css/Normalizer.css" >
		<link  rel="stylesheet" href="Content/css/InternalLibrary.css">
		<link  rel="stylesheet" href="Content/css/loading-bar.css">
		<script language="javascript" src="content/js/jquery-2.1.4.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.16/angular.min.js"></script>
		<script language="javascript" src="Content/js/angular-route.min.js"></script>
		<script language="javascript" src="Content/js/angular-sanitize.min.js"></script>
		<script language="javascript" src="Content/js/ng-infinite-scroll.min.js"></script>
		<title>Internal Library</title>
	</head>
	<body data-ng-app="InternalLibrary">
		<div class="container" style="margin-top:-15px">
			<!--- <nav role="navigation" class="navbar navbar-inverse navbar-fixed-top" style="min-height:0"> --->
			<nav role="navigation" class="navbar navbar-fixed-top nav-user" style="min-height:0">
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
						<a href="#/indexRoute" class="navbar-brand" id="brand">
							Internal Library
						</a>
					</div>
					<!-- Collection of nav links and other content for toggling -->
					<div id="navbarCollapse" class="collapse navbar-collapse">
						<ul class="nav navbar-nav">
							<!--- <li class="active">
								<a href="#/indexRoute">
									Home
								</a>
							</li> --->
							<li>
								<a href="#/Latest">
									Latest
								</a>
							</li>
							<li>
								<a href="#/AboutUs">
									About Us
								</a>
							</li>
							<li>
								<a href="#/SearchBook">
									Search Book
								</a>
							</li>
						</ul>
						<ul class="nav navbar-nav navbar-right">
							<li>
								<div class="searchDiv">
									<input type="text" class="form-control" title="Enter your search here" autocomplete="true" placeholder="Enter your search here" id="txtSearchBox">
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

		<!--- Main Body Section --->
		<div id="wrap">
			<!-- Begin page content -->
			<div class="container" style="margin-top:65px;box-shadow: -5px 0 5px -5px #333, 5px 0 5px -5px #333;    margin-bottom: -25px;">
				<div  id="bodyDiv" ng-view>
				</div>
			</div>
		</div>

		<!--- Footer Section --->
		<footer id="footer">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#footer-body">
						<span class="icon-bar">
						</span>
						<span class="icon-bar">
						</span>
						<span class="icon-bar">
						</span>
					</button>
					<ul class="footer-bar-btns visible-xs">
						<li>
							<a href="#" class="btn" title="History">
								<i class="fa fa-2x fa-clock-o blue-text">
								</i>
							</a>
						</li>
						<li>
							<a href="#" class="btn" title="Favourites">
								<i class="fa fa-2x fa-star yellow-text">
								</i>
							</a>
						</li>
						<li>
							<a href="#" class="btn" title="Subscriptions">
								<i class="fa fa-2x fa-rss-square orange-text">
								</i>
							</a>
						</li>
					</ul>
				</div>
				<div class="navbar-collapse collapse" id="footer-body">
					<ul class="nav navbar-nav">
						<li>
							<a href="#" class="">
								Browse Our Library
							</a>
						</li>
						<li>
							<a href="#" class="">
								About Us
							</a>
						</li>
						<li>
							<a href="#" class="">
								Contact Us
							</a>
						</li>
						<li>
							<a href="#" class="">
								User Review
							</a>
						</li>
						<li>
							<a href="#" class="">
								Terms &amp; Conditions
							</a>
						</li>
						<li>
							<a href="#" class="">
								Privacy Policy
							</a>
						</li>
					</ul>
					<ul class="nav navbar-nav navbar-right" id="copyright">
						<li>
							Copyright &copy; Mindfire Solutions 2015
						</li>
					</ul>
				</div>
			</div>
		</footer>

		
		<script language="javascript" src="content/js/bootstrap.min.js"></script>
		<script language="javascript" src="content/js/LoginControls.js"></script>
		<script language="javascript" src="content/js/UserJs.js"></script>
		<script language="javascript" src="Content/js/app.js"></script>
		<script language="javascript" src="Content/js/loading-bar.js"></script>

	</body>
</html>
