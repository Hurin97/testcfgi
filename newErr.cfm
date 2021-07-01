<cfif NOT isUserLoggedIn()>
    <cflocation url="index.cfm?noaccess" />
</cfif>
<!---Include header --->
<cfmodule template="front.cfm"  >

    <div id="pageBody">
        <h1> Здесь можно создать отчет об ошибке</h1>

        <cfinclude template="includes/newErrForm.cfm" >
    </div>

</cfmodule>