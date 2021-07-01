<cfif NOT isUserLoggedIn()>
    <cflocation url="index.cfm?noaccess" />
</cfif>
<!---Include header --->
<cfmodule template="front.cfm"  >

    <div id="pageBody">
        <h1> Представление отчета</h1>

        <cfinclude template="includes/errRepForm.cfm" >
        <h2> История изменений</h2>
        <cfinclude template="includes/comErrForm.cfm">
    </div>

</cfmodule>