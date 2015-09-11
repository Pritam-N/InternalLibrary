var app = angular.module("InternalLibrary", ['ngRoute','ngSanitize','infinite-scroll','angular-loading-bar']);

//config
app.config(function($routeProvider) {
	$routeProvider.when('/indexRoute', {
		controller : 'IndexController',
		templateUrl : '../../Default.cfm'
	}).when('/Latest', {
		controller : 'LatestController',
		templateUrl : '../../Latest.cfm'
	}).when('/AboutUs', {
		controller : 'AboutUsController',
		templateUrl : '../../AboutUs.cfm'
	}).when('/AddBook', {
		controller : 'AddBookController',
		templateUrl : '../../Admin/AddBook.cfm'
	}).when('/SearchBook', {
		controller : 'SearchBookController',
		templateUrl : '../../Admin/SearchBook.cfm'
	}).otherwise({
		redirectTo : '/indexRoute'
	});
});

//controllers
app.controller('AddBookController', function($scope) {

});
app.controller('SearchBookController', function($scope, $window, $http, searchBookService, bookDetailService) {
	$scope.searchResult = [];
	var searchIndex = 0;
	if(angular.isUndefined($scope.title) || angular.isUndefined($scope.isbn)){
		$window.scrollTo(0,0);
	}
	$scope.searchBooks = function(){
		$scope.searchResult = [];
		searchBookService.title = $scope.title;
		searchBookService.isbn = $scope.isbn;
		if(!angular.isUndefined($scope.title) || !angular.isUndefined($scope.isbn)){
			$http({
				method:"get",
				url:'../../GetBookAPI.cfc?method=SearchBook' 
				+ (angular.isUndefined($scope.title) ? "" : ("&title=" + $scope.title))
				+ (angular.isUndefined($scope.isbn) ? "" : ("&isbn=" + $scope.isbn))
			}).success(function(data){
				angular.forEach(data,function(value){
					$scope.searchResult.push(value);
				});
				if($scope.searchResult.length){
					$scope.showResult = true;
				}
				$scope.title = searchBookService.title;
				$scope.isbn = searchBookService.isbn;
			});
		}
	}
	$scope.ShowAllAuthors = function(){
		$scope.IsShowAllAuthors = true;
	}

	$scope.SelectedBookDetails = function(book){
		bookDetailService.title = book.Title;
		bookDetailService.description = book.Description;
		bookDetailService.ISBN10 = book.ISBN10;
		bookDetailService.ISBN13 = book.ISBN13;
		bookDetailService.printType = book.PrintType;
		bookDetailService.language = book.Language;
		bookDetailService.maturityRating = book.MaturityRating;
		bookDetailService.publishedDate = book.PublishedDate;
		bookDetailService.pageCount = book.PageCount;
		bookDetailService.image = book.Image;
		bookDetailService.thumbnail = book.Thumbnail;
		bookDetailService.authors = book.Authors;
		bookDetailService.categories = book.Categories;
		bookDetailService.publisher = book.Publisher;
	}

	$scope.SearchResultsPaging = function(){
		searchIndex = searchIndex + 10;
		searchBookService.title = $scope.title;
		searchBookService.isbn = $scope.isbn;
		if(!angular.isUndefined($scope.title) || !angular.isUndefined($scope.isbn)){
			$http({
				method:"get",
				url:'../../GetBookAPI.cfc?method=SearchBook' 
				+ (angular.isUndefined($scope.title) ? "" : ("&title=" + $scope.title))
				+ (angular.isUndefined($scope.isbn) ? "" : ("&isbn=" + $scope.isbn))
				+ "&searchIndex=" + searchIndex
			}).success(function(data){
				angular.forEach(data,function(value){
					$scope.searchResult.push(value);
				});
				if($scope.searchResult.length){
					$scope.showResult = true;
				}
				$scope.title = searchBookService.title;
				$scope.isbn = searchBookService.isbn;
			});
		}
	}

});
app.controller('IndexController', function($scope) {

});
app.controller('LatestController', function($scope) {

});
app.controller('AboutUsController', function($scope) {

});
//this controller is used to fetch the quotes from db
app.controller('quotesController', function($scope,$http){
	$http.get("../Data/Service.cfc?method=GetQuotes")
	.success(function(response) {
		$scope.quote = response.Qoute;
		$scope.author = response.Author;
	});
});
//this is used to fetch the data from the api and post to the server
app.controller('bookFetchController', function($scope,$http,$location,bookDetailService){
	$scope.getDetails = function(){
		$scope.request = $http({
			method:"get",
			url: "../../GetBookAPI.cfc?method=GetBookByISBN&isbn=" + $scope.isbn,
		}).success(function(response){
			bookDetailService.title = response.Title;
			bookDetailService.description = response.Description;
			bookDetailService.ISBN10 = response.ISBN10;
			bookDetailService.ISBN13 = response.ISBN13;
			bookDetailService.printType = response.PrintType;
			bookDetailService.language = response.Language;
			bookDetailService.maturityRating = response.MaturityRating;
			bookDetailService.publishedDate = response.PublishedDate;
			bookDetailService.pageCount = response.PageCount;
			bookDetailService.image = response.Image;
			bookDetailService.thumbnail = response.Thumbnail;
			bookDetailService.authors = response.Authors;
			bookDetailService.categories = response.Categories;
			bookDetailService.publisher = response.Publisher;
			$location.path('/AddBookRoute').replace();
		});
	}
});
app.controller('bookDetailsController', function($scope, $http, $location, bookDetailService){
	
	$scope.book = bookDetailService;
	if($scope.book.title == "")
	{
		$location.path("#/indexRoute");
	}
	$scope.book.author = angular.toJson(bookDetailService.authors);
	$scope.book.category = angular.toJson(bookDetailService.categories);
	$scope.Save = function(){
		$http({
			url: "../../Admin/Components/BookTransactions.cfc?method=SaveBook",
			method: 'POST',
			data: $.param($scope.book),
			headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
		}).success(function(data){
			if(data){
				$location.path("#/indexRoute");
			}
			else{
				$location.path("#/SearchBook");
			}
		});
	}
});

//service
app.service('bookDetailService', function () {
	this.title = "";
	this.description = "";
	this.ISBN10 = "";
	this.ISBN13 = "";
	this.printType = "";
	this.language = "";
	this.maturityRating = "";
	this.publishedDate = "";
	this.pageCount = "";
	this.image = "";
	this.thumbnail = "";
	this.authors = [];
	this.categories = [];
	this.publisher = "";
});
app.service("searchBookService", function(){
	this.title = "";
	this.isbn = "";
});


//directives
app.directive('ngEnter', function () {
	return function (scope, element, attrs) {
		element.bind("keydown keypress", function (event) {
			if(event.which === 13) {
				scope.$apply(function (){
					scope.$eval(attrs.ngEnter);
				});

				event.preventDefault();
			}
		});
	};
});

//filters
app.filter('truncate', function(){
	return function(input, limit){
		return (input.length > limit) ? input.substr(0, limit)+'…'
		: input;
	};
});