<div ng-controller="bookDetailsController" class="addBookDiv">
 <div id="imageDiv" style="float:left" class="col-md-4">
     <br><br>
     <img ng-src="{{book.image}}" alt="{{book.title}}" style="width:300px;height:500px">
 </div>
 <div class="form-horizontal col-md-8" style="float:left" ng-disabled="true">
    <br><br>
    <div class="form-group">
        <label class="col-md-4">Title</label>
        <div class="col-md-8">
            <input type="text" class="form-control" placeholder="Please enter the book title"
            id="txtBookTitle" ng-disabled="true" ng-bind="book.title" ng-model="book.title" 
            ng-keyup="searchBook()"/>
            <span style="color:red" ng-show="book.title.$dirty && book.title.$invalid">
                <span ng-show="book.title.$error.required">Title is required.</span>
            </span>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-4">ISBN 10</label>
        <div class="col-md-8">
            <input type="text" class="form-control" placeholder="Please enter the ISBN 10"
            id="txtBookTitle" ng-disabled="true" ng-bind="book.ISBN10" ng-model="book.ISBN10"/>
            <span style="color:red" ng-show="book.ISBN10.$dirty && book.ISBN10.$invalid">
                <span ng-show="book.ISBN10.$error.required">ISBN 10 is required.</span>
            </span>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-4">ISBN 13</label>
        <div class="col-md-8">
            <input type="text" class="form-control" placeholder="Please enter the ISBN 13"
            id="txtBookTitle" ng-disabled="true" ng-bind="book.ISBN13" ng-model="book.ISBN13"/>
            <span style="color:red" ng-show="book.ISBN13.$dirty && book.ISBN13.$invalid">
                <span ng-show="book.ISBN13.$error.required">ISBN 13 is required.</span>
            </span>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-4">Description</label>

        <div class="col-md-8">
            <textarea class="form-control" cols="3" rows="3" ng-bind="book.description" ng-model="book.description" ng-disabled="true" style="resize:none">
            </textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-4">Print Type</label>
        <div class="col-md-8">
            <input type="text" class="form-control"
            id="txtBookTitle" ng-bind="book.printType" ng-model="book.printType" ng-disabled="true"/>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-4">Language</label>
        <div class="col-md-8">
            <input type="text" class="form-control"
            id="txtBookTitle" ng-bind="book.language" ng-model="book.language" ng-disabled="true"/>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-4">Published Date</label>
        <div class="col-md-8">
            <input type="text" class="form-control"
            id="txtBookTitle" ng-bind="(book.publishedDate | date:'longDate')" ng-model="book.publishedDate" 
            ng-disabled="true"/>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-4">Maturity Rating</label>
        <div class="col-md-8">
            <input type="text" class="form-control"
            id="txtBookTitle" ng-bind="book.maturityRating" ng-model="book.maturityRating" ng-disabled="true"/>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-4">Page Count</label>
        <div class="col-md-8">
            <input type="text" class="form-control"
            id="txtBookTitle" ng-bind="book.pageCount" ng-model="book.pageCount" ng-disabled="true"/>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-4">Authors</label>
        <div class="col-md-8" >
            <textarea ng-disabled="true" ng-model="book.authors" style="width:300px">
                {{book.authors}}
            </textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-4">Categories</label>
        <div class="col-md-8" >
            <textarea ng-disabled="true" ng-model="book.categories" style="width:300px">
                {{book.categories}}
            </textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-4">Publisher</label>
        <div class="col-md-8" >
            <textarea ng-disabled="true" ng-model="book.publisher" style="width:300px">
                {{book.publisher}}
            </textarea>
        </div>
    </div>
    <button class="btn btn-success col-md-offset-6" style="width:100px" ng-click="Save()">Add</button>
    <a href="#/">
        <button class="btn btn-default" style="width:100px">Cancel</button>
    </a>
    <a href="#/SearchBook">
        <button class="btn btn-warning col-md-offset-1" style="width:100px;float:right;padding: 5px;">Search Again</button>
    </a>
</div>
</div>