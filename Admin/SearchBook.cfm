<div class="form-horizontal col-md-12 searchDiv" style="float:left" ng-controller="SearchBookController" >
    <br><br>
    <div class="form-group">
        <label class="col-md-8 text-danger">Please search for the book by any field.</label>
    </div>
    <div class="form-group col-md-5">
        <label class="col-md-3">Title</label>
        <div class="col-md-9">
            <input type="text" class="form-control" placeholder="Please enter the book title"
            id="txtBookTitle" ng-model="title" ng-enter="searchBooks()"/>
        </div>
    </div>

    <div class="form-group col-md-5">
        <label class="col-md-3">ISBN</label>
        <div class="col-md-9">
            <input type="text" class="form-control" placeholder="Please enter the ISBN 10"
            id="txtBookTitle" ng-model="isbn" ng-enter="searchBooks()"/>
        </div>
    </div>

    <div class="form-group col-md-2">
        <button class="btn btn-default" style="width:100px" ng-click="searchBooks()">Search</button>
    </div>
    <div class="searchResultsDiv col-md-12" ng-show="showResult" infinite-scroll="SearchResultsPaging()">
        <div class="col-md-12">showing results for 
             <div class="searchName">
                <span ng-show="title.length"> "Title: {{title}}"</span>
                <span ng-show="isbn.length"> "ISBN: {{isbn}}"</span>
            </div>
        </div>
        <hr>
        <div class="col-md-8" style="float:left">
            <div class="col-md-12" ng-repeat="book in searchResult" id="imageDiv">
                <div class="col-md-2">
                   <a href="#/AddBook" ng-click="SelectedBookDetails()">
                    <img id="bookImage" ng-src="{{book.Thumbnail}}" alt="{{book.Title}}">
                </a>
            </div>
            <div class="col-md-10">
                <a href="#/AddBook" id="bookTitle" ng-click="SelectedBookDetails(book)">{{book.Title | truncate:50}}</a> 
                <span class="superscript"> {{book.PublishedDate | date:'longDate'}}</span>
                <br/>
                <div ng-show="book.Authors.length" id="authorsDiv">
                    <span>by</span> 
                    <span ng-repeat="author in book.Authors" > {{author | truncate:75}}
                        <span ng-show="$index <= book.Authors.length-2">
                            ,
                        </span>
                    </span>
                </div>
                <div ng-show="book.Publisher.length" id="publisherDiv">
                    <span class="bookDetailHeading">Publisher:</span>
                    <br/>
                    <span> 
                        {{book.Publisher | truncate:75}}
                    </span>
                </div>
                <div ng-show="book.Language.length" id="languageDiv">
                    <span class="bookDetailHeading">Language:</span>
                    <br/>
                    <span ng-bind="book.Language"></span>
                </div>
           </div>
       </div>
       
   </div>
   <div class="col-md-4" style="border-left:1px solid #DDD;float:left">
            hello
        </div>
<!---    <button ng-click="SearchResultsPaging()" ng-show="showResult"> load more</button> --->
</div>
