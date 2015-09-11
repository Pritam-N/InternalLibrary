/**
 * Application
 *
 * @author pritama.nayak
 * @date 7/27/15
 **/
component
        accessors=true
        output=false
        persistent=false {

    /* APPLICATION VARIABLES */
    THIS.name = "InternalLibrary";
    THIS.applicationtimeout = CreateTimespan(10,0,0,0);
    THIS.sessionmanagement = true;
    THIS.sessiontimeout = CreateTimespan(0,1,0,0);
    THIS.setclientcookies = true;
    THIS.scriptprotect = true;

/**
@hint "Runs when ColdFusion receives the first request for a page in the application."
*/
    public boolean function OnApplicationStart()
    {
        APPLICATION.DataSource = "InternalLibraryDSN";
        APPLICATION.LogErrorPath = "C://InternalLibrary/Error.txt";
        APPLICATION.RootPath = ExpandPath( "./" );
        APPLICATION.ErrorLog = "C://InternalLibraryError.txt";
        APPLICATION.key = "AIzaSyDSKlXNRZLkfGBY5girwY62QP2R4Zr0R-E";

        /* Return Output */
        return true;
    }

/**
@hint "Runs when a request starts."
@TargetPage "Path from the web root to the requested page."
*/
    public boolean function OnRequestStart(required string TargetPage)
    {
        if( (isDefined("URL.refreshapp")) and (URL.refreshapp == "yes"))
        {
            OnApplicationStart();
        }
        REQUEST.ServiceObj = CreateObject("component","Data.Service");
        REQUEST.googleApiUrl = "https://www.googleapis.com/books/v1/volumes?q=";
        REQUEST.currentDateTime = Now();
        return true;
    }
}