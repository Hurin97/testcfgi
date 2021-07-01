<cfif NOT isUserLoggedIn()>
    <cflocation url="index.cfm?noaccess" />
</cfif>
<cfmodule template="front.cfm"  >

    <div id="pageBody">
        <h1>Список пользователей</h1>

        <cfinclude template="includes/allUsersForm.cfm" >
    
    </div>

</cfmodule>