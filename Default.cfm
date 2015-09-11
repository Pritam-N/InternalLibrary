<!---
<div>
	<div id="quoteDiv" ng-controller="quotesController">
		<p>{{quote}}</p>
		<span style="float:right">{{author}}</span>
	</div>
</div> --->
<div id="bodyMain">
	<div id="bodyHeader" ng-controller="quotesController">
		<div>
			<center>
				<p>{{quote}}</p>
				<p>{{author}}</p>
			</center>
		</div>
	</div>

	<div id="bodyHeader1" ng-controller="bookFetchController">
		<div>
			<input type="text" ng-model="isbn">
			<button ng-click="getDetails()">search</button>
		</div>
	</div>
</div>