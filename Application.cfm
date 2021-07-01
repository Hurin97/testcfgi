<cfapplication name="ErrorChecker"
  clientmanagement="Yes"
  sessionmanagement="Yes">

<cfset primarydatasource="testP">
<cflock  timeout="30" 
    scope="Session" 
    type="exclusive">
  <cfset session.current_location = "=/">

</cflock>

<cfset mainpage = "index.cfm">

<cfset sm_location = "dpa">

<cfset current_page = "#cgi.path_info#?#cgi.query_string#">

